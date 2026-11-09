#!/usr/bin/env python3
"""Generate Migration 182: Daily Audit Enrichments, Duplicate Merges, Keep-Separates, and RSYC Monitor Configuration."""

# 1. Duplicate Sailor Consolidations & Enrichments (2 pairs)
# Format: (keep_id, merge_id, keep_name, merge_name, backfills_dict)
merges = [
    (
        "53552b36-236f-58d8-b189-d1c7a9086d1c",
        "3ea3b023-5098-5bf8-a819-bb881de0adf5",
        "Oscar Gaylard",
        "Oscar Gayland",
        {"gender": "M", "club": "LBSC", "nationality": "AUS"},
    ),
    (
        "969d699b-ac23-51dc-b1ac-00e7070595e1",
        "3033206a-5327-54a1-b767-1509caf170bb",
        "Dohwan Kim",
        "Kim Do Hwan",
        {"gender": "M", "dob": "2012-01-01", "nationality": "KOR"},
    ),
]

# 2. Keep-Separate Registrations (10 pairs, ordered so a_id < b_id)
raw_keep_separates = [
    (
        "f6be3f6f-ca95-510a-8dc1-2cd5e34d0b3a",
        "Yu-Ching Kang",
        "f45e0130-7dca-5f3f-bc95-6271720a6550",
        "Yu-Hsin Kang",
        "Distinct athletes: Direct head-to-head competitors in 115th Academic Year National President's Cup Sailing Regatta 2026 — ILCA 4 (G) (Yilan Sailing Committee, TPE211956 vs TPE211389).",
    ),
    (
        "8eb39919-2873-52ba-b924-5caceb21772b",
        "Ching-Heng Chen",
        "b1a7dd64-fe8a-5606-9782-3049cdc83425",
        "Chi-Sheng Chen",
        "Distinct athletes: Direct head-to-head competitors in 2026 ASAF Cup Optimist Open Championships — Boys Fleet (Ci-Xin Waldorf TPE305 vs Penghu Sailing Association TPE500).",
    ),
    (
        "b2c05554-8405-55c8-bcbf-9c8b2e209f90",
        "Chih-Yu Chen",
        "72201bba-eca0-5022-bc09-619dd58d66ff",
        "Yu-Chi Chen",
        "Distinct athletes: Direct head-to-head competitors in 115th Academic Year National President's Cup Sailing Regatta 2026 — Optimist (B) (Yueming Elementary & Junior High School, TPE206 vs TPE202).",
    ),
    (
        "115073fc-e588-5843-9cbd-99fcd5990874",
        "Daniel Shan",
        "9fb849be-bfc1-5c19-b827-f95a2c775fc4",
        "Daniel Chan",
        "Distinct athletes: Daniel Shan is an RHKYC youth Optimist sailor (sail 230); Daniel Chan is a Hong Kong ILCA 6 sailor (sail 223750).",
    ),
    (
        "605abece-e556-4c50-a947-ff64a6792ff4",
        "Chen You Jhen",
        "56cdc1b0-297b-55f1-ab53-18ce968dba2b",
        "Yu-Chen Chen",
        "Distinct athletes: Taiwanese youth sailors with distinct given names and sail numbers (463 vs Simen Elementary Sailing Team TPE317).",
    ),
    (
        "83015dcb-6cd8-5b4e-9040-55d10d913849",
        "Lie Huan Cheng",
        "ca5a740b-f83f-59ba-9e8c-71171b957085",
        "Cheng-Hsuan Lee",
        "Distinct athletes: Lie Huan Cheng (Singapore SAFYC Optimist sailor, sail 3140) vs Cheng-Hsuan Lee (Taiwan Yilan Sailing Committee ILCA sailor, sail TPE 206219).",
    ),
    (
        "1acada38-b48d-5cb1-9016-563f3ae24665",
        "Huang Yu Chieh",
        "86b36815-73c2-5333-8a7c-bbb82e3688be",
        "Chien-Yu Huang",
        "Distinct athletes: Taiwanese sailors from different municipal teams and given names (Simen Tainan TPE326 vs Taipei Sailing Committee TPE351).",
    ),
    (
        "8ff74b8a-c2cc-544f-ada9-17b2f4e44527",
        "Chia-Cheng Chen",
        "b1a7dd64-fe8a-5606-9782-3049cdc83425",
        "Chi-Sheng Chen",
        "Distinct athletes: Taiwanese sailors from different associations and classes (Yueming ILCA TPE 211738 vs Penghu Optimist TPE500).",
    ),
    (
        "8bf566f5-98b6-5eec-b7fe-e23defb55572",
        "Chia-Che Chang",
        "23f21394-9b28-5e5b-8a72-c105f459ee3d",
        "Chiao-Chen Chang",
        "Distinct athletes: Taiwanese sailors from different county associations and classes (Taoyuan Sailing Committee TPE163105 vs Penghu Sailing Association TPE5188).",
    ),
    (
        "06575f3d-3a87-5420-acbc-8693b2325462",
        "Chen-Yueh Wu",
        "fa95f8cf-a1aa-5899-8a7b-a103437ccb66",
        "Yu-Chen Wu",
        "Distinct athletes: Taiwanese youth sailors from different schools (Simen Elementary Sailing Team TPE329 vs Ci-Xin Waldorf TPE0438).",
    ),
]

