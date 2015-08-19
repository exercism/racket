#lang racket

(require rackunit
         rackunit/text-ui
         "word-count.rkt")

(define suite
  (test-suite
    "Tests for the word-count exercise"
    (check-equal? (word-count "word")
                  '#hash(("word" . 1))
                  "one word")
    (check-equal? (word-count "one of each")
                  '#hash(("one" . 1) ("of" . 1) ("each" . 1))
                  "one of each")
    (check-equal? (word-count "one fish two fish red fish blue fish")
                  '#hash(("one" . 1) ("fish" . 4) ("two" . 1) ("red" . 1) ("blue" . 1))
                  "multiple occurrences")
    (check-equal? (word-count "car : carpet as java : javascript!!&@$%^&")
                  '#hash(("car" . 1) (":" . 2) ("carpet" . 1) ("as" . 1) ("java" . 1)
                                     ("javascript!!&@$%^&" . 1))
                  "preserves punctuation")
    (check-equal? (word-count "testing 1 2 testing")
                  '#hash(("testing" . 2) ("1" . 1) ("2" . 1))
                  "include numbers")
    (check-equal? (word-count "go Go GO")
                  '#hash(("go" . 1) ("Go" . 1) ("GO" . 1))
                  "mixed case")
    (check-equal? (word-count "wait for       it")
                  '#hash(("wait" . 1) ("for" . 1) ("it" . 1))
                  "multiple spaces")
    (check-equal? (word-count "rah rah ah ah ah\nroma roma ma\nga ga oh la la\nwant your bad romance")
                  '#hash(("rah" . 2) ("ah" . 3) ("roma" . 2) ("ma" . 1) ("ga" . 2) ("oh" . 1)
                                     ("la" . 2) ("want" . 1) ("your" . 1) ("bad" . 1)
                                     ("romance" . 1))
                  "newlines")))

(exit (if (zero? (run-tests suite)) 0 1))
