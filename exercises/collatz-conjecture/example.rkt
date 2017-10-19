#lang racket

(provide collatz)

(define (collatz n)
  (if (= n 1)
      0
      (if (and (exact-integer? n) (positive? n))
          (add1
           (if (even? n) 
               (collatz (/ n 2))
               (collatz (add1 (* 3 n)))))
          (error "number must be a positive integer"))))
  

  