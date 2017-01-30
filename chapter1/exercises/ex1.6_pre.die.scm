(define (square x) (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.0001))

(define (avg x y )
  (/ (+ x y) 2))

(define (improve-guess guess x)
  (avg guess (/ x guess)))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve-guess guess x) x)))


(define (sqrt x)
  (sqrt-iter 1.0 x))


;; 1.7 improved sqrt
(define (good-enough-guess? old new)
  (< (abs (- old new)) 0.01))

(define (sqrt-iter-improved guess x)
  (if (good-enough-guess? guess (improve-guess guess x))
      guess
      (sqrt-iter (improve-guess guess x) x)))

(define (sqrt-improved x)
  (sqrt-iter-improved 1.0 x))

