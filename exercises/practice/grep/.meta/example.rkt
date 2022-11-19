#lang racket

(provide grep)

(struct flags (lineno case-sensitive filename whole invert))

(define (member? v lst)
  (if (member v lst) #t #f))

(define (process-flags fs)
  (flags
   (member? "-n" fs)
   (not (member? "-i" fs))
   (member? "-l" fs)
   (member? "-x" fs)
   (member? "-v" fs)))

(define (add-line-numbers lines)
  (for/list ([n (in-naturals 1)]
             [line (in-list lines)])
    (cons line n)))

(define (process-pattern pat flags)
  (define cpat (regexp-quote pat (flags-case-sensitive flags)))
  (if (flags-whole flags)
      (string-append "^" cpat "$")
      cpat))

(define (grep-file f pat flags mod print-filename?)
  (define lines (add-line-numbers (file->lines f)))
  (define line-filter
    (lambda (line) (mod (regexp-match? pat (car line)))))
  (define res (filter line-filter lines))
  (define (add-lines matches)
    (if (flags-lineno flags)
        (map (lambda (m) (format "~a:~a" (cdr m) (car m))) matches)
        (map (lambda (m) (car m)) matches)))
  (define (add-filenames result)
    (if print-filename?
        (map (lambda (s) (format "~a:~a" f s)) result)
        result))
  (add-filenames (add-lines res)))

(define (file-contains? f pat)
  (regexp-match? pat (file->string f)))

(define (grep fls pat files)
  (define flags (process-flags fls))
  (define repat (process-pattern pat flags))
  (define filter-mod
    (if (flags-invert flags)
        not
        identity))
  (define file-filter
    (lambda (f) (filter-mod (file-contains? f repat))))
  (define print-filename? (> (length files) 1))
  (if (flags-filename flags)
      (filter file-filter files)
      (apply append
             (map (lambda (f)
                    (grep-file f repat flags filter-mod print-filename?))
                  files))))
