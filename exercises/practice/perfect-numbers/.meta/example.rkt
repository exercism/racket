#lang racket

(provide classify)

(define (divisor-sum n)
  (for/sum ([i (in-range 1 (add1 (quotient n 2)))]
            #:when (zero? (remainder n i)))
    i))

(define/contract (classify n)
  (-> exact-positive-integer? symbol?)
  (let ([sumdivisors (divisor-sum n)])
    (cond [(= n sumdivisors) 'perfect]
          [(> n sumdivisors) 'deficient]
          [else 'abundant])))
