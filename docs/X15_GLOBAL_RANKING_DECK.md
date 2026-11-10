---
marp: true
theme: default
paginate: true
header: "International X-15 Class Association · Global Ranking Proposal (Beta v0.2)"
footer: "SailorPath · November 2026"
---

# International X-15 Class Global Ranking — Beta (v0.2)
### A Modern, Transparent & Verifiable Ranking Framework for One-Design Wingfoil Racing

**Prepared by SailorPath for the International X-15 Class Association**  
*For Review & Discussion Ahead of the 2026 Class AGM (14 November 2026)*

---

## 1. Executive Summary: Why a Global Ranking Now?

* **Class Milestone:** World Sailing recognition (Nov 2025) and the successful completion of the inaugural **World Championships in Ibiza** (107 riders, 24 nations, 5 official divisions).
* **Expanding International Circuit:** 26+ events across Europe, Asia, Americas, and Africa listed on the 2026–2027 International Class Calendar.
* **The Need:** Riders, families, coaches, and Member National Authorities (MNAs) need a clear, objective measure of performance and activity that doesn't rely on fragmented spreadsheets.
* **Our Proposition:** An **independent Beta ranking** hosted on SailorPath, open to Class feedback, that automates standings directly from verified Race Committee scorecards.

---

## 2. Core Philosophy & Design Goals

1. **Easy to Understand:** Simple enough for a 13-year-old junior rider and their parents to follow and calculate on their own.
2. **Easy for Organisers to Supply:** Requires only standard published Race Committee scorecards (e.g. Sailwave / official Notice Board tables). No complex data re-entry.
3. **Easy for the Class to Audit:** 100% source-verified. Every score links directly to signed Race Committee evidence and publication timestamps.
4. **Reward Ability & Participation:** Balances high-level championship results with grassroots circuit growth across emerging nations.

---

## 3. The Five Ranking Ladders

Results count **only** when an administrator explicitly maps an official Race Committee scorecard to a ranking ladder. No synthetic age/gender reconstruction.

| Ranking Ladder | Target Category | Ibiza 2026 Fleet Mapping | Progression Rule |
| :--- | :--- | :--- | :--- |
| **Senior Men** | Open Male | `Senior Men` (38 riders) | Open age / Master categories included |
| **Senior Women** | Open Female | `Senior Women` (16 riders) | Open age female |
| **Youth Men** | Male U19 / U17 | `U19 and U17 Men` (28 riders) | Stays on Youth ladder until expiry |
| **Youth Women** | Female U19 / U17 | `U19 and U17 Women` (10 riders) | Stays on Youth ladder until expiry |
| **Junior** | Mixed U15 / U13 | `U15 and U13` (15 riders) | **Does not transfer to Youth.** Stays on Junior ladder until expiry. |

*Progression Note:* A junior rider who also competes in youth regattas appears on both ladders independently.

---

## 4. Proposed Target Event Grades & Downgrade Criteria

Grades are **proposed targets** until formally confirmed before racing. Clear objective criteria govern potential downgrades:

| Grade | Event Category | Conditions to Hold Grade | Downgrade Criteria |
| :---: | :--- | :--- | :--- |
| **200** | **World Championships** | Sole annual World Championship; $\ge 2$ valid races under event SIs. | Abandoned / invalid event $\implies$ 0 pts |
| **100** | **Continental Championships** | Pre-designated; $\ge 15$ starters across divisions; $\ge 3$ nations; $\ge 2$ races. | $<15$ starters or $<3$ nations $\implies$ Grade 50 |
| **100** | **Major Internationals** | Pre-designated; $\ge 25$ starters across divisions; $\ge 3$ nations; $\ge 3$ races. | $<25$ starters $\implies$ Grade 50 |
| **50** | **Class Circuit Opens & Nationals** | Listed on Class calendar or recognized National; $\ge 10$ starters; $\ge 3$ races. | $<10$ starters or $<3$ races $\implies$ 0 pts |
| **0** | **Clinics & Demos** | Instructional clinics, local club racing, unverified mixed fleets. | Always non-scoring |

