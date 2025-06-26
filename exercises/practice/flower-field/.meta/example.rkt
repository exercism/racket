#lang racket

(provide annotate)

(define (flower-at loc row)
  (cond [(null? row) 0]
        [(negative? loc) 0]
        [(>= loc (string-length row)) 0]
        [else (let ([c (string-ref row loc)])
                (if (char=? c #\*) 1 0))]))
    

(define (flowers-around loc row)
  (+ (flower-at (sub1 loc) row) (flower-at loc row) (flower-at (add1 loc) row)))

(define (make-annotated-row top middle bottom)
  (list->string
   (for/list ([c (in-string middle)]
              [i (in-range (string-length middle))])
     (if (char=? c #\space)
         (let ([b (+ (flowers-around i top)
                     (flowers-around i middle)
                     (flowers-around i bottom))])
           (if (zero? b) #\space (integer->char (+ b (char->integer #\0)))))
         c))))

(define (following-row i field)
  (if (>= (add1 i) (length field)) '() (list-ref field (add1 i))))

(define (annotate garden)
  (for/fold ([out '()]
             [top '()]
             [middle (following-row -1 garden)]
             [bottom (following-row 0 garden)]
             #:result (reverse out))
            ([i (in-inclusive-range 1 (length garden))])
    (values (cons (make-annotated-row top middle bottom) out)
            middle bottom (following-row i garden))))
