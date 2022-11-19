#lang racket

(require "triangle.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define equilateral
    (test-suite
     "Equilateral tests"

     (test-true "All sides are equal"
                (triangle? '(2 2 2) 'equilateral))

     (test-false "Any side is unequal"
                  (triangle? '(2 3 2) 'equilateral))

     (test-false "No sides are equal"
                  (triangle? '(5 4 6) 'equilateral))

     (test-false "All zero sides is not a triangle"
                  (triangle? '(0 0 0) 'equilateral))

     (test-true "Sides may be floats"
                  (triangle? '(0.5 0.5 0.5) 'equilateral))
      ))

  (define isosceles
    (test-suite
     "Isosceles tests"

     (test-true "Last two sides are equal"
                (triangle? '(3 4 4) 'isosceles))

     (test-true "First two sides are equal"
                (triangle? '(4 4 3) 'isosceles))

     (test-true "First and last sides are equal"
                (triangle? '(4 3 4) 'isosceles))

     (test-true "Equilateral triangles are also isosceles"
                (triangle? '(4 4 4) 'isosceles))

     (test-false "No sides are equal"
                (triangle? '(2 3 4) 'isosceles))

     (test-false "First triangle inequality violation"
                (triangle? '(1 1 3) 'isosceles))

     (test-false "Second triangle inequality violation"
                (triangle? '(1 3 1) 'isosceles))

     (test-false "Third triangle inequality violation"
                (triangle? '(3 1 1) 'isosceles))

     (test-true "Sides may be floats"
                (triangle? '(0.5 0.4 0.5) 'isosceles))
      ))

  (define scalene
    (test-suite
     "Scalene tests"

     (test-true "No sides are equal"
                (triangle? '(5 4 6) 'scalene))

     (test-false "All sides are equal"
                (triangle? '(4 4 4) 'scalene))

     (test-false "Two sides are equal"
                (triangle? '(4 4 3) 'scalene))

     (test-false "May not violate triangle inequality"
                (triangle? '(7 3 2) 'scalene))

     (test-true "Sides may be floats"
                (triangle? '(0.5 0.4 0.6) 'scalene))

      ))

  (begin
    (run-tests equilateral)
    (run-tests isosceles)
    (run-tests scalene)))
