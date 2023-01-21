#lang racket

(provide solve)

(define (solve puzzle)
  (define words (regexp-split #rx"==|[+]" (string-replace puzzle " " "")))

  (define number-set (range 10))

  (define individual-letters
    (for/fold ([acc '()]
               #:result acc)
              ([x (string->list (string-join words ""))])
      (cond
        [(member x acc) (values acc)]
        [else (values (append acc (list x)))])))

  (when (> (length individual-letters) (length number-set))
    '())

  (define (translate p)
    (for/hash ([i individual-letters]
               [j p])
      (values i j)))

  (define (word->sum word o)
    (for/fold ([acc '()]
               #:result (string->number (string-join acc "")))
              ([c (string->list word)])
      (let* ([n (hash-ref o c 0)]
             [s (number->string n)])
        (values (append acc (list s))))))

  (define (make-equation o)
    (for/fold ([acc '()]
               #:result acc)
              ([word words])
      (cond
        [(member word acc) (values acc)]
        [else (values (append acc (list (word->sum word o))))])))

  (define (is-first-letter-of-word-zero? p)
    (let* ([h (construct-answer p)])
      (let ([om (ormap (lambda (word)
                 (let* ([s (substring word 0 1)]
                        [v (hash-ref h s #f)])
                  (= 0 v))) words)])
        om)))

  (define (lhs-sum te)
    (for/sum ([i (take te (sub1 (length te)))]) i))

  (define (generate-permutations items size)
    (if (zero? size)
      '(())
      (for/list ([t (in-list (generate-permutations items (- size 1)))]
                 #:when #t
                 [i (in-list items)]
                 #:unless (member i t))
        (cons i t))))

  (define (construct-answer p)
    (for/hash ([i individual-letters]
               [j p])
      (values (string i) j)))

  (define (solution-found? p)
    (let ([e (make-equation (translate p))])
      (= (last e) (lhs-sum e))))

  (define first-solution
    (for/first ([p (generate-permutations number-set (length individual-letters))]
                #:when (and 
                         (not (is-first-letter-of-word-zero? p))
                         (solution-found? p)))
      (let ([h (construct-answer p)])
        (if h
          (for/list ([letter (map string individual-letters)])
            (cons letter (hash-ref h letter)))
          '()))))

  (let ([solution first-solution])
    (if solution solution '())))
