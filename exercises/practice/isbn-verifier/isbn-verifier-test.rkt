#lang racket/base

(require "isbn-verifier.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "isbn verifier tests"

     (test-true "valid isbn"
                 (isbn? "3-598-21508-8"))

     (test-false "invalid isbn check digit"
                 (isbn? "3-598-21508-9"))

     (test-true "valid isbn with a check digit of 10"
                (isbn? "3-598-21507-X"))

     (test-false "check digit is a character other than X"
                 (isbn? "3-598-21507-A"))

     (test-false "invalid check digit in isbn is not treated as zero"
                 (isbn? "4-598-21507-B"))

     (test-false "invalid character in isbn is not treated as zero"
                 (isbn? "3-598-P1581-X"))

     (test-false "X is only valid as a check digit"
                 (isbn? "3-598-2X507-9"))

     (test-false "only one check digit is allowed"
                 (isbn? "3-598-21508-96"))

     (test-false "X is not substituted by the value 10"
                 (isbn? "3-598-2X507-5"))

     (test-true "valid isbn without separating dashes"
                 (isbn? "3598215088"))

     (test-true "isbn without separating dashes and X as check digit"
                 (isbn? "359821507X"))

     (test-false "isbn without check digit and dashes"
                 (isbn? "359821507"))

     (test-false "too long isbn and no dashes"
                 (isbn? "3598215078X"))

     (test-false "too short isbn"
                 (isbn? "00"))

     (test-false "isbn without check digit"
                 (isbn? "3-598-21507"))

     (test-false "check digit of X should not be used for 0"
                 (isbn? "3-598-21515-X"))

     (test-false "empty isbn"
                 (isbn? ""))

     (test-false "input is 9 characters"
                 (isbn? "134456729"))

     (test-false "invalid characters are not ignored after checking length"
                 (isbn? "3132P34035"))

     (test-false "invalid characters are not ignored before checking length"
                 (isbn? "3598P215088"))

     (test-false "input is too long but contains a valid isbn"
                 (isbn? "98245726788"))))

  (run-tests suite))
