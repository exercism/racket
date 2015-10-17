#lang racket

(provide etl)

(define (etl h)
  (define klist (hash-keys h))
  (define ret-hash (make-hash))
  (for ([k klist])
    (for ([v (hash-ref h k)])
      ;(printf "~a: ~a\n" v k)
      (hash-set! ret-hash (string-downcase v) k)
      ))
  ret-hash)
           