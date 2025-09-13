# Book.Scanning.Errecto

The solutions for the Book Scanning Problem in this repository are taken from this repository: **https://github.com/Kostero/ghc20/tree/master**. The solution by Errecto team was placed 5th during the competition. They did some improvements in the extended round.  

We have:
 - organized files in a structured format
 - added batch scripts for automatical code execution
 - added a evaluation script to get the scores of the solutions
 - tested the solutions against a bigger dataset

**Important note:** The original code of the authors has not been changed.

## Solutions approaches

**Greedy (c_incunabula-tuned)**

Greedy heuristic for library signups: repeatedly select the not-yet-signed library maximizing adjusted gain = remaining book-score sum / signup_time, then mark its books taken, deduct their scores from overlapping libraries, and advance day by signup_time. Random “spec” multipliers (skip/×2/×10) and late-time boosts diversify choices and break near-deadline ties. Improves robustness.

**Greedy (d_tough_choices-tuned)**

Greedy variant with throughput: iteratively choose the unsigned library maximizing projected yield—sum of its highest-scoring unscanned books that fit after signup, limited by remaining days × per_day. Gains are multiplied by per-library weights: small random jitters and many hand-tuned zeros to blacklist weak libraries. Select, mark books scanned, advance day.

**Two-phase solver**

1. Randomized local search over library signup order using five moves—insert, replace, swap, erase, short-segment shuffle. Most iterations use a fast prefix-sum bound; late iterations use a capacity-aware greedy assigner.
2. Fix the best order and run score-tiered max-flow allocating books under per-day throughput and signup-time readiness constraints and overlaps.

Using a fixed seed makes Phase-1’s random local search deterministic: it locks the sequence of proposed moves (type, indices, positions, shuffle segments) and thus which local optimum you reach. Phase-2 max-flow is deterministic given the order, so only Phase-1 depends on the seed. We use the original creator’s seed for reproducibility.

Note:
ChatGPT 5 was used to get the analysis of the variants.
