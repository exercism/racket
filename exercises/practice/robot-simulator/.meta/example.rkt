#lang racket

(provide robot%)

(define dirs '(north east south west))
(define step (hash 'north '(0 1) 'east '(1 0) 'south '(0 -1) 'west '(-1 0)))

(define robot%
  (class object%
    (super-new)
    (init-field [position '(0 0)]
                [direction 'north])

    (define (turn t)
      (let* ([old-dir (index-of dirs direction)]
             [new-dir (modulo (+ old-dir t) 4)])
        (set! direction (list-ref dirs new-dir))))

    (define (move-step point delta)
      (let ([x (+ (car point) (car delta))]
            [y (+ (cadr point) (cadr delta))])
        (list x y)))

    (define (advance)
      (let ([s (hash-ref step direction)])
        (set! position (move-step position s))))

    (define/public (move instructions)
      (for ([cmd (in-string instructions)])
        (cond [(eq? cmd #\L) (turn -1)]
              [(eq? cmd #\R) (turn 1)]
              [(eq? cmd #\A) (advance)])))))


