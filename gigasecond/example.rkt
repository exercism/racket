#lang racket

(provide add-gigasecond)

(require racket/date)

(define (add-gigasecond date)
  (seconds->date (+ 1e9 (date->seconds date))))
