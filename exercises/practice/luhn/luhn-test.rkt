#lang racket/base

(require "luhn.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
      "Luhn tests"

      (test-false "single digit strings can not be valid" (valid? "1"))

      (test-false "a single zero is invalid" (valid? "0"))

      (test-true "a simple valid SIN that remains valid if reversed"
                  (valid? "059"))

      (test-true "a simple valid SIN that becomes invalid if reversed"
                  (valid? "59"))

      (test-true "a valid Canadian SIN" (valid? "055 444 285"))

      (test-false "invalid Canadian SIN" (valid? "055 444 286"))

      (test-false "invalid credit card" (valid? "8273 1232 7352 0569"))

      (test-false "invalid long number with an even remainder"
                   (valid? "1 2345 6789 1234 5678 9012"))

      (test-false "invalid long number with a remainder divisible by 5"
                   (valid? "1 2345 6789 1234 5678 9013"))

      (test-true "valid number with an even number of digits"
                  (valid? "095 245 88"))

      (test-true "valid number with an odd number of spaces"
                  (valid? "234 567 891 234"))

      (test-false "valid strings with a non-digit added at the end become invalid"
                   (valid? "059a"))

      (test-false "valid strings with punctuation included become invalid"
                  (valid? "055-444-285"))

      (test-false "valid strings with symbols included become invalid"
                  (valid? "055# 444$ 285"))

      (test-false "single zero with space is invalid" (valid? " 0"))

      (test-true "more than a single zero is valid" (valid? "0000 0"))

      (test-true "input digit 9 is correctly converted to output digit 9"
                 (valid? "091"))

      (test-true "very long input is valid"
                 (valid? "9999999999 9999999999 9999999999 9999999999"))

      (test-true "valid luhn with an odd number of digits and non zero first digit"
                 (valid? "109"))

      (test-false "using ascii value for non-doubled non-digit isn't allowed"
                  (valid? "055b 444 285"))

      (test-false "using ascii value for doubled non-digit isn't allowed"
                  (valid? ":9"))

      (test-false "non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed"
                  (valid? "59%59"))))
  
  (run-tests suite))
