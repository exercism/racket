#lang racket

(provide game%)

(define game%
  (class object%
    (super-new)
    (define frame 1)
    (define ball 0)
    (define standing 10)
    (define total 0)
    (define bonus1 0)
    (define bonus2 0)
    (define fill-balls 0)

    (define (game-over?)
       (and (> frame 10) (zero? fill-balls)))

    (define (new-frame)
       (set! frame (add1 frame))
       (set! standing 10))

    (define (add-roll pins)
      (define bonus
         (cond [(> frame 10) (max 0 (- bonus1 (- frame 10)))]
               [(zero? ball) bonus1]
               [else bonus2]))

      (if (zero? ball) (set! bonus1 0) (set! bonus2 0))

      (set! total (+ total (* pins (add1 bonus))))
      (set! standing (- standing pins))
      (cond
         [(zero? standing)
            (cond
              [(zero? ball)		; strike
                 (set! bonus1 (add1 bonus2))
                 (set! bonus2 1)
                 (when (= frame 10) (set! fill-balls 2))]
              [else			; spare
                 (set! bonus1 1)
                 (when (= frame 10) (set! fill-balls 1))
                 (set! ball 0)])]
          [else				; ordinary roll
             (set! ball (- 1 ball))])
      (when (> frame 10) (set! fill-balls (sub1 fill-balls)))
      (when (zero? ball) (new-frame)))

    (define/public (roll pins)
      (when (or (< pins 0) (> pins standing))
        (error "Invalid number of pins"))
      (when (game-over?)
        (error "Game is over"))
      (add-roll pins))

    (define/public (score)
       (cond
         [(game-over?) total]
         [else (error "Game is not over")]))))
