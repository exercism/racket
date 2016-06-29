#lang racket

(provide accumulate)

(define (accumulate lst op)
  (cond
    [(empty? lst) lst]
    [(cons (op (car lst)) (accumulate (cdr lst) op))]))