---

## 5. Fleet Size ($N$), Valid Starters & Re-indexing ($P$)

* **No "Ghost Entries":** A valid starter must have started at least one race in the series. Riders recorded solely as `DNS` or `DNC` across all races are **excluded from $N$**.
* **Re-indexed Finishing Place ($P$):** Valid starters are assigned positions $P \in \{1, \dots, N\}$ in relative order of the official final results.
  * Preserves mathematical bounds ($1 \le P \le N$) without altering printed regatta scorecards.
  * Official regatta finish is displayed alongside the re-indexed rank.
* **Disqualifications:**
  * **Race-level DQs (`DSQ`, `UFD`, `BFD`, `RET`):** Retained as valid starters in $N$.
  * **Series-level DQs (`DGM`, Gross Misconduct under RRS 69 / RRS 2):** Held for administrative review under Class policy.

---

## 6. The Points Formula & Small-Fleet Scaling

$$\text{Points} = E \times m(N) \times \frac{N - P + 1}{N}$$

* $E \in \{200, 100, 50\}$: Event grade.
* $N$: Number of valid starters in the division.
* $P$: Re-indexed finishing position ($P=1$ earns maximum points).
* $m(N)$: Division fleet-size multiplier:
  * **$N \ge 5 \implies m(N) = 1.0$** (Full grade points).
  * **$N \in \{3, 4\} \implies m(N) = 0.8$** (*Beta scaling:* permits emerging regional female/junior fleets to earn points without distorting world standings).
  * **$N < 3 \implies m(N) = 0.0$** (Results displayed on profile, 0 ranking points).

*Points are rounded to two decimal places (`0.01`).*

---

## 7. Simplified Counting Rules: Best Six (6)

> **"A rider’s score is the sum of their best six eligible results. These may include at most one Grade 200 result and at most two Grade 100 results. Any remaining places may be filled by Grade 50 results."**

* **Maximizing Athlete Totals:** If a rider has no Grade 200 or 100 results, they may count up to **six Grade 50 results**.
* **Fully Automated:** The system automatically evaluates all eligible permutations and selects the exact combination that yields the highest total points.
* **No Artificial Penalty:** If a rider's 6th Grade 50 result scores higher than a low-scoring Grade 200 finish, the system counts the higher Grade 50 score.

---

## 8. Rider-Specific Worlds Rollover (Up to 24 Months)

* **The Problem:** Youth and amateur wingfoil racing has variable travel budgets; stripping Worlds points on a rigid 12-month calendar penalizes riders when consecutive Worlds are 11 or 13 months apart (e.g., Ibiza Nov 2026 $\rightarrow$ Soma Bay Oct 2027 $\rightarrow$ La Palma Dec 2027).
* **The Solution:**
  1. A rider counts their most recent eligible Worlds result in that division for **up to 24 months**.
  2. When that rider competes in a subsequent eligible Worlds in the same division, the new result **immediately replaces** the prior result, even if lower.
  3. If a rider cannot attend the subsequent Worlds, their prior score remains valid until the 24-month mark.
  4. A cancelled or invalid championship **never** triggers replacement.
* All other results (Grade 100 & 50) follow standard **12-month expiry**.

---

## 9. Presentation Transparency (Over Premature Regional Caps)

* **No Arbitrary Geographic Restrictions:** Premature regional caps (e.g. limiting European or Asian events) would penalize pioneer fleets building early density.
* **Full Transparency on Every Ranking Row:**
  * Total points and number of counted regattas.
  * Complete breakdown of counting results: event name, grade, finish position, points, and expiry date.
  * List of eligible results that did *not* count (with transparent reasons).
* **Prominent Beta Activity Notice:**
  > *"Beta Notice: Global ranking totals reflect a combination of competitive performance and rider access to pre-designated international events. Standings will evolve as regional calendar density expands."*

---

