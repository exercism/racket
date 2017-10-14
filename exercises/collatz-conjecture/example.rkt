#lang racket

(provide collatz)

; uses a hash table to speed up subsequent calls
(define (collatz-length ht n)
  (cond 
    [(hash-ref ht n #f) => (lambda (colval) colval)]
    [else
     (define colval 0)
     (if (even? n) 
         (set! colval (add1 (collatz-length ht (/ n 2))))
         (set! colval (add1 (collatz-length ht (add1 (* 3 n))))))
     (hash-set! ht n colval)
     colval]))

(define (collatz n)
  (define h (make-hash (list '(1 . 0))))
  (if (and (exact-integer? n) (positive? n))
      (collatz-length h n)
      "Error: number must be a positive integer"))
  

