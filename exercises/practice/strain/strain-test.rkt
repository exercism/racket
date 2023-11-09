#lang racket/base

(require "strain.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define (always-true _) #t)

  (define (always-false _) #f)

  (define (contains-5? lst) (member 5 lst))

  (define (starts-with-z? str) (char=? (string-ref str 0) #\z))

  (define suite
    (test-suite
     "strain tests"

     (test-equal? "keep on empty list returns empty list"
                  (keep '() always-true)
                  '())

     (test-equal? "keeps everything"
                  (keep '(1 3 5) always-true)
                  '(1 3 5))

     (test-equal? "keeps nothing"
                  (keep '(1 3 5) always-false)
                  '())

     (test-equal? "keeps first and last"
                  (keep '(1 2 3) odd?)
                  '(1 3))

     (test-equal? "keeps neither first nor last"
                  (keep '(1 2 3) even?)
                  '(2))

     (test-equal? "keeps strings"
                  (keep '("apple" "zebra" "banana" "zombies" "cherimoya" "zealot")
                        starts-with-z?)
                  '("zebra" "zombies" "zealot"))

     (test-equal? "keeps lists"
                  (keep (list '(1 2 3) '(5 5 5) '(5 1 2) '(2 1 2) '(1 5 2) '(2 2 1) '(1 2 5))
                        contains-5?)
                  (list '(5 5 5) '(5 1 2) '(1 5 2) '(1 2 5)))

     (test-equal? "discard on empty list returns empty list"
                  (discard '() always-true)
                  '())

     (test-equal? "discards everything"
                  (discard '(1 3 5) always-true)
                  '())

     (test-equal? "discards nothing"
                  (discard '(1 3 5) always-false)
                  '(1 3 5))

     (test-equal? "discards first and last"
                  (discard '(1 2 3) odd?)
                  '(2))

     (test-equal? "discards neither first nor last"
                  (discard '(1 2 3) even?)
                  '(1 3))

     (test-equal? "discards strings"
                  (discard '("apple" "zebra" "banana" "zombies" "cherimoya" "zealot")
                           starts-with-z?)
                  '("apple" "banana" "cherimoya"))

     (test-equal? "discards lists"
                  (discard (list '(1 2 3) '(5 5 5) '(5 1 2) '(2 1 2) '(1 5 2) '(2 2 1) '(1 2 5))
                           contains-5?)
                  (list '(1 2 3) '(2 1 2) '(2 2 1)))))

  (run-tests suite))
