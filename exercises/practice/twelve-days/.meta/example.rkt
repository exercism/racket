#lang racket

(provide twelve-days)

(define gift-days
  '(("first" "a" "Partridge in a Pear Tree")
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
    ("twelfth" "twelve" "Drummers Drumming")))

(define gen-form
  "On the ~a day of Christmas my true love gave to me: ~a.")

(define (twelve-days [start 1] [end 12])
  ; sanitize inputs
  (and (< start 1)
      (set! start 1))
  (and (> end 12)
      (set! end 12))
  (and (>= start end)
        (let [(s (min start end))
              (e (max start end))]
            (set! start s)
            (set! end   e)))

  (string-trim (singer '() start end)))

(define (singer song start end)
  (let ([sng (cons
              (format gen-form (car (list-ref gift-days (- start 1)))
                               (presents start))
              song)])
    (if (= start end)
        (foldl (lambda (d s)
                (format "~a~%~%~a" d s))
               ""
               sng)
        (singer sng (+ 1 start) end))))

(define (presents day)
  ; gets all the presents for a paricular day
  (let ([pres (map (lambda (v)
                    (format "~a ~a" (second v) (third v)))
                   (list-tail (reverse gift-days) (- 12 day)))])
    (if (= 1 (length pres))
        (car pres)
        (format "~aand ~a"
          (foldr (lambda (p s)
                  (format "~a, ~a" p s))
                 ""
                 (take pres (- day 1)))
          (last pres)))))
