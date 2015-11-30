#lang racket/base

;; say : Convert integers to English-language descriptions

;; Implements the basic algorithm.
;; - Does not use the OSX "say" command to speak the number
;; - Does not insert "and" between chunks

(require
  racket/contract
  (only-in racket/match match-define)
  (only-in racket/string string-trim))

(define SCALE '#(END thousand million billion trillion))
;; Supported size classifiers

(define UPPER-BOUND (sub1 (expt 10 (* (vector-length SCALE) 3))))
;; The largest printable number

(define (scale? v) (for/or ([s (in-vector SCALE)]) (eq? v s)))
;; Contract for scales

;; Use contracts to enforce all bounds
(provide (contract-out
  [step1 (-> (integer-in 0 99) string?)]
  ;; Convert a positive, 2-digit number to an English string

  [step2 (-> natural-number/c (listof (integer-in 0 999)))]
  ;; Divide a large positive number into a list of 3-digit (or smaller) chunks

  [step3 (-> (integer-in (- UPPER-BOUND) UPPER-BOUND)
             (listof (cons/c natural-number/c scale?)))]
  ;; Break a number into chunks and insert scales between the chunks

  [step4 (-> (integer-in (- UPPER-BOUND) UPPER-BOUND)
             string?)]
  ;; Convert a number to an English-language string
))

;; =============================================================================

(define N<20
  '#("zero" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten"
     "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen"
     "eighteen" "nineteen"))

(define TENS>10
  '#("twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"))

(define (step1 n)
  (cond
   [(< n 20)
    (vector-ref N<20 n)]
   [else
    (define q (quotient n 10))
    (define r (modulo n 10))
    (define ten-str (vector-ref TENS>10 (- q 2)))
    (define one-str (and (not (zero? r)) (vector-ref N<20 r)))
    (if one-str
        (string-append ten-str "-" one-str)
        ten-str)]))

(define (step2 N)
  (let loop ([acc '()]
             [n N]  ;; Starts as original & we remove 3 digits each step.
             [i 0]) ;; Index used to pick a scale
    (define q (quotient n 1000))
    (define r (modulo n 1000))
    (cond
     [(= n r)
      ;; Reached fixpoint, stop iteration
      (cons r acc)]
     [else
      ;; Repeat using the quotient
      (loop (cons r acc) q (add1 i))])))

(define (step3 n)
  (define (add-scale n acc+i)
    (match-define (cons acc i) acc+i)
    (define s (vector-ref SCALE i))
    (define n+s (cons n s))
    (cons (cons n+s acc) (add1 i)))
  (car (foldr add-scale (cons '() 0) (step2 n))))

(define (step4 N)
  ;; Break N into chunks, convert each chunk+scale to a string
  (define str*
    (for/list ([n+s (in-list (step3 (abs N)))])
      (match-define (cons n s) n+s)
      (define q (quotient n 100))
      (define r (modulo n 100))
      (define n-str
        (cond
         [(zero? n)
          ""]
         [(< n 100)
          (step1 r)]
         [else
          (define hd (vector-ref N<20 q))
          (define tl (step1 r))
          (if (equal? "zero" tl)
              (string-append hd " hundred")
              (string-append hd " hundred " tl))]))
      ;; Don't print a scale for zeros or the last chunk
      (if (or (eq? s 'END) (zero? n))
          n-str
          (string-append n-str (format " ~a " s)))))
  ;; Use `string-trim` to remove trailing whitespace
  (define n-str (string-trim (apply string-append str*)))
  (cond ;; Check for special cases
   [(zero? N)
    "zero"]
   [(negative? N)
    (string-append "negative " n-str)]
   [else
    n-str]))

