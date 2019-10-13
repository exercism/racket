#lang racket

(require "triangle.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define equilateral
    (test-suite
     "Equilateral tests"

     (test-true "All sides are equal"
                (triangle? '(2 2 2) 'equilateral))
      ))

  (begin
    (run-tests equilateral)))
