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
