#lang racket

(require "allergies.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define-check (lists-equiv? desc act exp)
    (check-equal? (sort act string<?)
                  (sort exp string<?)
                  desc))

  (define suite
    (test-suite
     "Tests for the allergies exercise"

     (lists-equiv? "no allergies at all"
                   (list-allergies 0)
                   '())

     (lists-equiv? "allergic to just eggs"
                   (list-allergies 1)
                   '("eggs"))

     (lists-equiv? "allergic to just peanuts"
                   (list-allergies 2)
                   '("peanuts"))

     (lists-equiv? "allergic to just strawberries"
                   (list-allergies 8)
                   '("strawberries"))

     (lists-equiv? "allergic to eggs and peanuts"
                   (list-allergies 3)
                   '("eggs" "peanuts"))

     (lists-equiv? "allergic to more than eggs but not peanuts"
                   (list-allergies 5)
                   '("eggs" "shellfish"))

     (lists-equiv? "allergic to lots of stuff"
                   (list-allergies 248)
                   '("strawberries" "tomatoes" "chocolate" "pollen" "cats"))

     (lists-equiv? "allergic to everything"
                   (list-allergies 255)
                   '("eggs" "peanuts" "shellfish" "strawberries" "tomatoes"
                     "chocolate" "pollen" "cats"))

     (lists-equiv? "ignore non allergen score parts"
                   (list-allergies 509)
                   '("eggs" "shellfish" "strawberries" "tomatoes" "chocolate"
                     "pollen" "cats"))

     (test-case "no allergies means not allergic"
       (check-false (allergic-to? "peanuts" 0))
       (check-false (allergic-to? "cats" 0))
       (check-false (allergic-to? "strawberries" 0)))

     (test-true "is allergic to eggs"
                (allergic-to? "eggs" 1))

     (test-case "allergic to eggs in addition to other stuff"
       (check-true  (allergic-to? "eggs" 5))
       (check-true  (allergic-to? "shellfish" 5))
       (check-false (allergic-to? "strawberries" 5)))))

  (run-tests suite))
