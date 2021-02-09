#lang racket

(provide (contract-out
          [armstrong-number? (exact-nonnegative-integer? . -> . boolean?)]))

(define (list-digits n)
  (let loop ([N n]
             [a '()])
    (let-values ([(q r) (quotient/remainder N 10)])
      (if (zero? N)
          a
          (loop q (cons r a))))))

(define (armstrong-number? n)
  (let* ([digits (list-digits n)]
         [number-of-digits (length digits)])
    (= n
       (for/sum ([d digits])
         (expt d number-of-digits)))))