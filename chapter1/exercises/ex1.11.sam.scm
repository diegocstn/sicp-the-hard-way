; Exercise 1.11

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
