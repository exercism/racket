#lang racket/base

(require "queen-attack.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "queen-attack tests"

     (test-not-exn "queen with a valid position"
                   (lambda () (create-queen 2 2)))

     (test-exn "queen must have positive row"
                exn:fail?
                (lambda () (create-queen -2 2)))

     (test-exn "queen must have row on board"
                exn:fail?
                (lambda () (create-queen 8 4)))

     (test-exn "queen must have positive column"
                exn:fail?
                (lambda () (create-queen 2 -2)))

     (test-exn "queen must have column on board"
                exn:fail?
                (lambda () (create-queen 4 8)))

     (test-false "cannot attack"
                 (can-attack? (create-queen 2 4)
                              (create-queen 6 6)))

    (test-true "can attack on same row"
               (can-attack? (create-queen 2 4)
                            (create-queen 2 6)))

    (test-true "can attack on same column"
               (can-attack? (create-queen 4 5)
                            (create-queen 2 5)))

    (test-true "can attack on first diagonal"
               (can-attack? (create-queen 2 2)
                            (create-queen 0 4)))

    (test-true "can attack on second diagonal"
               (can-attack? (create-queen 2 2)
                            (create-queen 3 1)))

    (test-true "can attack on third diagonal"
               (can-attack? (create-queen 2 2)
                            (create-queen 1 1)))

    (test-true "can attack on fourth diagonal"
               (can-attack? (create-queen 1 7)
                            (create-queen 0 6)))

    (test-false "cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal"
                (can-attack? (create-queen 4 1)
                             (create-queen 2 5)))))

  (run-tests suite))

