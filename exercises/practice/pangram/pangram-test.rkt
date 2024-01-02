#lang racket/base

(require "pangram.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "pangram tests"

     (test-false "empty sentence"
                 (pangram? ""))

     (test-true "perfect lower case"
                (pangram? "abcdefghijklmnopqrstuvwxyz"))

     (test-true "only lower case"
                (pangram? "the quick brown fox jumps over the lazy dog"))

     (test-false "missing the letter 'x'"
                 (pangram? "a quick movement of the enemy will jeopardize five gunboats"))

     (test-false "missing the letter 'h'"
                 (pangram? "five boxing wizards jump quickly at it"))

     (test-true "with underscores"
                (pangram? "the_quick_brown_fox_jumps_over_the_lazy_dog"))

     (test-true "with numbers"
                (pangram? "the 1 quick brown fox jumps over the 2 lazy dogs"))

     (test-false "missing letters replaced by numbers"
                 (pangram? "t7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"))

     (test-true "mixed case and punctuation"
                (pangram? "\"Five quacking Zephyrs jolt my wax bed.\""))

     (test-false "a-m and A-M are 26 different characters but not a pangram"
                 (pangram? "abcdefghijklm ABCDEFGHIJKLM"))))

  (run-tests suite))
