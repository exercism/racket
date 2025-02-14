#lang racket

(require "bowling.rkt")

(module+ test
  (require rackunit
           rackunit/text-ui)

  (define (roll-all game balls)
    (for ([ball balls])
      (send game roll ball)))

  (define bowling-suite
    (test-suite
     "Check proper operation of 'bowling'"
     (test-case
       "should be able to score a game with all zeros"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
       (check-equal? (send game score) 0))

     (test-case
       "should be able to score a game with no strikes or spares"
       (define game (new game%))
       (roll-all game '(3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6))
       (check-equal? (send game score) 90))

     (test-case
       "a spare followed by zeros is worth ten points"
       (define game (new game%))
       (roll-all game '(6 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
       (check-equal? (send game score) 10))

     (test-case
        "points scored in the roll after a spare are counted twice"
       (define game (new game%))
       (roll-all game '(6 4 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
       (check-equal? (send game score) 16))

     (test-case
       "consecutive spares each get a one roll bonus"
       (define game (new game%))
       (roll-all game '(5 5 3 7 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
       (check-equal? (send game score) 31))

     (test-case
       "a spare in the last frame gets a one roll bonus that is counted once"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 7))
       (check-equal? (send game score) 17))

     (test-case
       "a strike earns ten points in a frame with a single roll"
       (define game (new game%))
       (roll-all game '(10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
       (check-equal? (send game score) 10))

     (test-case
       "points scored in the two rolls after a strike are counted twice as a bonus"
       (define game (new game%))
       (roll-all game '(10 5 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
       (check-equal? (send game score) 26))

     (test-case
       "consecutive strikes each get the two roll bonus"
       (define game (new game%))
       (roll-all game '(10 10 10 5 3 0 0 0 0 0 0 0 0 0 0 0 0))
       (check-equal? (send game score) 81))

     (test-case
       "a strike in the last frame gets a two roll bonus that is counted once"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 1))
       (check-equal? (send game score) 18))

     (test-case
       "rolling a spare with the two roll bonus does not get a bonus roll"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 3))
       (check-equal? (send game score) 20))

     (test-case
       "strikes with the two roll bonus do not get bonus rolls"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 10))
       (check-equal? (send game score) 30))

     (test-case
       "last two strikes followed by only last bonus with non strike points"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 0 1))
       (check-equal? (send game score) 31))

     (test-case
       "a strike with the one roll bonus after a spare in the last frame does not get a bonus"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 10))
       (check-equal? (send game score) 20))

     (test-case
       "all strikes is a perfect game"
       (define game (new game%))
       (roll-all game '(10 10 10 10 10 10 10 10 10 10 10 10))
       (check-equal? (send game score) 300))

     (test-case
       "rolls cannot score negative points"
       (define game (new game%))
       (check-exn exn:fail? (λ() (send game roll -1))))

     (test-case
        "a roll cannot score more than 10 points"
       (define game (new game%))
       (check-exn exn:fail? (λ() (send game roll 11))))

     (test-case
       "two rolls in a frame cannot score more than 10 points"
       (define game (new game%))
       (roll-all game '(5))
       (check-exn exn:fail? (λ() (send game roll 6))))

     (test-case
       "bonus roll after a strike in the last frame cannot score more than 10 points"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10))
       (check-exn exn:fail? (λ() (send game roll 11))))

     (test-case
       "two bonus rolls after a strike in the last frame cannot score more than 10 points"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 5))
       (check-exn exn:fail? (λ() (send game roll 6))))

     (test-case
       "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 6))
       (check-equal? (send game score) 26))

     (test-case
       "the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 6))
       (check-exn exn:fail? (λ() (send game roll 10))))

     (test-case
       "second bonus roll after a strike in the last frame cannot score more than 10 points"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10))
       (check-exn exn:fail? (λ() (send game roll 11))))

     (test-case
       "an unstarted game cannot be scored"
       (define game (new game%))
       (check-exn exn:fail? (λ() (send game score))))

     (test-case
       "an incomplete game cannot be scored"
       (define game (new game%))
       (roll-all game '(0 0))
       (check-exn exn:fail? (λ() (send game score))))

     (test-case
       "cannot roll if game already has ten frames"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
       (check-exn exn:fail? (λ() (send game roll 0))))

     (test-case
       "bonus rolls for a strike in the last frame must be rolled before score can be calculated"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10))
       (check-exn exn:fail? (λ() (send game score))))

     (test-case
       "both bonus rolls for a strike in the last frame must be rolled before score can be calculated"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10))
       (check-exn exn:fail? (λ() (send game score))))

     (test-case
       "bonus roll for a spare in the last frame must be rolled before score can be calculated"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3))
       (check-exn exn:fail? (λ() (send game score))))

     (test-case
       "cannot roll after bonus roll for spare"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 2))
       (check-exn exn:fail? (λ() (send game roll 2))))

     (test-case
       "cannot roll after bonus rolls for strike"
       (define game (new game%))
       (roll-all game '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 3 2))
       (check-exn exn:fail? (λ() (send game roll 2))))))

  (run-tests bowling-suite))
