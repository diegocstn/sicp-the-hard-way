# SICP / The Hard Way

Notes by Samuel Brandão

## Chapter 1 - Building Abstractions with Procedures

> We are about to study the idea of a computational process. Computational processes are abstract beings that inhabit computers. As they evolve, processes manipulate other abstract things called data. The evolution of a process is directed by a pattern of rules called a program. People create programs to direct processes. In effect, we conjure the spirits of the computer with our spells.

*Lisp*
- Acronym for LISt Processing, it is a pratical programming language. It included new data objects: atoms and lists, which set it apart from other languages of the period;
- Late 1950s as a *formalism* for reasoning about the use of certain kinds of logical expresisons, called recursion equations, as a model for computation;
- A Lisp interpreter is a machine that carries out processes described in Lisp;
- Evolved informally for many years, which generated many dialects. We will use Scheme;
- Unique features that make it an excellent medium for studying important programming constructs and data structures and for relating them to the linguistic features that support them;
- Lisp procedures can be represented and manipulated as data.

### 1.1 - The Elements of Programming
Note: using sublime, set syntax-specific setting `"auto_match_enabled": false`

Any Lisp program can be written with (John Locke!):
- Primitive expressions
- Means of combination
- Means of abstraction

Simple ideas can easily become more complex ones by combination, and abstraction allows us to keep complexity low.

##### Primitive expressions

All the following are primitive expressions
```
486
(+ 137 349)
(- 1000 334)
(* 5 9)
(/ 10 5)
(+ 2.7 10)
```

Combinations are created with an operator and one or more operands (although in Lisp you can also have zero operands).

Prefix notation is used as a convention, but also because it has quite a few advantages.

- Can be used for procedures with variable number of arguments `(+ 1 3 5 12)`
- No ambiguity, because the operator is always the leftomost element and the entire expression is parenthesized.

We can get confused by deeply nested expressions:

```
(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))
```

So it is better if we help ourselves by indenting expressions so that operands are aligned vertically:

```
(+ (* 3
      (+ (* 2 4)
         (+ 3 5)))
   (+ (- 10 7)
      6))
```

#### 1.1.2

In the Scheme dialect of Lisp, we name things with define. Typing `(define size 2)` causes the interpreter to associate the value 2 with the name `size`. Afterwards, we can refer to the value 2 by using the name `size`.

Example:
```
(define pi 3.14159)
(define radius 10)

(* pi (* radius radius))
314.159

(define circumference (* 2 pi radius))

circumference
62.8318
```

*Define* is our simplest means of abstraction, for it allows us to use simple names to refer to the result of compound operations. This allows the construction of complex structures step by step through intermediate objects of increasing complexity.

The _environment_ is the name we give to the mapping holding the names and values we associate through `define`. More specifically, the above examples rely on the _global_ environment.

#### 1.1.3 Evaluating Combinations

When evaluating combinations, the interpreter is itself following a procedure:

- Evaluate the subexpressions of the combination
- Apply the procedure that is the value of the leftmost expression (the operator) to the arguments that are the values of the subexpressions (the operands)

This is a recursive procedure, as the first step invoke the procedure itself. This allows us to use the same procedure to evaluate arbitrarily nested expressions:

```
(* (+ 2 (* 4 6)) (+ 3 5 7))
```

The operator itself can also be an expression that yields an operator.

We can represent any combination expressions, as complex or deep as we want, as a tree structure. When evaluating the expression we can imagine that the values of the operands percolate upward, starting from the terminal nodes and then combining at higher and higher levels. This is an example of tree accumulation (see Figure 1.1 on book).

The repeated application of the procedure eventually leads to having to evaluate primitive expressions (numerals, built-in operators or names). We stipulate that:

- The values of numerals are the numbers that they name;
- The values of built-in operators are the machine instruction sequences that carry out the corresponding operations;
- the values of other names are the objects associated with those names in the environment.

If we place the built-in operators in the global environment, the second rule can be seen as a special case of the third one.

> In an interactive language such as Lisp, it is meaningless to speak of the value of an expression such as (+ x 1) without specifying any information about the environment that would provide a meaning for the symbol x (or even for the symbol +).

`Define` is a _special form_, which do not follow the above evaluation steps. It is not the application of the procedure define to two arguments. _Special forms_ follow special evaluation rules.

The syntax of a language is formed by the set of expressions and associated evaluation rules it accepts.

#### 1.1.4 Compound Procedures

We can already associate names with values by using `define`. We can also associte procedure definitions with names, so that we can use them as operators on subsequent expressions.

Example: to square something, multiply it by itself can be associated as `square` as such:

```
(define (square x) (* x x))
(square 21)
441
```

