#lang racket

(provide encode decode)

(define (add-run len c code)
  (cond [(zero? len) code]
	[(= 1 len) (string-append code (string c))]
	[else (string-append code (~a len) (string c))]))

(define (encode text)
  (for/fold ([run-length 0]
	     [lastc #\?]
	     [code ""]
	     #:result (add-run run-length lastc code))
    ([c (in-string text)])
    (if (char=? c lastc)
      (values (add1 run-length) c code)
      (values 1 c (add-run run-length lastc code)))))

(define (expand-run run-spec)
  (let ([run-length (if (non-empty-string? (first run-spec))
		      (string->number (first run-spec))
		      1)])
    (make-string run-length (string-ref (second run-spec) 0))))

(define (decode code)
  (let ([runs (regexp-match* #px"(\\d*)(.)" #:match-select cdr code)])
    (string-append* (map expand-run runs))))
