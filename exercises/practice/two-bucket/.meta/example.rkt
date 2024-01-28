#lang racket

(provide measure)

(define (validate bucketOne bucketTwo goal)
  (if (> goal (max bucketOne bucketTwo))
    (error "goal too big")
    (let ([g (gcd bucketOne bucketTwo)])
      (if (not (zero? (remainder goal g)))
	(error "goal not reachable")
	null))))

(define (initial-contents bucketOne bucketTwo startBucket)
  (let ([one-full (cons bucketOne 0)]
	[two-full (cons 0 bucketTwo)])
    (cond [(eq? startBucket 'one)
	   (values one-full two-full)]
	  [(eq? startBucket 'two)
	   (values two-full one-full)]
	  [else (error "invalid start bucket")])))

(define (move-from contents bucketOne bucketTwo)
  (let* ([a (car contents)]
	 [b (cdr contents)]
	 [a-to-b (min a (- bucketTwo b))]
	 [b-to-a (min b (- bucketOne a))])
    (remove-duplicates
      (list (cons 0 b) (cons a 0)
	    (cons bucketOne b) (cons a bucketTwo)
	    (cons (- a a-to-b) (+ b a-to-b))
	    (cons (+ a b-to-a) (- b b-to-a))))))

(define (move-all queue bucketOne bucketTwo visited)
  (for ([contents queue])
    (set-add! visited contents))
  (filter-not (λ (c) (set-member? visited c))
	      (append-map (λ (c) (move-from c bucketOne bucketTwo)) queue)))

(define (achieves goal queue)
  (for/first ([contents queue]
	      #:when (or (= (car contents) goal)
			 (= (cdr contents) goal)))
	     contents))

(define (result moves goal contents)
  (if (= (car contents) goal)
    (list moves 'one (cdr contents))
    (list moves 'two (car contents))))

(define (measure bucketOne bucketTwo goal startBucket)
  (validate bucketOne bucketTwo goal)
  (let-values ([(start illegal)
		(initial-contents bucketOne bucketTwo startBucket)])
    (let ([visited (mutable-set illegal)])
      (do ([moves 0 (add1 moves)]
	   [queue (list start) (move-all queue bucketOne bucketTwo visited)]
	   [winner #f (achieves goal queue)])
	(winner (result moves goal winner))))))
