#lang racket/base

(require "run-length-encoding.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
      "run-length-encoding tests"

      (test-equal? "empty string"
		   (encode "") "")

      (test-equal? "single characters only are encoded without count"
		   (encode "XYZ") "XYZ")

      (test-equal? "string with no single characters"
		   (encode "AABBBCCCC") "2A3B4C")

      (test-equal? "single characters mixed with repeated characters"
		   (encode "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")
		   "12WB12W3B24WB")

      (test-equal? "multiple whitespace mixed in string"
		   (encode "  hsqq qww  ") "2 hs2q q2w2 ")

      (test-equal? "lowercase characters"
		   (encode "aabbbcccc") "2a3b4c")

      (test-equal? "empty string"
		   (decode "") "")

      (test-equal? "single characters only"
		   (decode "XYZ") "XYZ")

      (test-equal? "string with no single characters"
		   (decode "2A3B4C") "AABBBCCCC")

      (test-equal? "single characters with repeated characters"
		   (decode "12WB12W3B24WB")
		   "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")

      (test-equal? "multiple whitespace mixed in string"
		   (decode "2 hs2q q2w2 ") "  hsqq qww  ")

      (test-equal? "lowercase string"
		   (decode "2a3b4c") "aabbbcccc")

      (test-equal? "encode and then decode"
		   (decode (encode "zzz ZZ  zZ")) "zzz ZZ  zZ")))

  (run-tests suite))

