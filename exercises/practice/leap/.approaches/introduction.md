# Introduction

There are several idiomatic ways to solve this exercise.

## General guidance

Regardless of the approach chosen, this exercise requires students to use Boolean logic to decide if a given year is a leap year.

## Approach: Boolean chaining

```scheme
(define (leap-year? year)
  (and (zero? (modulo year 4))
       (or (not (zero? (modulo year 100)))
           (zero? (modulo year 400)))))
```

For more information, check the [Boolean chain approach][approach-boolean-chain].

## Approach: Cond form

```scheme
(define (leap-year? year)
  (cond
    [(zero? (modulo year 400)) #t]
    [(not (zero? (modulo year 100))) #f]
    [(zero? (modulo year 4)) #t]
    [else #f]))
```

For more information, check the [cond form approach][approach-cond-form].

## Approach: Pattern matching

```scheme
(define (leap-year? year)
  (define divisible-by-4 (zero? (modulo year 4)))
  (define divisible-by-100 (zero? (modulo year 100)))
  (define divisible-by-400 (zero? (modulo year 400))) 
  (match (list divisible-by-4 divisible-by-100 divisible-by-400)
    [(list _ _ #t) #t]
    [(list _ #t _) #f]
    [(list #t _ _) #t]
    [_ #f]))
```

For more information, check the [pattern matching approach][approach-pattern-matching].

[approach-boolean-chain]: https://exercism.org/tracks/racket/exercises/leap/approaches/boolean-chain
[approach-cond-form]: https://exercism.org/tracks/racket/exercises/leap/cond-form
[approach-pattern-matching]: https://exercism.org/tracks/racket/exercises/leap/approaches/pattern-matching