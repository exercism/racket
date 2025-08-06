#lang racket

(provide say)

(define/contract (say number)
  (-> (and/c exact-nonnegative-integer? (</c 1e12)) string?)
  (if (zero? number)
      "zero"
      (let* ([digits (string->list (number->string number))]
             [chunks (map list->string (chunk-from-right digits))]
             [words (map to-words chunks)]
             [scaled (label-magnitude (reverse words))])
        (string-join (reverse scaled) " "))))

(define (chunk-from-right chars)
  (foldr (lambda (char acc)
           (cond
             [(empty? acc) (list (list char))]
             [(< (length (first acc)) 3) (cons (cons char (first acc)) (rest acc))]
             [else (cons (list char) acc)]))
         '()
         chars))

(define (to-words chunk)
  (let ([number (string->number chunk)])
    (cond
      [(< number 20) (list-ref first-twenty number)]
      [(< number 100)
       (let* ([tens (quotient number 10)]
              [tens-word (list-ref tens-words tens)]
              [ones (remainder number 10)]
              [ones-word (list-ref first-twenty ones)])
         (if (zero? ones)
             tens-word
             (string-append tens-word "-" ones-word)))]
      [else
       (let* ([hundreds (quotient number 100)]
              [hundreds-word (list-ref first-twenty hundreds)]
              [rest (remainder number 100)]
              [rest-word (to-words (number->string rest))])
         (if (string=? rest-word "")
             (string-append hundreds-word " hundred")
             (string-append hundreds-word " hundred " rest-word)))])))

(define (label-magnitude words)
  (for/list ([word words]
             [magnitude '("" " thousand" " million" " billion")]
             #:unless (string=? word ""))
    (string-append word magnitude)))

(define first-twenty
  '("" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten"
    "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen"))

(define tens-words
  '("" "tens" "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"))
