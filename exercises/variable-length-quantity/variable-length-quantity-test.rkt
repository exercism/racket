#lang racket

(require "variable-length-quantity.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define encode
    (test-suite
     "Encode a series of integers, producing a series of bytes."

        (test-equal "zero"
                    (encode 0)
                    '(0))

        (test-equal "arbitrary single byte"
                    (encode 64)
                    '(64))

        (test-equal "largest single byte"
                    (encode 127)
                    '(127))

        (test-equal "smallest double byte"
                    (encode 128)
                    '(129 0))

        (test-equal "arbitrary double byte"
                    (encode 8192)
                    '(192 0))

        (test-equal "largest double byte"
                    (encode 16383)
                    '(255 127))

        (test-equal "smallest triple byte"
                    (encode 16384)
                    '(129 128 0))

        (test-equal "arbitrary triple byte"
                    (encode 1048576)
                    '(192 128 0))

        (test-equal "smallest quadruple byte"
                    (encode 2097151)
                    '(129 128 128 0))

        (test-equal "arbitrary quadruple byte"
                    (encode 134217728)
                    '(192 128 128 0))

        (test-equal "largest quadruple byte"
                    (encode 268435455)
                    '(255 255 255 127))

        (test-equal "smallest quintuple byte"
                    (encode 268435456)
                    '(129 128 128 128 0))

        (test-equal "arbitrary quintuple byte"
                    (encode 4278190080)
                    '(143 248 128 128 0))

        (test-equal "maximum 32-bit integer input"
                    (encode 4294967295)
                    '(143 255 255 255 127))

        ;;; {
        ;;;   "description": "two single-byte values",
        ;;;   "property": "encode",
        ;;;   "input": {
        ;;;     "integers": [64, 127]
        ;;;   },
        ;;;   "expected": [64, 127]
        ;;; },
        ;;; {
        ;;;   "description": "two multi-byte values",
        ;;;   "property": "encode",
        ;;;   "input": {
        ;;;     "integers": [16384, 1193046]
        ;;;   },
        ;;;   "expected": [129, 128, 0, 200, 232, 86]
        ;;; },
        ;;; {
        ;;;   "description": "many multi-byte values",
        ;;;   "property": "encode",
        ;;;   "input": {
        ;;;     "integers": [8192, 1193046, 268435455, 0, 16383, 16384]
        ;;;   },
        ;;;   "expected": [192, 0, 200, 232, 86, 255, 255, 255, 127, 0, 255, 127, 129, 128, 0]
        ;;; }
    ))

  (begin
    (run-tests encode)
    (run-tests decode)))
