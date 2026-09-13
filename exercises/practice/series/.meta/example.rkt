#lang racket

(provide slices)

(define (slices series slice-length)
  (cond
    [(string=? series "")
     (error "series cannot be empty")]
    [(negative? slice-length)
     (error "slice length cannot be negative")]
    [(zero? slice-length)
     (error "slice length cannot be zero")]
    [(> slice-length (string-length series))
     (error "slice length cannot be greater than series length")]
    [else
     (for/list ([start (in-range (add1 (- (string-length series) slice-length)))])
       (substring series start (+ start slice-length)))]))
