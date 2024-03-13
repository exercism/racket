#lang racket

(provide bank-account%)

(define bank-account%
  (class object%
    (super-new)
    (define open? #f)
    (define funds 0)
    (define lock (make-semaphore 0))

    (define (check-open)
      (or open? (error "account not open")))

    (define (check-positive amount)
      (or (> amount 0) (error "amount must be greater than 0")))

    (define/public (open)
      (if open?
	(error "account already open")
	(begin
          (set! open? #t)
          (set! funds 0)
    	  (semaphore-post lock))))

    (define/public (close)
      (check-open)
      (semaphore-wait lock)
      (set! open? #f)
      (semaphore-post lock))

    (define/public (deposit amount)
      (check-open)
      (check-positive amount)
      (semaphore-wait lock)
      (set! funds (+ funds amount))
      (semaphore-post lock))

    (define/public (withdraw amount)
      (check-open)
      (check-positive amount)
      (or (<= amount funds) (error "amount must be less than balance"))
      (semaphore-wait lock)
      (set! funds (- funds amount))
      (semaphore-post lock))

    (define/public (balance)
      (check-open)
      funds)))
