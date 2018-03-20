#lang lazy

(require lazy/force)

(provide pascal)

;; pascals-triangle
(define (iterate f x) (cons x (iterate f (f x))))

(define (pascal x)
  (!! (take x (iterate (λ (x) (map + (cons 0 x) (append x '(0)))) '(1)))))
