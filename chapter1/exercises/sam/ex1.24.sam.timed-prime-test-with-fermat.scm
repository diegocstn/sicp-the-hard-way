; First we redefine everything, but using fast-prime?
(define (runtime) (real-time-clock))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 100)                          ; fast-prime for 100 times (arbitrary choice)
      (report-prime n (- (runtime) start-time))))

(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (find-primes start end)
  (cond ((even? start) (find-primes (+ start 1) end))
      ((<= start end) (timed-prime-test start) (find-primes (+ start 2) end))))

; Ideally I'd expect the time to compute 1000000 to be only about 2 times the previous
; timings, since log(1000000) / log(1000) equals 2.

(find-primes 1000 1019) ; 10 7 7
(find-primes 100000 100043); 8 9 8
(find-primes 1000000 1000037) ; 9 8 9
(find-primes 10000000 10000103) ; 6 6 7
(find-primes 100000000 100000039) ; 7 6 7
(find-primes 1000000007 1000000021) ; 12 10 11

; Which are quite unreliable results.
; However running the above multiple times yield completely different results each
; time. In this experience it seems computatios is heavily influenced by the
; underlying machine. It is likely that results are taking more time to be processed
; because of O.S context switches than actual calculations. I'll try a modified
; version that performs each prime calculation 100.000 times:

(define (start-prime-test n start-time)
  (if (fast-prime? n 10000000)
      (report-prime n (- (runtime) start-time))))

; The results are surprisingly stable:
(find-primes 100003 100043) ; (/ (+ 32674 34346 34101) 3.0) AVG 
(find-primes 1000000007 1000000021) ; (/ (+ 67586 63078 64325) 3.0)

; This yields a ratio of 1.92, while the expected ratio would be 
; log2(1000000000) / log2(100000) = 1.8
; The fact that it is slightly above the theoretical ratio is reasonable since
; every time we execute `expmod` we also execute other constant-time operations
; such as branching on procedure calls. This could also accounts for O.S context
; switches and process scheduling.