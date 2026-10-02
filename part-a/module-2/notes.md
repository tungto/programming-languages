# Module 2 — Terms

## Variable Shadowing

Shadow: means to block the view of something, or to stand in front of it so you can't see it.

- Person A (`x = 10`) is standing there first.
- Person B (`x = 20`) steps directly in front of A.
- A is still there, but can only see B, because B shadows (hides) A.

## Environment (env) in Programming

An env is basically a mapping — it tells you what value each variable name currently refers to. When you evaluate `x + 1`, the env is what tells you what `x` actually is.

### Dynamic Env

A dynamic env is an env that contains variables and the evaluated values bound to them; this env is created when executing the code.

- Maps variable names → actual values (e.g., `x --> 34`)
- Built up as the program runs (during evaluation)
- Used when you actually evaluate expressions

```sml
val x = 2;
val y = x + 4;
(* this env contains vars x and y,
   where x is bound to 2 and y is bound to 6 (the evaluated value) *)
```

### Static Env

- Maps variable names → types (e.g., `x` has type `int`) — not values
- Built up during type checking, which happens before the program ever runs
- Used to catch errors early: using an undefined variable, or an inconsistent type (like adding a string to an int) — all caught before evaluation even starts

Instructor's framing: the static env behaves like the dynamic one structurally (still a lookup map, still grows binding by binding), but it deals with "what's an `int`" or "what's defined" — not actual values, and it doesn't run anything.

|              | Dynamic environment       | Static environment                       |
| ------------ | ------------------------- | ---------------------------------------- |
| Maps         | name → value              | name → type                              |
| Built during | evaluation (runtime)      | type checking (before runtime)           |
| Purpose      | compute the actual result | catch type errors / undefined vars early |

### Example 1 — basic buildup

```sml
val x = 34;
(* static env:  x : int *)
(* dynamic env: x => 34 *)

val y = 17;
(* static env:  x : int, y : int *)
(* dynamic env: x => 34, y => 17 *)

val z = (x + y) + (y + 2);
(* static env:  x : int, y : int, z : int *)
(* dynamic env: x => 34, y => 17, z => 70 *)

val q = z + 1;
(* static env:  x : int, y : int, z : int, q : int *)
(* dynamic env: x => 34, y => 17, z => 70, q => 71 *)
```

Math checks out: `z = (34+17) + (17+2) = 51 + 19 = 70`, then `q = 70 + 1 = 71`.

### Example 2 — shadowing updates both envs

```sml
val x = 10;
(* static env:  x : int *)
(* dynamic env: x => 10 *)

val x = 20;
(* the new x shadows the old one — old binding is gone from the env, not merged *)
(* static env:  x : int *)
(* dynamic env: x => 20 *)
```

Every later lookup of `x` resolves to the newest binding (`20`), just like Person B standing in front of Person A above.

### Example 3 — static env catches an error before dynamic env ever runs

```sml
val a = 5;
(* static env: a : int *)

val b = a + "hello";
(* type checker rejects this here — int + string doesn't type-check.
   the dynamic env never gets a chance to bind `b`, because the
   program never runs. this is the whole point of a *static* check. *)
```

# Vocab 
- Read-eval-print loop - REPL
- Intepreter
- variable sementic: how it type-checks and evaluates
- A value: an expression that, "has no more computation to do"
- What does: "all values are expressions. Not all expressions are values"? 
- How to type-check a variable binding? 
- How to evaluate a variable binding? 
- Definitions of:
  - integer constatns
  - addition
  - variables
  - conditionals
  - boolean constants
  - less-than comparision
- Questions to ask when learn new construct in a pl
- what is OPTION?




<!-- fun binding -->

```sml
fun pow (x: int, y: int) = 
  if y = 0
  then 0
  else x * pow (x, y - 1)
```

When learn new construct we ask: 
- syntax
- how it type-checking
- how it evaluate
- how to call/ use it

**Pair and other tuples**
What is an tuples? 
**Pairs**
Syntax: (e1, e2)
Evaluatation: 



## summary 1 notes
new_env = old_env + {x: v} 