#lang racket

(require math/number-theory)

(provide classify)

(define (classify n)
  (let ([sumdivisors (- (divisor-sum n) n)])
    (cond [(= n sumdivisors) 'perfect]
          [(> n sumdivisors) 'deficient]
          [else 'abundant])))
