#lang racket

(provide grep-file)

(define (grep-file f pattern)
  (with-input-from-file f
    (lambda ()
      (for/list ([line (in-lines)] ;; Iterate over lines in file, lazily
                 [line-number (in-naturals 1)] ;; Iterate over natural numbers, lazily
                 #:when (regexp-match? pattern line))
        (cons line-number line)))))

;; =============================================================================

;; Code inside the "main" module is run in Dr.Racket or on the command-line,
;;  but not when the file is included as a library.
(module+ main
  (require racket/cmdline)
  (command-line
   #:program "racket-grep"
   #:args (pat-str . file*)
   (begin
     (define pattern (regexp pat-str))
     (for ([f (in-list file*)])
       (for ([num+str (in-list (grep-file f pattern))])
         (printf "~a\n~a\n" f (make-string (string-length f) #\-))
         (printf "~a : ~a\n" (car num+str) (cdr num+str))
         (newline))))))
