(define (double x) (+ x x))
(define (halve x) (/ x 2))

; The following is an improved version of the previous exercise.
; The number of steps grows logarithmically with `b` and the space is constant.
(define (not-so-slow-mult-improved a b)
  (define (mult-iter a b acc)
  	  ; Help visualizing how the algorithm proceeds
  	  (display a) (display "x") (display b) (display " with acc: ") (display acc) (display "\n")
	  (if (= b 1)
	  	  (+ a acc)
	  	  (if (even? b) (mult-iter (double a) (halve b) acc)
	  	  	            (mult-iter a (- b 1) (+ acc a)))))
  (mult-iter a b 0))