;; Exercise 1.11
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
