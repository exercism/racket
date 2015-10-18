#lang racket

(provide (contract-out
          [etl (-> hash? hash?)]))          

; TODO Provide contract on the keys and values of the input and output

(define (etl h)
  (define klist (hash-keys h))
  (define ret-hash (make-hash))
  (for ([k klist])
    (for ([v (hash-ref h k)])
      ;(printf "~a: ~a\n" v k)
      (hash-set! ret-hash (string-downcase v) k)))  ; All letters will be lowercase      
  ret-hash)
           