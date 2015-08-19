#lang racket

(provide perfect-numbers)

(define (perfect-numbers n)
  (filter perfect? (range 1 (add1 n))))

(define (perfect? n)
  (= (apply + (filter (lambda (x)
            (zero? (modulo n x))) (range 1 n))) n))
