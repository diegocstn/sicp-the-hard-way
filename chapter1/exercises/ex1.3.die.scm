(define (square x) (* x x))
(define (sum-of-square x y) (+ (square x) (square y)))
(define (>= n1 n2)
  (if (> (- n1 n2) -1)
    #t
    #f
  )
)
(define (maxsquare n1 n2 n3)
  (cond ( (and (>= n1 n2) (>= n2 n3)) (sum-of-square n1 n2))
	( (and (>= n2 n1) (>= n3 n1)) (sum-of-square n2 n3))
	( (and (>= n1 n2) (>= n3 n2)) (sum-of-square n1 n3)))
 )
