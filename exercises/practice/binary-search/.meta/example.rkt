#lang racket

(provide binary-search)

(define (binary-search array value)
  (define (rec left right)
    (cond
      [(> left right) (error "Value not in array")]
      [else (define mid (+ left (quotient (- right left) 2)))
            (cond
              [(< value (list-ref array mid)) (rec left (sub1 mid))]
              [(< (list-ref array mid) value) (rec (add1 mid) right)]
              [else mid])]))
  (rec 0 (sub1 (length array))))