## 10. Governance, Source Conflicts & Correction Window

* **Provisional Status:** All newly imported event results and rankings are marked **Provisional** during a **7-day correction window**.
* **Post-Window Authoritative Updates:** If an event Protest Committee, Race Committee, or Class Association issues an authoritative correction after 7 days, rankings update immediately.
* **Official Scoring Table Priority:**
  * The signed/published scoring table is the authoritative working source.
  * Discrepancies between scoring tables and press releases are flagged publicly.
  * Unresolved discrepancies affecting a rider's rank make that specific result provisional.
  * *Ibiza 2026 Example:* Leo Zabell is scored 3rd and Antoni Lutomski 4th per the official Sailwave table, while the press release differed. SailorPath honors the scoring table and visibly flags the placings pending Class clarification.

---

## 11. 2026 Ibiza Worlds Baseline Preview (Grade 200)

*Inaugural baseline standings generated from visually verified official scorecards:*

| Senior Men ($N=38, \text{R}=2$) | Senior Women ($N=16, \text{R}=2$) | Youth Men ($N=28, \text{R}=4$) | Youth Women ($N=10, \text{R}=3$) | Junior ($N=15, \text{R}=4$) |
| :--- | :--- | :--- | :--- | :--- |
| **1. K. Manowiecki (POL)** — 200.00 | **1. J. Koep (GER)** — 200.00 | **1. H. Vierling (USA)** — 200.00 | **1. Y. Li (CHN)** — 200.00 | **1. B. Almeida (BRA)** — 200.00 |
| **2. R. Ghio (FRA)** — 194.74 | **2. P. Wawrzyniak (POL)** — 187.50 | **2. B. Loire (FRA)** — 192.86 | **2. A. Rio (FRA)** — 180.00 | **2. H. Doyle (USA)** — 186.67 |
| **3. K. Mirel (USA)** — 189.47 | **3. M. Korszon (POL)** — 175.00 | **3. L. Zabell (ESP)\*** — 185.71 | **3. A. Mjoen (NOR)** — 160.00 | **3. K. Hryniewicz (POL)** — 173.33 |
| **4. M. McElheny (USA)** — 184.21 | **4. C. Robert (SUI)** — 162.50 | **4. A. Lutomski (POL)\*** — 178.57 | **4. B. Jerzelkowska (POL)** — 140.00 | **4. J. Andy (HKG)** — 160.00 |
| **5. L. Bohm (AUT)** — 178.95 | **5. B. Campos (ESP)** — 150.00 | **5. B. Virag (HUN)** — 171.43 | **5. S. Bratli (NOR)** — 120.00 | **5. V. Vaclavek (CZE)** — 146.67 |

*\*Flagged provisional pending Class clarification of medal attribution.*

---

## 12. Key Discussion Questions for the Class AGM

We invite the International X-15 Class Executive Committee and Members to review:

1. **Division Alignment:** Does the Class support maintaining these 5 combined ranking ladders to match current Race Committee scoring practice?
2. **Small-Fleet Scaling ($m(N)$):** Is the $0.8\times$ factor for 3–4 boat fleets appropriate for emerging regional stops (e.g. Asia/Americas) during 2027?
3. **Proposed Target Grades:** Does the Class agree with the proposed target grading of upcoming events (e.g., Asian Cup = Grade 100, Singapore Open & X-15 Games = Grade 50)?
4. **Disciplinary Policy:** Agreement on treating race penalties (DSQ/UFD) as valid starters while excluding series-level misconduct (RRS 69).
5. **Next Steps:** Run the ranking as an **Independent Beta on SailorPath** through 2027, reviewing data with the Class before formal adoption.

---

# Thank You

**SailorPath**  
*Tracking one-design sailing and foiling race by race.*

- Framework Document: `docs/X15_GLOBAL_RANKING_FRAMEWORK.md`
- Live Event Hub: `sailorpath.com/classes/x15`
- Contact & Feedback: `marcuswongjw@gmail.com`
