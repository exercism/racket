# Introduction

There are several idiomatic ways to solve this exercise.

## Approach: Reversing a list of characters

```scheme
(define (my-reverse s)
    (list->string (foldl cons '() (string->list s))))
```

For more information, check the [reversing a list of characters approach][approach-reversing-list].

## Approach: Reversing with substrings

```scheme
(define (my-reverse s)
  (if (non-empty-string? s)
      (string-append (my-reverse (substring s 1))
                     (substring s 0 1))
      ""))
```

For more information, check the [reversing with substrings approach][approach-reversing-substrings].

## Approach: Reversing by index

```scheme
(define (my-reverse s)
  (define end (sub1 (string-length s)))
  (build-string (add1 end)
                (λ (i) (string-ref s (- end i)))))
```

For more information, check the [reversing by index approach][approach-reversing-by-index].


[approach-reversing-list]:          https://exercism.org/tracks/racket/exercises/reverse-string/approaches/reversing-list
[approach-reversing-substrings]:    https://exercism.org/tracks/racket/exercises/reverse-string/approaches/reversing-substrings
[approach-reversing-by-index]:      https://exercism.org/tracks/racket/exercises/reverse-string/approaches/reversing-by-index