#lang racket

(provide (struct-out character)
         ability
         make-character
         modifier)

(struct character
    ()) ; Add necessary struct fields

(define (ability)
  (error "Not implemented yet"))

(define (modifier value)
  (error "Not implemented yet"))

(define (make-character)
  (error "Not implemented yet"))
