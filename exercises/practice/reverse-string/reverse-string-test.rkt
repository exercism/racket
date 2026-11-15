#lang racket/base

(require "reverse-string.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "reverse-string tests"

      (test-equal? "an empty string"
                   (my-reverse "")
                   "")

      (test-equal? "a word"
                   (my-reverse "robot")
                   "tobor")

      (test-equal? "a capitalized word"
                   (my-reverse "Ramen")
                   "nemaR")

      (test-equal? "a sentence with punctuation"
                   (my-reverse "I'm hungry!")
                   "!yrgnuh m'I")

      (test-equal? "a palindrome"
                   (my-reverse "racecar")
                   "racecar")

      (test-equal? "an even-sized word"
                   (my-reverse "drawer")
                   "reward")

      (test-equal? "wide characters"
                   (my-reverse "子猫")
                   "猫子")))

  (run-tests suite))
