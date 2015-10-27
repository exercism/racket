#lang racket

(provide (contract-out
          [etl (-> hash? hash?)]))          

; TODO Provide contract on the keys and values of the input and output

(define (etl h)
  (for*/hash ([(score letter*) (in-hash h)]
              [letter (in-list letter*)])
      #;(printf "~a: ~a\n" letter score)
      (values (string-downcase letter) score)))  ; All letters will be lowercase
