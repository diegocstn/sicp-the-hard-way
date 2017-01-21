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
