; When we calculated exponentials through successive squaring we managed to
; reduce the number of steps to O(logn) instead of O(n) by reducing the problem,
; at each step, to the same problem on an input with half the original size.
; In other words, at each step we reduced in half the total number of steps to
; be performed.

; The version of expmod proposed by Louis Reasoner has transformed the logarithmic
; process in a linear process by reverting precisely the benefit obtained on
; with successive squarings. With the explicit multiplication, he is still reducing
; the problem on `n` to the solution of the same problem on `n/2`, but he is
; triggering the calculation on `n/2` once for each of the separate calls to
; expmod. Hence the total time for such a calculation would be T(n) = 2*T(n/2).
; Calling the procedure `square` would trigger a single calculation
; of the `(expmod base (/ exp 2) m)` combination to be passed as argument.

; We may memoize such calculation in order to be able to keep the same
; explicit multiplication and preserving the logarithmic time, as such:

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (define memoized (expmod base (/ exp 2) m))
         (remainder (* memoized memoized)
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))