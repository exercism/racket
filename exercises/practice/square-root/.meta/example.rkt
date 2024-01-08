#lang racket

(provide square-root)

(define (square-root radicand)
    (for/first ([num (in-naturals)]
                #:when (equal? (expt num 2) radicand))
      num))