#lang racket

(provide triangle?)

(define (triangle? sides kind)
  (let ([a (first sides)]
        [b (second sides)]
        [c (third sides)])
    (if (and (< 0 a) (< 0 b) (< 0 c)
            (> (+ a b) c)
            (> (+ a c) b)
            (> (+ b c) a))
        (case kind
          [(equilateral)  (test-equilateral a b c)]
          [(isosceles)    (test-isosceles a b c)]
          [(scalene)      (test-scalene a b c)])
        #f)))

(define (test-equilateral a b c)
  (= a b c))

(define (test-isosceles a b c)
  (or (= a b)
      (= a c)
      (= b c)))

(define (test-scalene a b c)
  (not (test-isosceles a b c)))
