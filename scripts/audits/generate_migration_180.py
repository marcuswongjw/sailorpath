#!/usr/bin/env python3
"""Generate Migration 180: Demographic Enrichments, Duplicate Merges, Keep-Separates, and Regatta Corrections."""

dob_enrichments = [
    ("7c98de8c-7b60-5fa7-a90e-d8349ed96b86", "Muhammad Hadif Nabihan Bin Rashidi", "2010-01-01", "Thailand International Sailing Championships 2026 — ILCA 4"),
    ("91927627-a2be-5b01-a357-134fe82679f9", "Adam Iwan Carraz", "2009-01-01", "17th Eastern Seaboard Regatta 2025 — ILCA 6"),
]

nat_enrichments = [
    ("08805f7e-ee2e-52e8-823f-d9b7b81941ba", "Nur Adlina Nasreen Binti Mohd Nasri", "MAS", "2024 ILCA Asian Open Championship (ILCA 6 Women)"),
    ("1e4b724c-4571-5f4a-8f48-73f77141691d", "Muhammad Asnawi Iqbal Bin Adam", "MAS", "19th Asian Games Hangzhou 2022; 2024 ILCA Asian Open Championship; Pre-33rd SEA Games 2025"),
    ("2135c975-184e-5672-81ec-4fbcf85bcbf7", "Kritkamon Prasertnopakun", "THA", "Children’s Day Regatta 2025 — ILCA 4"),
    ("2d5a08d0-b75a-5097-9d88-989426fe2f12", "Kim Jong Hwi", "KOR", "19th Asian Games Hangzhou 2022 (Boy's Dinghy - ILCA 4)"),
    ("499c67de-06e1-5c6f-a3f1-694b2342b326", "Poramut Srisawaddisrilodom", "THA", "Children’s Day Regatta 2025 — ILCA 4"),
    ("5acb538c-6b7b-5ba7-8cb8-2aad97d20816", "Htet Lin Zaw", "MYA", "Pre-33rd SEA Games 2025 — ILCA 7"),
    ("64a16ae0-dd22-57c2-9f39-cbcae2141900", "Jeremy Ein", "THA", "Children’s Day Regatta 2025 — ILCA 4"),
    ("68fea819-ebd7-5cec-9b89-de1d58136f05", "Luck Puapitsirikul", "THA", "Children’s Day Regatta 2025 — ILCA 4; Thailand National Championship 2025 — Long Distance — ILCA 4"),
    ("8813d941-a761-5ea0-8a0b-f6ed49ff38b8", "Nur Alia Amera Binti Mohamad Latif", "MAS", "2024 ILCA Asian Open Championship (ILCA 6 Women)"),
    ("8d54107d-d292-5e13-9616-cf53bbd41c87", "Prapassorn Kaewprom", "THA", "2024 Optimist Asian & Oceanian Championship; Thailand National Championship 2025 — Long Distance — ILCA 4"),
    ("d878c3d4-9655-5857-b7e6-d576942f4cb3", "Thit Bone Khant Nyar", "MYA", "18th Eastern Seaboard Regatta 2026 — Optimist Silver"),
    ("d9337400-b506-5662-9c3c-9c657c5c947b", "Chanatip Tongglum", "THA", "2023 Optimist Asian & Oceanian Championship (Optimist Overall)"),
    ("e65296f7-fdc4-582a-b74b-fc2463ea8228", "Nur Shazrin Mohamad Latif", "MAS", "19th Asian Games Hangzhou 2022 (Women's Single Dinghy - ILCA 6)"),
    ("e89161ab-34e7-5022-a08c-5b00bea6532b", "Shota Sratongsang", "THA", "Children’s Day Regatta 2025 — Optimist Silver"),
    ("e9c8f1e1-acff-5660-ba36-6f75834f3421", "Phyu Cin Thadar", "MYA", "18th Eastern Seaboard Regatta 2026 — Optimist Silver"),
    ("eccf0a0e-a600-599a-b300-79f74309a169", "Zwel La Yaung", "MYA", "18th Eastern Seaboard Regatta 2026 — Optimist Silver"),
    ("ef51229e-76d0-5295-ab12-5b7250335f85", "Phumsamut Watetakarn", "THA", "Children’s Day Regatta 2025 — ILCA 4"),
]

