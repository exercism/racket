#lang racket

(provide sum-of-squares square-of-sums difference)

(define (sum-of-squares n)
  (apply + (map (lambda (i) (expt i 2)) (range 1 (+ n 1)))))

(define (square-of-sums n)
  (expt (apply + (range 1 (+ n 1))) 2))

(define (difference n)
  (- (square-of-sums n)
     (sum-of-squares n)))
