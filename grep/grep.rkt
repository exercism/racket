#lang racket

(provide
  grep-file
  ;; (-> Path-String Regexp (Listof (Pairof Natural String)))
  ;; Find lines in a file matching a regular expression pattern.
  ;; Output is a list of pairs containing the number and contents of
  ;;  each matching line.
)


;; =============================================================================

(module+ main
  ;; Extra challenge: fill in this submodule so that running
  ;;  `racket grep.rkt PATTERN FILE ...`
  ;; runs grep on each FILE searching for PATTERN, and prints the results
  ;; to stdout.
  (printf "Not implemented!\n")
)
