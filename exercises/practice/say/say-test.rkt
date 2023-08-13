#lang racket

(require "say.rkt")


(module+ test
  (require rackunit rackunit/text-ui)

  (define (exn-msg-matches? msg f)
    (with-handlers ([exn:fail? (lambda (exn)
                                 (string=? (exn-message exn) msg))])
      (f)))

  (define suite
    (test-suite
      "say tests"

        (test-equal? "zero"
                    (spell-out 0)
                    "zero")

        (test-equal? "one"
                    (spell-out 1)
                    "one")

        (test-equal? "fourteen"
                    (spell-out 14)
                    "fourteen")

        (test-equal? "twenty"
                    (spell-out 20)
                    "twenty")

        (test-equal? "twenty-two"
                    (spell-out 22)
                    "twenty-two")

        (test-equal? "thirty"
                    (spell-out 30)
                    "thirty")

        (test-equal? "ninety-nine"
                    (spell-out 99)
                    "ninety-nine")

        (test-equal? "one hundred"
                    (spell-out 100)
                    "one hundred")

        (test-equal? "one hundred twenty-three"
                    (spell-out 123)
                    "one hundred twenty-three")

        (test-equal? "two hundred"
                    (spell-out 200)
                    "two hundred")

        (test-equal? "nine hundred ninety-nine"
                    (spell-out 999)
                    "nine hundred ninety-nine")

        (test-equal? "one thousand"
                    (spell-out 1000)
                    "one thousand")

        (test-equal? "one thousand two hundred thirty-four"
                    (spell-out 1234)
                    "one thousand two hundred thirty-four")

        (test-equal? "one million"
                    (spell-out 1000000)
                    "one million")

        (test-equal? "one million two thousand three hundred forty-five"
                    (spell-out 1002345)
                    "one million two thousand three hundred forty-five")

        (test-equal? "one billion"
                    (spell-out 1000000000)
                    "one billion")

        (test-equal? "a big number"
                    (spell-out 987654321123)
                    "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three")
        
        (test-true "numbers below zero are out of range"
                (exn-msg-matches?
                  "input out of range"
                  (lambda () (spell-out -1))))
        
        (test-true "numbers above 999,999,999,999 are out of range"
                (exn-msg-matches?
                  "input out of range"
                  (lambda () (spell-out 1000000000000))))))

 (run-tests suite))
