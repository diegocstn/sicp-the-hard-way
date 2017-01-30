## Chapter 1
>Lisp descriptions of processes can themselves be represented and manipulated as Lisp data

**Combinations** are the building blocks of a Lisp programs.
A combination is a list of expressions delimited by parentheses:
- `(+ 4 5)`
- `(+ 4 (/ 6 3))`

Combinations are evaluated recursively, we can represent them as a tree. The process of evaluation of the tree, percolating values upwards, is known as ***tree accumulation***.

`(define x 3)` is one of the *special forms*, it has a different evaluation rule, it's used for 'naming things' (variables, procedures etc..).

**Procedures definitions**

We can define a procedure using the form
`(define (name params) (body))`

e.g. `(define (square x) (* x x))`


### Evaluation models

Two possible evaluation models:
1. **applicative order evaluation**: evaluate first the operator and operands and then apply

2. **normal order evaluation**: fully expand until the expression is only composed of primitive operators and then perform the evaluation

### Conditionals

TODO
