#lang racket

(provide keep discard)

(define (keep lst predicate)
  (for/list ([value lst]
             #:when (predicate value))
    value))

(define (discard lst predicate)
  (keep lst (negate predicate)))
