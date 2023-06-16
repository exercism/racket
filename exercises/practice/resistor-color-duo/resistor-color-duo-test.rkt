#lang racket/base

(require "resistor-color-duo.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (run-tests
   (test-suite "resistor-color tests"
               (test-equal? "Brown and black"
                            (color-code '("brown" "black"))
                            10)
               (test-equal? "Blue and grey"
                            (color-code '("blue" "grey"))
                            68)
               (test-equal? "Yellow and violet"
                            (color-code '("yellow" "violet"))
                            47)
               (test-equal? "White and red"
                            (color-code '("white" "red"))
                            92)
               (test-equal? "Orange and orange"
                            (color-code '("orange" "orange"))
                            33)
               (test-equal? "Ignore additional colors"
                            (color-code '("green" "brown" "orange"))
                            51)
               (test-equal? "Black and brown, one-digit"
                            (color-code '("black" "brown"))
                            1))))
