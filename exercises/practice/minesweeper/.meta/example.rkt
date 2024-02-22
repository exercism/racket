#lang racket

(provide annotate)

(define (bomb-at loc row)
  (cond [(null? row) 0]
	[(negative? loc) 0]
	[(>= loc (string-length row)) 0]
	[else (let ([c (string-ref row loc)])
		(if (char=? c #\*) 1 0))]))
    

(define (bombs-around loc row)
  (+ (bomb-at (sub1 loc) row) (bomb-at loc row) (bomb-at (add1 loc) row)))

(define (make-annotated-row top middle bottom)
  (list->string
    (for/list ([c (in-string middle)]
	       [i (in-range (string-length middle))])
      (if (char=? c #\space)
	(let ([b (+ (bombs-around i top)
		    (bombs-around i middle)
		    (bombs-around i bottom))])
	  (if (zero? b) #\space (integer->char (+ b (char->integer #\0)))))
	c))))

(define (following-row i field)
  (if (>= (add1 i) (length field)) '() (list-ref field (add1 i))))

(define (annotate minefield)
  (for/fold ([out '()]
	     [top '()]
	     [middle (following-row -1 minefield)]
	     [bottom (following-row 0 minefield)]
	     #:result (reverse out))
            ([i (in-inclusive-range 1 (length minefield))])
     (values (cons (make-annotated-row top middle bottom) out)
	     middle bottom (following-row i minefield))))