keep_separates = []
for id1, n1, id2, n2, reason in raw_keep_separates:
    if id1 < id2:
        keep_separates.append((id1, n1, id2, n2, reason))
    else:
        keep_separates.append((id2, n2, id1, n1, reason))

lines = [
    "-- Migration 182: Daily Audit Enrichments, Duplicate Merges, Keep-Separates, and RSYC Monitor Configuration",
    "--",
    "-- 1. Consolidates 2 verified duplicate sailor pairs (Oscar Gayland -> Oscar Gaylard; Kim Do Hwan -> Dohwan Kim)",
    "--    and enriches survivor profiles with verified demographic attributes (gender, DOB, nationality, club).",
    "-- 2. Registers 10 confirmed distinct keep-separate sailor pairs in admin_change_log.",
    "-- 3. Updates RSYC 2026 Knockout Championship (Gold & Silver) monitor URLs and links official results PDFs.",
    "",
    "BEGIN;",
    "",
    "-- ============================================================================",
    "-- 1. DUPLICATE SAILOR CONSOLIDATIONS & DEMOGRAPHIC ENRICHMENTS (2 PAIRS)",
    "-- ============================================================================",
    "",
    "-- Enrich Dohwan Kim's regatta_results rows with verified gender, nationality, and birth_year",
    "UPDATE public.regatta_results",
    "SET gender = COALESCE(NULLIF(gender, ''), 'M'),",
    "    nationality = COALESCE(NULLIF(nationality, ''), 'KOR'),",
    "    birth_year = COALESCE(birth_year, 2012),",
    "    updated_at = clock_timestamp()",
    "WHERE sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1';",
    "",
]

