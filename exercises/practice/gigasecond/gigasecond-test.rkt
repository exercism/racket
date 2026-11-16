#lang racket/base

(require "gigasecond.rkt")

(module+ test
  (require rackunit rackunit/text-ui racket/date)

  (define (make-datetime year month day hour minute second)
    (seconds->date (find-seconds second minute hour day month year #f)))

  (define suite
    (test-suite
     "gigasecond tests"
      (test-equal? "full time specified"
                   (add-gigasecond (make-datetime 2015 01 24 22 0 0))
                   (make-datetime 2046 10 02 23 46 40))
      (test-equal? "full time with day roll-over"
                   (add-gigasecond (make-datetime 2015 01 24 23 59 59))
                   (make-datetime 2046 10 03 01 46 39))))

  (run-tests suite))
