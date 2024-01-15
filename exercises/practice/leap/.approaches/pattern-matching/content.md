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


[The match form](match-form) compares an expression to a series of patterns describing its shape.
For this exercise, this takes the form of creating a list containing three Boolean values representing whether a year is divisible by 4, 100, or 400.
The first three patterns describe a three-element list, but each one encodes a literal `#t` to be matched in a different location. The other elements can be any value due to `_`.
The first pattern accepts any value for the first two slots but requires `#t` in the third.
This means any year divisible by 400 will match this pattern regardless of whether it's also divisible by 4 or 100.
The second pattern accepts any value for the first and last slot but requires `#t` in the second slot.
This means any year that's divisible by 100 but not by 400 matches this pattern.
If it were divisible by 400, the first pattern would have matched.
The third pattern operates similarly, and finally any remaining value that didn't match the previous patterns will satisfy the last pattern.


Once the pattern is matched, the associated body is evaluated, returning its value.
`#t` is returned if the first or third patterns are matched, and `#f` is returned for the second and fourth patterns.

[match-form]: https://docs.racket-lang.org/guide/match.html