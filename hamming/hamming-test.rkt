#lang racket

(require rackunit
         rackunit/text-ui
         "hamming.rkt")

(define suite
  (test-suite
    "Tests for the hamming exercise"
    (check-equal? 0 (hamming-distance "A" "A")
                  "identical strands")
    (check-equal? 0 (hamming-distance "GGACTGA" "GGACTGA")
                  "long identical strands")
    (check-equal? 1 (hamming-distance "A" "G")
                  "complete distance in single nucleotide strands")
    (check-equal? 2 (hamming-distance "AG" "CT")
                  "complete distance in small strands")
    (check-equal? 1 (hamming-distance "AT" "CT")
                  "small distance in small strands")
    (check-equal? 1 (hamming-distance "GGACG" "GGTCG")
                  "small distance")
    (check-equal? 2 (hamming-distance "ACCAGGG" "ACTATGG")
                  "small distance in long strands")
    (check-equal? 1 (hamming-distance "AGA" "AGG")
                  "non-unique character in first strand")
    (check-equal? 1 (hamming-distance "AGG" "AGA")
                  "non-unique character in second strand")
    (check-equal? 4 (hamming-distance "GATACA" "GCATAA")
                  "large distance")
    (check-equal? 9 (hamming-distance "GGACGGATTCTG" "AGGACGGATTCT")
                  "large distance in off-by-one strand")
    (check-equal? 0 (hamming-distance "" "")
                  "empty strands")
    (check-exn #rx"strings of equal length"
               (thunk (hamming-distance "AATG" "AAA"))
               "disallow first strand longer")
    (check-exn #rx"strings of equal length"
               (thunk (hamming-distance "ATA" "AGTG"))
               "disallow second string longer")))

(exit (if (zero? (run-tests suite)) 0 1))
