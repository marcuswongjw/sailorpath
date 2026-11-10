# X-15 Global Ranking — Beta (v0.2)

**Proposed Framework for International X-15 Class Review**

- **Document Version:** `v0.2` (Updated 9 November 2026)
- **Status:** Independent draft framework prepared for Class review. It becomes an official Class ranking only if the International X-15 Class Association adopts it in writing.
- **Scope:** International X-15 one-design racing. Kept completely separate from Singapore national dinghy rankings and open WingFoil / iQFOiL standings.

---

## Aim

Reward current performance at verified X-15 events in a way that is easy for riders and families to understand, easy for organisers to supply, and easy for the Class to audit.

The beta model uses pre-designated event grades, a rolling 12-to-24 month window, a transparent counting formula, and points based on event grade, valid fleet size, and finishing position.

---

## Summary of the Six v0.2 Governance & Methodological Principles

Following review of the inaugural **2026 X-15 World Championships in Ibiza** (4–8 November 2026) and the **2026–2027 International X-15 Class calendar**, the framework incorporates six foundational principles:

1. **Simplified Counting Rules:** A rider’s score is the sum of their **best six eligible results**. These may include **at most one Grade 200 result** and **at most two Grade 100 results**. Any remaining places (up to six in total) may be filled by Grade 50 results. The system automatically selects the combination that yields the highest total points.
2. **Rider-Specific Worlds Rollover:** A rider may count their most recent eligible Worlds result in a division for **up to 24 months**. When that rider competes in a subsequent eligible Worlds in the same division, the new result replaces their previous Worlds result, even if lower. A cancelled or invalid championship does not trigger replacement. Other results remain eligible for 12 months.
3. **Precision on Fleet Size ($N$), Valid Starters & Re-indexing ($P$):** A valid starter is a rider recorded as having started at least one race in the series. Riders recorded solely as `DNS` or `DNC` across all races are excluded from $N$. Positions among valid starters are re-indexed in the relative order of the official final results ($1 \le P \le N$), while the official scorecard place is displayed separately. Race-level disqualifications (`DSQ`, `UFD`, `BFD`, `RET`) retain valid starter status; series-level disqualifications (`DNE`, `DGM`) are held for administrative review under a published policy.
4. **Five Ladders with Explicit Admin Event Mapping:** The five proposed ranking ladders are retained. For each event, an administrator explicitly maps the official scorecard to a ranking ladder. Mixed, split, or ambiguous divisions are held for review; SailorPath never infers eligibility from names. Progression is preserved: Junior results stay on the Junior ladder until natural expiry (they do not transfer to Youth). A rider racing both age brackets appears on both ladders independently.
5. **Transparency Over Premature Regional Caps:** No geographic or regional caps are imposed during the beta. Each ranking row displays total points, number of events counted, full breakdown of counting events (grades, points, expiry), and eligible uncounted events, accompanied by a clear beta note that rankings reflect both sailing performance and access to eligible events. Small-fleet multipliers ($N \in \{3, 4\}$) remain in beta testing.
6. **Tightened Governance & Proposed Target Grades:** Rankings are **provisional** during the seven-day correction window and remain updateable whenever an organiser issues an authoritative post-event correction. The official scoring table is the primary working source; source discrepancies are flagged publicly, and unresolved conflicts affecting a rider's final place make that result provisional. Calendar event grades are listed as **“Proposed Target Grades”** until formally designated before racing, with published rules for objective downgrade.

---

## 1. Ranking Ladders & Event Mapping

Each result counts only when an administrator explicitly maps an official, published Race Committee scorecard to a ranking ladder. SailorPath does not reconstruct age or gender sub-fleets from mixed or open scorecards.

| Ranking Ladder | Target Demographic | Ibiza 2026 Mapping Reference | Progression Rule |
| :--- | :--- | :--- | :--- |
| **Senior Men** | Open Male | `Senior Men` (38 riders) | Open age / Master categories included |
| **Senior Women** | Open Female | `Senior Women` (16 riders) | Open age female |
| **Youth Men (U19 & U17)** | Male U19 / U17 | `U19 and U17 Men` (28 riders) | Stays on Youth ladder until expiry |
| **Youth Women (U19 & U17)** | Female U19 / U17 | `U19 and U17 Women` (10 riders) | Stays on Youth ladder until expiry |
| **Junior (U15 & U13)** | Mixed U15 / U13 | `U15 and U13` (15 riders) | **Does not transfer to Youth.** Stays on Junior ladder until expiry. |

