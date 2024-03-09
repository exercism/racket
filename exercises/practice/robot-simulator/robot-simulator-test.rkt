#lang racket/base

(require racket/class)
(require "robot-simulator.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite "robot simulator tests"
      (test-case "at origin facing north"
        (define robot (new robot% [position '(0 0)] [direction 'north]))
        (check-equal? (get-field position robot) '(0 0))
        (check-equal? (get-field direction robot) 'north))
        
      (test-case "at negative position facing south"
        (define robot (new robot% [position '(-1 -1)] [direction 'south]))
        (check-equal? (get-field position robot) '(-1 -1))
        (check-equal? (get-field direction robot) 'south))
    
      (test-case "changes north to east"
        (define robot (new robot% [position '(0 0)] [direction 'north]))
	(send robot move "R")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'east))
        
      (test-case "changes east to south"
        (define robot (new robot% [position '(0 0)] [direction 'east]))
        (send robot move "R")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'south))
        
      (test-case "changes south to west"
        (define robot (new robot% [position '(0 0)] [direction 'south]))
        (send robot move "R")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'west))
        
      (test-case "changes west to north"
        (define robot (new robot% [position '(0 0)] [direction 'west]))
        (send robot move "R")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'north))
    
      (test-case "changes north to west"
        (define robot (new robot% [position '(0 0)] [direction 'north]))
        (send robot move "L")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'west))
        
      (test-case "changes west to south"
        (define robot (new robot% [position '(0 0)] [direction 'west]))
        (send robot move "L")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'south))
        
      (test-case "changes south to east"
        (define robot (new robot% [position '(0 0)] [direction 'south]))
        (send robot move "L")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'east))
        
      (test-case "changes east to north"
        (define robot (new robot% [position '(0 0)] [direction 'east]))
        (send robot move "L")
	(check-equal? (get-field position robot) '(0 0))
	(check-equal? (get-field direction robot) 'north))
    
      (test-case "facing north increments Y"
        (define robot (new robot% [position '(0 0)] [direction 'north]))
        (send robot move "A")
	(check-equal? (get-field position robot) '(0 1))
	(check-equal? (get-field direction robot) 'north))
        
      (test-case "facing south decrements Y"
        (define robot (new robot% [position '(0 0)] [direction 'south]))
          (send robot move "A")
	(check-equal? (get-field position robot) '(0 -1))
	(check-equal? (get-field direction robot) 'south))
        
      (test-case "facing east increments X"
        (define robot (new robot% [position '(0 0)] [direction 'east]))
          (send robot move "A")
	(check-equal? (get-field position robot) '(1 0))
	(check-equal? (get-field direction robot) 'east))
        
      (test-case "facing west decrements X"
        (define robot (new robot% [position '(0 0)] [direction 'west]))
        (send robot move "A")
	(check-equal? (get-field position robot) '(-1 0))
	(check-equal? (get-field direction robot) 'west))
    
      (test-case "moving east and north from README"
        (define robot (new robot% [position '(7 3)] [direction 'north]))
        (send robot move "RAALAL")
	(check-equal? (get-field position robot) '(9 4))
	(check-equal? (get-field direction robot) 'west))
        
      (test-case "moving west and north"
        (define robot (new robot% [position '(0 0)] [direction 'north]))
          (send robot move "LAAARALA")
	(check-equal? (get-field position robot) '(-4 1))
	(check-equal? (get-field direction robot) 'west))
        
      (test-case "moving west and south"
        (define robot (new robot% [position '(2 -7)] [direction 'east]))
        (send robot move "RRAAAAALA")
	(check-equal? (get-field position robot) '(-3 -8))
	(check-equal? (get-field direction robot) 'south))
        
      (test-case "moving east and north"
        (define robot (new robot% [position '(8 4)] [direction 'south]))
        (send robot move "LAAARRRALLLL")
	(check-equal? (get-field position robot) '(11 5))
	(check-equal? (get-field direction robot) 'north))))

  (run-tests suite))
