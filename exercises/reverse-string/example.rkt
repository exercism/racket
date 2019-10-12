#lang racket

(provide (contract-out
          [my-reverse (string?  . -> . string?)]))

(define (my-reverse str)
  (list->string (foldl cons '() (string->list str))))
