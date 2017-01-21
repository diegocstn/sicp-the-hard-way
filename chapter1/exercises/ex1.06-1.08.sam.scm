; Exercise 1.6
; The procedure never ends, as every time we try using new-if we need to evaluate
; both operands. Since one of the operands is always a call to sqrt-iter itself,
; the procedure doesn't finish since whenever we hit the base case of the recursion
; we also perform another recursive call.

; Exercise 1.7

(define (sqrt x)
  (define (sqrt-iter guess x)
    (define new-guess (improve guess x))

    (if (good-enough? guess new-guess x)
        new-guess
        (sqrt-iter new-guess x)))

  (define (improve guess x)
    (average guess (/ x guess)))

  (define (average x y)
    (/ (+ x y) 2))

  (define (good-enough? guess new-guess x)
    (display new-guess)
    (display "\n")
    (define change-threshold (* 0.00001 (abs guess))) ; a small percentage of last guess
    (< (abs (- new-guess guess)) change-threshold))

    ; Our initial guess is 1
    (sqrt-iter 1.0 x))

; This version definetely works better with really small numbers!
; For large numbers, the previous version hanged for numbers such as
; 10^15, while this one did complete and returned a pretty close value
; (31622779.27999515).

; Exercise 1.8

; if y is an approximation to the cube root of x ,
; then a better approximation is given by the value (x / y^2 + 2y)/ 3.

(define (cubert x)
  (define (cubert-iter guess)
    (define new-guess (improve guess))

    (if (good-enough? guess new-guess)
        new-guess
        (cubert-iter new-guess)))

  (define (improve guess)
    (/ (+ (/ x (square guess))
          (* 2 guess))
       3))

  (define (good-enough? guess new-guess)
    (display new-guess)
    (display "\n")
    (define change-threshold (* 0.00001 (abs guess))) ; a small percentage of last guess
    (< (abs (- new-guess guess)) change-threshold))

    ; Our initial guess is 1
    (cubert-iter 1.0))


; Exercise 1.10

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

; Value of (A 1 10)
(A (- 1 1)
   (A 1 (- 10 1)))

(A 0 (A 1 9))
(* 2 (A 1 9))
(* 2 (* 2 (A 1 8)))
(* 2 (* 2 (* 2 (A 1 7))))
(* 2 (* 2 (* 2 (* 2 (A 1 6)))))
(* 2 (* 2 (* 2 (* 2 (* 2 (A 1 5))))))
(* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (A 1 4)))))))
(* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (A 1 3))))))))
(* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (A 1 2)))))))))
(* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (A 1 1))))))))))
(* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 2)))))))))
; 1024

; Value of (A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 2 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 (A 0 2)))
(A 1 (A 1 (* 2 2)))
(A 1 (A 1 4))
(A 1 (A 0 (A 1 3)))
(A 1 (A 0 (A 0 (A 1 2))))
(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
(A 1 (A 0 (A 0 (A 0 2))))
(A 1 (* 2 (* 2 (* 2 2))))
(A 1 (* 2 (* 2 (* 2 2))))
(A 1 16)
(A 0 (A 1 15))

; we already know how this expands:
; (A 0 y) becomes (* 2 y), while (A 1 15) becomes 2^15
; So we obtain 2^16 = 65536
; (A 3 3) also yields the same result

(define (f n) (A 0 n)) ; defines 2 * n
(define (g n) (A 1 n)) ; defines 2 ^ n
(define (h n) (A 2 n)) ; 2^2^2^...^2^2 (n times)

; Exercise 1.11
; f(n) = n if n < 3
; f(n) = f(n−1) + 2f(n−2) + 3f(n−3) if n ≥ 3

(define (f n)
  (define (f-term factor)
    (* factor
       (f (- n factor))))

  (define (f-terms)
    (+ (f-term 1) (f-term 2) (f-term 3)))

  (if (< n 3)
      n
      (f-terms))
  )

; Skipping 1.12 and 1.13

'
