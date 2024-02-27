#lang racket

(provide spiral-matrix)

(define (extract-row r coord)
  (let* ([row (filter (λ (c) (= (caar c) r)) coord)]
         [sorted-row (sort row < #:key cdar)])
    (map cdr sorted-row)))

(define (take-step x y dx dy n h)
  (let ([x1 (+ x dx)] [y1 (+ y dy)])
    (if (or (negative? x1) (negative? y1)
            (= x1 n) (= y1 n) (hash-has-key? h (cons y1 x1)))
      (values (- x dy) (+ y dx) (- dy) dx)
      (values x1 y1 dx dy))))

(define (coordinates n)
  (let ([h (make-hash)])
    (for/fold
      ([x 0] [y 0] [dx 1] [dy 0] #:result (hash->list h))
      ([i (in-inclusive-range 1 (* n n))])
      (hash-set! h (cons y x) i)
      (take-step x y dx dy n h))))

(define (spiral-matrix n)
  (let ([coord (coordinates n)])
    (for/list ([i (in-range n)])
      (extract-row i coord))))
