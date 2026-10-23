# Sailor Duplicate Reconciliation — Batch 8

**Executed:** 23 October 2026, 09:33 SGT  
**Scope:** Live Supabase Production (`fdziuyexczkngvugvsbu`)  
**Status:** Successfully Applied via Migration 145  

---

## 1. Summary of Actions

- **31 duplicate stub profiles consolidated** into **27 canonical sailor profiles**.
- **100% data integrity verified**:
  - `0` orphaned regatta results
  - `0` orphaned regatta result participants
  - `0` shared regatta conflicts between source and survivor profiles
  - All aliases, follower links, squad memberships, and claims seamlessly repointed.
- **7 durable keep-separate decisions recorded** in `admin_change_log` for verified distinct individuals (e.g. siblings sharing family boats) to prevent false-positive reappearance in the admin queue.
- Total active sailors in database: **3,057** (reduced from 3,088).

---

## 2. Consolidated Sailor Profiles (27 Groups)

### Group A: Reordered Name Tokens & Regional Multi-Entry Profiles
1. **Wai Zhi Tong** (`wai-zhi-tong`, SGP): Consolidated `Zhi Tong Wai` (`ilca4-worlds26-sgp-zhi-tong-wai-e31f27`, Aarhus Worlds 2026). Updated ILCA 4 sail to `225226`. (Results: 45 → 46)
2. **Wong Weikai Zachary** (`wong-weikai-zachary-ft0rnv9`, SGP): Consolidated `Zachary Wong` (`ilca4-worlds26-sgp-zachary-wong-d0bc30`, Aarhus Worlds 2026). Updated ILCA 4 sail to `221061`. (Results: 30 → 31)
3. **Pee Teck Woon** (`pee-teck-woon`, SGP): Consolidated `Pee Teckwoon` (`ilca4-worlds26-sgp-pee-teckwoon-a57565`, Aarhus Worlds 2026). Updated ILCA 4 sail to `228472`. (Results: 34 → 35)
4. **Chen Yu Kai** (`chen-yu-kai-thai25-ad7a6b`, TPE): Consolidated `Yu Kai Chen` (`yu-kai-chen-sr26-76e668`) and `Yu-Kai Chen` (`ilca4-tpe-yu-kai-chen-222236`). Shared sail `222236`, DOB `2010-01-01`.
5. **Thomas Yong Jin Ko** (`ilca4-hkg-thomas-yong-jin-ko-211709`, HKG): Consolidated `Ko Thomas Yong Jin` (`ko-thomas-yong-jin-lqdwzzm`) and `Thomas Ko` (`ilca4-hkg-thomas-ko-211709`). Shared sail `211709`.
6. **Yilin Elaine Dong** (`ilca4-hkg-yilin-elaine-dong-211688`, HKG): Consolidated `Dong Yilin Elaine` (`dong-yilin-elaine-lwxonfj`) and `Elaine Dong` (`ilca4-hkg-elaine-dong-211688`). Shared sail `211688`.
7. **Zhuowen Sophie Shao** (`ilca4-hkg-zhuowen-sophie-shao-191718`, HKG): Consolidated `Shao Zhuowen Sophie` (`shao-zhuowen-sophie-0bxv7fx`) and `Sophie Shao` (`ilca4-hkg-sophie-shao-215314`). Shared sails `191718` / `215314`.
8. **Seoyi An** (`asian-kor-seoyi-an-4eb55a`, KOR): Consolidated `An Seoyi` (`an-seoyi-sr26-47cfa1`). Shared Gangwon Sailing Team, DOB `2013-01-01`, sails `586` (Opti) / `190953` (ILCA).
9. **Yeh Chen Yang** (`yeh-chen-yang-thai25-077c93`, TPE): Consolidated `Chen-Yang Yeh` (`ilca4-tpe-chen-yang-yeh-214553`). Shared DOB `2012-01-01`, sails `422` (Opti) / `214553` (ILCA 4).
10. **Cheung Manchak** (`cheung-manchak-64rzofu`, HKG): Consolidated `Manchak Cheung` (`ilca4-hkg-manchak-cheung-190912`). Shared DOB `2011-09-12`, sails `302` (Opti) / `190912` (ILCA 4).
11. **Huang Chi Fang** (`huang-chi-fang-thai25-9bdb02`, TPE): Consolidated `Chi-Fang Huang` (`ilca4-tpe-chi-fang-huang-220975`). Shared DOB `2010-01-01`, sails `306` (Opti) / `220975` (ILCA 4).
12. **Jihoo Kim** (`asian-kor-jihoo-kim-263754`, KOR): Consolidated `Kim Jihoo` (`kim-jihoo-sr26-a1a0f3`). Shared KSAF, sail `562`, DOB `2012-01-01`.
13. **Songha Lee** (`ilca4-kor-songha-lee-223204`, KOR): Consolidated `Lee Songha` (`lee-songha-thai25-1417d1`). Shared DOB `2011-01-01`, sails `KOR 520` (Opti) / `223204` (ILCA 4).
14. **Tzu-Ho Liu** (`ilca4-tpe-tzu-ho-liu-217714`, TPE): Consolidated `Liu Tzu Ho` (`liu-tzu-ho-sr26-6b17e3`). Shared sail `217714`, DOB `2009-01-01`.
15. **Yixiu Luo** (`yixiu-luo-thai25-850d22`, CHN): Consolidated `Luo Yixiu` (`luo-yixiu-sr26-a4b376`). Shared Vanhang Sailing, sail `210703`, DOB `2009-01-01`.
16. **Sai Kit Tse** (`ilca4-hkg-sai-kit-tse-211740`, HKG): Consolidated `Tse Sai Kit` (`tse-sai-kit-lzoeucw`). Shared HKSF, sail `211740`.
17. **Chen Yu Shin** (`chen-yu-shin-thai25-27cdb9`, TPE): Consolidated `Yu Shin Chen` (`yu-shin-chen-sr26-9922c4`). Shared RVYC, sail `213037`, DOB `2008-01-01`.