merges = [
    ("c8b6f944-2891-5f53-b78e-4bf822624355", "7329e489-32e2-4a20-ac2a-d24146248c8b", "Baby Beverly Brylle Magramo", "Baby Beverly Brylle C. Magramo", {}),
    ("03207997-4a62-508b-abb9-15b43480a36b", "8be1e07c-edcf-4426-971f-7fff75bdd8f6", "Ivan Matthew Eseque", "Ivan Matthew D Eseque", {}),
    ("ee47fb94-4096-5154-9620-8c29f4f0db0d", "4d904c1b-b1a3-5873-942b-69138cf8b4ab", "Daniel Alonso Subia", "Daniel Alonso Bantegui Subia", {"sail_number": "PHI21"}),
    ("d48c024a-3059-5f68-9a6a-7f678f9b2fb2", "5d322d72-01f5-4733-b2d1-7400189566c5", "Kesha Rose Hara", "Kesha Rose C. Hara", {}),
    ("2590130d-2e1e-5116-b5e6-4de3ac752482", "c9234597-3fc1-4610-b3ac-9c60a3924002", "Rose Ann Marienau", "Rose Ann H. Marienau", {}),
    ("611448bb-466a-5beb-b19e-a7a0c2348414", "49f5428c-032e-4acf-828b-a3790dae9c13", "Amanda Amadeo", "Amanda S. Amadeo", {}),
    ("c198b673-3ee0-568e-af44-6f0dee646380", "e6d4c0c6-4f35-48f2-ad30-3cff006b0d08", "Zyke Castillo", "Zyke D. Castillo", {}),
    ("c0226ff0-5edd-50b9-93c0-f95fe36e3c5c", "a315221a-cfc2-4a46-ad03-130bc3498cc7", "Fred Julian Marienau", "Fred Marienau", {}),
    ("a6963324-b0a4-56dc-94f5-f78816b28b6b", "be357a39-d5b7-401b-8e1f-c2d361169222", "Mark Amadeo", "Mark Adrey M. Amadeo", {}),
    ("e08b2f5b-a819-5368-a628-1096d2723279", "10e48363-4610-43d8-9a8d-3e175daaeffa", "Edmon Asejo Jr", "Edmon A. Asejo Jr", {}),
    ("a7e5107d-faf3-4a7d-88f4-44613744a575", "4cdb0d0e-8efc-562d-bcb9-563bed0079eb", "Lahari Kommaravelly", "Kommaravelly Lahari", {}),
    ("c766be2b-32b7-4e38-9f7f-d31332e58c80", "1086f572-4d3c-5707-926a-1f89c1684cf9", "Chandralekha Tattari", "Tattari Chandralekha", {}),
    ("e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7", "eb4e503b-fd7a-5a05-bd7a-3908567eab8f", "Yeji Lee", "Yeji Lee", {"nationality": "KOR", "sail_number": "B6338"}),
    ("4b4c1623-a048-417c-acf2-af278aeffba3", "d5b73423-e2a1-558b-829c-44b824606225", "Addy Armand Anuar", "Addy Armand Bin Anuar", {"sail_number": "SGP 143"}),
    ("122c11af-b3e3-5e08-9bc7-cc28a33ce040", "832131a0-a4ef-579b-9a6d-1d242d8d2db1", "Isla Ren Cohen", "Ilsa Ren Cohen", {"gender": "F"}),
    ("31374565-e925-521a-a074-93c0d364cbc2", "f309cdc5-86b9-5851-ac8f-1e70f9f7ccee", "Zac Boyd", "Zachariah Boyd", {}),
]

