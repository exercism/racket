#lang racket

(provide word-count)

(define (word-count sentence)
  (let ([normalized-sentence (normalize-input sentence)])
    (for/fold ([result (hash)])
              ([word (in-list (string-split normalized-sentence))])
      (hash-set result word (add1 (hash-ref result word 0))))))

(define (normalize-input s)
  (handle-single-quoted-words
   (list->string
    (map
     (λ (c)
       (cond [(char<=? #\a c #\z) c]
             [(char<=? #\0 c #\9) c]
             [(char=? #\' c) c]
             [else #\space]))
     (string->list
      (string-downcase s))))))

(define (handle-single-quoted-words s)
  (regexp-replace* #px"'\\b(\\w+)\\b'" s " \\1 "))