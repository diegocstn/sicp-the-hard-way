(define (runtime) (real-time-clock))

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
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

(timed-prime-test 10)

; Using this procedure, write a procedure search-for-primes that checks the
; primality of consecutive odd integers in a specified range.

(define (find-primes start end)
	(cond ((even? start) (find-primes (+ start 1) end))
		  ((<= start end) (timed-prime-test start) (find-primes (+ start 2) end))))

; Use your procedure
; to find the three smallest primes larger than 1000;
; than 100,000; larger than 1,000,000. Note the time needed to test each prime.

(find-primes 1000 1019)
(find-primes 100000 100043)
(find-primes 1000000 1000037)
(find-primes 10000000 10000103)
(find-primes 100000000 100000039)

; My results are compatible. Timing do seem to follow a linear ratio compared
; to the previous step, but closer to a 2-4 multiplication factor.
