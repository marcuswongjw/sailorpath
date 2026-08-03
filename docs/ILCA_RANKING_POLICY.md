# Singapore ILCA 4 / ILCA 6 ranking & squad policy

## Dual sail numbers

Sailors **younger than 15** may hold **two** sail numbers:

| Class | Profile field |
|--------|----------------|
| Optimist | `sail_number` (primary) |
| ILCA 4 | `sail_number_ilca4` |

On import, sail numbers update **per class** by **latest regatta date**. Club and school still follow the single latest event of any class.

## High Ranking Points (ILCA 4 & ILCA 6)

In a ranking regatta with **N** starters:

| Place | Points |
|------:|-------:|
| 1st | N |
| 2nd | N − 1 |
| … | … |
| Nth | 1 |
| DNS / no result | 0 |

**Series score** = sum of the **best 3** point totals from the **last 5** ranking regattas (higher is better).

### Ranking vs non-ranking ILCA events

ILCA 4 (and ILCA 6) events can be **ranking** or **non-ranking**:

| Status | Counts toward national Best 3 of 5? |
|--------|-------------------------------------|
| Ranking | Yes (when `counts_for_ranking` is true) |
| Non-ranking | No — still on sailor logbook / profiles |

**Insufficient races:** if **completed races &lt; 3**, the event is treated as **non-ranking** for the series (abandoned / incomplete regatta). Set **Races completed** on import or in Database → Regattas. Admin can also mark non-ranking manually for trials/training.

Optimist Gold/Silver continues to use **place as score** (lower is better) and is **never mixed** with ILCA events.

## ILCA 4 national ranking list

Membership is **admin-managed** (`sailors.ilca4_national_list`, migration `026_ilca4_national_list.sql`).

- **Admin → ILCA ranking**: shows **all** sailors with ILCA 4 results or an ILCA 4 sail number; toggle **Add to list / remove**.
- **Seed from official 73 names**: matches DB names to the authority list (token-order, e.g. `Goh, Ian` ≈ `Ian Goh`).
- **Public board** (`/sg/ilca4`): Optimist-style table (R1–R5 high points + Best 3 of 5). Only flagged sailors **with ranking results**. **No public squad shortlist** (admin-only).
- Until at least one DB flag is set, the seed name list is used as a fallback.
- **ILCA 4 duplicate finder** in the same admin tab (name / Optimist sail / ILCA 4 sail).

## ILCA 4 national squad (up to 16)

**Eligibility:** on the national list; ranked **top 25**; **SGP nationality only**; birth year implies **≤ 17** in the intake year (as of 31 Dec of intake year).

| Intake | Ranking as of |
|--------|----------------|
| **July** | **30 June** (same calendar year) |
| **January** | **20 December** (previous calendar year) |

**Selection order** (from the ranking list, top 25 only, SGP):

1. Top **2 males** and top **2 females** (overall)
2. Top **2 males** and top **2 females** who are **16** in the intake year
3. Top **4 males** and top **4 females** who are **15 or younger** in the intake year

If any bucket is short, invite the **next highest ranked sailor of the same gender** until the gender slots are filled (cap 16).

## Admin / public

- **Public:** `/sg/ilca4` national standings (menu: SG ILCA 4).
- **Regatta Excel**: set Class = ILCA 4 → Open fleet (no Gold/Silver).
- **Gold analysis**: Optimist Gold only.
- **ILCA ranking** (admin tab): High-points series + squad shortlist preview.

