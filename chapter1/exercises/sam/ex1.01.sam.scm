; I'm using these procedures to demonstrate the answers to the exercise.

(define (expect something comparator)
  (cond ((comparator something) (display "OK!") #t)
        (else (display "!!FAIL!!") #f)))

(define (to_be another_something)
  (lambda (something) (= something another_something)))


(define (to_be_truthy argument)
  (to_be #t))

(define (to_be_falsy what)
  (not what))

; Exercise 1.1
(expect 10 (to_be 10))
(expect (+ 5 3 4) (to_be 12))
(expect (- 9 1) (to_be 8))
(expect (/ 6 2) (to_be 3))
(expect (+ (* 2 4) (- 4 6)) (to_be 6))
(define a 3)
; Value a

(define b (+ a 1))
; Value b

(expect (+ a b (* a b)) (to_be 19))
(expect (= a b) to_be_falsy)
(expect (if (and (> b a) (< b (* a b)))
    b
    a)
	(to_be b))

(expect (cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25)) (to_be 16))

(expect (+ 2 (if (> b a) b a)) (to_be 6))

(expect (* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1)) (to_be 16))