---

## 2. Event Categories & Proposed Target Grades

Grades are proposed targets until formally confirmed before racing by a designated administrator. Events must satisfy objective conditions to hold their grade; otherwise, they are downgraded according to published criteria.

| Grade | Category | Eligibility Conditions | Objective Downgrade Rule |
| :---: | :--- | :--- | :--- |
| **200** | **World Championship & Youth World Championship** | Official World Championship for the division; $\ge 2$ completed races constituting a valid championship under event SIs. | If cancelled or fewer than minimum required races completed, non-scoring (0 pts). |
| **100** | **Continental Championship or Qualifying Major International** | Pre-designated; $\ge 3$ countries; $\ge 2$ completed races (Continental) or $\ge 3$ races (Major International); **$\ge 15$ valid starters** across divisions (Continental) or **$\ge 25$ valid starters** (Major International). | If fewer than 15 valid starters or $<3$ countries, downgraded to Grade 50. If $<2$ completed races, non-scoring (0 pts). |
| **50** | **Class Circuit Open (`X-15 Games`, `America One Tour`, `Singapore Open`) & Recognised National Championships** | Listed on official Class calendar or recognized National Championship; $\ge 10$ valid starters across divisions; $\ge 3$ completed races; $\ge 2$ countries (Opens). | If fewer than 10 valid starters or $<3$ completed races, non-scoring (0 pts). |
| **0** | **Clinics, Demos, Exhibitions, Club Events** | Instructional clinics, local club racing, or unverified mixed fleets. | Always non-scoring (0 pts); displayed in sailor activity history only. |

---

## 3. Fleet Size ($N$), Valid Starters, Position Re-indexing ($P$), and Disqualifications

### A. Valid Starter Definition
- A **valid starter** is a rider recorded as having started at least one race in the official series.
- Any rider whose scoreline across all races consists entirely of non-starting codes (`DNS`, `DNC`) is **excluded** from the fleet size $N$.
- The division fleet size $N$ is the total count of valid starters in that official scoring sheet.

### B. Position Re-indexing ($P$)
- To guarantee mathematical consistency ($1 \le P \le N$) without altering official regatta scorecards:
  - Valid starters are assigned ranking positions $P \in \{1, \dots, N\}$ in the exact relative finishing order of the official final results.
  - The official printed regatta place is preserved and displayed alongside the ranking position.

### C. Disqualifications
- **Race-Level Disqualifications (`DSQ`, `UFD`, `BFD`, `DNE` in a single race, `RET`, `DNF`):** If the rider started at least one race, they remain a valid starter ($N$) and receive their re-indexed finishing place $P$.
- **Series-Level Disqualifications (`DGM`, disciplinary gross misconduct, RRS 69 / RRS 2):** Result is excluded from ranking points and held for administrative review under a published disciplinary policy.

---

## 4. Points Formula & Small-Fleet Multiplier

$$\text{Points} = E \times m(N) \times \frac{N - P + 1}{N}$$

Where:
- $E \in \{200, 100, 50\}$ is the event grade.
- $N$ is the number of **valid starters** in the official division.
- $P \in \{1, \dots, N\}$ is the rider’s re-indexed finishing position among valid starters.
- $m(N)$ is the small-fleet multiplier:
  - $m(N) = 1.0$ for **$N \ge 5$** (winner receives full grade points $E$).
  - $m(N) = 0.8$ for **$N \in \{3, 4\}$** (beta scaling to allow emerging regional fleets to score without distorting global rankings).
  - $m(N) = 0.0$ for **$N < 3$** (visible in event results, but 0 ranking points).

*Points are rounded to two decimal places (`0.01`).*

---

## 5. Simplified Counting Rules

A rider’s total score on a ranking ladder is the sum of their **best six eligible results**, selected automatically to maximize total points, subject to the following caps:

- **At most one (1) Grade 200 result**
- **At most two (2) Grade 100 results**
- **Remaining places (up to 6 total) filled by Grade 50 results**

*Example:* A rider with zero Grade 200 and zero Grade 100 results may count up to **six Grade 50 results**. If a rider's 6th Grade 50 result scores higher than a low-scoring Grade 200 finish, the system automatically counts the Grade 50 result to ensure the highest possible total.