This is actually syntactic sugar for the general form of a procedure definition:

```
(define name (lambda ⟨formal parameters⟩) ⟨body⟩))
```

Any compound procedure defined can be used to build other procedures:

```
(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))
```

> Compound procedures are used in exactly the same way as primitive procedures. Indeed, one could not tell by looking at the definition of sum-of-squares given above whether square was built into the interpreter, like + and *, or defined as a compound procedure.

#### 1.1.5 The Substitution Model for Procedure Application

> To apply a compound procedure to arguments, evaluate the body of the procedure with each formal parameter replaced by the corresponding argument.

An example of the process caleed "Substitution Model":

```
(f 5)                             ; We begin by retrieving the body of f:
(sum-of-squares (+ a 1) (* a 2))  ; we replace the formal parameter a by the argument 5
(sum-of-squares (+ 5 1) (* 5 2))  ; We repeat the procedure now with sum-of-squares
(+ (square 6) (square 10))
(+ (* 6 6) (* 10 10))
(+ 36 100)
136
```

It is mainly used to help us think about procedure application, interpreters do not work by manipulating the text of a procedure to substitute values for the forma parameters. In practice the "substitution" is accomplished by using a local env for the formal params. It breaks with the usage of mutable data, and other models then become necessary.

#### Applicative Order vs. Normal Order

On the above example, whenever possible at each step we proceeded by evaluating the operands before diving into the procedure application:

```
(sum-of-squares (+ 5 1) (* 5 2))  ; We calculate 6 and 10 before
(+ (square 6) (square 10))
```

Another approach would not evaluate operands until their values were actually needed, as such:

```
(sum-of-squares (+ 5 1) (* 5 2))

(+ (square (+ 5 1))
   (square (+ 5 2)))

(+ (* (+ 5 1) (+ 5 1))
   (* (+ 5 2) (+ 5 2)))
; And then reduce:

(+ (* 6 6)
   (* 10 10))

(+ 36 100)

136
```
This is called _normal-order_ evaluation. We first fully expand and then reduce, while the other process, known as _applicative-order evaluation_ first evaluates the arguments and then apply the procedure.

They produce the same results for procedures that can be modelled with the Substitution Model, but not necessarily for every procedure.

Lisp uses applicative-order, partly because of the efficiency obtained from avoiding multiple evaluations of expressions such as those illustrated with `(+ 5 1)` and `(+_5 2)`.

#### 1.1.6 Conditional Expressions and Predicates

### Cond

General form:
```
(cond (⟨p₁⟩ ⟨e₁⟩)
      (⟨p₂⟩ ⟨e₂⟩)
      …
      (⟨pₙ⟩ ⟨eₙ⟩))
```

Example: a procedure for calculating the absolute value
```
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))
```

Another form, using `else` (as last statement):

```
(define (abs x)
  (cond ((< x 0) (- x))
      (else x)))
```

