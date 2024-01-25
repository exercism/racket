#lang racket

(provide owns-zebra drinks-water)

(struct house (number color owner pet drink smokes) #:transparent)

(define all-houses
  (for*/list ([n '(1 2 3 4 5)]
              [c '(red green ivory yellow blue)]
              [o '(Englishman Spaniard Ukrainian
		   Norwegian Japanese)]
              [p '(dog snails fox horse zebra)]
              [d '(coffee tea milk orange-juice water)]
              [s '(Old-Gold Kools Chesterfields
		    Lucky-Strike Parliaments)])
      (house n c o p d s)))

(define house-constraints
  (list 
    (λ (h) (eq? (eq? (house-owner h) 'Englishman)
	        (eq? (house-color h) 'red)))
    (λ (h) (eq? (eq? (house-owner h) 'Spaniard)
	        (eq? (house-pet h) 'dog)))
    (λ (h) (eq? (eq? (house-drink h) 'coffee)
	        (eq? (house-color h) 'green)))
    (λ (h) (eq? (eq? (house-owner h) 'Ukrainian)
	        (eq? (house-drink h) 'tea)))
    (λ (h) (eq? (eq? (house-smokes h) 'Old-Gold)
	        (eq? (house-pet h) 'snails)))
    (λ (h) (eq? (eq? (house-smokes h) 'Kools)
	        (eq? (house-color h) 'yellow)))
    (λ (h) (eq? (eq? (house-drink h) 'milk)
	        (= (house-number h) 3)))
    (λ (h) (eq? (eq? (house-owner h) 'Norwegian)
	        (= (house-number h) 1)))
    (λ (h) (eq? (eq? (house-smokes h) 'Lucky-Strike)
	        (eq? (house-drink h) 'orange-juice)))
    (λ (h) (eq? (eq? (house-owner h) 'Japanese)
	        (eq? (house-smokes h) 'Parliaments)))
    (λ (h) (eq? (= (house-number h) 2)
	        (eq? (house-color h) 'blue)))
    (λ (h) (implies (eq? (house-color h) 'green)
	            (not (= (house-number h) 1))))
    (λ (h) (implies (eq? (house-color h) 'ivory)
		    (not (= (house-number h) 5))))))

(define (apply-constraints constraints items)
  (for/fold ([it items])
            ([constraint constraints])
     (filter constraint it)))

(define feasible-houses
  (apply-constraints house-constraints all-houses))

(define (next-door? h1 h2)
  (= (abs (- (house-number h1) (house-number h2))) 1))

(define two-house-constraints
  (list
     (λ (h1 h2) (implies (and (eq? (house-color h1) 'green)
			       (eq? (house-color h2) 'ivory))
		         (= (house-number h1)
			    (add1 (house-number h2)))))
     (λ (h1 h2) (implies (and (eq? (house-smokes h1) 'Chesterfields)
			      (eq? (house-pet h2) 'fox))
			 (next-door? h1 h2)))
     (λ (h1 h2) (implies (and (eq? (house-smokes h1) 'Kools)
			      (eq? (house-pet h2) 'horse))
			 (next-door? h1 h2)))))

(define (check-street constraint street)
  (for*/and ([h1 street]
	     [h2 street])
    (constraint h1 h2)))

(define street-constraints
  (map (λ (c) (λ (s) (check-street c s))) two-house-constraints))

(define houses-by-number
  (for/list ([n '(1 2 3 4 5)])
    (filter (λ (h) (= n (house-number h))) feasible-houses)))

(define (disjoint? h1 h2)
  (not (or (eq? (house-color h1) (house-color h2))
	   (eq? (house-owner h1) (house-owner h2))
	   (eq? (house-pet h1) (house-pet h2))
	   (eq? (house-drink h1) (house-drink h2))
	   (eq? (house-smokes h1) (house-smokes h2)))))

(define (extends? street h)
  (andmap (λ (h1) (disjoint? h h1)) street))

(define (build-streets houses street)
  (if (null? houses)
    (list street)
    (for/fold
      ([streets '()])
      ([h (car houses)]
       #:when (extends? street h))
      (append streets (build-streets (cdr houses) (cons h street))))))
      
(define all-streets
  (build-streets houses-by-number '()))

(define feasible-streets
  (apply-constraints street-constraints all-streets))

(define (find-owner condition)
  (if (= 1 (length feasible-streets))
    (for/first ([h (car feasible-streets)]
		#:when (condition h))
      (house-owner h))
    (null)))

(define (owns-zebra)
  (find-owner (λ (h) (eq? (house-pet h) 'zebra))))

(define (drinks-water)
  (find-owner (λ (h) (eq? (house-drink h) 'water))))
