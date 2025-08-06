#lang racket

(provide (struct-out character)
         ability
         make-character
         modifier)

(struct character
    ()) ; Add necessary struct fields

(define (ability)
  (error "Please implement 'ability'"))

(define (modifier value)
  (error "Please implement 'modifier'"))

(define (make-character)
  (error "Please implement 'make-character'"))
