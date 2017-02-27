(define (linear-exp b n)
	(define (exp-squares-iter b n acc)
		(cond ((= n 0) acc)
			  ((even? n) (exp-squares-iter (square b) (/ n 2) acc))  ; (b^2)^(n/2)
			  (else (exp-squares-iter b (- n 1) (* b acc))) ; (b * b^(n-1))
		))

	(exp-squares-iter b n 1))
