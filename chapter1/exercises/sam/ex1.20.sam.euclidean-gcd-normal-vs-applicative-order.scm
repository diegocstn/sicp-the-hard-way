; exercise 1.20

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; Normal order: fully expand, then contract
; Applicative order: evaluate operands and apply

; 1 Normal Order evaluation of (gcd 206 40)
(gcd 206 40)

(gcd 40 (remainder 206 40))

; On the if clause b evaluated to 6, so we continue expanding
(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))

; On the if clause b evaluated to 4, so we continue expanding
(gcd (remainder 40 (remainder 206 40))
     (remainder (remainder 206 40)
                (remainder 40 (remainder 206 40))));

; On the if clause b evaluated to 2, so we continue expanding
(gcd (remainder (remainder 206 40)
                (remainder 40 (remainder 206 40)))
     (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 206 40)
                           (remainder 40 (remainder 206 40)))))

; Finally b evaluates to 0, so the procedure yields a
(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
(remainder (remainder 206 40) (remainder 40 6))
(remainder (remainder 206 40) 4)
(remainder 6 4)
2

; How many times was the remainder operation calculated?
; 1) At the first step `(gcd 206 40)`, b is a numeral 40 so no remainder
; operation is actually performed
; 2) The next 4 operations evaluates b in order to evaluate the if predicate,
; and in these cases it means evaluating one remainder operation the first time,
; two the second time, three the third time and so on.
;
; The following were the values of b, evaluated in the if predicate on each step:
; Step 0: 40
; Step 1: (remainder 206 40)
; Step 2: (remainder 40 (remainder 206 40))
; Step 3: (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
; Step 4: (remainder (remainder 40 (remainder 206 40))
;                    (remainder (remainder 206 40)
;                               (remainder 40 (remainder 206 40))))
;
; Since at each step n, a new `b` is calculated as the remainder of `a` and `b`,
; the number of remainder operations R(n) grows as 1 + R(n-1) + R(n-2),
; with R(n) = 0 for n <= 0
;
; R(1) = R(-1) + R(0) + 1 = 1
; R(2) = R(0) + R(1) + 1  = 2
; R(3) = R(1) + R(2) + 1  = 4
; R(4) = R(2) + R(3) + 1  = 7

; Subtotal: 14
; Remainder operations evaluated when contracting: 4
; Total remainder evaluations: 18

; Part B) Applicative order

(gcd 206 40)
 ; -> (gcd 40 (remainder 206 40))

(gcd 40 6)
 ; -> (gcd 6 (remainder 40 6))

(gcd 6 4)
 ; -> (gcd 4 (remainder 6 4))

(gcd 4 2)
;  -> (gcd 2 (remainder 4 2))

(gcd 2 0)
2

; Only 4 remainder operations were executed.