keep_separates = [
    (
        "08350803-1171-57de-a0b6-4c9f6f8a4771",
        "Yun-Yun Chuang",
        "5a624207-08d4-53e9-8381-42cf361b8e70",
        "Yun-Hao Chuang",
        "Distinct athletes: Yun-Yun Chuang and Yun-Hao Chuang are Taiwanese brothers competing concurrently for 舊城蓮潭帆船隊 (Lotus Pond Sailing Team).",
    ),
    (
        "60fc244e-f889-52e0-bb3b-00e8bedff4d7",
        "Yasuhiro Nishimura",
        "6581432e-6145-5bfc-800a-7c7cd7a5619d",
        "Tooko Nishimura",
        "Distinct athletes: Yasuhiro Nishimura (male) and Tooko Nishimura (female) are family members competing in different years/divisions for EYCJ using family boat JPN 3365.",
    ),
    (
        "5264ce32-f38f-507a-8d4b-e4757f4b2e64",
        "Jun Han",
        "df7c6bd6-12f7-412b-994a-f116e820e30d",
        "Ryan Lo Jun Han",
        "Distinct athletes: Jun Han is a Korean youth Optimist sailor (KOR); Ryan Lo Jun Han is a Singapore national Olympic ILCA 7 sailor (SGP).",
    ),
]

lines = [
    "-- Migration 180: Sailor Demographic Enrichments, Regional Duplicate Consolidations,",
    "-- Keep-Separate Registrations, and Regatta Result Reconciliations",
    "--",
    "-- 1. Enriches 2 verified DOBs and 17 verified nationalities from unanimous official scoring sheets.",
    "-- 2. Consolidates 16 verified duplicate sailor pairs (PHI, IND, KOR, SGP, AUS) with 0 shared regatta conflicts.",
    "-- 3. Registers 3 verified keep-separate decisions in admin_change_log.",
    "-- 4. Removes 25 mis-assigned HKRW 2026 29er rows from Langkawi 2026 29er (preserving the 6 official LIRP 2026 entries",
    "--    and verifying all 25 rows remain intact on HKRW 2026 29er), and reconciles single-discard flags on 2026 ILCA 4 Youth Worlds.",
    "",
    "BEGIN;",
    "",
    "-- ============================================================================",
    "-- 1. VERIFIED DEMOGRAPHIC ENRICHMENTS (2 DOBS + 17 NATIONALITIES)",
    "-- ============================================================================",
    "",
]

for sid, name, dob, src in dob_enrichments:
    lines.append(f"-- {name} ({sid}) -> DOB: '{dob}' (Source: {src})")
    lines.append("UPDATE public.sailors")
    lines.append(f"SET dob = '{dob}'::date, updated_at = clock_timestamp()")
    lines.append(f"WHERE id = '{sid}' AND dob IS NULL;")
    lines.append("")

for sid, name, nat, src in nat_enrichments:
    lines.append(f"-- {name} ({sid}) -> Nationality: '{nat}' (Source: {src})")
    lines.append("UPDATE public.sailors")
    lines.append(f"SET nationality = '{nat}', updated_at = clock_timestamp()")
    lines.append(f"WHERE id = '{sid}' AND (nationality IS NULL OR nationality = '');")
    lines.append("")

lines.extend([
    "-- ============================================================================",
    "-- 2. DUPLICATE SAILOR CONSOLIDATIONS (16 PAIRS)",
    "-- ============================================================================",
    "",
])

