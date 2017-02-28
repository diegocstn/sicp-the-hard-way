; let T be the following transformation of a and b
; a <- a + b
; b <- a

; We can express it as a special case of p=0, q=1 of the set of transformations Tpq
; defined on p  and q:
;  a <- bq + aq + ap
;  b <- bp + aq

; The exercise tells us to prove that applying T twice (T²) yields the same
; effect as applying a single time another Tp'q' transformation of that same form.
; The first step in proving it is to actually find out what we would obtain if
; we would apply Tpq twice. We do this by applying the transformation to itself,
; replacing a and b on the right-hand side of the transformation by the formula
; of the transformation itself.

; This tells us how to obtain a new `a` and `b´ after applying T once.
;  a <- bq + aq + ap
;  b <- bp + aq

; This tells us how to obtain a new `a` and `b` after applying T twice.
;  a <- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
;  b <- (bp + aq)p + (bq + aq + ap)q

; Expanding the multiplications:
; It is actually not necessary to develop both parts of the transformation, so
; we will just stick to `a`.
;  a <- bpq + aq² + bq² + aq² + apq + bpq + apq + ap²

; We now have to group those sums so that we isolate `a` and `b` in order to
; obtain something in the shape of the generic Tp'q':
;  a <- bq' + aq' + ap'

; We start by moving `b`s to the left:
; a <- bpq + bq² + bpq + aq² + aq² + apq + apq + ap²
; a <- b(pq + q² + pq) + 2aq² + 2apq + ap²
; a <- b(q² + 2pq) + 2aq² + 2apq + ap²

; We have now found our q' (the coefficient of b). We must know express the rest
; of the sums in the form `aq' + ap'`, which is the same as `a(q' + p')`. So we
; isolate a in the expression:
; a <- b(q² + 2pq) + a(2q² + 2pq + p²)

; We now need to separate q' and p' from `(2q² + 2pq + p²)`:
; (2q² + 2pq + p²) => (q² + q² + 2pq + p²) => (q² + 2pq + q² + p²)

; We now have the expression of (Tpq)², for a generic pq:
; a <- b(q² + 2pq) + a(q² + 2pq + q² + p²)
; a <- b(q² + 2pq) + a(q² + 2pq) + a(q² + p²)

; Finally, q' = q² + 2pq and p' = q² + p² that generates `Tp'q' = (Tpq)²`.

; Part 2, calculating q' and p' in scheme and filling in the placeholders
; in the provided fib function.

(define (q1 p q)
	(+ (square q)
	   (* 2 p q)))

(define (p1 p q)
	(+ (square p) (square q)))

(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (p1 p q)		 ; compute p'
                   (q1 p q)      ; compute q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

; Tests for correctness, uses the intuitive recursive version of fibonacci
; unefficient for large numbers!
(define (control-fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (test-fib count)
	(cond ((= count 0) (display "OK") #t)
		  ((= (control-fib count) (fib count)) (test-fib (- count 1)))
		(else (display "Error for count") (display count) #f)))

(test-fib 10000)
