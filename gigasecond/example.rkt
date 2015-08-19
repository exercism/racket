#lang racket

(require racket/date)

(define (add-gigasecond date)
  (seconds->date (+ 1e9 (date->seconds date))))

(provide add-gigasecond)
