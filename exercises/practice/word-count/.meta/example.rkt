#lang racket

(provide word-count)

(define (word-count sentence)
  (let* ([lowered (string-downcase sentence)]
         [words (regexp-match* #px"[a-z0-9]+(?:'[a-z0-9]+)?" lowered)])
    (for/fold ([counts (hash)])
              ([word (in-list words)])
      (hash-set counts word (add1 (hash-ref counts word 0))))))
