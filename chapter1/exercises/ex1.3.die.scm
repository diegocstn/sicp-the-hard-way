(define (square x) (* x x))
(define (sum-of-square x y) (+ (square x) (square y)))
(define (>= n1 n2)
  (if (> (- n1 n2) -1)
    n1
    n2
  )
)
(define (maxsquare n1 n2 n3)
  (sum-of-square (>= n1 n2) (>= n2 n3))
)