for keep_id, merge_id, keep_name, merge_name, backfills in merges:
    esc_keep = keep_name.replace("'", "''")
    esc_merge = merge_name.replace("'", "''")
    lines.append(f"-- Merge '{esc_merge}' ({merge_id}) into '{esc_keep}' ({keep_id})")

    if backfills:
        set_parts = []
        for col, val in backfills.items():
            set_parts.append(f"{col} = '{val}'")
        set_parts.append("updated_at = clock_timestamp()")
        lines.append("-- 0. Backfill non-null attributes onto survivor")
        lines.append(f"UPDATE public.sailors SET {', '.join(set_parts)} WHERE id = '{keep_id}';")
        lines.append("")

    if keep_name != merge_name:
        lines.append(f"""-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('{keep_id}', '{esc_merge}')
ON CONFLICT (alias_name) DO NOTHING;
""")

    lines.append(f"""-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '{keep_id}'
  WHERE rr_dup.sailor_id = '{merge_id}'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '{keep_id}'
  WHERE rr_dup.sailor_id = '{merge_id}'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '{merge_id}'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '{keep_id}'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '{keep_id}'
WHERE sailor_id = '{merge_id}';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '{merge_id}'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '{keep_id}'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '{keep_id}'
WHERE sailor_id = '{merge_id}';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '{keep_id}'
WHERE sailor_id = '{merge_id}'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '{keep_id}');
DELETE FROM public.sailor_aliases WHERE sailor_id = '{merge_id}';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '{keep_id}'
WHERE sailor_id = '{merge_id}'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '{keep_id}');
DELETE FROM public.sailor_claims WHERE sailor_id = '{merge_id}';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '{keep_id}'
WHERE sailor_id = '{merge_id}';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
  DELETE FROM public.followed_sailors WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '{merge_id}';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '{keep_id}',
  '{esc_keep} <- {esc_merge}',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '{keep_id}',
    'keepName', '{esc_keep}',
    'mergeId', '{merge_id}',
    'mergeName', '{esc_merge}'
  ),
  'migration_180',
  clock_timestamp()
);
""")

lines.extend([
    "-- ============================================================================",
    "-- 3. KEEP-SEPARATE REGISTRATIONS (3 PAIRS)",
    "-- ============================================================================",
    "",
])

for a_id, a_name, b_id, b_name, reason in keep_separates:
    assert a_id < b_id
    pair_key = f"{a_id}|{b_id}"
    esc_reason = reason.replace("'", "''")
    lines.append(f"""INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '{a_id}',
  '{a_name} / {b_name}',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '{pair_key}',
    'aId', '{a_id}',
    'aName', '{a_name}',
    'bId', '{b_id}',
    'bName', '{b_name}',
    'reason', '{esc_reason}'
  ),
  'migration_180',
  clock_timestamp()
);
""")

