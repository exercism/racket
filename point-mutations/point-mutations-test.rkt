#lang racket/base

(require rackunit)
(require rackunit/text-ui)
(require "point-mutations.rkt")

(define point-mutations-tests
  (test-suite
   "point mutations tests"
   
   (test-eqv? "no difference between empty strands"
              (hamming-distance "" "")
              0)
   
   (test-eqv? "no difference between identical strands"
              (hamming-distance "GATTACA" "GATTACA")
              0)
   
   (test-eqv? "complete hamming distance in small strand"
              (hamming-distance "ACT" "GGA")
              3)
   
   (test-eqv? "small hamming distance in middle somewhere"
              (hamming-distance "GGACG" "GGTCG")
              1)
   
   (test-eqv? "larger difference"
              (hamming-distance "ACCAGGG" "ACTATGG")
              2)
   
   (test-exn "String length mismatch." exn:fail?
             (lambda ()
               (hamming-distance "AGACAACAGCCAGCCGCCGGATT" "AGGCAA")))))

(run-tests point-mutations-tests)
