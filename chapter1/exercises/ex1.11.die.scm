;; Write a func f(n) such that
;;  fn(n) = n if n < 3
;;  fn(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n >= 3

(define (f n)
  (if (< n 3)
      n
      (+
       (f (- n 1))
       (* 2 (f (- n 2)))
       (* 3 (f (- n 3))))
      )
  )

(define (f-iter-in a b c count)
  (if (< count 3) c
  (f-iter-in b c (+ c (* b 2) (* a 3))  (- count 1))
  )
)

(define (f-iter n) (f-iter-in 0 1 2 n))
