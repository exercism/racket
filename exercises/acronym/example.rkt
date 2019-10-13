#lang racket

(provide acronym)

(define (all-upper-case? s)
  (equal? s (string-upcase s)))

(define (all-lower-case? s)
  (equal? s (string-downcase s)))

(define (process-word word)
  (define (first-letter s)
    (~a (if (zero? (string-length s))
            ""
            (char-upcase (string-ref s 0)))))
  
  (define (filter-caps s)
    (list->string (filter char-upper-case? (string->list s))))
  
  (cond
    [(all-upper-case? word) (first-letter word)]
    [(all-lower-case? word) (first-letter word)]
    [else (filter-caps word)]))  ;; camelcase/mixed case

(define (acronym str)
  (let ([words (string-split str #px"(\\s+)|-")])
    (apply string-append
           (for/list ([w (in-list words)])
             (process-word w)))))
