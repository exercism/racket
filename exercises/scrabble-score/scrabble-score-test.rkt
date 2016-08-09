#lang racket/base

(module+ test
  (require "scrabble-score.rkt")

  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "scrabble tests"

     (test-eqv? "a is worth one point"
                (score "a")
                1)

     (test-eqv? "scoring is case insensitive"
                (score "A")
                1)

     (test-eqv? "f is worth four"
                (score "f")
                4)

     (test-eqv? "two one point letters make a two point word"
                (score "at")
                2)

     (test-eqv? "three letter word"
                (score "zoo")
                12)

     (test-eqv? "medium word"
                (score "street")
                6)

     (test-eqv? "longer words with valuable letters"
                (score "quirky")
                22)

     (test-eqv? "long mixed case word"
                (score "OxyphenButazone")
                41)

     (test-eqv? "english scrabble letters score"
                (score "pinata")
                8)

     (test-eqv? "non english scrabble letters do not score"
                (score "piñata")
                7)

     (test-eqv? "empty words are worth zero"
                (score "")
                0)

     ))

  (run-tests suite))
