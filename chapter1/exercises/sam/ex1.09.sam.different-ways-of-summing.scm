; Exercise 1.9:

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

; Evaluation of (+ 4 5):
(if (= 4 0)
    b
    (inc (+ (dec 4) 5)))

(inc (+ 3 5))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9

; We can say this procedure uses a as a counter, decrementing it to keep track
; of the number of times we have to increment b to obtain the result.
; The increment operations are remembered to be performed later.

; This is a recursive process as we can see by the shape of the evaluation
; (expanding / contracting), and for the fact that every step a number of
; deferred operations needs to be remembered for later evaluation.
; It grows linearly according to the parameter a.

; Second version
(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

; Evaluation of (+ 4 5)
(if (= 4 0)
    b
    (+ (dec 4) (inc 5)))

(+ (dec 4) (inc 5))
(+ 3 6)
(+ (dec 3) (inc 6))
(+ 2 7)
(+ (dec 2) (inc 7))
(+ 1 8)
(+ (dec 1) (inc 8))
(+ 0 9)
9

; This other version 'transfers' 1 element from a to b at every procedure call,
; until a reaches 0. At which point it returns b.

; This is an iterative process, even though it is implemented with a recursive
; procedure `+`. At each step we only need the internal state to be able to resume
; the procedure.
