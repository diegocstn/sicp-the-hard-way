; Exercise 1.12

(define (pascal row col)
	(define prev-row (- row 1))
	(cond ((> col row) #f)
	      ((or (= col row) (= col 0)) 1)
	      (else (+ (pascal prev-row (- col 1)) (pascal prev-row col)))))