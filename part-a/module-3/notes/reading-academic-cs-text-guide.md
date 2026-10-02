# How to Read Dense Academic/CS Text (B2 ESL Guide)

A reusable method for reading things like Coursera course notes, textbooks, and papers — text that is precise but hard to parse.

---

## Why this type of text feels so hard

- It's **precise, not casual** — every word matters, so you can't skim
- It uses **long sentences with the key idea buried in the middle or end**
- It uses **abstract placeholder words** (`x`, `e`, `t`, `v`) instead of concrete examples
- It packs **several ideas into one sentence** using connector phrases

None of this means the *ideas* are hard — often the idea is simple, but the **English sentence structure** hides it. Your job is to unpack the sentence, not just the idea.

---

## The 4-Step Reading Method

### Step 1: Read twice, with different goals
- **1st pass:** read fast, don't stop, just get the general topic. Don't take notes.
- **2nd pass:** slow down, apply Steps 2–4 below sentence by sentence.

Trying to fully understand on the first read is exhausting because you're doing two jobs at once (understanding English + understanding the concept).

---

### Step 2: Delete "connector phrases" — they are grammar glue, not new ideas

These phrases often confuse ESL readers because they look like they carry meaning, but they're mostly structural:

| Formal phrase | What it really means |
|---|---|
| "that is" | "=" (it equals) |
| "except with" | "plus" / "but add" (NOT subtraction — common trap) |
| "which will depend on" | "based on" |
| "mostly this depends on" | "mainly needs" |
| "(which will depend on ...)" in parentheses | a side note — OK to skip on first read |

**Trap to remember:** "except with" in this kind of text usually means **ADDING** something, not removing it. Example: "the environment except with x" = "the environment PLUS x" — this is opposite to the everyday meaning of "except," so watch for it.

---

### Step 3: Break one long sentence into several short ones, in order

Academic writing compresses many ideas into one sentence. You are allowed to "decompress" it back into separate sentences — one idea per sentence, in the order they logically happen.

**Example:**

> "produce a new dynamic environment that is the current environment except with x having the value v where v is the result of evaluating e"

Becomes:
1. We evaluate `e`.
2. This gives a value. Call it `v`.
3. Take the old environment.
4. Add one new thing: `x` now equals `v`.
5. This is the new environment.

---

### Step 4: Translate English into pseudocode / symbols

This is the strongest tool. Once you've broken a sentence into simple pieces (Step 3), compress it into a short symbolic line — this removes ambiguity and is often *easier to hold in memory* than the English sentence.

**Example:**

> "new dynamic environment = old dynamic environment except with x having value v"

becomes:

```
new_env = old_env + { x: v }
```

**Do this every time** you meet a rule described in English. It's a legitimate professional reading strategy, not a shortcut — engineers do this constantly when reading specs.

---

## Extra: Watch for these specific patterns

1. **Nested clauses in parentheses** — usually a side note, skip on first pass:
   > "evaluate e (which will depend on what kind of expression it is)"
   → Core meaning: "evaluate e." The parenthetical just says "the method depends on the expression type" — not essential to the main flow.

2. **"A is B except with C"** → `A = B + C` (adding C, not removing)

3. **"The result of X-ing Y"** → usually just means "Y's result" (simpler noun form)
   > "the result of evaluating e" = "e's value"

4. **Abstract letters (x, e, t, v)** — the moment you see these, **substitute a real example** immediately:
   ```
   val a = 3     →   x=a, e=3, t=int, v=3
   ```
   Abstract rules are hard to hold in your head; concrete examples are easy to check.

---

## Practice Routine (do this for every dense paragraph)

1. Read the paragraph once, fast, no stopping.
2. Re-read sentence by sentence. For each sentence:
   - Cross out connector phrases mentally (Step 2)
   - Break it into short, ordered sentences (Step 3)
   - Write a pseudocode line if it describes a rule or process (Step 4)
3. Plug in ONE concrete example to check your understanding.
4. If still unclear — ask for the specific sentence to be broken down, not the whole paragraph. Narrow questions get clearer answers.

---

## Quick Reference Table (keep this open while reading)

| When you see... | Do this |
|---|---|
| A sentence over ~25 words | Break into 2-4 shorter sentences |
| "that is", "except with" | Replace with "=" or "+" |
| Text in `(parentheses)` | Skip on first read, it's usually a side note |
| Abstract letters (x, e, t, v, ...) | Substitute a real, concrete example immediately |
| A rule described in prose | Try writing it as 1-2 lines of pseudocode |
| "X is analogous to Y" / "same as above but..." | Make a 2-column table comparing X and Y side by side |
