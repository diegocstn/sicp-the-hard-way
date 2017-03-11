; For small numbers the proposed procedures should be enough. However,
; when testing for bigger numbers, the fact that Alyssa's solution performs
; the remainder calculation only at the end may cause wrong results, since
; the exponential calculation may overflow the default integer representation
; of the underlying machine much quicker.

; If the underlying Scheme implementation (or any other programming language)
; automatically handles numbers exceeding the default integer representation,
; correctness may be guaranteed but we may not be able to assume
; arithmetic operations with such numbers to take constant time,
; and so the algorithm performance may differ
