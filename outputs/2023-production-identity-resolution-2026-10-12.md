# 2023 production import — identity resolution record

**Preflight date:** 12 October 2026
**Production project:** SailorPath (`fdziuyexczkngvugvsbu`)
**Target migration:** `112_import_verified_singapore_2023_results.sql`

## Deployment status

- The idempotent prerequisite migration `109_add_regatta_official_result_sources` was applied successfully to production.
- Migration `112_import_verified_singapore_2023_results` was applied successfully to production.
- All six 2023 class sheets, 477 result rows, 3,531 individual race scores, and 477 solo participant snapshots are present.
- The owner-approved 27 aliases and six source-backed profiles were written only after the migration’s uniqueness and alias-conflict guards passed.
- Every imported result has its expected race count; 0 gross-score, net-score, participant-snapshot, or latest class-specific sail-number mismatches remain.

## Resolved decisions

The **27 Approved** alias rows and **6 Approved — create** rows below were applied in migration 112. Every source row has an owner-approved identity decision; no sailor profiles were merged.

| Source name in official result | Staged result occurrence(s) | Live roster suggestion | Status | Reason |
| --- | --- | --- | --- | --- |
| Aaron Abraham | NSC Cup 2023 (Optimist Gold) — rank 69 (entry SGP 4669) | Aaron Abraham Say | **Approved** | Truncated last token. |
| Adien Wong Kang Jun | CSC Optimist Championships 2023 (Optimist Silver) — rank 47 (entry 2018) | Aiden Wong Kang Jun | **Approved** | Single-letter spelling variance. |
| Adriel Cheung Hei Yat | CSC Optimist Championships 2023 (Optimist Silver) — rank 35 (entry 3611) | Cheung Hei Yat Adriel | **Approved** | Same tokens in reverse order. |
| Amos Tham | NSC Cup 2023 (Optimist Gold) — rank 2 (entry SGP 4463) | Tham Wan Yew Amos | **Approved** | Shortened source name; one plausible roster profile. |
| Bu Ruigiao | 46th Singapore ILCA Open 2023 (ILCA 4) — rank 42 (entry 214814) | Ruiqiao Bu | **Approved** | Reordered name and transliteration spelling variance. |
| Elliot Tang Chi Cheong | CSC Optimist Championships 2023 (Optimist Silver) — rank 65 (entry 2020) | Tang Chi Cheong Elliot | **Approved** | Same tokens in reverse order. |
| Emrys Kang Jie Long | CSC Optimist Championships 2023 (Optimist Silver) — rank 77 (entry 74) | Kang Jie Long Emrys | **Approved** | Same tokens in reverse order. |
| Estelle Yeo Rui | NSC Cup 2023 (Optimist Silver) — rank 88 (entry SGP 773) | Estelle Yeo Rui En | **Approved** | Source omits final given name. |
| Jade Yen Zi Ning | NSC Cup 2023 (Optimist Gold) — rank 59 (entry SGP 798) | Jade Yeh Zi Yu | **Approved** | Closest profile has materially different given-name tokens; no alias should be added without confirmation. |
| Jared Liew Joon Kit | CSC Optimist Championships 2023 (Optimist Gold) — rank 33 (entry 3198) | Jared Soon Kit Liew | **Approved** | Reordered source name with one likely OCR/transcription difference. |
| Jeanette Tan Wan Wen | CSC Optimist Championships 2023 (Optimist Silver) — rank 61 (entry 2017) | New source-backed profile | **Approved — create** | A pre-existing alias “Tan Wan Wen Jeanette” points to this profile, but the canonical profile name is materially different. |
| Jemimah Chang | 46th Singapore ILCA Open 2023 (ILCA 4) — rank 11 (entry 138) | Jemima Chang | **Approved** | One-letter spelling variance. |
| Jiang Peiru | CSC Optimist Championships 2023 (Optimist Silver) — rank 49 (entry 4637) | New source-backed profile | **Approved — create** | No credible existing SailorPath profile candidate. |
| Joseph Yak Yun Zhong | CSC Optimist Championships 2023 (Optimist Silver) — rank 57 (entry 4739) | Yak Yun Zhong Joseph | **Approved** | Same tokens in reverse order. |
| Kate Bateman | CSC Optimist Championships 2023 (Optimist Silver) — rank 11 (entry 117) | Kate En Rui Bateman | **Approved** | Source omits middle given names. |
| Kate Yen Zi Ning | NSC Cup 2023 (Optimist Gold) — rank 56 (entry SGP 797) | Kate Yeh Zi Ning | **Approved** | Single-letter surname spelling variance. |
| Kayler Tan Li YIng | CSC Optimist Championships 2023 (Optimist Silver) — rank 28 (entry 3787) | Tan Li Ying Kayler | **Approved** | Same tokens in reverse order. |
| Li Xuanyi | CSC Optimist Championships 2023 (Optimist Gold) — rank 66 (entry 8501) | New source-backed profile | **Approved — create** | No credible existing SailorPath profile candidate. |
| Li Yuxuan Lyric | NSC Cup 2023 (Optimist Gold) — rank 18 (entry SGP 728) | Lyric Li Yuxuan | **Approved** | Same tokens in reverse order. |
| Liu Sining | CSC Optimist Championships 2023 (Optimist Gold) — rank 42 (entry 9077) | New source-backed profile | **Approved — create** | No credible existing SailorPath profile candidate. |
| Lyu Zixuan | CSC Optimist Championships 2023 (Optimist Gold) — rank 35 (entry 9066) | New source-backed profile | **Approved — create** | No credible existing SailorPath profile candidate. |
| Mikaele Rae Ng | CSC Optimist Championships 2023 (Optimist Gold) — rank 7 (entry 151) | Mikaela Rae Ng | **Approved** | One-letter spelling variance. |
| Misa Lim | CSC Optimist Championships 2023 (Optimist Gold) — rank 64 (entry 774) | Misa Lim Laurie | **Approved** | Source omits final surname token. |
| Pitsilis Amandien Zoe | CSC Optimist Championships 2023 (Optimist Gold) — rank 49 (entry 702) | Amandine Zoe Pitsilis | **Approved** | Reordered name with likely spelling variance. |
| Ren Yinuo | CSC Optimist Championships 2023 (Optimist Gold) — rank 52 (entry 3869) | New source-backed profile | **Approved — create** | No credible existing SailorPath profile candidate. |
| Russell Xaivier Quek | CSC Optimist Championships 2023 (Optimist Gold) — rank 56 (entry 3008) | Russell Xavier Quek | **Approved** | Single-letter spelling variance. |
| Ryo Bateman | CSC Optimist Championships 2023 (Optimist Silver) — rank 26 (entry 119) | Ryo En Hua Bateman | **Approved** | Source omits middle given names. |
| Sage Yeh Fang Yu | CSC Optimist Championships 2023 (Optimist Silver) — rank 67 (entry 796) | Yeh Fang Yu Sage | **Approved** | Same tokens in reverse order. |
| Siti Ra'idah Biinte | NSC Cup 2023 (Optimist Gold) — rank 51 (entry SGP 3181) | Siti Raidah Binte Mohd Airudin | **Approved** | Source is a shortened/spelling-variant form of one existing profile. |
| Spencer Isaac | NSC Cup 2023 (Optimist Silver) — rank 52 (entry SGP 3286) | Spencer Quek | **Approved** | Existing profile already has longer alias “Spencer Isaac Quek”. |
| Timonthy Ng Kai Zhe | CSC Optimist Championships 2023 (Optimist Silver) — rank 78 (entry 2023) | Ng Kai Zhe Timothy | **Approved** | Reordered source name with transposed letters. |
| Worawit Jutakhiti | CSC Optimist Championships 2023 (Optimist Silver) — rank 63 (entry 2025) | Worawit Jutahkiti | **Approved** | Single-letter spelling variance. |
| Zaid Mohamed Noodeen Bin Jaffar Sadik | CSC Optimist Championships 2023 (Optimist Gold) — rank 47 (entry 3666) | Zaid Mohd Noordeen Bin Jaffar Sadik | **Approved** | Existing profile has near-identical alias; source has one spelling variance. |

## Production verification summary

1. All 27 aliases and six profiles are present in production, including the approved Jade Yen Zi Ning → Jade Yeh Zi Yu mapping.
2. All 477 results, 3,531 race scores, 477 participant snapshots, and latest class-specific profile sail numbers reconcile against the deployed migration data.
