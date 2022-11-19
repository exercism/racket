#lang racket

(provide
 ;; String [Listof String] -> [Listof String]
 ;; pick candidates for anagrams from the given list
 ;; def. a candidate consists of the same letters as subject
 anagrams-for)

;; -----------------------------------------------------------------------------
(define (anagrams-for subject candidates)
  (filter (lambda (w) (anagram? w subject)) candidates))

;; String String -> Boolean
;; is a an anagram for b?
(define (anagram? a b)
  (define (sorted-string s)
    (list->string (sort (string->list s) char-ci<?)))
  (and
   (string-ci=? (sorted-string a) (sorted-string b))
   (not (string-ci=? a b))))
