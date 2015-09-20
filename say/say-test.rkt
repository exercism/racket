#lang racket

(require "example.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define-syntax-rule (check-equal* f [arg == val] ...)
    (begin (check-equal? (f arg) val) ...))

  (define-syntax-rule (check-exn* f pat [arg] ...)
    (begin (check-exn exn:fail:contract? (lambda () (f arg))) ...))

  (define step*
    (list
      (test-suite "step1"
        (check-equal* step1
         [0 == "zero"]
         [14 == "fourteen"]
         [50 == "fifty"]
         [98 == "ninety-eight"]
         [99 == "ninety-nine"])

        (check-exn* step1
         [-1]
         [100]))

      (test-suite "step2"
        (check-equal* step2
         [1234567890 == '(1 234 576 890)]
         [1000 == '(1 0)]))

      (test-suite "step3"
        (check-equal* step3
         [1234567890 == '((1 . billion) (234 . million)
                          (567 . thousand) (890 . END))]))

      (test-suite "step4"
        (check-equal* step4
         [22 == "twenty-two"]
         [12345 == "twelve thousand three hundred forty-five"]))))

  (for ([suite (in-list step*)])
    (run-tests suite)))
