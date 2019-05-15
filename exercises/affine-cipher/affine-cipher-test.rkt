#lang racket/base

; Tests adapted from `problem-specifications/canonical-data.json v2.0.0
(require "affine-cipher.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define encode-suite
    (test-suite "affine-cipher encoding tests"
                (test-equal? "encode yes"
                             (encode "yes" 5 7)
                             "xbt")

                (test-equal? "encode no"
                             (encode "no" 15 18)
                             "fu")

                (test-equal? "encode OMG"
                             (encode "OMG" 21 3)
                             "lvz")

                (test-equal? "encode O M G"
                             (encode "O M G" 25 47)
                             "hjp")

                (test-equal? "encode mindblowingly"
                             (encode "mindblowingly" 11 15)
                             "rzcwa gnxzc dgt")

                (test-equal? "encode numbers"
                             (encode "Testing,1 2 3, testing." 3 4)
                             "jqgjc rw123 jqgjc rw")

                (test-equal? "encode deep thought"
                             (encode "Truth is fiction." 5 17)
                             "iynia fdqfb ifje")
 
                (test-equal? "encode all the letters"
                             (encode "The quick brown fox jumps over the lazy dog." 17 33)
                             "swxtj npvyk lruol iejdc blaxk swxmh qzglf")

                (test-exn "encode with a not coprime to m"
                          exn:fail? (lambda () (encode "This is a test" 6 17)))))

  (define decode-suite
    (test-suite "affine-cipher decoding tests"
                (test-equal? "decode exercism"
                             (decode "tytgn fjr" 3 7)
                             "exercism")

                (test-equal? "decode a sentence"
                             (decode "qdwju nqcro muwhn odqun oppmd aunwd o" 19 16)
                             "anobstacleisoftenasteppingstone")

                (test-equal? "decode numbers"
                             (decode "odpoz ub123 odpoz ub" 25 7)
                             "testing123testing")

                (test-equal? "decode all the letters"
                             (decode "swxtj npvyk lruol iejdc blaxk swxmh qzglf" 17 33)
                             "thequickbrownfoxjumpsoverthelazydog")

                (test-equal? "decode with no spaces in input"
                             (decode "swxtjnpvyklruoliejdcblaxkswxmhqzglf" 17 33)
                             "thequickbrownfoxjumpsoverthelazydog")

                (test-equal? "decode with too many spaces"
                             (decode "vszzm    cly   yd cg    qdp" 15 16)
                             "jollygreengiant")

                (test-exn "decode with a not coprime to m"
                          exn:fail? (lambda () (decode "Test" 13 5)))))

  (begin
    (run-tests encode-suite)
    (run-tests decode-suite)))
