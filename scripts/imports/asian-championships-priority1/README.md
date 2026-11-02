# Batch A: 2024 & 2023 Optimist Asian & Oceanian Championships Import

## Official Sources & Evidence Corroboration
Per `AGENTS.md` guidelines, official final results PDFs were downloaded from official host / scoring authorities, rendered to high-resolution PNGs via macOS PDFKit, and visually cross-checked against HTML results tables and individual race values:

1. **2024 Optimist Asian & Oceanian Championship**
   - **Host Venue**: Clearwater Bay Golf & Country Club Marina, Hong Kong
   - **Dates**: Dec 29, 2024 – Jan 5, 2025
   - **Organizers**: Sailing Federation of Hong Kong, China / Royal Hong Kong Yacht Club / IODA
   - **Official PDF**: `https://scoring.sailti.com/public/download/overall-datetime-pdf/8761/1/20250104170729`
   - **PDF Title**: *2024 Optimist Asian & Oceanian Championship — Final Overall Results (04/01/2025 17:07:29).pdf*
   - **SHA-256**: `02ad68ed417f443c020d5b41277a7b74cb24877a9d245741e8ef47ede2923399`
   - **Rendered Screenshots**: `screenshots/2024-opti-asian-page-[1-5].png` (5 pages)
   - **Competitors**: 133
   - **Races**: 9 races (5 Qualifying, 4 Final), 1 discard
   - **Score Reconciliation**: 133/133 gross totals and net totals match printed PDF with 0 errors.

2. **2023 Optimist Asian & Oceanian Championship**
   - **Host Venue**: Abu Dhabi Marine Sports Club, Abu Dhabi, United Arab Emirates
   - **Dates**: Oct 29 – Nov 5, 2023
   - **Organizers**: Abu Dhabi Marine Sports Club / UAE Sailing & Rowing Federation / IODA
   - **Official PDF**: `https://scoring.sailti.com/public/download/overall-datetime-pdf/7326/1/20231109230737`
   - **PDF Title**: *2023 Optimist Asian & Oceanian Championship — Final Overall Results (09/11/2023 23:07:37).pdf*
   - **SHA-256**: `93e6ff1b09d0f8b1cda52244c9a6c7b36581b1a4d3e1077a1c93b58b26ac2e47`
   - **Rendered Screenshots**: `screenshots/2023-opti-asian-page-[1-6].png` (6 pages)
   - **Competitors**: 157
   - **Races**: 9 races (5 Qualifying, 4 Final), 1 discard
   - **Score Reconciliation**: 157/157 gross totals and net totals match printed PDF with 0 errors.

---

## Fleet & Athlete Profile Summary
- **Total Combined Entries**: 290 individual competitors
- **Total Race Scores**: 2,610 individual race results
- **Profiles Linked to Existing Database Records**:
  - 2024: 90 competitors matched existing profiles (including Singapore squad and regional sailors)
  - 2023: 62 competitors matched existing profiles; 8 matched newly created 2024 profiles
- **New Profiles Created**: 130 international youth sailor profiles created source-faithfully with official NOC and gender.
- **Singapore National Squad Matching**:
  - 100% of established Singapore athletes in both regattas are matched to their canonical SailorPath profiles.
  - 2024 Singapore squad: Ethan Chia (1st Overall / Asian Champion), Sean Kum (2nd Overall), Nigel Tan (4th), Ashlea Tham (5th), Pee Teck Woon (6th), Desiree Lee (7th), Zeph Wan (9th), Lucas Cao (11th), Mikaela Rae Ng (36th), Germaine Sim (50th), Alyssa Wong (63rd).
  - 2023 Singapore squad: Ethan Chia (5th Overall / 1st Asian Boy), Lucas Cao (16th), Sean Kum (42nd), Zeph Wan (47th), Ethan Lee (56th), Nicole Lim (57th - new source-faithful profile), Nathaniel Cheung (63rd), Mikaela Rae Ng (84th), Ashlea Tham (86th), Nia Mehry Zahedi (96th).

---

## Ranking Policy
Per the Singapore ranking policy, overseas continental championships do not award national ranking points:
- `counts_for_ranking = false` on both `regatta_events` and `regattas` sheets.
- `ranking_credit = false` on all participant entries.


---

# Batch B: 19th Asian Games Hangzhou 2022 (Sailing) Import

