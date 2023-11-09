#lang racket/base

(require "protein-translation.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "protein-translation tests"

     (test-equal? "Empty RNA sequence results in no proteins"
                  (proteins "")
                  '())

     (test-equal? "Methionine RNA sequence"
                  (proteins "AUG")
                  '("Methionine"))

     (test-equal? "Phenylalanine RNA sequence 1"
                  (proteins "UUU")
                  '("Phenylalanine"))

     (test-equal? "Phenylalanine RNA sequence 2"
                  (proteins "UUC")
                  '("Phenylalanine"))

     (test-equal? "Leucine RNA sequence 1"
                  (proteins "UUA")
                  '("Leucine"))

     (test-equal? "Leucine RNA sequence 2"
                  (proteins "UUG")
                  '("Leucine"))

     (test-equal? "Serine RNA sequence 1"
                  (proteins "UCU")
                  '("Serine"))

     (test-equal? "Serine RNA sequence 2"
                  (proteins "UCC")
                  '("Serine"))

     (test-equal? "Serine RNA sequence 3"
                  (proteins "UCA")
                  '("Serine"))

     (test-equal? "Serine RNA sequence 4"
                  (proteins "UCG")
                  '("Serine"))

     (test-equal? "Tyrosine RNA sequence 1"
                  (proteins "UAU")
                  '("Tyrosine"))

     (test-equal? "Tyrosine RNA sequence 2"
                  (proteins "UAC")
                  '("Tyrosine"))

     (test-equal? "Cysteine RNA sequence 1"
                  (proteins "UGU")
                  '("Cysteine"))

     (test-equal? "Cysteine RNA sequence 2"
                  (proteins "UGC")
                  '("Cysteine"))

     (test-equal? "Tryptophan RNA sequence"
                  (proteins "UGG")
                  '("Tryptophan"))

     (test-equal? "STOP codon RNA sequence 1"
                  (proteins "UAA")
                  '())

     (test-equal? "STOP codon RNA sequence 2"
                  (proteins "UAG")
                  '())

     (test-equal? "STOP codon RNA sequence 3"
                  (proteins "UGA")
                  '())

     (test-equal? "Sequence of two protein codons translates into proteins"
                  (proteins "UUUUUU")
                  '("Phenylalanine" "Phenylalanine"))

     (test-equal? "Sequence of two different protein codons translates into proteins"
                  (proteins "UUAUUG")
                  '("Leucine" "Leucine"))

     (test-equal? "Translate RNA strand into correct protein list"
                  (proteins "AUGUUUUGG")
                  '("Methionine" "Phenylalanine" "Tryptophan"))

     (test-equal? "Translation stops if STOP codon at beginning of sequence"
                  (proteins "UAGUGG")
                  '())

     (test-equal? "Translation stops if STOP codon at end of two-codon sequence"
                  (proteins "UGGUAG")
                  '("Tryptophan"))

     (test-equal? "Translation stops if STOP codon at end of three-codon sequence"
                  (proteins "AUGUUUUAA")
                  '("Methionine" "Phenylalanine"))

     (test-equal? "Translation stops if STOP codon in middle of three-codon sequence"
                  (proteins "UGGUAGUGG")
                  '("Tryptophan"))

     (test-equal? "Translation stops if STOP codon in middle of six-codon sequence"
                  (proteins "UGGUGUUAUUAAUGGUUU")
                  '("Tryptophan" "Cysteine" "Tyrosine"))

     (test-exn "Non-existing codon can't translate"
               exn:fail?
               (lambda () (proteins "AAA")))

     (test-exn "Unknown amino acids, not part of a codon, can't translate"
               exn:fail?
               (lambda () (proteins "XYZ")))

     (test-exn "Incomplete RNA sequence can't translate"
               exn:fail?
               (lambda () (proteins "AUGU")))

     (test-equal? "Incomplete RNA sequence can translate if valid until a STOP codon"
                  (proteins "UUCUUCUAAUGGU")
                  '("Phenylalanine" "Phenylalanine"))))

  (run-tests suite))