---

## 6. Expiry & Rider-Specific Worlds Rollover

1. **Standard 12-Month Expiry:** All Grade 100 and Grade 50 results expire **12 months** after the final race date of the event.
2. **Rider-Specific Worlds Rollover (Up to 24 Months):**
   - A rider may count their most recent eligible World Championship result in that division for **up to 24 months**.
   - When that rider competes in a subsequent eligible World Championship in the same division, the new result **immediately replaces** their previous World Championship result, even if the new score is lower.
   - If a rider does *not* compete in the subsequent World Championship, their previous Worlds score remains eligible until the 24-month mark.
   - A cancelled, abandoned, or invalid championship does **not** trigger replacement.

---

## 7. Public Presentation & Beta Transparency

To avoid arbitrary geographic restrictions while the global calendar matures, no regional caps are imposed. Instead, full transparency is provided on every ranking page:

- **Row Breakdown:** Every rider entry displays:
  1. Total ranking points and number of counted events.
  2. Individual counting events with event name, grade, finishing place, points earned, and expiry date.
  3. Eligible results that did not count (with reasons, e.g., lower points, Grade 100 cap reached).
- **Beta Activity Disclosure:** A prominent banner explains:
  > *"Beta Notice: Global ranking totals reflect a combination of competitive performance and rider access to pre-designated international events. Standings will evolve as regional calendar density expands."*
- **Small-Fleet Review:** Fleet sizes ($N = 2, 3, 4, 5$) will be audited after the 2026–2027 season before formalizing the multiplier policy with the Class.

---

## 8. Governance, Source Conflicts & Correction Window

1. **Provisional Window:** All newly imported event results and rankings remain **Provisional** during a **7-day correction window**.
2. **Post-Window Authoritative Corrections:** If an event Race Committee, Protest Committee, or Class Association issues an authoritative correction after the 7-day window, SailorPath updates the scoring record and ranking history immediately.
3. **Source Priority & Discrepancies:**
   - The official signed or published scoring table (e.g. Sailwave / official notice board) is the authoritative working source.
   - Public discrepancies (such as conflicting editorial press releases) are visibly flagged.
   - Any unresolved conflict that creates ambiguity over a rider's finishing place makes that specific result provisional on the ranking ladder.
   - *Ibiza 2026 Flag:* In `U19 and U17 Men`, Leo Zabell is scored 3rd (15.0 nett) and Antoni Lutomski 4th (16.0 nett) in the official scoring table, whereas the class text recap stated otherwise. SailorPath scores Zabell 3rd and Lutomski 4th while flagging the result as provisional pending formal Class medal clarification.

---

## 9. 2026–2027 Calendar Proposed Target Grades

Synced with [`src/lib/x15Calendar.ts`](../src/lib/x15Calendar.ts) (checked November 2026). All grades are **Proposed Targets** pending pre-race confirmation:

