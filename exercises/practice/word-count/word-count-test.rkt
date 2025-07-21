#lang racket

(require "word-count.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "word-count tests"

     (test-equal? "count one word"
                  (word-count "word")
                  '#hash(("word" . 1)))

     (test-equal? "count one of each word"
                  (word-count "one of each")
                  '#hash(("one" . 1) ("of" . 1) ("each" . 1)))

     (test-equal? "multiple occurrences of a word"
                  (word-count "one fish two fish red fish blue fish")
                  '#hash(("one" . 1) ("fish" . 4) ("two" . 1) ("red" . 1) ("blue" . 1)))

     (test-equal? "handles cramped lists"
                  (word-count "one,two,three")
                  '#hash(("one" . 1) ("two" . 1) ("three" . 1)))

     (test-equal? "handles expanded lists"
                  (word-count "one,\ntwo,\nthree")
                  '#hash(("one" . 1) ("two" . 1) ("three" . 1)))

     (test-equal? "ignore punctuation"
                  (word-count "car : carpet as java : javascript!!&@$%^&")
                  '#hash(("car" . 1) ("carpet" . 1) ("as" . 1) ("java" . 1) ("javascript" . 1)))

     (test-equal? "include numbers"
                  (word-count "testing, 1, 2, testing")
                  '#hash(("testing" . 2) ("1" . 1) ("2" . 1)))

     (test-equal? "normalize case"
                  (word-count "go Go GO Stop stop")
                  '#hash(("go" . 3) ("stop" . 2)))

     (test-equal? "with apostrophes"
                  (word-count "'First: don't laugh. Then: don't cry. You're getting it.'")
                  '#hash(("first" . 1) ("don't" . 2) ("laugh" . 1) ("then" . 1) ("cry" . 1)
                                       ("you're" . 1) ("getting" . 1) ("it" . 1)))

     (test-equal? "with quotations"
                  (word-count "Joe can't tell between 'large' and large.")
                  '#hash(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1) ("large" . 2)
                                     ("and" . 1)))

     (test-equal? "substrings from the beginning"
                  (word-count "Joe can't tell between app, apple and a.")
                  '#hash(("joe" . 1) ("can't" . 1) ("tell" . 1) ("between" . 1) ("app" . 1)
                                     ("apple" . 1) ("and" . 1) ("a" . 1)))

     (test-equal? "multiple spaces not detected as a word"
                  (word-count " multiple   whitespaces")
                  '#hash(("multiple" . 1) ("whitespaces" . 1)))

     (test-equal? "alternating word separators not detected as a word"
                  (word-count ",\n,one,\n ,two \n 'three'")
                  '#hash(("one" . 1) ("two" . 1) ("three" . 1)))

     (test-equal? "quotation for word with apostrophe"
                  (word-count "can, can't, 'can't'")
                  '#hash(("can" . 1) ("can't" . 2)))))

  (run-tests suite))
