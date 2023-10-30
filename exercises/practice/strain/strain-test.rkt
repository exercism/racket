#lang racket/base

(require "strain.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "strain tests"

     (test-equal? "keep on empty list returns empty list"
                  (keep '() "fn(x) -> true")
                  '())

     (test-equal? "keeps everything"
                  (keep '(1 3 5) "fn(x) -> true")
                  '(1 3 5))

     (test-equal? "keeps nothing"
                  (keep '(1 3 5) "fn(x) -> false")
                  '())

     (test-equal? "keeps first and last"
                  (keep '(1 2 3) "fn(x) -> x % 2 == 1")
                  '(1 3))

     (test-equal? "keeps neither first nor last"
                  (keep '(1 2 3) "fn(x) -> x % 2 == 0")
                  '(2))

     (test-equal? "keeps strings"
                  (keep '("apple" "zebra" "banana" "zombies" "cherimoya" "zealot") "fn(x) -> starts_with(x, 'z')")
                  '("zebra" "zombies" "zealot"))

     (test-equal? "keeps lists"
                  (keep '('(1 2 3) '(5 5 5) '(5 1 2) '(2 1 2) '(1 5 2) '(2 2 1) '(1 2 5)) "fn(x) -> contains(x, 5)")
                  '('(5 5 5) '(5 1 2) '(1 5 2) '(1 2 5)))

     (test-equal? "discard on empty list returns empty list"
                  (discard '() "fn(x) -> true")
                  '())

     (test-equal? "discards everything"
                  (discard '(1 3 5) "fn(x) -> true")
                  '())

     (test-equal? "discards nothing"
                  (discard '(1 3 5) "fn(x) -> false")
                  '(1 3 5))

     (test-equal? "discards first and last"
                  (discard '(1 2 3) "fn(x) -> x % 2 == 1")
                  '(2))

     (test-equal? "discards neither first nor last"
                  (discard '(1 2 3) "fn(x) -> x % 2 == 0")
                  '(1 3))

     (test-equal? "discards strings"
                  (discard '("apple" "zebra" "banana" "zombies" "cherimoya" "zealot") "fn(x) -> starts_with(x, 'z')")
                  '("apple" "banana" "cherimoya"))

     (test-equal? "discards lists"
                  (discard '('(1 2 3) '(5 5 5) '(5 1 2) '(2 1 2) '(1 5 2) '(2 2 1) '(1 2 5)) "fn(x) -> contains(x, 5)")
                  '('(1 2 3) '(2 1 2) '(2 2 1)))))

  (run-tests suite))
