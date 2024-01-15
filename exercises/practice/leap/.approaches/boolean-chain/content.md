# Chaining Boolean expressions

```scheme
(define (leap-year? year)
  (and (zero? (modulo year 4))
       (or (not (zero? (modulo year 100)))
           (zero? (modulo year 400)))))
```

The Boolean expression `(zero? (modulo year 4))` checks the remainder from dividing `year` by 4.
If a year is evenly divisible by 4, the remainder will be zero.
[`(zero? n)`](zero?) returns the Boolean value `#t` when `n` is zero.
All leap years are divisible by 4, and this pattern is then repeated whether a year is not divisible by 100 and whether it's divisible by 400.
[The `and` and `or` forms](and-or) can chain the values from these three Boolean expressions to produce a new value.
The `and` form produces `#f` if any expression is `#f` or it returns the value of the last expression.
Any value besides `#f` is equivalent to `#t`.
The `or` form produces `#f` if all expressions are `#f` or it returns the first non-`#f` value.

| year | divisible by 4 | not divisible by 100 | divisible by 400 |    result    |
| ---- | -------------- | -------------------  | ---------------- | ------------ |
| 2020 |             #t |                   #t |    not evaluated |           #t |
| 2019 |             #f |        not evaluated |    not evaluated |           #f |
| 2000 |             #t |                   #f |               #t |           #t |
| 1900 |             #t |                   #f |               #f |           #f |

By situationally skipping some of the tests, we can efficiently calculate the result with fewer operations.

[zero?]: https://docs.racket-lang.org/reference/number-types.html#%28def._%28%28quote._~23~25kernel%29._zero~3f%29%29
[and-or]: https://docs.racket-lang.org/guide/conditionals.html#%28part._and%2Bor%29