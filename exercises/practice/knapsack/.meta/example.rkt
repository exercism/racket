#lang racket

(provide item maximum-value)

(struct item (weight value) #:transparent)

(define (maximum-value maximum-weight items)
  (for/fold
    ([top-value (make-vector (add1 maximum-weight) 0)]
     #:result (vector-ref top-value maximum-weight))
    ([it items])
    (for/vector ([w (in-inclusive-range 0 maximum-weight)])
      (if (> (item-weight it) w)
	(vector-ref top-value w)
	(max (vector-ref top-value w)
             (+ (vector-ref top-value (- w (item-weight it)))
		(item-value it)))))))
