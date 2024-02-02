#lang racket/base

(require "luhn.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
      "Luhn tests"

      (test-equal? "single digit strings can not be valid"
                   (valid? "1") #f)

      (test-equal? "a single zero is invalid"
                   (valid? "0") #f)

      (test-equal? "a simple valid SIN that remains valid if reversed"
                   (valid? "059") #t)

      (test-equal? "a simple valid SIN that becomes invalid if reversed"
                   (valid? "59") #t)

      (test-equal? "a valid Canadian SIN"
                   (valid? "055 444 285") #t)

      (test-equal? "invalid Canadian SIN"
                   (valid? "055 444 286") #f)

      (test-equal? "invalid credit card"
                   (valid? "8273 1232 7352 0569") #f)

      (test-equal? "invalid long number with an even remainder"
                   (valid? "1 2345 6789 1234 5678 9012") #f)

      (test-equal? "invalid long number with a remainder divisible by 5"
                   (valid? "1 2345 6789 1234 5678 9013") #f)

      (test-equal? "valid number with an even number of digits"
                   (valid? "095 245 88") #t)

      (test-equal? "valid number with an odd number of spaces"
                   (valid? "234 567 891 234") #t)

      (test-equal? "valid strings with a non-digit added at the end become invalid"
                   (valid? "059a") #f)

      (test-equal? "valid strings with punctuation included become invalid"
                   (valid? "055-444-285") #f)

      (test-equal? "valid strings with symbols included become invalid"
                   (valid? "055# 444$ 285") #f)

      (test-equal? "single zero with space is invalid"
                   (valid? " 0") #f)

      (test-equal? "more than a single zero is valid"
                   (valid? "0000 0") #t)

      (test-equal? "input digit 9 is correctly converted to output digit 9"
                   (valid? "091") #t)

      (test-equal? "very long input is valid"
                   (valid? "9999999999 9999999999 9999999999 9999999999") #t)

      (test-equal? "valid luhn with an odd number of digits and non zero first digit"
                   (valid? "109") #t)

      (test-equal? "using ascii value for non-doubled non-digit isn't allowed"
                   (valid? "055b 444 285") #f)

      (test-equal? "using ascii value for doubled non-digit isn't allowed"
                   (valid? ":9") #f)

      (test-equal? "non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed"
                   (valid? "59%59") #f)))
  
  (run-tests suite))

