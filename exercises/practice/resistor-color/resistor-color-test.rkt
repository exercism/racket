#lang racket/base

; Tests adapted from `problem-specifications/canonical-data.json v1.1.0
(require "resistor-color.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (run-tests
   (test-suite "resistor-color tests"
               (test-equal? "Color codes -> Black"
                            (color-code "black")
                            0)
               (test-equal? "Color codes -> White"
                            (color-code "white")
                            9)
               (test-equal? "Color codes -> Orange"
                            (color-code "orange")
                            3)
               (test-equal? "Colors"
                            (colors)
                            '("black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white")))))
