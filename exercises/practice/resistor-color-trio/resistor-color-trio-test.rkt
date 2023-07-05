#lang racket/base

(require "resistor-color-trio.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (run-tests
   (test-suite "resistor-color tests"
               (test-equal? "Orange and orange and black"
                            (color-code '("orange" "orange" "black"))
                            "33 ohms")
               (test-equal? "Blue and grey and brown"
                            (color-code '("blue" "grey" "brown"))
                            "680 ohms")
               (test-equal? "Red and black and red"
                            (color-code '("red" "black" "red"))
                            "2 kiloohms")
               (test-equal? "Green and brown and orange"
                            (color-code '("green" "brown" "orange"))
                            "51 kiloohms")
               (test-equal? "Yellow and violet and yellow"
                            (color-code '("yellow" "violet" "yellow"))
                            "470 kiloohms")
               (test-equal? "Blue and violet and blue"
                            (color-code '("blue" "violet" "blue"))
                            "67 megaohms")
               (test-equal? "Minimum possible value"
                            (color-code '("black" "black" "black"))
                            "0 ohms")
               (test-equal? "Maximum possible value"
                            (color-code '("white" "white" "white"))
                            "99 gigaohms")
               (test-equal? "First two colors make an invalid octal number"
                            (color-code '("black" "grey" "black"))
                            "8 ohms")
              (test-equal? "Ignore extra colors"
                            (color-code '("blue" "green" "yellow" "orange"))
                            "650 kiloohms"))))
