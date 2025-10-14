#lang racket

(provide format-message)

(define (format-message name number)
  (string-append name
                 ", you are the "
                 (number->string number)
                 (suffix number)
                 " customer we serve today. Thank you!"))

(define (suffix n)
  (match (list (modulo n 10) (modulo n 100))
    [(list 1 11) "th"]
    [(list 2 12) "th"]
    [(list 3 13) "th"]
    [(list 1 _) "st"]
    [(list 2 _) "nd"]
    [(list 3 _) "rd"]
    [else "th"]))
