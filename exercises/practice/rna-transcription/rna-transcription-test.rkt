#lang racket/base

(require "rna-transcription.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "rna-transcription tests"

      (test-equal? "Empty RNA sequence"
                   (to-rna "")
                   "")

      (test-equal? "RNA complement of cytosine is guanine"
                   (to-rna "C")
                   "G")

      (test-equal? "RNA complement of guanine is cytosine"
                   (to-rna "G")
                   "C")

      (test-equal? "RNA complement of thymine is adenine"
                   (to-rna "T")
                   "A")

      (test-equal? "RNA complement of adenine is uracil"
                   (to-rna "A")
                   "U")

      (test-equal? "RNA complement"
                   (to-rna "ACGTGGTCTTAA")
                   "UGCACCAGAAUU")))

  (run-tests suite))
