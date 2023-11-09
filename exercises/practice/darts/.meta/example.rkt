#lang racket

(provide score)

(define (score x y)
  (let ([distance (sqrt (+ (* x x) (* y y)))])
    (cond
      [(<= distance 1.0) 10]
      [(<= distance 5.0) 5]
      [(<= distance 10.0) 1]
      [else 0]
    )))
