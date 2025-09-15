#lang racket/base

(require "hamming.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "hamming tests"

     (test-equal? "empty strands"
                  (hamming-distance "" "")
                  0)
    
     (test-equal? "single letter identical strands"
                  (hamming-distance "A" "A")
                  0)

     (test-equal? "single letter different strands"
                  (hamming-distance "G" "T")
                  1)
              
     (test-equal? "long identical strands"
                  (hamming-distance "GGACTGAAATCTG" "GGACTGAAATCTG")
                  0)

     (test-equal? "long different strands"
                  (hamming-distance "GGACGGATTCTG" "AGGACGGATTCT")
                  9)

     (test-exn "disallow first strand longer" exn:fail?
               (lambda ()
                 (hamming-distance "AATG" "AAA")))
      
     (test-exn "disallow second strand longer" exn:fail?
               (lambda ()
                 (hamming-distance "ATA" "AGTG")))

     (test-exn "disallow left empty strand" exn:fail?
               (lambda ()
                 (hamming-distance "" "G")))

     (test-exn "disallow right empty strand" exn:fail?
               (lambda ()
                 (hamming-distance "G" "")))))

  (run-tests suite))
