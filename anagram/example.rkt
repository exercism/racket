#lang racket

(provide anagrams-for)

(define (anagrams-for subject candidates)
  (filter (lambda (w) (anagram? w subject)) candidates))

(define (anagram? a b)
  (let ([sorted-string
         (lambda (s)
           (apply string (sort (string->list s) char-ci<?)))])
    (and
     (string-ci=? (sorted-string a)
                  (sorted-string b))
     (not (string-ci=? a b)))))