## Official Sources & Evidence Corroboration
- **Event**: 19th Asian Games Hangzhou 2022 (Sailing)
- **Host Venue**: Ningbo Xiangshan Sailing Centre, Ningbo, China
- **Competition Dates**: Sep 21 – Sep 27, 2023
- **Organizers**: Hangzhou Asian Games Organising Committee (HAGOC) / Olympic Council of Asia (OCA)
- **Official Source**: Official OCA / Atos Games Information System archive tables.
- **Official PDF Search Record**:
  - `info.hangzhou2022.cn/resAG2022-/pdf/AG2022-/SAL/`: Host server now decommissioned.
  - `ocagames.com/orb/books/Hangzhou_2022/`: Dedicated results book PDF not published.
  - `racingrulesofsailing.org/documents/10653/event`: Official Notice Board points to the Atos information system.
  - *Per AGENTS.md, since no standalone official PDF is available, results are designated as official web-verified results (not PDF-verified).*
- **Score Reconciliation**: All race finishes, discards, and net totals independently verified and 100% reconciled against visible official result tables across all 8 classes.

---

## Classes & Singapore Squad Results
1. **Men's Dinghy - ILCA 7** (13 competitors, 11 races)
   - 🥇 **Ryan Lo Jun Han** (SGP) — **GOLD MEDAL** (26 net, 32 gross) &rarr; `Ryan Lo Jun Han` (`df7c6bd6-12f7-412b-994a-f116e820e30d`)
   - 🥈 Ha Jeemin (KOR) — Silver Medal (33 net)
   - 🥉 Vishnu Saravanan (IND) — Bronze Medal (34 net)

2. **Boy's Dinghy - ILCA 4** (12 competitors, 11 races)
   - 🥇 Weka Bhanubandh (THA) — Gold Medal (13 net)
   - 🥈 **Isaac Goh** (SGP) — **SILVER MEDAL** (21 net, 30 gross) &rarr; `Isaac Goh` (`93fc1c81-1ec7-4600-b9a1-bc613d11449c`)
   - 🥉 Muhammad Asnawi Iqbal Bin Adam (MAS) — Bronze Medal (42 net)

3. **Girl's Dinghy - ILCA 4** (8 competitors, 11 races)
   - 🥇 Noppassorn Khunboonjan (THA) — Gold Medal (16 net)
   - 🥈 Neha Thakur (IND) — Silver Medal (27 net)
   - 🥉 **Keira Marie Carlyle** (SGP) — **BRONZE MEDAL** (28 net, 33 gross) &rarr; `Keira Carlyle` (`be779040-d45c-4052-b458-9c9e88803505`)

4. **Women's Single Dinghy - ILCA 6** (9 competitors, 11 races)
   - 🥇 Nur Shazrin Mohamad Latif (MAS) — Gold Medal (25 net)
   - 🥈 Stephanie Norton (HKG) — Silver Medal (37 net)
   - 🥉 **Victoria Chan Jing Hua** (SGP) — **BRONZE MEDAL** (38 net, 46 gross) &rarr; `Victoria Chan` (`97cbde3f-9b92-5b2b-abbd-416a43ad32c9`)

5. **Women's Skiff - 49erFX** (6 boats / 12 sailors, 14 races)
   - 🥇 Hu Xiaoyu / Shan Mengyuan (CHN) — Gold Medal (27 net)
   - 🥈 Misaki Tanaka / Sera Nagamatsu (JPN) — Silver Medal (29 net)
   - 🥉 **Kimberly Min Lim / Cecilia Rui Qi Low** (SGP) — **BRONZE MEDAL** (34 net, 38 gross)

6. **Men's Skiff - 49er** (8 boats / 16 sailors, 14 races)
   - 🥇 Wen Zaiding / Liu Tian (CHN) — Gold Medal (42 net)
   - 🥈 Musab Mohammed Sulaiyam Al Hadi / Waleed Issa Al-Habashi Al-Kendi (OMA) — Silver Medal (46 net)
   - 🥉 Akira Luke Sakai / Russell Williams Aylsworth (HKG) — Bronze Medal (47 net)
   - 6th: **Koh Yi Nian / Tan Jen-E** (SGP) — 68 net, 77 gross

7. **Men's Windsurfing - iQFoil** (9 competitors, 18 races, 3 discards)
   - 🥇 Bi Kun (CHN) — Gold Medal (15 net)
   - 🥈 Lee Taehoon (KOR) — Silver Medal (36 net)
   - 🥉 Cheng Ching Yin (HKG) — Bronze Medal (45 net)
   - 6th: **Elkan Reshawn Oh** (SGP) — 90 net, 120 gross &rarr; `Elkan Oh` (`dbe45d3e-6640-4242-b347-f8ce6030a26c`)

