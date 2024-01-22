# Reversing a List of Characters

```scheme
(define (my-reverse s)
    (list->string (foldl cons '() (string->list s))))
```