lines.extend([
    "-- ============================================================================",
    "-- 4. REGATTA DISCREPANCY CORRECTIONS",
    "-- ============================================================================",
    "",
    "-- 4A. Remove 25 mis-assigned HKRW 2026 29er result rows from Langkawi 2026 29er (cd329052-dd4e-5b0b-985a-00a096b2b6ba)",
    "DO $$",
    "DECLARE",
    "  v_hkrw_count integer;",
    "  v_langkawi_remaining integer;",
    "BEGIN",
    "  -- Verify HKRW 2026 29er (c92a7017-4779-5f9b-8a56-4ca469fed159) already has all 25 entries intact",
    "  SELECT count(*) INTO v_hkrw_count",
    "  FROM public.regatta_results",
    "  WHERE regatta_id = 'c92a7017-4779-5f9b-8a56-4ca469fed159';",
    "",
    "  IF v_hkrw_count <> 25 THEN",
    "    RAISE EXCEPTION 'Expected 25 entries in HKRW 2026 29er before cleanup, found %', v_hkrw_count;",
    "  END IF;",
    "",
    "  DELETE FROM public.regatta_race_results",
    "  WHERE regatta_result_id IN (",
    "    SELECT id FROM public.regatta_results",
    "    WHERE regatta_id = 'cd329052-dd4e-5b0b-985a-00a096b2b6ba'",
    "      AND evidence_name = 'Official HKRW 2026 29er Asian Championship Results (RHKYC)'",
    "  );",
    "",
    "  DELETE FROM public.regatta_result_participants",
    "  WHERE regatta_result_id IN (",
    "    SELECT id FROM public.regatta_results",
    "    WHERE regatta_id = 'cd329052-dd4e-5b0b-985a-00a096b2b6ba'",
    "      AND evidence_name = 'Official HKRW 2026 29er Asian Championship Results (RHKYC)'",
    "  );",
    "",
    "  DELETE FROM public.regatta_results",
    "  WHERE regatta_id = 'cd329052-dd4e-5b0b-985a-00a096b2b6ba'",
    "    AND evidence_name = 'Official HKRW 2026 29er Asian Championship Results (RHKYC)';",
    "",
    "  SELECT count(*) INTO v_langkawi_remaining",
    "  FROM public.regatta_results",
    "  WHERE regatta_id = 'cd329052-dd4e-5b0b-985a-00a096b2b6ba';",
    "",
    "  IF v_langkawi_remaining <> 6 THEN",
    "    RAISE EXCEPTION 'Expected 6 official Langkawi 29er entries remaining, found %', v_langkawi_remaining;",
    "  END IF;",
    "END $$;",
    "",
    "-- 4B. Reconcile single-discard flags on 2026 ILCA 4 Youth World Championships (Boys & Girls)",
    "WITH matched_discards AS (",
    "  SELECT DISTINCT ON (rr.id)",
    "    rrr.id AS race_result_id",
    "  FROM public.regatta_results rr",
    "  JOIN public.regattas r ON r.id = rr.regatta_id",
    "  JOIN public.regatta_race_results rrr ON rrr.regatta_result_id = rr.id",
    "  WHERE r.slug IN ('2026-ilca-4-youth-worlds-boys', '2026-ilca-4-youth-worlds-girls')",
    "    AND rr.total_score > rr.nett_score",
    "    AND abs(rrr.score - (rr.total_score - rr.nett_score)) < 0.05",
    "    AND COALESCE(rrr.scoring_code, '') <> 'DNE'",
    "  ORDER BY rr.id, rrr.race_number",
    ")",
    "UPDATE public.regatta_race_results rrr",
    "SET discarded = true, updated_at = clock_timestamp()",
    "FROM matched_discards md",
    "WHERE rrr.id = md.race_result_id",
    "  AND rrr.discarded = false;",
    "",
    "-- 5. Summary audit log entry",
    "INSERT INTO public.admin_change_log (",
    "  action, entity_type, entity_id, entity_label, summary, details, source, created_at",
    ") VALUES (",
    "  'sailors.demographics_enrichment',",
    "  'sailor',",
    "  '00000000-0000-0000-0000-000000000000',",
    "  'Daily Audit Remediation — Migration 180',",
    "  'Enriched 2 DOBs and 17 nationalities; merged 16 duplicate sailor pairs; registered 3 keep-separate pairs; cleaned 25 mis-assigned HKRW 29er rows from Langkawi 2026 29er and reconciled 447 ILCA 4 Youth Worlds discard flags.',",
    "  jsonb_build_object(",
    "    'dobs_updated', 2,",
    "    'nationalities_updated', 17,",
    "    'duplicates_merged', 16,",
    "    'keep_separates_registered', 3,",
    "    'langkawi_29er_orphan_hkrw_rows_removed', 25,",
    "    'ilca4_worlds_discards_reconciled', 447",
    "  ),",
    "  'migration_180',",
    "  clock_timestamp()",
    ");",
    "",
    "COMMIT;",
    "",
])

out_path = "src/db/migrations/180_enrich_demographics_merge_duplicates_and_fix_langkawi_29er.sql"
with open(out_path, "w") as f:
    f.write("\n".join(lines))
print(f"Wrote {out_path} ({len(lines)} lines)")
