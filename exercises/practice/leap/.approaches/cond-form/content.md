# Cond form

```scheme
(define (leap-year? year)
  (cond
    [(zero? (modulo year 400)) #t]
    [(zero? (modulo year 100)) #f]
    [(zero? (modulo year 4)) #t]
    [else #f]))
```

[The cond form][cond-form] sequentially evaluates a series of test expressions until one produces a non-`#f` value.
Then the associated body for the test expression is evaluated, producing a value.
At this point, test expression evaluation inside the cond form ends and the value is returned.
If no test expressions are matched, [void][void-constant] is produced so often
the last expression is `#t` or `else` which will always be satisfied, allowing a default value to be set.

The cond form can be visualized as a nested [if form][if-form].

```scheme
(define (leap-year? year)
  (if (zero? (modulo year 400))
      #t
      (if (zero? (modulo year 100))
          #f
          (if (zero? (modulo year 4))
              #t
              #f))))
```

To run though how this works, `year` is set to 2024, a leap year.

```scheme
(zero? (modulo year 400)) ; produces #f so ignored
(zero? (modulo year 100)) ; produces #f so ignored
(zero? (modulo year 4)) ; produces #t
```

The third test expression produces the first non-`#f` value so its body gets evaluated.
That body contains `#t` which is then the returned value from the cond.
That value is then returned by the function.


[cond-form]: https://docs.racket-lang.org/guide/conditionals.html#%28part._cond%29
[void-constant]: https://docs.racket-lang.org/reference/void.html#%28def._%28%28quote._~23~25kernel%29._void%29%29
[if-form]: https://docs.racket-lang.org/reference/if.html