8. **Women's Windsurfing - iQFoil** (5 competitors, 18 races, 3 discards)
   - 🥇 Huang Xianting (CHN) — Gold Medal (19 net)
   - 🥈 Ma Kwan Ching (HKG) — Silver Medal (29 net)
   - 🥉 Aticha Homraruen (THA) — Bronze Medal (48 net)
   - 4th: **Marsha Binte Shahrin** (SGP) — 54 net, 70 gross &rarr; `Marsha Shahrin` (`80419c1d-1ffc-4e6b-9c75-d94a7516df6b`)

---

## Ranking Policy
- `counts_for_ranking = false` on `regatta_events` and all 8 `regattas` sheets.
- `ranking_credit = false` on all participant entries.

## Batch C: 2024 ILCA Asian Open Championship (Haikou, China) — COMPLETED & DEPLOYED

- **Event**: 2024 ILCA Asian Open Championship
- **Dates**: December 14–20, 2024
- **Venue**: Haikou, Hainan, China
- **Organizers**: Asian Sailing Federation (ASAF), ILCA Asia, Chinese Yachting Association (CYA)
- **Source PDF**: `sources/2024-ilca-asian-championship-results-book.pdf` (25 pages)
- **SHA-256**: `4286a79171d047d3b4b18c6f2972a7e98a01beb94829edae5da88f9cd1be92ba`
- **Visual Screenshots**: `screenshots/2024-ilca-asian/page-[1-25].png`
- **Migration File**: `03-import-batch-c.sql`
- **Parent Event ID**: `e1a02024-a510-48e0-8003-000000002024`
- **Sheets Created (5)**:
  1. `b1a02024-a510-48e0-8003-000000000001`: ILCA 4 Youth Boys U18 (77 competitors, 10 races, 770 results)
  2. `b1a02024-a510-48e0-8003-000000000002`: ILCA 4 Youth Girls U18 (52 competitors, 10 races, 520 results)
  3. `b1a02024-a510-48e0-8003-000000000003`: ILCA 6 Men (30 competitors, 10 races, 300 results)
  4. `b1a02024-a510-48e0-8003-000000000004`: ILCA 6 Women (43 competitors, 10 races, 430 results)
  5. `b1a02024-a510-48e0-8003-000000000005`: ILCA 7 Men (47 competitors, 10 races, 470 results)
- **Total Rows**: 249 competitors, 2,490 race results, 249 participants, 206 new international athlete profiles.
- **Singapore Athletes (23 entries, 100% mapped)**:
  - Aurick Leow You Shun (7th, ILCA 4 Boys)
  - Austin Yeo Jia Yu (8th, ILCA 4 Boys)
  - Eitan Oh (12th, ILCA 4 Boys)
  - Ian Goh (15th, ILCA 4 Boys)
  - Wong Weikai Zachary (37th, ILCA 4 Boys)
  - Caleb Peck Rui Kai (54th, ILCA 4 Boys)
  - Danielle Lai (10th, ILCA 4 Girls)
  - Gabi Oh (11th, ILCA 4 Girls)
  - Sarah Yong (13th, ILCA 4 Girls)
  - Jemima Chang (17th, ILCA 4 Girls)
  - Nicholette Lee Wee Wen (22nd, ILCA 4 Girls)
  - Wong Li Xuan Mildred (37th, ILCA 4 Girls)
  - Isaac Goh (5th, ILCA 6 Men)
  - Kenan Kee Zen Tan (9th, ILCA 6 Men)
  - Ethan Yi Xuan Lim (21st, ILCA 6 Men)
  - Clive Wei Jun Seah (28th, ILCA 6 Men)
  - Jania Ang (11th, ILCA 6 Women)
  - Abigail Koh (32nd, ILCA 6 Women)
  - Keira Carlyle (33rd, ILCA 6 Women)
  - Elisha Lim Yu Ting (38th, ILCA 6 Women)
  - Charlotte Wee Shuen Lee (39th, ILCA 6 Women)
  - Sarah Seow Hui Yan (41st, ILCA 6 Women)
  - Jarrod Toh (33rd, ILCA 7 Men)
- **Deployment Status**: Successfully executed live on remote Supabase (`fdziuyexczkngvugvsbu`). All post-flight constraints and score reconciliation assertions passed.
