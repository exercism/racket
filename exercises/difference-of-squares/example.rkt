#lang racket

(provide sum-of-squares square-of-sums difference)

(define (sum-of-squares n)
  (for/sum
      ([i (in-range (add1 n))])
    (* i i)))

(define (square-of-sums n)
  (let ([sum (for/sum
               ([i (in-range (add1 n))]) i)])
    (* sum sum)))

(define (difference n)
  (- (square-of-sums n) (sum-of-squares n)))
