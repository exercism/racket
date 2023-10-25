#lang racket/base

(require "dnd-character.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define character (make-character))
  (define (in-range? n)
    (<= 3 n 18))
  (define (constitution->hitpoints n)
     (+ (modifier n) 10))
  (define (validate-character instance pred)
    (and (pred (character-strength instance))
         (pred (character-dexterity instance))
         (pred (character-constitution instance))
         (pred (character-intelligence instance))
         (pred (character-wisdom instance))
         (pred (character-charisma instance))
         (eqv? (constitution->hitpoints (character-constitution instance))
             (character-hitpoints instance))))

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
                (in-range? (ability)))

     (test-true "random character is valid"
                (validate-character character in-range?))
 
     (test-eqv? "each ability is only calculated once"
                (character-strength character)
                (character-strength character))))

  (run-tests suite))
