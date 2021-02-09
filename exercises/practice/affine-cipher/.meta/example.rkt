#lang racket/base
(require racket/contract)
(require racket/stream)
(require racket/string)

(provide (contract-out
          [encode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]
          [decode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]))

; numbers wind up in [48, 57]
; message characters wind up in [0, 25]
(define (message->integers msg)
  (map (λ(d)
         (if (char-numeric? d)
             (char->integer d)
             (- (char->integer d) (char->integer #\a))))
       (filter (λ(c)
                 (or (char-numeric? c)
                     (char-lower-case? c)))
               (string->list
                (string-downcase msg)))))

(define (integers->message ints)
  (list->string
   (map (λ(e) (integer->char e))
        (map (λ(d)
               (if (< d 26)
                   (+ d (char->integer #\a))
                   d)) ints))))

(define (chunk msg)
  (let ([N (string-length msg)])
    (string-join
     (for/list ([i (stream->list (in-range 0 N 5))])
       (substring msg i (min N (+ i 5)))))))

(define (encode msg a b)
  (if (= (gcd a 26) 1)
      (chunk
       (integers->message
        (map (λ(d)
               (if (< d 26)
                   (modulo (+ b (* a d)) 26)
                   d))
             (message->integers msg))))
      (error "a and m must be coprime")))

(define (decode msg a b)
  (let ([M (message->integers msg)]
        [ai (mmi a 26)])
    (integers->message
     (map (λ(d)
            (if (< d 26)
                (modulo (* ai (- d b)) 26)
                d)) M))))

; http://www-math.ucdenver.edu/~wcherowi/courses/m5410/exeucalg.html
; https://en.wikibooks.org/wiki/Algorithm_Implementation/Mathematics/Extended_Euclidean_algorithm
; https://stackoverflow.com/questions/13096491/multiplicative-inverse-of-modulo-m-in-scheme
(define (egcd a b)
  (if (= a 0)
      (values b 0 1)
      (let-values ([(g x y) (egcd (modulo b a) a)])
        (values g (- y (* (quotient b a) x)) x))))

(define (mmi a b)
  (let-values ([(g x y) (egcd a b)])
    (if (= 1 g)
        (modulo x b)
        #f)))