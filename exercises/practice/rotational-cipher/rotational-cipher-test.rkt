#lang racket

(require "rotational-cipher.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "Rotational cipher tests"

     (test-equal? "rotate a by 0, same output as input"
                  (rotate "a" 0)
                  "a")

     (test-equal? "rotate a by 1"
                  (rotate "a" 1)
                  "b")

     (test-equal? "rotate a by 26, same output as input"
                  (rotate "a" 26)
                  "a")


     (test-equal? "rotate m by 13"
                  (rotate "m" 13)
                  "z")

     (test-equal? "rotate n by 13 with wrap around alphabet"
                  (rotate "n" 13)
                  "a")

     (test-equal? "rotate capital letters"
                  (rotate "OMG" 5)
                  "TRL")

     (test-equal? "rotate spaces"
                  (rotate "O M G" 5)
                  "T R L")

     (test-equal? "rotate numbers"
                  (rotate "Testing 1 2 3 testing" 4)
                  "Xiwxmrk 1 2 3 xiwxmrk")

     (test-equal? "rotate punctuation"
                  (rotate "Let's eat, Grandma!" 21)
                  "Gzo'n zvo, Bmviyhv!")

     (test-equal? "rotate all letters"
                  (rotate "The quick brown fox jumps over the lazy dog." 13)
                  "Gur dhvpx oebja sbk whzcf bire gur ynml qbt.")))

  (run-tests suite))
