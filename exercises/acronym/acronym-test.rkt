#lang racket/base

(require "acronym.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "acronym tests"

     (test-equal? "basic"
                  (acronym "Portable Network Graphics")
                  "PNG")

     (test-equal? "lowercase words"
                  (acronym "Ruby on Rails")
                  "ROR")

     (test-equal? "camelcase"
                  (acronym "HyperText Markup Language")
                  "HTML")

     (test-equal? "punctuation"
                  (acronym "First In, First Out")
                  "FIFO")

     (test-equal? "all caps words"
                  (acronym "PHP: Hypertext Preprocessor")
                  "PHP")

     (test-equal? "non-acronym all caps word"
                  (acronym "GNU Image Manipulation Program")
                  "GIMP")

     (test-equal? "hyphenated"
                  (acronym "Complementary metal-oxide semiconductor")
                  "CMOS")))

  (run-tests suite))
