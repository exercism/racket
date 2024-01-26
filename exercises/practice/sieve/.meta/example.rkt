#lang racket

(provide primes)

(define (i->p i)
  (+ (* 2 i) 3))

(define (p->i p)
  (quotient (- p 3) 2))

(define (cross-out i table)
  (let ([p (i->p i)])
    (do
      ([i (p->i (* p p)) (+ i p)])
      ((>= i (vector-length table)))
      (vector-set! table i #t))))

(define (sieve limit)
  (let* ([odds (quotient (sub1 limit) 2)]
	 [crossed-out (make-vector odds #f)])
    (let search ([i 0] [ps '(2)])
      (cond [(= i odds) (reverse ps)]
	    [(vector-ref crossed-out i) (search (add1 i) ps)]
	    [else
	       (begin
		 (cross-out i crossed-out)
		 (search (add1 i) (cons (i->p i) ps)))]))))


(define (primes limit)
  (if (< limit 2)
    null
    (sieve limit)))
