#lang racket

(provide (struct-out character)
         ability
         make-character
         modifier)

(struct character
    (strength dexterity constitution intelligence wisdom charisma hitpoints))

(define (ability)
  (define (dice-rolls n)
    (for/list ([i n])
      (add1 (random 6))))
  (define (drop-lowest lst)
    (cdr (sort lst <)))
  (define (total-score n)
    (define dice (dice-rolls n))
    (for/sum ([i (drop-lowest dice)])
      i))
  (total-score 4))

(define (modifier value)
    (floor (/ (- value 10) 2)))

(define (make-character)
    (define strength (ability))
    (define dexterity (ability))
    (define constitution (ability))
    (define intelligence (ability))
    (define wisdom (ability))
    (define charisma (ability))
    (define hitpoints (+ (modifier constitution) 10))
    (character strength dexterity constitution intelligence wisdom charisma hitpoints))
