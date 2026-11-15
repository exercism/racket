#lang racket/base

(require "alphametics.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test

  (define suite
    (test-suite
     "alphametics tests"

     (test-equal? "puzzle with three letters"
                  (solve "I + BB == ILL")
                  '(("I" . 1)
                    ("B" . 9)
                    ("L" . 0)))

     (test-equal? "solution must have unique value for each letter"
                  (solve "A == B")
                  '())

     (test-equal? "leading zero solution is invalid"
                  (solve "ACA + DD == BD")
                  '())

     (test-equal? "puzzle with two digits final carry"
                  (solve "A + A + A + A + A + A + A + A + A + A + A + B == BCC")
                  '(("A" . 9)
                    ("B" . 1)
                    ("C" . 0)))

     (test-equal? "puzzle with four letters"
                  (solve "AS + A == MOM")
                  '(("A" . 9)
                    ("S" . 2)
                    ("M" . 1)
                    ("O" . 0)))

     (test-equal? "puzzle with six letters"
                  (solve "NO + NO + TOO == LATE")
                  '(("N" . 7)
                    ("O" . 4)
                    ("T" . 9)
                    ("L" . 1)
                    ("A" . 0)
                    ("E" . 2)))

     (test-equal? "puzzle with seven letters"
                  (solve "HE + SEES + THE == LIGHT")
                  '(("H" . 5)
                    ("E" . 4)
                    ("S" . 9)
                    ("T" . 7)
                    ("L" . 1)
                    ("I" . 0)
                    ("G" . 2)))

     (test-equal? "puzzle with eight letters"
                  (solve "SEND + MORE == MONEY")
                  '(("S" . 9)
                    ("E" . 5)
                    ("N" . 6)
                    ("D" . 7)
                    ("M" . 1)
                    ("O" . 0)
                    ("R" . 8)
                    ("Y" . 2)))

     (test-equal? "puzzle with ten letters"
                  (solve "AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE")
                  '(("A" . 5)
                    ("N" . 0)
                    ("D" . 3)
                    ("S" . 6)
                    ("T" . 9)
                    ("R" . 1)
                    ("O" . 2)
                    ("G" . 8)
                    ("F" . 7)
                    ("E" . 4)))

     (test-equal? "puzzle with ten letters and 199 addends"
                  (solve "THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES")
                  '(("T" . 9)
                    ("H" . 8)
                    ("I" . 7)
                    ("S" . 4)
                    ("A" . 1)
                    ("F" . 5)
                    ("R" . 3)
                    ("E" . 0)
                    ("O" . 6)
                    ("L" . 2)))))

  (run-tests suite))
