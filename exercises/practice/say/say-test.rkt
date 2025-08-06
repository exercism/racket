#lang racket

(require "say.rkt")

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define suite
    (test-suite "say tests"

      (test-equal? "zero" (say 0) "zero")

      (test-equal? "one" (say 1) "one")

      (test-equal? "two" (say 2) "two")

      (test-equal? "fourteen" (say 14) "fourteen")

      (test-equal? "twenty" (say 20) "twenty")

      (test-equal? "twenty-two" (say 22) "twenty-two")

      (test-equal? "thirty" (say 30) "thirty")

      (test-equal? "ninety-nine" (say 99) "ninety-nine")

      (test-equal? "one hundred" (say 100) "one hundred")

      (test-equal? "one hundred twenty-three"
                   (say 123)
                   "one hundred twenty-three")

      (test-equal? "two hundred" (say 200) "two hundred")

      (test-equal? "nine hundred ninety-nine"
                   (say 999)
                   "nine hundred ninety-nine")

      (test-equal? "one thousand" (say 1000) "one thousand")

      (test-equal? "one thousand two hundred thirty-four"
                   (say 1234)
                   "one thousand two hundred thirty-four")

      (test-equal? "one million" (say 1000000) "one million")

      (test-equal? "one million two thousand three hundred forty-five"
                   (say 1002345)
                   "one million two thousand three hundred forty-five")

      (test-equal? "one billion" (say 1000000000) "one billion")

      (test-equal?
       "a big number"
       (say 987654321123)
       "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three")

      (test-exn "numbers below zero are out of range"
                exn:fail?
                (lambda () (say -1)))

      (test-exn "numbers above 999,999,999,999 are out of range"
                exn:fail?
                (lambda () (say 1000000000000)))))

  (run-tests suite))
