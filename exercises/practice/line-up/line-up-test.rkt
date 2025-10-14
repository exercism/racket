#lang racket/base

(require "line-up.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite
     "line-up tests"

     (test-equal? "format smallest non-exceptional ordinal numeral 4"
                  (format-message "Gianna" 4)
                  "Gianna, you are the 4th customer we serve today. Thank you!")

     (test-equal? "format greatest single digit non-exceptional ordinal numeral 9"
                  (format-message "Maarten" 9)
                  "Maarten, you are the 9th customer we serve today. Thank you!")

     (test-equal? "format non-exceptional ordinal numeral 5"
                  (format-message "Petronila" 5)
                  "Petronila, you are the 5th customer we serve today. Thank you!")

     (test-equal? "format non-exceptional ordinal numeral 6"
                  (format-message "Attakullakulla" 6)
                  "Attakullakulla, you are the 6th customer we serve today. Thank you!") 

     (test-equal? "format non-exceptional ordinal numeral 7"
                  (format-message "Kate" 7)
                  "Kate, you are the 7th customer we serve today. Thank you!")

     (test-equal? "format non-exceptional ordinal numeral 8"
                  (format-message "Maximiliano" 8)
                  "Maximiliano, you are the 8th customer we serve today. Thank you!")

     (test-equal? "format exceptional ordinal numeral 1"
                  (format-message "Mary" 1)
                  "Mary, you are the 1st customer we serve today. Thank you!")

     (test-equal? "format exceptional ordinal numeral 2"
                  (format-message "Haruto" 2)
                  "Haruto, you are the 2nd customer we serve today. Thank you!")

     (test-equal? "format exceptional ordinal numeral 3"
                  (format-message "Henriette" 3)
                  "Henriette, you are the 3rd customer we serve today. Thank you!")

     (test-equal? "format smallest two digit non-exceptional ordinal numeral 10"
                  (format-message "Alvarez" 10)
                  "Alvarez, you are the 10th customer we serve today. Thank you!")

     (test-equal? "format non-exceptional ordinal numeral 11"
                  (format-message "Jacqueline" 11)
                  "Jacqueline, you are the 11th customer we serve today. Thank you!")

     (test-equal? "format non-exceptional ordinal numeral 12"
                  (format-message "Juan" 12)
                  "Juan, you are the 12th customer we serve today. Thank you!")

     (test-equal? "format non-exceptional ordinal numeral 13"
                  (format-message "Patricia" 13)
                  "Patricia, you are the 13th customer we serve today. Thank you!")

     (test-equal? "format exceptional ordinal numeral 21"
                  (format-message "Washi" 21)
                  "Washi, you are the 21st customer we serve today. Thank you!")

     (test-equal? "format exceptional ordinal numeral 62"
                  (format-message "Nayra" 62)
                  "Nayra, you are the 62nd customer we serve today. Thank you!")

     (test-equal? "format exceptional ordinal numeral 100"
                  (format-message "John" 100)
                  "John, you are the 100th customer we serve today. Thank you!")

     (test-equal? "format exceptional ordinal numeral 101"
                  (format-message "Zeinab" 101)
                  "Zeinab, you are the 101st customer we serve today. Thank you!")

     (test-equal? "format non-exceptional ordinal numeral 112"
                  (format-message "Knud" 112)
                  "Knud, you are the 112th customer we serve today. Thank you!")

     (test-equal? "format exceptional ordinal numeral 123"
                  (format-message "Yma" 123)
                  "Yma, you are the 123rd customer we serve today. Thank you!")))

  (run-tests suite))
