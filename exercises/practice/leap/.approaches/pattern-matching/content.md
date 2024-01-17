# Pattern matching

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

[The match form][match-form] compares an expression sequentially to a series of clauses that contain patterns describing the contents of that expression and values returned when a given pattern is matched.
For this exercise, this takes the form of creating a list containing three Boolean values representing whether a year is divisible by 4, 100, or 400.
As an example, let's run through this code assuming `year` is set to 1993.
`(divisible-by-4 1999)` is `#f`, `(divisible-by-100 1999)` is `#f`, and `(divisible-by-400 1999)` is `#f`.
Filling in these results below, we have four patterns underneath it:

```scheme
(match (list #t #f #f) ; assuming the year is 1999
  [(list _ _ #t) #t]
  [(list _ #t _) #f]
  [(list #t _ _) #t]
  [_ #f])
```

The first three expect a list of three elements (`_` matching any value), but they differ on which value in the pattern can only be the literal value `#t`.

The first clause `[(list _ _ #t) #t]` describes a series of checks where the year must at least be divisible by 400.
A year divisible by 400 is also divisible by 4 and 100 so we can safely assume all three checks returned `#t` and there's no need to specify the result.
If this pattern is matched, `#t` is returned.
1999 isn't divisible by 400 since the `#f` in the third position means the pattern isn't matched.

The second clause `[(list _ #t _) #f]` describes a series of checks where the year must at least be divisible by 100.
A year divisible by 100 is also divisible by 4 so we can be sure that other check returned true and there's no need to specify it here.
We can also assume a year divisible by 100 wouldn't be divisible by 400 because if it were, the previous pattern would have already matched.
If this pattern is matched, `#f` is returned.
1999 isn't divisible by 100 since `#f` in the second position means the pattern isn't matched.

The third clause `[(list #t _ _) #t]` describes a series of checks where the year must at least be divisible by 4.
If this pattern is matched, `#t` is returned.
1999 isn't divisible by 4 since `#f` in the first position means the pattern isn't matched.

The fourth clause `[_ #f]` features a pattern with a single `_`, which means any value at all can match this pattern. 
Without such a clause, an exception will occur if none of the clauses' patterns matched.
1999 isn't divisible by 4, 100, or 400, but it matches this catch-all pattern after not matching the previous patterns.
As a result, `#f` is returned by the code.

[match-form]: https://docs.racket-lang.org/guide/match.html
