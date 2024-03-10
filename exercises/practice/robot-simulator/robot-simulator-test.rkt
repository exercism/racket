#lang racket/base

(require racket/class)
(require "robot-simulator.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite "robot simulator tests"
      (test-case "Create robot at origin facing north"
        (define robot (new robot% [position '(0 0)] [direction 'north]))
        (check-equal? (get-field position robot) '(0 0))
        (check-equal? (get-field direction robot) 'north))
        
      (test-case "Create robot at negative position facing south"
        (define robot (new robot% [position '(-1 -1)] [direction 'south]))
        (check-equal? (get-field position robot) '(-1 -1))
        (check-equal? (get-field direction robot) 'south))
    
      (test-case "Rotating clockwise changes north to east"
        (define robot (new robot% [position '(0 0)] [direction 'north]))
	(send robot move "R")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'east))
        
      (test-case "Rotating clockwise changes east to south"
        (define robot (new robot% [position '(0 0)] [direction 'east]))
        (send robot move "R")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'south))
        
      (test-case "Rotating clockwise changes south to west"
        (define robot (new robot% [position '(0 0)] [direction 'south]))
        (send robot move "R")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'west))
        
      (test-case "Rotating clockwise changes west to north"
        (define robot (new robot% [position '(0 0)] [direction 'west]))
        (send robot move "R")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'north))
    
      (test-case "Rotating counter-clockwise changes north to west"
        (define robot (new robot% [position '(0 0)] [direction 'north]))
        (send robot move "L")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'west))
        
      (test-case "Rotating counter-clockwise changes west to south"
        (define robot (new robot% [position '(0 0)] [direction 'west]))
        (send robot move "L")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'south))
        
      (test-case "Rotating counter-clockwise changes south to east"
        (define robot (new robot% [position '(0 0)] [direction 'south]))
        (send robot move "L")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'east))
        
      (test-case "Rotating counter-clockwise changes east to north"
        (define robot (new robot% [position '(0 0)] [direction 'east]))
        (send robot move "L")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'north))
    
      (test-case "Moving forward one facing north increments Y"
        (define robot (new robot% [position '(0 0)] [direction 'north]))
        (send robot move "A")
	(check-equal? (get-field position robot) '(0 1))
	(check-equal? (get-field direction robot) 'north))
        
      (test-case "Moving forward one facing south decrements Y"
        (define robot (new robot% [position '(0 0)] [direction 'south]))
        (send robot move "A")
	(check-equal? (get-field position robot) '(0 -1))
	(check-equal? (get-field direction robot) 'south))
        
      (test-case "Moving forward one facing east increments X"
        (define robot (new robot% [position '(0 0)] [direction 'east]))
        (send robot move "A")
	(check-equal? (get-field position robot) '(1 0))
	(check-equal? (get-field direction robot) 'east))
        
      (test-case "Moving forward one facing west decrements X"
        (define robot (new robot% [position '(0 0)] [direction 'west]))
        (send robot move "A")
	(check-equal? (get-field position robot) '(-1 0))
	(check-equal? (get-field direction robot) 'west))
    
      (test-case "Follow series of instructions - moving east and north from README"
        (define robot (new robot% [position '(7 3)] [direction 'north]))
        (send robot move "RAALAL")
	(check-equal? (get-field position robot) '(9 4))
	(check-equal? (get-field direction robot) 'west))
        
      (test-case "Follow series of instructions - moving west and north"
        (define robot (new robot% [position '(0 0)] [direction 'north]))
        (send robot move "LAAARALA")
	(check-equal? (get-field position robot) '(-4 1))
	(check-equal? (get-field direction robot) 'west))
        
      (test-case "Follow series of instructions - moving west and south"
        (define robot (new robot% [position '(2 -7)] [direction 'east]))
        (send robot move "RRAAAAALA")
	(check-equal? (get-field position robot) '(-3 -8))
	(check-equal? (get-field direction robot) 'south))
        
      (test-case "Follow series of instructions - moving east and north"
        (define robot (new robot% [position '(8 4)] [direction 'south]))
        (send robot move "LAAARRRALLLL")
	(check-equal? (get-field position robot) '(11 5))
	(check-equal? (get-field direction robot) 'north))))

  (run-tests suite))
