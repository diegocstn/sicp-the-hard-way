; Exercise 1.2
(+ (+ 5 4)
   (* (- 2
         (- 3
            (+ 6 45)))
      (* 3
         (* (- 6 2)
            (- 2 7)))))


; Exercise 1.3

(define (sum-of-squares-of-larger a b c)
  (define (sum-of-squares a b) (+ (square a) (square b)))
  (define (find-larger a b) (if (> a b) a b))

  (if (> a b) (sum-of-squares a (find-larger b c))
              (sum-of-squares b (find-larger a c))))

(sum-of-squares-of-larger 2 3 4)

; Exercise 1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; Calculating a + abs(b) can be thought of as two distinct operations according
; to the value of b:
; a + abs(b) = a + b if b >= 0
; a + abs(b) = a - b if b < 0
; The above implementation chooses which operator to use according to the sign of b,
; effectively solving the problem by dividing it in the two cases represented above.

; Exercise 1.5
; Normal order:
(test 0 (p))

(if (= 0 0)
      0
      (p)))

; At which point we have to evaluate the special form 'if'. The predicate
; evaluates to true, and the procedure returns 0.

; Applicative order:
(test 0 (p))

; In order to apply `test` we must first evaluate it's operands. We evaluate (p)
; and obtain (p):

(test 0 (p))

; and we conclude that with applicative-order this evaluation never finishes
