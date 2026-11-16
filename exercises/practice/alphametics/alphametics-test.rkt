#lang racket/base

(require "alphametics.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite "alphametics tests"
      (test-equal? "puzzle with three letters"
                   (sort
                     (solve "I + BB == ILL")
                     string<? #:key car)
                   (sort
                     '(("I" . 1) ("B" . 9) ("L" . 0))
                     string<? #:key car))

      (test-equal? "solution must have unique value for each letter"
                   (sort
                     (solve "A == B")
                     string<? #:key car)
                   (sort
                     '()
                     string<? #:key car))

      (test-equal? "leading zero solution is invalid"
                   (sort
                     (solve "ACA + DD == BD")
                     string<? #:key car)
                   (sort
                     '()
                     string<? #:key car))

      (test-equal? "puzzle with two digits final carry"
                   (sort
                     (solve "A + A + A + A + A + A + A + A + A + A + A + B == BCC")
                     string<? #:key car)
                   (sort
                     '(("A" . 9) ("B" . 1) ("C" . 0))
                     string<? #:key car))

      (test-equal? "puzzle with four letters"
                   (sort
                     (solve "AS + A == MOM")
                     string<? #:key car)
                   (sort
                     '(("A" . 9) ("S" . 2) ("M" . 1) ("O" . 0))
                     string<? #:key car))

      (test-equal? "puzzle with six letters"
                   (sort
                     (solve "NO + NO + TOO == LATE")
                     string<? #:key car)
                   (sort
                     '(("N" . 7) ("O" . 4) ("T" . 9) ("L" . 1) ("A" . 0) ("E" . 2))
                     string<? #:key car))

      (test-equal? "puzzle with seven letters"
                   (sort
                     (solve "HE + SEES + THE == LIGHT")
                     string<? #:key car)
                   (sort
                     '(("E" . 4) ("G" . 2) ("H" . 5) ("I" . 0) ("L" . 1) ("S" . 9) ("T" . 7))
                     string<? #:key car))

      (test-equal? "puzzle with eight letters"
                   (sort
                     (solve "SEND + MORE == MONEY")
                     string<? #:key car)
                   (sort
                     '(("S" . 9) ("E" . 5) ("N" . 6) ("D" . 7) ("M" . 1) ("O" . 0) ("R" . 8) ("Y" . 2))
                     string<? #:key car))

      (test-equal? "puzzle with ten letters"
                   (sort
                     (solve "AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE")
                     string<? #:key car)
                   (sort
                     '(("A" . 5) ("D" . 3) ("E" . 4) ("F" . 7) ("G" . 8) ("N" . 0) ("O" . 2) ("R" . 1) ("S" . 6) ("T" . 9))
                     string<? #:key car))

      (test-equal? "puzzle with ten letters and 199 addends"
                   (sort
                     (solve "THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES")
                     string<? #:key car)
                   (sort
                     '(("A" . 1) ("E" . 0) ("F" . 5) ("H" . 8) ("I" . 7) ("L" . 2) ("O" . 6) ("R" . 3) ("S" . 4) ("T" . 9))
                     string<? #:key car))))

  (run-tests suite))
