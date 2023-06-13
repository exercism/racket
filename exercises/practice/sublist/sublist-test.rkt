#lang racket

(require "sublist.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite "sublist tests"

                ; empty
                (test-eqv? "empty equals empty"       (sublist? '() '()) 'equal)
                (test-eqv? "empty is a sublist"       (sublist? '() '(1 2 3)) 'sublist)
                (test-eqv? "empty is a superlist"     (sublist? '(1 2 3) '()) 'superlist)

                ; equal lists
                (test-eqv? "equal are equal"          (sublist? '(1 2 3) '(1 2 3)) 'equal)

                ; different lists
                (test-eqv? "different are unequal"    (sublist? '(1 2 3) '(4 5 6)) 'unequal)

                ; sublist at start, middle, end
                (test-eqv? "sublist at start"         (sublist? '(1 2 3) '(1 2 3 4 5 6 7)) 'sublist)
                (test-eqv? "sublist at middle"        (sublist? '(3 4 5) '(1 2 3 4 5 6 7)) 'sublist)
                (test-eqv? "sublist at end"           (sublist? '(5 6 7) '(1 2 3 4 5 6 7)) 'sublist)

                ; superlist at start, middle, end
                (test-eqv? "superlist at start"       (sublist? '(1 2 3 4 5 6 7) '(1 2 3)) 'superlist)
                (test-eqv? "superlist at middle"      (sublist? '(1 2 3 4 5 6 7) '(3 4 5)) 'superlist)
                (test-eqv? "superlist at end"         (sublist? '(1 2 3 4 5 6 7) '(5 6 7)) 'superlist)

                ; multiple matches
                (test-eqv? "sublist w/ multiple matches"  (sublist? '(1 2 3) '(1 1 1 2 3)) 'sublist)
                (test-eqv? "sublist w/ multiple matches"  (sublist? '(1 1 1 2 3) '(1 2 3)) 'superlist)
                (test-eqv? "no match w/ multiple matches" (sublist? '(1 2 3) '(1 1 1 2 4)) 'unequal)

                ; order matters
                (test-eqv? "order matters"            (sublist? '(1 2 3) '(3 2 1)) 'unequal)

                ; recurring values in sublist
                (test-eqv? "recurring sublist"        (sublist? '(1 2 1 2 3) '(1 2 3 1 2 1 2 3 2 1)) 'sublist)
                (test-eqv? "recurring unequal"        (sublist? '(1 2 1 2 3) '(1 2 3 1 2 3 2 3 2 1)) 'unequal)

                ))
  (run-tests suite)
  )
