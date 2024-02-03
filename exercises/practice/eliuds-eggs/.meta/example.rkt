#lang racket

(provide number->eggs)

(define (number->eggs n)
  (define (recurse val eggs)
    (define updated (floor (/ val 2)))
    (or (and (zero? val) eggs)
        (if (odd? val)
            (recurse updated (add1 eggs))
            (recurse updated eggs))))
  (recurse n 0))