for keep_id, merge_id, keep_name, merge_name, backfills in merges:
    esc_keep = keep_name.replace("'", "''")
    esc_merge = merge_name.replace("'", "''")
    lines.append(f"-- Merge '{esc_merge}' ({merge_id}) into '{esc_keep}' ({keep_id})")

    if backfills:
        set_parts = []
        for col, val in backfills.items():
            esc_val = val.replace("'", "''")
            if col == "dob":
                set_parts.append(f"dob = COALESCE(dob, '{esc_val}'::date)")
            else:
                set_parts.append(f"{col} = '{esc_val}'")
        set_parts.append("updated_at = clock_timestamp()")
        lines.append("-- 0. Backfill verified attributes onto survivor")
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
SET sailor_id = '{keep_id}', updated_at = clock_timestamp()
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
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '{keep_id}',
    'keepName', '{esc_keep}',
    'mergeId', '{merge_id}',
    'mergeName', '{esc_merge}'
  ),
  'migration_182',
  clock_timestamp()
);
""")

lines.extend([
    "-- ============================================================================",
    "-- 2. KEEP-SEPARATE REGISTRATIONS (10 PAIRS)",
    "-- ============================================================================",
    "",
])

for a_id, a_name, b_id, b_name, reason in keep_separates:
    assert a_id < b_id
    pair_key = f"{a_id}|{b_id}"
    esc_a = a_name.replace("'", "''")
    esc_b = b_name.replace("'", "''")
    esc_reason = reason.replace("'", "''")
    lines.append(f"""INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
)
SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '{a_id}',
  '{esc_a} / {esc_b}',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '{pair_key}',
    'aId', '{a_id}',
    'aName', '{esc_a}',
    'bId', '{b_id}',
    'bName', '{esc_b}',
    'reason', '{esc_reason}'
  ),
  'migration_182',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '{pair_key}'
);
""")

lines.extend([
    "-- ============================================================================",
    "-- 3. RSYC 2026 KNOCKOUT MONITOR CONFIGURATION & OFFICIAL RESULTS LINKS",
    "-- ============================================================================",
    "",
    "-- Point RSYC Gold monitor to official regatta page instead of registration form link",
    "UPDATE public.result_import_monitors",
    "SET event_url = 'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-gold-fleet-knockout-championship-2026/'",
    "WHERE event_id = '5d1c38fe-f2cd-41bc-bb24-a2d8af62ef8b';",
    "",
    "-- Point RSYC Silver monitor to official regatta page explicitly",
    "UPDATE public.result_import_monitors",
    "SET event_url = 'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2026/'",
    "WHERE event_id = '76502024-d455-4a18-98fb-bb329a17e6e7';",
    "",
    "-- Ensure RSYC Silver event nor_url points to the official NoR PDF",
    "UPDATE public.regatta_events",
    "SET nor_url = 'https://rsyc.org.sg/wp-content/uploads/2026/08/NOR_RSYC_Silver_KO_2026.pdf',",
    "    updated_at = clock_timestamp()",
    "WHERE id = '76502024-d455-4a18-98fb-bb329a17e6e7';",
    "",
    "-- Link official overall ranking PDFs and NoR URLs on RSYC Gold and Silver regattas",
    "UPDATE public.regattas",
    "SET official_results_url = 'https://rsyc.org.sg/wp-content/uploads/2026/10/RSYC_Gold_Knockout_Race_2026_Results_Print_Overall_Rankings.pdf',",
    "    official_results_source_name = 'RSYC Official Overall Rankings PDF',",
    "    nor_url = COALESCE(nor_url, 'https://rsyc.org.sg/wp-content/uploads/2026/08/NOR_RSYC_Gold_KO_2026.pdf'),",
    "    updated_at = clock_timestamp()",
    "WHERE slug = 'rsyc-2026-gold';",
    "",
    "UPDATE public.regattas",
    "SET official_results_url = 'https://rsyc.org.sg/wp-content/uploads/2026/09/RSYC_Silver_Knockout_Race_2026_Results_Print_No_Race_Overall_Rankings.pdf',",
    "    official_results_source_name = 'RSYC Official Overall Rankings PDF',",
    "    nor_url = COALESCE(nor_url, 'https://rsyc.org.sg/wp-content/uploads/2026/08/NOR_RSYC_Silver_KO_2026.pdf'),",
    "    updated_at = clock_timestamp()",
    "WHERE slug = 'rsyc-2026-silver';",
    "",
    "-- 4. Summary audit log entry",
    "INSERT INTO public.admin_change_log (",
    "  action, entity_type, entity_id, entity_label, summary, details, source, created_at",
    ") VALUES (",
    "  'sailors.demographics_enrichment',",
    "  'sailor',",
    "  '00000000-0000-0000-0000-000000000000',",
    "  'Daily Audit Remediation — Migration 182',",
    "  'Consolidated 2 verified duplicate sailor pairs (Oscar Gaylard, Dohwan Kim) with demographic enrichments; registered 10 keep-separate pairs; updated RSYC 2026 Knockout monitor URLs and official results PDF links.',",
    "  jsonb_build_object(",
    "    'sailors_enriched', 2,",
    "    'duplicates_merged', 2,",
    "    'keep_separates_registered', 10,",
    "    'monitors_updated', 2",
    "  ),",
    "  'migration_182',",
    "  clock_timestamp()",
    ");",
    "",
    "COMMIT;",
    "",
])

out_path = "src/db/migrations/182_daily_audit_merges_keep_separates_and_rsyc_monitor.sql"
with open(out_path, "w") as f:
    f.write("\n".join(lines))
print(f"Wrote {out_path} ({len(lines)} lines)")
