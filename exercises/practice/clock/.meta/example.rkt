#lang racket

(provide (struct-out clock)
         add
         subtract
         clock->string)

(struct clock (hours minutes)
  #:transparent
  #:methods
  gen:equal+hash
  [(define (equal-proc self other rec)
     (define normalized-self (normalize-clock self))
     (define normalized-other (normalize-clock other))
     (and (rec (clock-hours normalized-self)
            (clock-hours normalized-other))
          (rec (clock-minutes normalized-self)
            (clock-minutes normalized-other))))
   (define (hash-proc self rec)
     (define normalized (normalize-clock self))
     (+ (* (rec (clock-hours normalized) 60)
           (rec (clock-minutes normalized)))))
   (define (hash2-proc self rec)
     (define normalized (normalize-clock self))
     (+ (rec (clock-hours normalized))
        (/ (rec (clock-minutes normalized) 60))))])

(define (normalize-clock c)
  (let* ([total-minutes (modulo (+ (* (clock-hours c) 60) (clock-minutes c)) 1440)]
         [new-hours (modulo (quotient total-minutes 60) 24)]
         [new-minutes (modulo (- total-minutes (* new-hours 60)) 60)])
    (clock new-hours new-minutes)))

(define (clock->string c)
  (define normalized (normalize-clock c))
  (~a (~a (clock-hours normalized) #:width 2 #:align 'right #:pad-string "0")
      ":"
      (~a (clock-minutes normalized) #:width 2 #:align 'right #:pad-string "0")))

(define (add c minutes)
  (clock (clock-hours c)
         (+ (clock-minutes c) minutes)))

(define (subtract c minutes)
  (clock (clock-hours c)
         (- (clock-minutes c) minutes)))
