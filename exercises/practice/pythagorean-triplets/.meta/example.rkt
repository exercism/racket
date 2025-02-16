#lang racket

(provide triplets-with-sum)

(define (primitives pmax)
  (for*/list
    ([m (in-naturals 2)]
     #:break (> (* 2 (* m (add1 m))) pmax)
     [n (in-range (add1 (remainder m 2)) m 2)]
     #:when (= 1 (gcd m n)))
    (define a (- (* m m) (* n n)))
    (define b (* 2 (* m n)))
    (define c (+ (* m m) (* n n)))
    (sort (list a b c) < )))

(define (triplets-with-sum p)
  (define (scale-up triple)
     (define perimeter (for/sum ([t triple]) t))
     (cond
       [(zero? (remainder p perimeter))
         (define k (quotient p perimeter))
         (for/list ([t triple]) (* k t))]
       [else #f]))
   (sort (filter-map scale-up (primitives p)) < #:key car))
