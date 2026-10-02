# Section 1: SML Study and Reading Guide

Overview of Standard ML (SML) fundamentals from the first section of the course. Focus: functional programming, type systems, immutable data.

## Table of Contents

1. [The Three-Question Framework](#1-the-three-question-framework)
2. [Expressions, Values, and Environments](#2-expressions-values-and-environments)
3. [Variable Bindings and Immutability](#3-variable-bindings-and-immutability)
4. [Function Bindings and Lexical Scope](#4-function-bindings-and-lexical-scope)
5. [Compound Data: Pairs, Tuples, and Lists](#5-compound-data-pairs-tuples-and-lists)
6. [Local Bindings: Let Expressions](#6-local-bindings-let-expressions)
7. [Options: Handling "Nothing"](#7-options-handling-nothing)
8. [Logic and Comparison Operators](#8-logic-and-comparison-operators)
9. [Academic Vocabulary Glossary](#9-academic-vocabulary-glossary-b2-level)
10. [Complex Sentence Breakdowns](#10-complex-sentence-breakdowns)
11. [4-Step Action Plan for Mastery](#11-4-step-action-plan-for-mastery)

---

## 1. The Three-Question Framework

For any new language construct, answer three questions:

| # | Question | Meaning |
|---|----------|---------|
| 1 | **Syntax** | How do you write it? Grammar and structure rules. |
| 2 | **Static semantics** (type-checking) | What are the type rules? Happens *before* the program runs. Uses the **static environment** (types of previous bindings). |
| 3 | **Dynamic semantics** (evaluation) | How does it run? Expression simplifies to a value using the **dynamic environment** (values of previous bindings). |

---

## 2. Expressions, Values, and Environments

### Expressions vs. Values

- **Expression:** code that can be evaluated. Example: `8 + 9`.
- **Value:** expression with no more computation to do. Example: `17`.
- **Relationship:** all values are expressions, but not all expressions are values.

```sml
8 + 9            (* expression, not a value; evaluates to 17 *)
17               (* value *)
(1 + 2, 3 + 4)   (* expression; evaluates to the value (3, 7) *)
```

Type-check *then* evaluate. Ill-typed expression never runs:

```sml
val a = 1 + "2";   (* type error: caught before evaluation *)
```

### Static vs. Dynamic Environments

The *environment* is the context where code exists.

| Environment | Also known as | Purpose | Contains |
|-------------|---------------|---------|----------|
| **Static** | Context | Type-checking | Types of preceding bindings (e.g. `x : int`) |
| **Dynamic** | Environment | Evaluation | Values of preceding bindings (e.g. `x = 17`) |

Worked trace:

```sml
val x = 34;          (* static: x : int          dynamic: x = 34 *)
val y = x + 1;       (* static: x : int, y : int  dynamic: x = 34, y = 35 *)
val z = (x, y > 30); (* static: z : int * bool    dynamic: z = (34, true) *)
```

Each new binding extends both environments. Unbound name (e.g. using `w` above) fails type-checking.

---

## 3. Variable Bindings and Immutability

### Variable Bindings

**Syntax:**

```sml
val x = e;
```

- **Type-checking:** find type of `e` in current static environment. New static environment includes `x` with that type.
- **Evaluation:** evaluate `e` to value `v` in current dynamic environment. New dynamic environment maps `x` to `v`.

### Shadowing

Variables in ML are **immutable**. Once bound, a variable cannot change. No assignment statement exists.

```sml
val x = 8;
val x = 10;  (* second binding shadows the first *)
```

- First binding still exists, but environment uses most recent `x`.
- Earlier code that captured old `x` is unaffected:

```sml
val x = 8;
val y = x + 1;   (* y = 9 *)
val x = 10;      (* shadows x; y is still 9 *)
val z = x + y;   (* z = 19 *)
```

Shadowing is **not** mutation. A new binding is created; old one is untouched.

### Aliasing

Data is immutable, so language need not care whether two variables point to the same memory (**aliasing**).

- Languages with mutation (e.g. Java): two variables point to same object, changing one changes the other.
- ML: values never change, so shared vs. copied does not matter. Safer and more efficient.

```sml
val xs = [1, 2, 3];
val ys = 0 :: xs;    (* ys = [0, 1, 2, 3]; may share memory with xs *)
(* xs is still [1, 2, 3]; no code can ever observe the sharing *)
```

---

## 4. Function Bindings and Lexical Scope

### Function Syntax and Typing

**Syntax:**

```sml
fun x0 (x1 : t1, ..., xn : tn) = e
```

| Part | Meaning |
|------|---------|
| `x0` | Function name |
| `x1` ... `xn` | Arguments |
| `t1` ... `tn` | Argument types |
| `e` | Function body (an expression) |

**Type-checking:** body `e` is checked in a static environment where arguments have declared types and `x0` has type `(t1 * ... * tn) -> t`, where `t` is the type of `e` (the return type). This allows **recursion** (function calling itself).

**Evaluation:** a function is already a value. Calling `x0 (e1, ..., en)` evaluates the arguments, binds them to `x1` ... `xn`, then evaluates the body.

```sml
fun pow (x : int, y : int) =        (* pow : int * int -> int *)
    if y = 0
    then 1
    else x * pow (x, y - 1)

val a = pow (2, 5);                 (* a = 32 *)
```

Recursion works because `pow` is already in the static environment while its own body is type-checked.

```sml
fun sum_list (xs : int list) =
    if null xs
    then 0
    else hd xs + sum_list (tl xs)

val s = sum_list [1, 2, 3];         (* s = 6 *)
```

### Lexical Scope (Defined vs. Called)

Function body evaluates in the environment current **when the function was defined**, not where it is called.

- **Arguments:** bound to values only within the function body.
- **Top-level environment:** function arguments are not added to it.

```sml
val x = 1;
fun f (y : int) = x + y;   (* f captures x = 1 *)
val x = 100;               (* shadows x, but f does not see it *)
val z = f 2;               (* z = 3, not 102 *)
```

`f` uses `x = 1` because that was the environment when `f` was defined. Later shadowing of `x` cannot change `f`'s behaviour. Same idea underlies closures.

---

## 5. Compound Data: Pairs, Tuples, and Lists

### Pairs and Tuples

- **Building:** `(e1, e2)` is a pair. `(e1, e2, e3)` is a triple.
- **Accessing:** `#1 e`, `#2 e`, etc.
- **Types:** if `e1` is `int` and `e2` is `bool`, pair type is `int * bool`.
- Nesting allowed; tuples can hold other tuples and lists.

```sml
val p = (3, true);                  (* p : int * bool *)
val a = #1 p;                       (* a = 3 *)
val t = (1, (true, "hi"), [2, 3]);  (* t : int * (bool * string) * int list *)
val b = #2 (#2 t);                  (* b = "hi" *)
```

Function taking and returning pairs:

```sml
fun swap (pr : int * bool) = (#2 pr, #1 pr);   (* swap : int * bool -> bool * int *)
```

### Lists

Lists have flexible length but are **homogeneous** (all elements same type).

| Operation | Syntax | Description |
|-----------|--------|-------------|
| Empty list | `[]` | List with 0 elements. Type `'a list`. |
| Cons | `e1 :: e2` | Add element `e1` to front of list `e2`. |
| Null | `null e` | `true` if list is empty. |
| Head | `hd e` | First element. Exception if empty. |
| Tail | `tl e` | List minus first element. Exception if empty. |

```sml
val xs = [1, 2, 3];       (* int list; same as 1 :: 2 :: 3 :: [] *)
val ys = 0 :: xs;         (* [0, 1, 2, 3] *)
val h  = hd xs;           (* 1 *)
val t  = tl xs;           (* [2, 3] *)
val n  = null [];         (* true *)
val e  = [] : int list;   (* empty list with explicit type *)

val bad = [1, true];      (* type error: list not homogeneous *)
val boom = hd [];         (* runtime exception: empty list *)
```

Type rules: `e1 :: e2` needs `e1 : t` and `e2 : t list`, result `t list`. `hd : 'a list -> 'a`, `tl : 'a list -> 'a list`, `null : 'a list -> bool`. `'a` (read "alpha") is a type variable meaning "any type".

Typical list recursion: `null` is the base case, `hd` and `tl` drive the recursive case (see `sum_list` above).

Append, building a list with `::`:

```sml
fun append (xs : int list, ys : int list) =
    if null xs
    then ys
    else hd xs :: append (tl xs, ys)

val r = append ([1, 2], [3, 4]);   (* r = [1, 2, 3, 4] *)
```

---

## 6. Local Bindings: Let Expressions

**Syntax:**

```sml
let b1 b2 ... bn in e end
```

- **Purpose:** local variables and helper functions.
- **Scope:** bindings `b1` ... `bn` usable only inside the `let` expression.
- **Efficiency:** `let` avoids **exponential blowup**. Store recursive call result in a local variable (e.g. `val tl_ans = good_max(tl xs)`) so the same call is not repeated for the same data.
- **Type-checking / evaluation:** each `bi` extends the environment for the following bindings and for `e`. Type and value of whole `let` = type and value of `e`.

```sml
val r =
    let
        val a = 3
        val b = a * 2      (* sees a *)
    in
        a + b              (* 9 *)
    end
(* a and b are not visible here *)
```

### Example: `bad_max` vs. `good_max`

`bad_max` calls `bad_max (tl xs)` up to twice per level. Cost doubles each level, so O(2^n):

```sml
fun bad_max (xs : int list) =
    if null xs
    then 0   (* poor choice for empty list; see Options *)
    else if null (tl xs)
    then hd xs
    else if hd xs > bad_max (tl xs)
    then hd xs
    else bad_max (tl xs)
```

`good_max` saves the recursive result once with `let`. Cost O(n):

```sml
fun good_max (xs : int list) =
    if null xs
    then 0
    else if null (tl xs)
    then hd xs
    else
        let val tl_ans = good_max (tl xs)
        in
            if hd xs > tl_ans
            then hd xs
            else tl_ans
        end
```

Rough scale: on a 30-element list, `bad_max` makes on the order of a billion calls; `good_max` makes 30.

Local helper function:

```sml
fun countdown (x : int) =
    let
        fun count (from : int) =
            if from = x
            then x :: []
            else from :: count (from - 1)
    in
        count 7
    end
```

---

## 7. Options: Handling "Nothing"

Use options when a function may have no meaningful result (e.g. max of an empty list).

| Construct | Meaning | Type |
|-----------|---------|------|
| `NONE` | No value | `'a option` |
| `SOME e` | Wraps a value `v` | `t option` |
| `isSome` | Checks option is not `NONE` | |
| `valOf` | Extracts value from `SOME`. Exception on `NONE`. | |

Better `max`: return `NONE` for empty list instead of fake `0`.

```sml
fun max1 (xs : int list) =                 (* max1 : int list -> int option *)
    if null xs
    then NONE
    else
        let val tl_ans = max1 (tl xs)
        in
            if isSome tl_ans andalso valOf tl_ans > hd xs
            then tl_ans
            else SOME (hd xs)
        end

val m1 = max1 [3, 9, 4];   (* SOME 9 *)
val m2 = max1 [];          (* NONE *)
```

`valOf` is safe here only because `isSome` is checked first (`andalso` short-circuits). `SOME 9` has type `int option`, not `int`; must unwrap with `valOf` (or pattern matching, covered later).

---

## 8. Logic and Comparison Operators

| Operator | Syntax | Notes |
|----------|--------|-------|
| AND | `e1 andalso e2` | Short-circuit: `e2` evaluated only if `e1` is `true` |
| OR | `e1 orelse e2` | Short-circuit: `e2` evaluated only if `e1` is `false` |
| Negation | `not e` | |
| Equality | `e1 = e2` | |
| Inequality | `e1 <> e2` | |
| Negative numbers | `~7` | Use tilde `~`, not minus `-` |

```sml
val a = ~7;                          (* negative seven *)
val b = 3 - 7;                       (* binary minus is fine: ~4 *)
val c = 3 < 4 andalso 5 > 2;         (* true *)
val d = (1 = 2) orelse not (3 = 4);  (* true *)
val e = (1 <> 2);                    (* true *)
val f = 1 = 1 orelse hd [] = 0;      (* true; hd [] never evaluated *)
```

### Conditionals: `if-then-else`

**Syntax:** `if e1 then e2 else e3`

- **Type-checking:** `e1` must be `bool`. `e2` and `e3` must have the **same** type `t`. Whole expression has type `t`.
- **Evaluation:** evaluate `e1`. If `true`, result is `e2`; else `e3`. Only one branch evaluated.
- `else` is required. It is an expression, not a statement.

```sml
val a = if 3 > 2 then "yes" else "no";   (* "yes" *)
val b = if true then 1 else "no";        (* type error: branches differ *)
```

### Arithmetic notes

- `int` operators: `+ - * div`. Integer division is `div` (e.g. `7 div 2 = 3`), not `/`.
- `real` operators: `+ - * /`. `int` and `real` do not mix: `1 + 2.0` is a type error. Convert with `Real.fromInt`.
- `=` works on `int`, `bool`, `string`, but **not** on `real` (use `Real.==` or comparisons like `<`).
- Strings join with `^`: `"foo" ^ "bar"` is `"foobar"`.
- Comments: `(* ... *)`.

---

## 9. Academic Vocabulary Glossary (B2 Level)

| Word | Simple definition |
|------|-------------------|
| Binding | Link between a name (variable) and a value or type. |
| Immutable | Cannot be changed after creation. |
| Semantics | Meaning or logic of code (how it behaves). |
| Syntax | Rules for writing code correctly (the "grammar"). |
| Shadowing | Reusing a name for a new variable, hiding the old one. |
| Recursive | Function that calls itself to solve a smaller part of a problem. |
| Homogeneous | All parts same kind (e.g. list of only integers). |
| Inference | Computer automatically figures something out (like a type). |

---

## 10. Complex Sentence Breakdowns

### Passage 1: On Immutability

> "Because if there is no such feature mutation, then when you are writing your code you can rely on no other code doing something that would make your code wrong, incomplete, or difficult to use."

**Main idea:** if data cannot change, code is safer.

**Breakdown:**

- **"No such feature":** you cannot change variables.
- **"Rely on":** you can trust.
- **"No other code doing something":** other parts of the program won't secretly change your data.

### Passage 2: On Lexical Scope

> "Exactly which environment is it we extend with the arguments? The environment that 'was current' when the function was defined, not the one where it is being called."

**Main idea:** functions remember the environment where they were born.

**Breakdown:**

- **"Extend with the arguments":** add input values to the list of known variables.
- **"Was current":** variables that existed at that time.
- **"Defined" vs. "Called":** when code was written vs. when code actually runs.

---

## 11. 4-Step Action Plan for Mastery

1. **Trace the environment.** For every small ML program, draw the **static environment** (types) and **dynamic environment** (values) on paper.
2. **Practice the 3 questions.** For every new operator (e.g. `andalso`, `::`), write out its syntax, type-checking rule, and evaluation rule.
3. **Implement recursion.** Write list functions (e.g. `sum_list`, `append`) without notes. Focus on the **base case** (empty list) and the **recursive case**.
4. **Analyze efficiency.** Trace why `bad_max` from the notes is slow. Rewrite with a `let` expression and see the savings.
