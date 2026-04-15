#lang racket

(provide solve)

(struct letter-entry (ch leading rank weight) #:transparent)

(define (solve puzzle)
  (define tokens (string-split puzzle))

  (define num-columns
    (let ([words (filter (λ (t) (char-alphabetic? (string-ref t 0))) tokens)])
      (apply max (map string-length words))))

  ;; Associate each word with its sign: -1 for LHS, +1 for RHS
  (define word-signs
    (let loop ([tokens tokens] [sign -1] [result '()])
      (match tokens
        ['() result]
        [(cons "==" rest) (loop rest 1 result)]
        [(cons "+" rest) (loop rest sign result)]
        [(cons word rest) (loop rest sign (cons (cons word sign) result))])))

  (define unique-letters
    (remove-duplicates (filter char-alphabetic? (string->list puzzle))))

  (define letter-info
    (sort
     (for/list ([ch (in-list unique-letters)])
       (define leading 0)

       (define weight (make-vector num-columns 0))
       (for ([ws (in-list word-signs)])
         (define word (car ws))
         (define sign (cdr ws))
         (define len (string-length word))
         (when (and (> len 1) (char=? (string-ref word 0) ch))
           (set! leading 1))
         (for ([col (in-range len)])
           (when (char=? (string-ref word (- len 1 col)) ch)
             (vector-set! weight col (+ (vector-ref weight col) sign)))))

       (define rank
         (or (for/first ([col (in-range num-columns)]
                         #:when (not (zero? (vector-ref weight col))))
               col)
             (- num-columns 1)))

       (letter-entry ch leading rank weight))
     < #:key letter-entry-rank))

  ;; Compute weighted column sum from current mapping
  (define (column-sum col mapping)
    (for/sum ([entry (in-list letter-info)])
      (* (vector-ref (letter-entry-weight entry) col)
         (hash-ref mapping (letter-entry-ch entry) 0))))

  (define (check-column remaining col claimed carry mapping)
    (define col-sum (+ carry (column-sum col mapping)))
    (cond
      [(not (zero? (modulo col-sum 10))) #f]
      [(< (+ col 1) num-columns)
       (assign-letters remaining
                       (+ col 1)
                       claimed
                       (quotient col-sum 10)
                       mapping)]
      [(zero? col-sum) mapping]
      [else #f]))

  (define (assign-letters remaining col claimed carry mapping)
    (match remaining
      ['() (check-column remaining col claimed carry mapping)]
      [(cons entry rest)
       #:when (> (letter-entry-rank entry) col)
       (check-column remaining col claimed carry mapping)]
      [(cons entry rest)
       (for/or ([digit (in-range (letter-entry-leading entry) 10)]
                #:unless (bitwise-bit-set? claimed digit))
         (assign-letters rest
                         col
                         (bitwise-ior claimed (arithmetic-shift 1 digit))
                         carry
                         (hash-set mapping (letter-entry-ch entry) digit)))]))

  (define result (assign-letters letter-info 0 0 0 (hash)))

  (if result
      (for/list ([ch (in-list unique-letters)])
        (cons (string ch) (hash-ref result ch)))
      '()))
