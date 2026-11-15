#lang racket/base

(require "roman-numerals.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "roman-numerals tests"

      (test-equal? "1 is I"
                   (to-roman 1)
                   "I")

      (test-equal? "2 is II"
                   (to-roman 2)
                   "II")

      (test-equal? "3 is III"
                   (to-roman 3)
                   "III")

      (test-equal? "4 is IV"
                   (to-roman 4)
                   "IV")

      (test-equal? "5 is V"
                   (to-roman 5)
                   "V")

      (test-equal? "6 is VI"
                   (to-roman 6)
                   "VI")

      (test-equal? "9 is IX"
                   (to-roman 9)
                   "IX")

      (test-equal? "16 is XVI"
                   (to-roman 16)
                   "XVI")

      (test-equal? "27 is XXVII"
                   (to-roman 27)
                   "XXVII")

      (test-equal? "48 is XLVIII"
                   (to-roman 48)
                   "XLVIII")

      (test-equal? "49 is XLIX"
                   (to-roman 49)
                   "XLIX")

      (test-equal? "59 is LIX"
                   (to-roman 59)
                   "LIX")

      (test-equal? "66 is LXVI"
                   (to-roman 66)
                   "LXVI")

      (test-equal? "93 is XCIII"
                   (to-roman 93)
                   "XCIII")

      (test-equal? "141 is CXLI"
                   (to-roman 141)
                   "CXLI")

      (test-equal? "163 is CLXIII"
                   (to-roman 163)
                   "CLXIII")

      (test-equal? "166 is CLXVI"
                   (to-roman 166)
                   "CLXVI")

      (test-equal? "402 is CDII"
                   (to-roman 402)
                   "CDII")

      (test-equal? "575 is DLXXV"
                   (to-roman 575)
                   "DLXXV")

      (test-equal? "666 is DCLXVI"
                   (to-roman 666)
                   "DCLXVI")

      (test-equal? "911 is CMXI"
                   (to-roman 911)
                   "CMXI")

      (test-equal? "1024 is MXXIV"
                   (to-roman 1024)
                   "MXXIV")

      (test-equal? "1666 is MDCLXVI"
                   (to-roman 1666)
                   "MDCLXVI")

      (test-equal? "3000 is MMM"
                   (to-roman 3000)
                   "MMM")

      (test-equal? "3001 is MMMI"
                   (to-roman 3001)
                   "MMMI")

      (test-equal? "3888 is MMMDCCCLXXXVIII"
                   (to-roman 3888)
                   "MMMDCCCLXXXVIII")

      (test-equal? "3999 is MMMCMXCIX"
                   (to-roman 3999)
                   "MMMCMXCIX")))

  (run-tests suite))