But else is just a syntactic sugar. The following is equivalent (#t is a primitive value representing true):

```
(define (abs x)
  (cond ((< x 0) (- x))
      (#t x)))
```

The evaluation proceeds in order until a predicate that evaluates to `true` is found, at whith point it's consequent expresson is evaluated for the result. If none is true, the value of the `cond` is undefined.

_Predicates_ are procedures that evaluate to `true` or `false`.

#### If - Used only when tehre are precisely two cases.

General form:

```
(if ⟨predicate⟩ ⟨consequent⟩ ⟨alternative⟩)
```

Example:
```
(define (abs x)
  (if (< x 0)
      (- x)
      x))
```

#### Logical composition operators

- `(and ⟨e₁⟩ … ⟨eₙ⟩)`
- `(or ⟨e₁⟩ … ⟨eₙ⟩)`
- `(not ⟨e⟩)`

And and Or are not procedures. They're special forms because the subexpressions are not necessarily all evaluated (lazy evaluation / short-circuiting).

#### 1.1.7 Example: Square Roots by Newton’s Method

> The contrast between function and procedure is a reflection of the general distinction between describing properties of things and describing how to do things, or, as it is sometimes referred to, the distinction between declarative knowledge and imperative knowledge. In mathematics we are usually concerned with declarative (what is) descriptions, whereas in computer science we are usually concerned with imperative (how to) descriptions.

Newton's method of successive approximations for computing square root of x:
  - Pick a random guess y
  - If the guess is good enough, we're finished
  - Improve the guess by averaging y and x/y (this always lead to a number that is closer to the sqrt of x)

We can write the basic strategy as a procedure:

```
(define (sqrt x)
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))

  (define (improve guess x)
    (average guess (/ x guess)))

  (define (average x y)
    (/ (+ x y) 2))

  (define (good-enough? guess x)
    (display guess) ; Added by me to follow the approximation path
    (display "\n")
    (< (abs (- (square guess) x)) 0.001))

  ; Our initial guess is 1
  (sqrt-iter 1.0 x))
```

#### 1.1.8 Procedures as Black-Box Abstractions

The sqrt problem illustrates well how a single problem can be broken down into
multiple subproblems. This decomposition strategy allow procedures to be reused
as components for multiple other procedures.

In order for procedures to be usable as black-box abstractions, a few things are important:

- Procedural abstraction: users of a procedures know nothing about the internals of the procedure itself (implementation is hidden, only the public interface is known).
- Local names
  - Users should not care about the formal parameters names used by the author of the procedure.
  - Formal parameters or names defined within a procedure should be distinct from the same names present in the context of usage of the procedure.
- Block structure: it should be possible to create internal definitions that do not leak to the outer context. This way we can localize subprocedures and build arbitrarily complex black-boxes. In scheme embedded definitions must come before their usage in a function body.

* Generically, a (code) block is a lexical structure of source code which is grouped together, and consists of declarations and/or statements. Languages that permit the creation of blocks are called block-structured programming languages.

> A formal parameter of a procedure has a very special role in the procedure definition, in that it doesn’t matter what name the formal parameter has. Such a name is called a bound variable, and we say that the procedure definition binds its formal parameters. The meaning of a procedure definition is unchanged if a bound variable is consistently renamed throughout the definition.26 If a variable is not bound, we say that it is free. The set of expressions for which a binding defines a name is called the scope of that name. In a procedure definition, the bound variables declared as the formal parameters of the procedure have the body of the procedure as their scope.

Example:
```
(define y 13)
(define (procedure a)  ; a is bound
  (+ y a))             ; y is free, so it refers to 13

(procedure 42) ; yields 55

(define a 12)
(procedure 42) ; still yields 55

(define y 42)
(procedure 42) ; now yields 84
```

Within `procedure`, a is ou bound name/varible. It is bound to the definition of the procedure so it will assume the value passed in when using the procedure. `y` instead is a free variable, and following the rules of lexical scoping, it is free to refer to binding made by enclosing procedure definitions, assuming the value 13 in this case.

### 1.2 Procedures and the Processes They Generate

> A procedure is a pattern for the local evolution of a computational process. It specifies how each stage of the process is built upon the previous stage. We would like to be able to make statements about the overall, or global, behavior of a process whose local evolution has been specified by a procedure. This is very difficult to do in general, but we can at least try to describe some typical patterns of process evolution.

Linear recursive processes require the interpreter to keep track of a number of operations to be performed later on, and the amount of operations that must be remembered grows linearly as the input size grows. Their evaluation usually presents a sequence of combination expansions and later a contraction. Book example: resursive factorial calculation.

Linear iterative processes do not need to keep track of deferred operations. The interpreter keeps track of a fixed number of state variables, the rules that describe how they should be updated as the process moves from state to state and optionally an end test specifying when it should terminate. Linear: the number of steps required grows linearly with the input size. Book example: iterative factorial calculation with accumulator.

In the iterative version, to resume a computation all we need would be the values of the fixed state variables. With the recursive process, the information of "where the process is" regarding the chain of deferred operations is also needed. The longer the chain, more info must be maintained.

A recursive procedure can describe an iterative process. We can use recursion to implement an iterative process to calculate the factorial of a number. If our interpreter performs tail-recursion optimizations, such a process would consume a constant amount of memory, just like it would with special constructs for iterations from other languages.

#### 1.2.2 Tree Recursion

The recursive implementation of fibonacci evolves as a tree recursive process:
```
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
```
(See image on book for the tree representation of the evaluation of (fib 5))

(fib n) is the closest integer to (φ^n) / sqrt(5), where φ is the golden ratio:
φ = (1 + sqrt(5))/2   ~ 1.6180

It satisfies the equation φ^2 = φ + 1.

The process uses an amount of steps that grows exponentially with the input, while the space usage grows linearly: at any point in the computation we only need to keep track of the nodes that are above us in the tree. The parent nodes represent the deferred operations at that point (the stack depth), hence the space needed is proportional to the depth of the tree. The number of steps is proportional to the number of nodes in the tree.

Tree recursive processes tend to be adequate to solve problems based on tree-like strucutures.

#### 1.2.3 Orders of Growth

When evaluating the tree of a process, the number of steps is proportional to the time taken for the evaluation.

Orders of growth provide only a crude description of the behavior of a process. For example, a process
requiring n 2 steps and a process requiring 1000n 2 steps and a process requiring 3n 2 + 10n + 17 steps all
have (n 2 ) order of growth.

#### 1.2.4 Exponentiation
