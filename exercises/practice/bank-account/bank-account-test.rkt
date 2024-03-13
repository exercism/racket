#lang racket/base

(require racket/class racket/future)
(require "bank-account.rkt")

(module+ test
  (require rackunit rackunit/text-ui))

(module+ test
  (define suite
    (test-suite "bank account tests"
      (test-case "Newly opened account has zero balance"
        (define account (new bank-account%))
        (send account open)
        (check-equal? (send account balance) 0))
    
      (test-case "Single deposit"
        (define account (new bank-account%))
        (send account open)
        (send account deposit 100)
        (check-equal? (send account balance) 100))
    
      (test-case "Multiple deposits"
        (define account (new bank-account%))
        (send account open)
        (send account deposit 100)
        (send account deposit 50)
        (check-equal? (send account balance) 150))
    
      (test-case "Withdraw once"
        (define account (new bank-account%))
        (send account open)
        (send account deposit 100)
        (send account withdraw 75)
        (check-equal? (send account balance) 25))
    
      (test-case "Withdraw twice"
        (define account (new bank-account%))
        (send account open)
        (send account deposit 100)
        (send account withdraw 80)
        (send account withdraw 20)
        (check-equal? (send account balance) 0))
    
      (test-case "Can do multiple operations sequentially"
        (define account (new bank-account%))
        (send account open)
        (send account deposit 100)
        (send account deposit 110)
        (send account withdraw 200)
        (send account deposit 60)
        (send account withdraw 50)
        (check-equal? (send account balance) 20))
    
      (test-case "Cannot check balance of closed account"
        (define account (new bank-account%))
        (send account open)
        (send account close)
        (check-exn #rx"account not open"
          (λ() (send account balance))))
    
      (test-case "Cannot deposit into closed account"
        (define account (new bank-account%))
        (send account open)
        (send account close)
        (check-exn #rx"account not open"
          (λ () (send account deposit 50))))
    
      (test-case "Cannot deposit into unopened account"
        (define account (new bank-account%))
        (check-exn #rx"account not open"
          (λ () (send account deposit 50))))
    
      (test-case "Cannot withdraw from closed account"
        (define account (new bank-account%))
        (send account open)
        (send account close)
        (check-exn #rx"account not open"
          (λ () (send account withdraw 50))))
    
      (test-case "Cannot close an account that was not opened"
        (define account (new bank-account%))
        (check-exn #rx"account not open"
          (λ () (send account close))))
    
      (test-case "Cannot open an already opened account"
        (define account (new bank-account%))
        (send account open)
        (check-exn #rx"account already open"
          (λ () (send account open))))
    
      (test-case "Reopened account does not retain balance"
        (define account (new bank-account%))
        (send account open)
        (send account deposit 50)
        (send account close)
        (send account open)
        (check-equal? (send account balance) 0))
    
      (test-case "Cannot withdraw more than deposited"
        (define account (new bank-account%))
        (send account open)
        (send account deposit 25)
        (check-exn #rx"amount must be less than balance"
          (λ () (send account withdraw 50))))
    
      (test-case "Cannot withdraw negative"
        (define account (new bank-account%))
        (send account open)
        (send account deposit 100)
        (check-exn #rx"amount must be greater than 0"
          (λ () (send account withdraw -50))))
    
      (test-case "Cannot deposit negative"
        (define account (new bank-account%))
        (send account open)
        (check-exn #rx"amount must be greater than 0"
          (λ () (send account deposit -50))))
    
      (test-case "Can handle concurrent transactions"
        (define account (new bank-account%))
        (send account open)
        (for/async ([i 1000])
          (send account deposit 1)
          (send account withdraw 1))
        (check-equal? (send account balance) 0))))

  (run-tests suite))
