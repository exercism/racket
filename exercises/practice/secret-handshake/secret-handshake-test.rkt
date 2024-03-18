#lang racket/base

(require "secret-handshake.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite "secret handshake tests"
      (test-equal? "wink for 1"
        (commands 1)
        '("wink"))

      (test-equal? "double blink for 10"
        (commands 2)
        '("double blink"))

      (test-equal? "close your eyes for 100"
        (commands 4)
        '("close your eyes"))

      (test-equal? "jump for 1000"
        (commands 8)
        '("jump"))

      (test-equal? "combine two actions"
        (commands 3)
        '("wink" "double blink"))

      (test-equal? "reverse two actions"
        (commands 19)
        '("double blink" "wink"))

      (test-equal? "reversing one action gives the same action"
        (commands 24)
        '("jump"))

      (test-equal? "reversing no actions still gives no actions"
        (commands 16)
        '())

      (test-equal? "all possible actions"
        (commands 15)
        '("wink" "double blink" "close your eyes" "jump"))

      (test-equal? "reverse all possible actions"
        (commands 31)
        '("jump" "close your eyes" "double blink" "wink"))

      (test-equal? "do nothing for zero"
        (commands 0)
        '())))

  (run-tests suite))
