#lang racket/base

(require "dnd-character.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define (ability-in-range? score)
    (<= 3 score 18))

  (define (all-scores-in-range? char)
    (define abilities (list character-strength
                            character-dexterity
                            character-constitution
                            character-intelligence
                            character-wisdom
                            character-charisma))
    (define valid-hitpoints (<= 6 (character-hitpoints char) 14))
    (and (for/and ([f abilities])
           (ability-in-range? (f char)))
          valid-hitpoints))
  
  (define (characters-are-random?)
    (define previous (make-character))
    (for/and ([_ (in-range 1000)])
      (define current (make-character))
      (define result (not (equal? current previous)))
      (set! previous current)
      result))

  (define suite
    (test-suite
     "D&D character"

     (test-eqv? "ability modifier -> ability modifier for score 3 is -4"
                (modifier 3) -4)

     (test-eqv? "ability modifier -> ability modifier for score 4 is -3"
                (modifier 4) -3)

     (test-eqv? "ability modifier -> ability modifier for score 5 is -3"
                (modifier 5) -3)
  
     (test-eqv? "ability modifier -> ability modifier for score 6 is -2"
                (modifier 6) -2)

     (test-eqv? "ability modifier -> ability modifier for score 7 is -2"
                (modifier 7) -2)

     (test-eqv? "ability modifier -> ability modifier for score 8 is -1"
                (modifier 8) -1)
      
     (test-eqv? "ability modifier -> ability modifier for score 9 is -1"
                (modifier 9) -1)
      
     (test-eqv? "ability modifier -> ability modifier for score 10 is 0"
                (modifier 10) 0)
      
     (test-eqv? "ability modifier -> ability modifier for score 11 is 0"
                (modifier 11) 0)
            
     (test-eqv? "ability modifier -> ability modifier for score 12 is +1"
                (modifier 12) 1)
            
     (test-eqv? "ability modifier -> ability modifier for score 13 is +1"
                (modifier 13) 1)
            
     (test-eqv? "ability modifier -> ability modifier for score 14 is +2"
                (modifier 14) 2)
            
     (test-eqv? "ability modifier -> ability modifier for score 15 is +2"
                (modifier 15) 2)
            
     (test-eqv? "ability modifier -> ability modifier for score 16 is +3"
                (modifier 16) 3)
            
     (test-eqv? "ability modifier -> ability modifier for score 17 is +3"
                (modifier 17) 3)

     (test-eqv? "ability modifier -> ability modifier for score 18 is +4"
                (modifier 18) 4)

     (test-true "random ability is within range"
                (ability-in-range? (ability)))

     (test-true "random character is valid"
                (all-scores-in-range? (make-character)))

    ; track-specific test
     (test-true "all characters are randomly generated"
                (characters-are-random?))))

  (run-tests suite))
