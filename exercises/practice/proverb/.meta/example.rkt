#lang racket

(provide recite)

(define (recite lst)
  (cond
    [(empty? lst) '()]
    [else (append
           (for/list ([value lst]
                      [next-value (rest lst)])
             (format "For want of a ~a the ~a was lost." value next-value))
           (list (format "And all for the want of a ~a." (first lst))))]))
