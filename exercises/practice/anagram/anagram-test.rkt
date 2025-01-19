#lang racket/base

(require "anagram.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
     "anagram tests"

     (test-equal? "no-matches"
                  (anagrams-for "diaper"
                                '("hello" "world" "zombies" "pants"))
                  '())

     (test-equal? "detects two anagrams"
                  (sort (anagrams-for "solemn"
                                      '("lemons" "cherry" "melons"))
                        string<?)
                  '("lemons" "melons"))

     (test-equal? "does not detect anagram subsets"
                  (anagrams-for "good"
                                '("dog" "goody"))
                  '())

     (test-equal? "detects anagram"
                  (anagrams-for "listen" 
                                '("enlists" "google" "inlets" "banana"))
                  '("inlets"))

     (test-equal? "detects three anagrams"
                  (sort (anagrams-for "allergy"
                                      '("gallery" 
                                        "ballerina" 
                                        "regally"
                                        "clergy"
                                        "largely"
                                        "leading"))
                        string<?)

                  '("gallery" "regally" "largely"))

     (test-equal? "detects multiple anagrams with different case"
                  (sort (anagrams-for "nose"
                                      '("Eons" "ONES"))
                        string<?)
                  '("Eons" "ONES"))

     (test-equal? "does not detect non-anagrams with identical checksum"
                  (anagrams-for "mass"
                                '("last"))
                  '())

     (test-equal? "detects anagrams case-insensitively"
                  (anagrams-for "Orchestra"
                                '("cashregister" "Carthorse" "radishes"))
                  '("Carthorse"))

     (test-equal? "detects anagrams using case-insensitive subject"
                  (anagrams-for "Orchestra"
                                '("cashregister" "carthorse" "radishes"))
                  '("carthorse"))

     (test-equal? "detects anagrams using case-insensitive possible matches"
                  (anagrams-for "orchestra"
                                '("cashregister" "Carthorse" "radishes"))
                  '("Carthorse"))
                  
     (test-equal? "does not detect an anagram if the original word is repeated"
                  (anagrams-for "go"
                                '("goGoGO"))
                  '())

     (test-equal? "anagrams must use all letters exactly once"
                  (anagrams-for "tapper"
                                '("patter"))
                  '())

     (test-equal? "words are not anagrams of themselves"
                  (anagrams-for "BANANA"
                                '("BANANA"))
                  '())

     (test-equal? "words are not anagrams of themselves even if letter case is partially different"
                  (anagrams-for "BANANA"
                                '("Banana"))
                  '())
                
     (test-equal? "words are not anagrams of themselves even if letter case is completely different"
                  (anagrams-for "BANANA"
                                '("banana"))
                  '())

     (test-equal? "words other than themselves can be anagrams"
                  (anagrams-for "LISTEN"
                                '("LISTEN" "Silent"))
                  '("Silent"))))

  (run-tests suite))
