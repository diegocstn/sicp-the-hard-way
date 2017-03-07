(define (runtime) (real-time-clock))

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next-divisor test-divisor)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))))
(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time))

(define (find-primes start end)
	(cond ((even? start) (find-primes (+ start 1) end))
		  ((<= start end) (timed-prime-test start) (find-primes (+ start 2) end))))

; Non optimized
(define (next-divisor divisor)
  (+ divisor 1))

(find-primes 1000000 1000037) ; (/ (+ 4 4 4 7 6 6 5 4 4) 9.0) = 4.88 AVG
(find-primes 10000000 10000103) ; (/ (+ 14 10 8 10 6 4 10 6 5) 9.0) = 8.11 AVG
(find-primes 100000000 100000039) ; (/ (+ 41 25 14 28 14 15 58 22 14) 9.0) = 25.66 AVG

; Optimized
(define (next-divisor divisor)
  (if (= divisor 2) 3 (+ divisor 2)))

(find-primes 1000000 1000037) ; (/ (+ 2 2 1 2 2 2 3 3 3) 9.0) ~2.22
(find-primes 10000000 10000103); (/ (+ 3 2 3 10 6 6 5 3 3) 9.0) ~4.55
(find-primes 100000000 100000039); (/ (+ 15 8 8 27 23 17 9 8 9) 9.0) ~13.77

; Executing the procedure once for each range yields pretty different results,
; far from the expected ratio of 2, as it is evident from the first three
; timings of the second range (14, 10, 8 against 3, 2, 3).

; However, running the procedure multiple times for each range and calculating
; the averaged oes seem to yield measurements quite close to the ratio of 2,
; although slightly smaller. This can be likely justified by the additional
; branch condition that needs to becalculated within the `next-divisor` procedure.
