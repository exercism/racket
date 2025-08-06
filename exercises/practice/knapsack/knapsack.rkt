#lang racket

(provide item maximum-value)

(struct item (weight value) #:transparent)

(define (maximum-value maximum-weight items)
  (error "Please implement 'maximum-value'"))
