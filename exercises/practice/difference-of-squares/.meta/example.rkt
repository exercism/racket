#lang racket

(provide sum-of-squares square-of-sum difference)

(define (sum-of-squares n)
  (for/sum
      ([i (in-range (add1 n))])
    (* i i)))

(define (square-of-sum n)
  (let ([sum (for/sum
               ([i (in-range (add1 n))]) i)])
    (* sum sum)))

(define (difference n)
  (- (square-of-sum n) (sum-of-squares n)))
