#lang racket

(require rackunit
         rackunit/text-ui
         racket/date
         "gigasecond.rkt")

(define (make-datetime year month day hour minute second)
  (seconds->date (find-seconds second minute hour day month year #f)))

(define suite
  (test-suite
    "Tests for the gigasecond exercise"
    (check-equal? (make-datetime 2043 1 1 1 46 40) (add-gigasecond (make-datetime 2011 4 25 0 0 0)))
    (check-equal? (make-datetime 2009 2 19 1 46 40) (add-gigasecond (make-datetime 1977 6 13 0 0 0)))
    (check-equal? (make-datetime 1991 3 27 1 46 40) (add-gigasecond (make-datetime 1959 7 19 0 0 0)))
    (check-equal? (make-datetime 2046 10 2 23 46 40) (add-gigasecond (make-datetime 2015 1 24 22 0 0)))
    (check-equal? (make-datetime 2046 10 3 1 46 39) (add-gigasecond (make-datetime 2015 1 24 23 59 59)))
    (let ([your-birthday (make-datetime 1970 1 1 8 30 0)]
          [your-gigasecond (make-datetime 2001 9 9 10 16 40)])
      (check-equal? your-gigasecond (add-gigasecond your-birthday)))))

(exit (if (zero? (run-tests suite)) 0 1))
