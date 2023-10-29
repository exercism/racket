#lang racket

(provide recite)

(define (recite lst)
  (cond
    [(empty? lst) '()]
    [else (define (verse index)
            (cond
              [(= index (sub1 (length lst))) (list (format "And all for the want of a ~a." (list-ref lst 0)))]
              [else (append
                     (list (format "For want of a ~a the ~a was lost."
                                   (list-ref lst index)
                                   (list-ref lst (add1 index))))
                     (verse (add1 index)))]))
          (verse 0)]))
