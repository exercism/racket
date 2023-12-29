#lang racket

(provide binary-search)

(define (binary-search array target)
  (let loop ([lo 0] [hi (vector-length array)])
    (define mid (quotient (+ lo hi) 2))
    (cond
      [(= lo hi) (and (< lo (vector-length array))
                      (= (vector-ref array lo) target)
                      lo)]
      [(< (vector-ref array mid) target) (loop (+ 1 mid) hi)]
      [else (loop lo mid)])))
