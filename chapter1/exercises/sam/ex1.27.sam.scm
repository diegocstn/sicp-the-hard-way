; Exercise 1.27.  Demonstrate that the Carmichael numbers listed in footnote 47
; really do fool the Fermat test. That is, write a procedure that takes an
; integer n and tests whether a^n is congruent to a modulo n for every a<n,
; and try your procedure on the given Carmichael numbers.

; 561, 1105, 1729, 2465, 2821, and 6601


(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (is-carmichael n)
  (define (iter-carmichael n a)
    (cond ((= a 0) #t)
          ((= (expmod a n n) a) (iter-carmichael n (- a 1)))
          (else #f)))

  (iter-carmichael n (- n 1)))

(is-carmichael 561)
(is-carmichael 1105)
(is-carmichael 1729)
(is-carmichael 2465)
(is-carmichael 2821)
(is-carmichael 6601)