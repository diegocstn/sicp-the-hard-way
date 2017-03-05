(define (double x) (+ x x))
(define (halve x) (/ x 2))

; Based on the following definition of multiplication
; a * b = double(SUM_OF(a), b/2 times) if b is even
; a * b = a + (a * (b - 1))            if b is odd
(define (not-so-slow-mult a b)
  (if (= b 0)
  	  0
  	  (if (even? b) (double (not-so-slow-mult a (halve b)))
  	  	            (+ a (not-so-slow-mult a (- b 1))))))

; The above procedure performs Θ(logn) steps and space complexity grows linearly with n.