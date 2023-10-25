#lang racket

(require "high-scores.rkt")

(module+ test
  (require rackunit rackunit/text-ui)
  
  (define suite
    (test-suite
     "high score tests"

     (test-equal? "List of scores"
                  (let* ([values '(30 50 20 70)]
                         [high-scores (new high-scores% [values values])])
                    (send high-scores scores))
                  '(30 50 20 70))

     (test-equal? "Latest scores"
                  (let* ([values '(100 0 90 30)]
                         [high-scores (new high-scores% [values values])])
                    (send high-scores latest))
                  30)

     (test-equal? "Personal-best scores"
                  (let* ([values '(40 100 70)]
                         [high-scores (new high-scores% [values values])])
                    (send high-scores personal-best))
                  100)

     (test-equal? "Top 3 scores -> Personal top three from a list of scores"
                  (let* ([values '(10 30 90 30 100 20 10 0 30 40 40 70 70)]
                         [high-scores (new high-scores% [values values])])
                    (send high-scores personal-top-three))
                  '(100 90 70))

     (test-equal? "Top 3 scores -> Personal top highest to lowest"
                  (let* ([values '(20 10 30)]
                         [high-scores (new high-scores% [values values])])
                    (send high-scores personal-top-three))
                  '(30 20 10))

     (test-equal? "Top 3 scores -> Personal top when there is a tie"
                  (let* ([values '(40 20 40 30)]
                         [high-scores (new high-scores% [values values])])
                    (send high-scores personal-top-three))
                  '(40 40 30))

     (test-equal? "Top 3 scores -> Personal top when there are less than 3"
                  (let* ([values '(30 70)]
                         [high-scores (new high-scores% [values values])])
                    (send high-scores personal-top-three))
                  '(70 30))

     (test-equal? "Top 3 scores -> Personal top when there is only one"
                  (let* ([values '(40)]
                         [high-scores (new high-scores% [values values])])
                    (send high-scores personal-top-three))
                  '(40))
        
     (test-equal? "Top 3 scores -> Latest score after personal top scores"
                  (let* ([values '(70 50 20 30)]
                         [high-scores (new high-scores% [values values])])
                    (and (send high-scores personal-top-three)
                         (send high-scores latest)))
                  30)

     (test-equal? "Top 3 scores -> Scores after personal top scores"
                  (let* ([values '(30 50 20 70)]
                         [high-scores (new high-scores% [values values])])
                    (and (send high-scores personal-top-three)
                         (send high-scores scores)))
                  '(30 50 20 70))
        
     (test-equal? "Top 3 scores -> Latest score after personal best"
                  (let* ([values '(20 70 15 25 30)]
                         [high-scores (new high-scores% [values values])])
                    (and (send high-scores personal-best)
                         (send high-scores latest)))
                  30)
          
     (test-equal? "Top 3 scores -> Scores after personal best"
                  (let* ([values '(20 70 15 25 30)]
                         [high-scores (new high-scores% [values values])])
                    (and (send high-scores personal-best)
                         (send high-scores scores)))
                  '(20 70 15 25 30))))

  (run-tests suite))
