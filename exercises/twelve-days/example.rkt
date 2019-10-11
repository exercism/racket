#lang racket

(provide twelve-days)

(define gift-days
  (reverse '(("first" "a" "Partridge in a Pear Tree")
             ("second" "two" "Turtle Doves")
             ("third" "three" "French Hens")
             ("fourth" "four" "Calling Birds")
             ("fifth" "five" "Gold Rings")
             ("sixth" "six" "Geese-a-Laying")
             ("seventh" "seven" "Swans-a-Swimming")
             ("eighth" "eight" "Maids-a-Milking")
             ("ninth" "nine" "Ladies Dancing")
             ("tenth" "ten" "Lords-a-Leaping")
             ("eleventh" "eleven" "Pipers Piping")
             ("twelfth" "twelve" "Drummers Drumming"))))

(define gen-form
  "On the ~s day of Christmas my true love gave to me: ~s")

(define (twelve-days [start 1] [end 12])
  ; sanitize inputs
  (if (< 1 start)
      (set! start 1))
  (if (> 12 end)
      (set! end 12))

  (singer "" start end))

(define (singer song start end)
  )

(define (presents day)
  ; gets all the presents for a paricular day
  (map (lambda (v)
        )
       (list-tail gift-days (- 12 day))))