### Group B: Minor Spelling / Name Variations & Missing Prefixes
18. **Muhammad Aiman Aqeel Bin Mohd Firdaus** (`muhammad-aiman-aqeel-bin-mohd-firdaus-29c7tud`, MAS): Consolidated `Muhammad Aiman Aqeel Mohd Firdaus` (`ilca4-worlds26-mas-muhammad-aiman-aqeel-mohd-firdaus-19fa5b`, Aarhus Worlds 2026). Updated ILCA 4 sail to `209885`.
19. **Nur Hafizanah Binti Zailan** (`nur-hafizanah-binti-zailan-25131kd`, MAS): Consolidated `Nur Hafizanah Zailan` (`ilca4-worlds26-mas-nur-hafizanah-zailan-55c9c4`, Aarhus Worlds 2026). Updated ILCA 4 sail to `209887`.
20. **John James Dwyer** (`ilca4-worlds26-jpn-john-james-dwyer-cdbe59`, JPN): Consolidated `John Dwyer` (`ilca4-jpn-john-dwyer-184018`). Shared ILCA sail `184018`.
21. **Jiun Choi** (`ilca4-worlds26-kor-jiun-choi-614785`, KOR): Consolidated `Ji Un Choi` (`ilca4-kor-ji-un-choi-223205`). Shared Busan Sailing Federation, ILCA sails `223205` / `225770`.
22. **Aueangkun Jadsanam** (`aueangkun-jadsanam-sr26-2b2f39`, THA): Consolidated `Auengkun Jadsanam` (`auengkun-jadsanam-sr26-525c8f`). Shared DOB `2009-01-01`.
23. **Yiming Jason Wu** (`yiming-jason-wu-sr26-4feb0a`, CHN): Consolidated `Yiming Wu` (`yiming-wu-thai25-471946`). Shared Vanhang Sailing, sail `214250`, DOB `2009-01-01`.
24. **Cheryl Sitong Shen** (`cheryl-shen-thai25-83677e`, HKG): Consolidated `Cheryl Sitong` (`cheryl-sitong-sr26-21b5d6`). Shared Vanhang Sailing, sail `214466`, DOB `2011-01-01`.

### Group C: First-Name / Partial Placeholders
25. **Tasanatham Suthamgosal** (`asian-tha-tasanatham-481c84`, THA): Consolidated `Tasanatham` (`tasanatham-sr26-99affe`). Shared ACDC, sail `1979`, DOB `2015-01-01`.
26. **Dani Pieter Mahmoud van Olphen** (`dani-pieter-mahmoud-van-olphen-gjqupp4`, HKG): Consolidated `Dani Van Olphen` (`ilca4-hkg-dani-van-olphen-213234`). Updated ILCA 4 sail to `213234`.
27. **Lyora Hong-yi Wallier** (`ilca4-hkg-lyora-hong-yi-wallier-213316`, HKG): Consolidated `Lyora Wallier` (`lyora-wallier-zq6g66t`). Shared ILCA sail `213316`.

---

## 3. Durable Keep-Separate Decisions (7 Pairs)

The following pairs were permanently recorded in `admin_change_log` with action `sailors.duplicates.keep_separate`:
1. `Maiko Higaki` ↔ `Nanako Higaki` (Sisters in Japan sharing family boat JPN 3434)
2. `Tomoharu Shiroishi` ↔ `Yasuharu Shiroishi` (Brothers in Japan sharing family boat JPN 3250)
3. `Ela Murat` ↔ `Eva Murat` (Sisters in Hong Kong)
4. `Maia Lim Laurie` ↔ `Misa Lim Laurie` (Sisters in USA/SGP)
5. `Kanna Yamamura` ↔ `Nana Yamamura` (Sisters in Japan)
6. `Kohei Hayashi` ↔ `Shohei Hayashi` (Brothers in Japan)
7. `Chen-Yi Kai` ↔ `Yu Kai Chen` (Unrelated sailors: Singapore Opti sailor born 2016 vs Taiwanese ILCA 4 sailor born 2010)
