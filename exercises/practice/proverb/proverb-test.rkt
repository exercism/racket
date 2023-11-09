#lang racket/base

(require "proverb.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "proverb tests"

     (test-equal? "zero pieces"
                  (recite '())
                  '())
     (test-equal? "one piece"
                  (recite '("nail"))
                  '("And all for the want of a nail."))
     (test-equal? "two pieces"
                  (recite '("nail"  "shoe"))
                  '("For want of a nail the shoe was lost."
                    "And all for the want of a nail."))
     (test-equal? "three pieces"
                  (recite '("nail" "shoe" "horse"))
                  '("For want of a nail the shoe was lost."
                    "For want of a shoe the horse was lost."
                    "And all for the want of a nail."))
     (test-equal? "full proverb"
                  (recite '("nail" "shoe" "horse" "rider" "message" "battle" "kingdom"))
                  '("For want of a nail the shoe was lost."
                    "For want of a shoe the horse was lost."
                    "For want of a horse the rider was lost."
                    "For want of a rider the message was lost."
                    "For want of a message the battle was lost."
                    "For want of a battle the kingdom was lost."
                    "And all for the want of a nail."))
     (test-equal? "four pieces modernized"
                  (recite '("pin" "gun" "soldier" "battle"))
                  '("For want of a pin the gun was lost."
                    "For want of a gun the soldier was lost."
                    "For want of a soldier the battle was lost."
                    "And all for the want of a pin."))))

  (run-tests suite))
