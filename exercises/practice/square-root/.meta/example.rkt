#lang racket

(provide square-root)

(define/contract (square-root radicand)
  (-> exact-positive-integer? (or/c exact-positive-integer?
                                    false?))
  (for/first ([num (in-inclusive-range 1 radicand)]
              #:when (equal? (expt num 2) radicand))
    num))
