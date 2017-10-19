#lang racket

(provide collatz)

(define (collatz-length n [acc 0])
  (if (= n 1)
      acc
      (collatz-length (if (even? n)
                          (/ n 2)
                          (add1 (* 3 n)))
                      (add1 acc))))

(define (collatz n)
  (if (nand (exact-integer? n)
            (positive? n))
      (error "number must be a positive integer")
      (collatz-length n)))
  

  