; Exercise 1.15
; sin r = 3 * sin(r/3) - 4 * sin3(r/3)
(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
   (if (not (> (abs angle) 0.1))
       angle
       (p (sine (/ angle 3.0)))))

; a) (sine 12.15)

(p (sine 12.15))
(p (p (sine 4.05)))
(p (p (p (sine 1.3499999999999999))))
(p (p (p (p (sine .44999999999999996)))))
(p (p (p (p (p (sine .15))))))
(p (p (p (p (p (sine 4.999999e-2))))))

; 5 calls, since from this point it will start
; start reducing p calls

; b) space and time complexity
; The space required is the space necessary to remember the deferred operations,
; which grows at the same rate as the number of steps (calls to `sine` since this
; is a recursive procedure). So both time and space follow the same order of growth.
;
; The order of growth in Space and time is better than linear. We need to multiply
; the input by three in order for the space to increase by 1 (by adding another
; deferred call to the `p` function). The space and time complexity is
; logarithmic (base 3).