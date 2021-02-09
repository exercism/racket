#lang racket/base

(require racket/match)

(provide score)

(define (score word)
  (for/sum ([c (in-string (string-downcase word))])
    (match c
      [(or #\a #\e #\i #\o #\u #\l #\n #\r #\s #\t)  1]
      [(or #\d #\g)                                  2]
      [(or #\b #\c #\m #\p)                          3]
      [(or #\f #\h #\v #\w #\y)                      4]
      [(or #\k)                                      5]
      [(or #\j #\x)                                  8]
      [(or #\q #\z)                                 10]
      [_ 0])))
