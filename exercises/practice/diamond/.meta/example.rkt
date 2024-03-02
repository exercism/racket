#lang racket

(provide rows)

(define (make-row n c)
  (let* ([outside (make-string (- n c) #\space)]
	 [inside (make-string (max (sub1 (* 2 c)) 0) #\space)]
	 [mark (make-string 1 (integer->char (+ c (char->integer #\A))))]
         [middle (if (zero? (string-length inside))
		   mark
		   (string-append mark inside mark))])
    (string-append outside middle outside)))


(define (rows high-char)
  (let* ([n (- (char->integer high-char) (char->integer #\A))]
	 [top-rows (for/list ([c (in-range n)])
		    (make-row n c))]
	 [bottom-rows (reverse top-rows)]
	 [middle-row (make-row n n)])
    (append top-rows (list middle-row) bottom-rows)))
