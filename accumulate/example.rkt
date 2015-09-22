#lang racket

(provide accumulate)

(define (accumulate collection op)
  (map op collection))