| Period | Event | Venue | Proposed Target Grade | Category |
| :--- | :--- | :--- | :---: | :--- |
| **4–8 Nov 2026** | **X-15 World Championships 2026** | Ibiza, Spain | **200** | World Championship |
| **15–17 Dec 2026** | X-15 Emerging Nations Clinic | Jomtien, Thailand | **0** | Clinic (non-scoring) |
| **18–20 Dec 2026** | **X-15 Asian Cup 2026** | Jomtien, Thailand | **100** | Continental Championship |
| **27–31 Jan 2027** | **46th Singapore Open** | Singapore | **50** | Class Circuit Open |
| **Feb 2027** | **X-15 Games Malaysia** | Langkawi, Malaysia | **50** | Class Circuit Open |
| **Mar 2027** | **X-15 African Continental Championships** | Soma Bay, Egypt | **100** | Continental Championship |
| **Mar 2027** | **America One Racing Foiling Tour #1** | Long Beach, USA | **50** | Class Circuit Open |
| **Apr 2027** | **X-15 North American Championships** | Hawaii, USA | **100** | Continental Championship |
| **May 2027** | **X-15 Games Italy** | Lake Garda, Italy | **50 / 100** | Open (100 if $\ge 25$ starters & $\ge 3$ nations confirmed) |
| **May 2027** | **X-15 Games Caribbean** | Grand Cayman | **50** | Class Circuit Open |
| **May 2027** | **Garnier King of Bay** | Rewa, Poland | **50** | Class Circuit Open / National |
| **May 2027** | **America One Racing Foiling Tour #2** | Kaneohe, USA | **50** | Class Circuit Open |
| **18–20 Jun 2027** | **X-15 Games Poland** | Górki Zachodnie, Poland | **50** | Class Circuit Open |
| **Jul 2027** | **America One Racing Foiling Tour #3** | Cascade Locks, USA | **50** | Class Circuit Open |
| **Jul 2027** | **US Wingfoil Nationals** | San Francisco, USA | **50** | National Championship |
| **10–12 Jul 2027** | X-15 Peru Exhibition | Paracas, Peru | **0** | Exhibition (non-scoring) |
| **26 Jul – 1 Aug 2027** | **X-15 Games Scotland** | Scotland, UK | **50** | Class Circuit Open |
| **6–8 Aug 2027** | **X-15 Games Norway** | Arendal, Norway | **50** | Class Circuit Open |
| **Late Aug 2027** | **X-15 Games UK** | Portland, UK | **50** | Class Circuit Open |
| **Sep 2027** | **X-15 South American Championships** | Búzios, Brazil | **100** | Continental Championship |
| **Oct 2027** | **X-15 World Championships 2027** | Soma Bay, Egypt | **200** | World Championship |
| **Oct 2027** | **X-15 Games Hong Kong** | Hong Kong | **50** | Class Circuit Open |
| **Nov 2027** | **X-15 European Championships** | Ibiza, Spain | **100** | Continental Championship |
| **Nov 2027** | **America One Racing Foiling Tour #4** | Pensacola, USA | **50** | Class Circuit Open |
| **10–18 Dec 2027** | **X-15 Youth World Championships** | La Palma, Spain | **200** | Youth World Championship |
| **Dec 2027 / TBA** | **X-15 Games Thailand / China / France / Malta / Turkey** | Various | **50** | Class Circuit Open |

---

## 10. Baseline Preview — 2026 Ibiza World Championships (Grade 200)

*Scored under v0.2 rules ($E = 200$, $m(N) = 1.0$, re-indexed valid starters).*

- **Senior Men ($N = 38$, 2 races):**
  1. Kamil Manowiecki (POL) — **200.00 pts**
  2. Romain Ghio (FRA) — **194.74 pts**
  3. Kai Mirel (USA) — **189.47 pts**
  4. Mala'e McElheny (USA) — **184.21 pts**
  5. Luis Bohm (AUT) — **178.95 pts**
- **Senior Women ($N = 16$, 2 races):**
  1. Jette Koep (GER) — **200.00 pts**
  2. Pola Wawrzyniak (POL) — **187.50 pts**
  3. Marcelina Korszon (POL) — **175.00 pts**
  4. Cindy Robert (SUI) — **162.50 pts**
  5. Berta Campos Blanco (ESP) — **150.00 pts**
- **Youth Men — U19 and U17 Men ($N = 28$, 4 races):**
  1. Holland Vierling (USA) — **200.00 pts**
  2. Baptiste Loire (FRA) — **192.86 pts**
  3. Leo Zabell (ESP)* — **185.71 pts** *(Provisional — flagged)*
  4. Antoni Lutomski (POL)* — **178.57 pts** *(Provisional — flagged)*
  5. Botond Virag (HUN) — **171.43 pts**
- **Youth Women — U19 and U17 Women ($N = 10$, 3 races):**
  1. Yana Li (CHN) — **200.00 pts**
  2. Anae Rio (FRA) — **180.00 pts**
  3. Ane Fiskvik Mjoen (NOR) — **160.00 pts**
  4. Blanka Jerzelkowska (POL) — **140.00 pts**
  5. Sandra Bratli (NOR) — **120.00 pts**
- **Junior — U15 and U13 ($N = 15$, 4 races):**
  1. Benjamin Almeida (BRA) — **200.00 pts**
  2. Harrison Doyle (USA) — **186.67 pts**
  3. Kacper Hryniewicz (POL) — **173.33 pts**
  4. Ji Laizhi Andy (HKG) — **160.00 pts**
  5. Viktor Vaclavek (CZE) — **146.67 pts**
