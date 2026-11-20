# Programming Languages (SML course)

## 1. Goal

Build a CS foundation in functional programming that I can carry into JS/TS and backend work.
Done means: for each of sections 1-4 of *Programming Languages, Part A* (Dan Grossman, Standard
ML), I can solve a fresh homework-style problem from a blank file with passing tests, and explain
the section's key idea (immutability, pattern matching, closures, type inference, modules) in two
minutes with one SML and one JS example, alone and without notes.

Horizon: 2026-11-23 + 12 weeks = 2027-02-14. Then decide: Part B (Racket), or apply the ideas in
a JS/TS side project.

## 2. Topic graph

### 2.1 Graph

```
module-1 --> module-2 --> module-3 --> module-4
```

Critical path: the whole chain. Each section builds on the last, so there is no parallel topic.

| # | Topic | Needs | Unlocks | Bar category | Est. h | Source |
|---|---|---|---|---|--:|---|
| 1 | [module-1](topics/module-1/TOPIC.md) | - | module-2 | code + explain | 9 | Section 1 videos, `docs/section1sum.pdf`, HW1 |
| 2 | [module-2](topics/module-2/TOPIC.md) | module-1 | module-3 | code + explain | 9 | Section 2 videos, `docs/section2sum.pdf`, HW2 |
| 3 | [module-3](topics/module-3/TOPIC.md) | module-2 | module-4 | code + explain | 9 | Section 3 videos, `docs/section3sum.pdf`, HW3 |
| 4 | [module-4](topics/module-4/TOPIC.md) | module-3 | - | code + explain | 9 | Section 4 videos, `docs/section4sum.pdf`, HW4 |

`Needs` must match each `TOPIC.md`'s **Needs** field exactly; `validate.py` checks it. A
`(lite)` need only requires the configured minimum level on its subtopics.

### 2.2 Parallel rule

One module at a time. Start the next module only after the current one passes its bar
(re-tests of earlier modules continue in `active-revise`). No second topic in a checkpoint week.

## 3. Levels and bars

L1 recognize · L2 predict · L3 do alone · L4 spot the failure mode · L5 explain aloud (handle
two follow-ups) · L6 applied for 7 days.

| Bar category | Pass bar (independent, cold) |
|---|---|
| code + explain | (a) a fresh homework-style function from a blank file in 25 min, tests pass, no notes; (b) a 2-minute explain of the section's key idea with one SML and one JS example, surviving two follow-up questions |

Done = the bar met cold and alone, **plus** a re-test passed at +7d or later ("kept").

## 4. Phases

A forecast, not a schedule. The week numbers move; the order does not.

### Phase 1: W1-3

| Week | Main | Second | Outcome |
|---|---|---|---|
| 1 | module-1 | - | HW1 functions 1-6 done from blank |
| 2 | module-1 | - | HW1 complete, tests pass |
| 3 | module-1 | - | module-1 passed (CP1) |

### Phase 2: W4-6

| Week | Main | Second | Outcome |
|---|---|---|---|
| 4 | module-2 | - | datatypes, case, patterns predict-level |
| 5 | module-2 | - | HW2 complete |
| 6 | module-2 | - | module-2 passed |

### Phase 3: W7-9

| Week | Main | Second | Outcome |
|---|---|---|---|
| 7 | module-3 | - | map/filter/fold and closures do-alone |
| 8 | module-3 | - | HW3 complete |
| 9 | module-3 | - | module-3 passed (CP2) |

### Phase 4: W10-12

| Week | Main | Second | Outcome |
|---|---|---|---|
| 10 | module-4 | - | type inference by hand on 5 examples |
| 11 | module-4 | - | HW4 / module exercises complete |
| 12 | module-4 | - | module-4 passed (CP3) |

## 5. Tracks and effort

Side track next to interview-v2: about 3 h/week. Tue and Thu 40 min (main module), Sat 60 min
(homework or perform-drill), Sun 20 min (weekly review + due re-tests). Total: `plan.weekly_hours`
h/week across the slots in `coach.slot_map`.

### 5.1 Effort levels

| Level | Size | Counts for the streak? |
|---|---|---|
| minimum day | 10 min - one recall item + one error row | yes |
| minimum | 20 min | yes |
| target | 30 min | yes |
| stretch | 60 min - target + one follow-up on the same topic | offered, never owed |

### 5.2 Pace gate and drop ladder

Gate: `plan.weekly_hours × pace.gate_fraction` per week, measured over the last
`pace.lookback_weeks` weeks. Below it twice running, the next tier fires automatically.

| Tier | Drops | Saves |
|--:|---|--:|
| 1 | stretch blocks and challenge problems | 0.5 h |
| 2 | Java/C comparison files and optional videos; keep homework | 0.5 h |

Never dropped at any tier: due re-tests, each section's homework.

## 6. Checkpoints

| CP | Week | Bar | Failure branch |
|---|--:|---|---|
| CP1 | 3 | module-1 passed: HW1 tests pass, cold function from blank, 2-min explain of "no mutation" and let/scope | module-1 keeps the slot for W4; every later week shifts +1; horizon moves to 2027-02-21 |
| CP2 | 9 | module-3 passed: map/filter/fold from blank, closures explained with a JS example | if module-2 or 3 is still open, cut subtopic "ADTs with closures (vs Java/C)" to L2 and keep the dates |
| CP3 | 12 | module-4 passed, modules 1-3 kept | extend by 2 weeks max, then stop and decide Part B vs apply-in-JS |

The failure branch is written in advance and applied verbatim. Never improvised on the day.
