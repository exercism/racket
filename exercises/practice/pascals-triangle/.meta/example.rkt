#lang racket

(provide rows)

(define (next-row bottom)
  (do ([xs bottom (cdr xs)]
       [left 0 (car xs)]
       [row '() (cons (+ left (car xs)) row)])
    ((null? xs) (cons 1 row))))

(define (rows height)
  (for/fold ([triangle '(())]
             #:result(if (null? triangle)
                       triangle
                       (cdr (reverse triangle))))
    ([r (in-range height)])
    (cons (next-row (car triangle)) triangle)))
