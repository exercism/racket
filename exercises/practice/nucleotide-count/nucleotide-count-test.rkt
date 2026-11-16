#lang racket/base

(require "nucleotide-count.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "nucleotide-count tests"

      (test-equal? "empty strand"
                   (nucleotide-counts "")
                   '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0)))

      (test-equal? "can count one nucleotide in single-character input"
                   (nucleotide-counts "G")
                   '((#\A . 0) (#\C . 0) (#\G . 1) (#\T . 0)))

      (test-equal? "strand with repeated nucleotide"
                   (nucleotide-counts "GGGGGGG")
                   '((#\A . 0) (#\C . 0) (#\G . 7) (#\T . 0)))

      (test-equal? "strand with multiple nucleotides"
                   (nucleotide-counts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
                   '((#\A . 20) (#\C . 12) (#\G . 17) (#\T . 21)))

      (test-exn "strand with invalid nucleotides"
                exn:fail? (lambda () (nucleotide-counts "AGXXACT")))))

  (run-tests suite))
