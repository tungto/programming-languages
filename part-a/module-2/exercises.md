## Exercises

Work these out on paper before checking the answer key. For each snippet, write out both the static env and dynamic env at the marked point (or say why one of them never gets built).

**1. Basic buildup**

```sml
val m = 6;
val n = m * 2;
val p = n - m;
(* ??? env here *)
```

**2. Shadowing**

```sml
val k = 1;
val k = k + 1;
val k = k * 10;
(* ??? env here *)
```

**3. Type error**

```sml
val s = "age";
val t = s + 5;
(* what happens to the dynamic env here? why? *)
```

**4. Undefined variable**

```sml
val u = v + 1;
(* v was never declared. what catches this, and when? *)
```

**5. Order of binding**

```sml
val r = 3;
val s = r + q;
val q = 10;
(* is this valid? what does it tell you about when names must exist in the env? *)
```

<details>
<summary>Answer key (click to expand)</summary>

**1.**

- static env: `m : int, n : int, p : int`
- dynamic env: `m => 6, n => 12, p => 6`

**2.**

- static env: `k : int` (one entry — shadowing replaces, doesn't add)
- dynamic env: `k => 20` (`1` → `2` → `20`, each new binding hides the last)

**3.**

- Type checker rejects `s + 5` (`string + int`) during static checking.
- Dynamic env for `t` is never built — the program never runs because it fails to type-check first.

**4.**

- The static checker catches it: `v` has no entry in the static env, so it's flagged as undefined before evaluation starts. Dynamic env never sees `u` either.

**5.**

- Not valid. `q` doesn't exist in the env yet when `s` is defined — envs are built top-to-bottom, binding by binding. A later `val` can't be used by an earlier one.

</details>
