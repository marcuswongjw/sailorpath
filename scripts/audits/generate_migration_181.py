#!/usr/bin/env python3
"""Generate Migration 181: Daily Audit Enrichments, Duplicate Merges, Keep-Separates, and Participant Backfill."""

# 1. Verified Demographic Enrichments (22 sailors: gender + nationality where missing)
# Format: (id, name, gender, nationality_if_missing, source)
demographic_enrichments = [
    ("0054671b-b92c-5436-9f55-93096948fd98", "Pham Khanh Ngoc Nguyen", "F", "VIE", "33rd SEA Games 2025 — Sailing — ILCA 4 Girls"),
    ("108d0eda-d379-5e23-bcde-6732a7f489cb", "Khim Ashley Albo", "F", "PHI", "33rd SEA Games 2025 — Sailing — ILCA 4 Girls"),
    ("243ed8f1-783f-4c3c-b69c-5a39442342ab", "Carlstein Jade Dulay", "M", None, "33rd SEA Games 2025 — Sailing — Optimist Boys"),
    ("2a686543-6915-54dc-80db-b8781caabdc7", "Anya Zahadi", "F", "INA", "Pre-33rd SEA Games 2025 — Optimist Girls"),
    ("8fb29ccf-ffa1-5d78-bf3c-80c3b8836e98", "Le Phuong Anh Phan", "F", None, "33rd SEA Games 2025 — Sailing — Optimist Girls"),
    ("a92a882b-f3f4-5fb0-83d2-efd88dc6a54e", "Muhammad Adhit", "M", None, "33rd SEA Games 2025 & Pre-33rd SEA Games 2025 — Optimist Boys"),
    ("b7076ceb-74cd-5fbc-b529-681c6842ebd1", "Thanh Nhat Mai", "M", None, "33rd SEA Games 2025 — Sailing — ILCA 4 Boys"),
    ("c261ebe9-0054-4de8-ad6f-31899871703f", "Xu Xiaorong", "M", None, "22nd Langkawi International Regatta Perdana 2026 — ILCA 4 Men"),
    ("d4ac1747-65f6-57eb-aac2-aa3247f79da9", "Aguero Pratama Syabani", "M", "INA", "Pre-33rd SEA Games 2025 — Optimist Boys"),
    ("eb4f8426-a71a-5b09-88bb-93b30260a5e6", "Huynh Thai Son Pham", "M", None, "33rd SEA Games 2025 — Sailing — Optimist Boys"),
    ("025dc288-9bc5-5669-9222-9e3e1663e9ab", "金田 惺吾", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
    ("17808d6a-0599-592b-a66f-7e33cb3acda5", "宇留野 遥斗", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
    ("1a60f694-7f83-59b1-be24-c3f9f930793e", "関 颯一郎", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
    ("4d01c91c-7fd5-5d8d-817c-c6d1ac9cab82", "後藤 晴人", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
    ("553dba2f-58d9-54c1-bd31-4bd37a7f3489", "岡田 晴", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
    ("8aa3b54b-684e-5eef-afc7-47e359202408", "畠中 康佑", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
    ("977d76ad-0559-5022-a08d-e3366282d003", "渕上 幸星", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
    ("a777bff8-7bb8-519c-825a-5b9deeb90080", "白石 征也", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
    ("a8fd220f-14f1-5610-88bb-ed6681ce72c6", "マーズデン 珀空", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
    ("acc560b9-f226-51ca-9606-a32206715912", "山本 汐穏", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
    ("ed724e62-5752-5327-8d54-4fcad0c02a4b", "田中 大基", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
    ("f261f31b-599c-5d97-bf9e-582efa0d366b", "青山 侑友", "M", "JPN", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
]

# 2. Duplicate Sailor Consolidations (9 pairs)
# Format: (keep_id, merge_id, keep_name, merge_name, backfills_dict)
merges = [
    (
        "61b1d74c-edcd-4730-b606-d3ae3264d658",
        "3114c493-b297-5031-8b50-eb75a88a9d3f",
        "Cheryl Ho Hai Yan",
        "Cheryl Ho",
        {"nationality": "SGP"},
    ),
    (
        "97297f2f-45a3-4a42-bb8b-7de07d9a5cde",
        "bfa40b34-a5ab-5948-a2a2-7078eace1d91",
        "Febe Wong Qi Ke",
        "Febe Wong",
        {"nationality": "SGP"},
    ),
    (
        "688cc8ae-873e-40a3-9bc4-7d05a496994a",
        "2113225c-9122-535a-ac52-cf5b2143de4d",
        "Gemma Chen Huang Heng",
        "Gemma Chen",
        {"nationality": "SGP"},
    ),
    (
        "1ff55ac5-256c-42da-9fa5-a85d4f8d7f22",
        "7e0abc5a-75d5-5273-b0f8-4cec7d106914",
        "Hirunsira Munkhongpornpaiboon",
        "Hirunsiri Munkhongpornpaiboon",
        {},
    ),
    (
        "eff0fe49-b3da-5a1c-a71b-f997f26b3e48",
        "8fd6382c-05d0-4980-8ada-ac6bb25c6afc",
        "Alia Sabreen Faisal",
        "Alia Sabren Faisal",
        {},
    ),
    (
        "06f7dd80-c725-5e9f-bbea-e69503a06eac",
        "d8d91597-0448-4284-9b31-73b2a7f5fd6d",
        "Prince July Montecer",
        "Prince July Monticer",
        {},
    ),
    (
        "dffea961-6ebf-47bc-8ce8-f9a134a539b8",
        "0cc2b490-0422-5b10-a4b8-14435ff94dbd",
        "Samuel Rodolfo R. Tolentino",
        "Samuel Tolentino",
        {"gender": "M", "club": "Philippine Sailing Association"},
    ),
    (
        "f6b26ef3-658c-54c1-97f6-77b99166f040",
        "a5b6a7b9-622e-45c2-9051-d81b22fec7f2",
        "Roahnne Roy Santos",
        "RoahnneRoy T Santos",
        {"nationality": "PHI", "club": "Philippine Sailing Association"},
    ),
    (
        "aa564db6-5ef3-5666-a821-425146fc692e",
        "3dd68c8f-98b7-4632-b5c1-ddbada92d55b",
        "Linger Zhou",
        "Ling Er Zhou",
        {"gender": "F"},
    ),
]

# 3. Keep-Separate Registrations (13 pairs, ordered so a_id < b_id)
raw_keep_separates = [
    (
        "2626c2a3-e937-5606-a38f-683128a5cf5d",
        "Chanyul Park",
        "d9f3075d-4b63-576d-b544-b7991dcaa603",
        "Hayul Park",
        "Distinct athletes: Chanyul Park (Haegang Middle School, Q359) and Hayul Park (Godeok Hambaek Elementary School, O474) are separate Korean youth sailors.",
    ),
    (
        "3a2198bc-fe35-49c3-a5ba-2a32a35c81c6",
        "Muhammad Yaasin Bin Syahrizan",
        "c9df556b-7b8e-5944-92c8-0cc863207d9b",
        "Muhammad Yusri Bin Syahrizan",
        "Distinct athletes: Malaysian brothers (Yaasin sail 115 and Yusri sail 56051, MSN Sarawak).",
    ),
    (
        "0a103a01-a892-5c7f-a671-634fa5565dc9",
        "Ibuki Watanabe",
        "101de41c-3d78-5248-a9b2-36a88119d281",
        "Itsuki Watanabe",
        "Distinct athletes: Ibuki Watanabe (Tsu Technical High School, JPN 55936) and Itsuki Watanabe (YJYC, JPN 3246).",
    ),
    (
        "309280c8-279c-518f-8673-2496c0bf7172",
        "Yu-Cheng Kao",
        "f1676640-6736-5ced-aa15-5d34ece931db",
        "Yu-Heng Kao",
        "Distinct athletes: Taiwanese teammates/brothers at Ximen Elementary Sailing Team (TPE 41009 vs TPE 399).",
    ),
    (
        "bf5455bc-c310-5bc1-85f1-372889e90934",
        "Suphachok Chueatathong",
        "c4a8af93-b344-5b96-a9e4-bef4c6f0107b",
        "Suphachai Chueatathong",
        "Distinct athletes: Thai brothers competing for WATH under sail numbers 999 and 31.",
    ),
    (
        "78ac9250-8763-5e62-a94a-e25440100616",
        "Shan-Ya Lee",
        "d2384e74-ecef-53b2-8006-54f4ccdcbc36",
        "Shan-Yu Lee",
        "Distinct athletes: Taiwanese siblings competing for Lotus Pond Sailing Team (TPE 427 vs TPE 773).",
    ),
    (
        "489d4743-1a7b-5f61-b3c2-2576df0df2fe",
        "Shohei Hayashi",
        "6a8873bc-12ed-58a4-be8b-14f9d6ff1fe3",
        "Kohei Hayashi",
        "Distinct athletes: Japanese brothers/teammates at Hayama Town Sailing Association (JPN 3469 vs JPN 2940).",
    ),
    (
        "bbc40d80-aedd-5383-8e46-063b2f8cabe0",
        "Ting-Jen Lin",
        "fc743756-eaa4-5d96-9dc9-b9c22ffe845c",
        "Ting-En Lin",
        "Distinct athletes: Taiwanese siblings competing for YMES Sail Team.",
    ),
    (
        "57a1f9c5-bf57-5654-85a6-68f16b64ab40",
        "Muhammad Zafir Bin Mohd Zailan",
        "d09b7f61-8e4b-58e0-bfa9-21af32b8fb1b",
        "Muhammad Zafrin Bin Mohd Zailan",
        "Distinct athletes: Selangor brothers competing under sail numbers 207095 and 22.",
    ),
    (
        "ad6fa7a4-fafc-4dc8-8bd7-92fcb8e39a0d",
        "Ela Murat",
        "b434b981-9f3a-514a-974c-fbf63700fd1b",
        "Eva Murat",
        "Distinct athletes: RHKYC sisters competing under sail numbers 205828 and 61377.",
    ),
    (
        "0eb30de4-6e06-50f3-b8d4-3f02cc0130dd",
        "Nana Yamamura",
        "523be7c2-3db8-5273-a02a-9c840f48bf5f",
        "Kanna Yamamura",
        "Distinct athletes: Yumenoshima YC sisters competing under sail numbers JPN 3480 and JPN 338.",
    ),
    (
        "0285e1be-3c9f-5d9e-a21a-21f995a09436",
        "Nur Hafizahanani Binti Zailan",
        "96bfe722-1e1a-4e2c-901e-dae4789973ac",
        "Nur Hafizanah Binti Zailan",
        "Distinct athletes: Malaysian sailors (Nur Hafizahanani of Sabah sail 224712 vs Nur Hafizanah of MSN/MSA sail 1031).",
    ),
    (
        "604b8e9d-46c9-5dfb-a85a-0398148f64c8",
        "Ho-Yen Chen",
        "a3a56f5a-b9a0-55f9-be09-78ce57354464",
        "He-Yen Chen",
        "Kept separate pending Chinese roster verification: Ho-Yen Chen (President's Cup ILCA 4, TPE220704) vs He-Yen Chen (ASAF Cup Optimist Boys, R25) of Penghu Sailing Association.",
    ),
]

keep_separates = []
for id1, n1, id2, n2, reason in raw_keep_separates:
    if id1 < id2:
        keep_separates.append((id1, n1, id2, n2, reason))
    else:
        keep_separates.append((id2, n2, id1, n1, reason))

lines = [
    "-- Migration 181: Daily Audit Enrichments, Duplicate Merges, Keep-Separates, and Participant Backfill",
    "--",
    "-- 1. Enriches 22 verified sailor profiles with corroborated gender and nationality from gender-specific official divisions.",
    "-- 2. Consolidates 9 verified duplicate sailor pairs (including SGP 29er teams at HKRW 2026: Cheryl Ho Hai Yan,",
    "--    Febe Wong Qi Ke, and Gemma Chen Huang Heng; plus THA, IND, PHI, CHN profiles) with 0 shared regatta conflicts.",
    "-- 3. Registers 13 keep-separate pairs in admin_change_log.",
    "-- 4. Backfills 124 missing regatta_result_participants rows for Thailand Optimist 2026 (65) and Langkawi 2026 Optimist Gold (59).",
    "",
    "BEGIN;",
    "",
    "-- ============================================================================",
    "-- 1. VERIFIED DEMOGRAPHIC ENRICHMENTS (22 SAILORS)",
    "-- ============================================================================",
    "",
]

for sid, name, gender, nat, src in demographic_enrichments:
    esc_name = name.replace("'", "''")
    esc_src = src.replace("'", "''")
    lines.append(f"-- {esc_name} ({sid}) -> Gender: '{gender}'" + (f", Nationality: '{nat}'" if nat else "") + f" (Source: {esc_src})")
    lines.append("UPDATE public.sailors")
    lines.append(f"SET gender = COALESCE(NULLIF(gender, ''), '{gender}')," + (f" nationality = COALESCE(NULLIF(nationality, ''), '{nat}')," if nat else "") + " updated_at = clock_timestamp()")
    lines.append(f"WHERE id = '{sid}';")
    lines.append("")

lines.extend([
    "-- ============================================================================",
    "-- 2. DUPLICATE SAILOR CONSOLIDATIONS (9 PAIRS)",
    "-- ============================================================================",
    "",
    "-- Ensure HKRW 2026 29er SGP charter boat results carry SGP nationality and Roahnne Roy Santos results carry PHI nationality",
    "UPDATE public.regatta_results",
    "SET nationality = 'SGP', updated_at = clock_timestamp()",
    "WHERE id IN ('ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', '9c8184da-16ba-590f-91db-8364b07abef6');",
    "",
    "UPDATE public.regatta_results",
    "SET nationality = 'PHI', updated_at = clock_timestamp()",
    "WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2' AND nationality = 'SGP';",
    "",
])

for keep_id, merge_id, keep_name, merge_name, backfills in merges:
    esc_keep = keep_name.replace("'", "''")
    esc_merge = merge_name.replace("'", "''")
    lines.append(f"-- Merge '{esc_merge}' ({merge_id}) into '{esc_keep}' ({keep_id})")

    if backfills:
        set_parts = []
        for col, val in backfills.items():
            esc_val = val.replace("'", "''")
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
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '{keep_id}',
    'keepName', '{esc_keep}',
    'mergeId', '{merge_id}',
    'mergeName', '{esc_merge}'
  ),
  'migration_181',
  clock_timestamp()
);
""")

lines.extend([
    "-- ============================================================================",
    "-- 3. KEEP-SEPARATE REGISTRATIONS (13 PAIRS)",
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
) VALUES (
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
  'migration_181',
  clock_timestamp()
);
""")

lines.extend([
    "-- ============================================================================",
    "-- 4. BACKFILL 124 MISSING REGATTA_RESULT_PARTICIPANTS ROWS",
    "-- ============================================================================",
    "",
    "UPDATE public.regatta_results rr",
    "SET entry_label = COALESCE(rr.entry_label, s.name)",
    "FROM public.sailors s",
    "WHERE s.id = rr.sailor_id",
    "  AND rr.entry_label IS NULL;",
    "",
    "INSERT INTO public.regatta_result_participants (",
    "  regatta_result_id,",
    "  sailor_id,",
    "  source_name,",
    "  display_order,",
    "  role,",
    "  match_status,",
    "  ranking_credit",
    ")",
    "SELECT",
    "  rr.id,",
    "  rr.sailor_id,",
    "  s.name,",
    "  1,",
    "  CASE WHEN rr.entry_type = 'crew' THEN 'unknown' ELSE 'solo' END,",
    "  'matched',",
    "  CASE WHEN rr.entry_type = 'crew' THEN false ELSE true END",
    "FROM public.regatta_results rr",
    "JOIN public.sailors s ON s.id = rr.sailor_id",
    "WHERE NOT EXISTS (",
    "  SELECT 1 FROM public.regatta_result_participants rrp WHERE rrp.regatta_result_id = rr.id",
    ")",
    "ON CONFLICT (regatta_result_id, display_order) DO NOTHING;",
    "",
    "DO $$",
    "DECLARE",
    "  v_orphaned_results integer;",
    "BEGIN",
    "  SELECT count(*) INTO v_orphaned_results",
    "  FROM public.regatta_results rr",
    "  LEFT JOIN public.regatta_result_participants rrp ON rrp.regatta_result_id = rr.id",
    "  WHERE rrp.id IS NULL;",
    "",
    "  IF v_orphaned_results <> 0 THEN",
    "    RAISE EXCEPTION 'Expected 0 orphaned regatta_results after participant backfill, found %', v_orphaned_results;",
    "  END IF;",
    "END $$;",
    "",
    "-- 5. Summary audit log entry",
    "INSERT INTO public.admin_change_log (",
    "  action, entity_type, entity_id, entity_label, summary, details, source, created_at",
    ") VALUES (",
    "  'sailors.demographics_enrichment',",
    "  'sailor',",
    "  '00000000-0000-0000-0000-000000000000',",
    "  'Daily Audit Remediation — Migration 181',",
    "  'Enriched 22 sailor profiles with gender/nationality; merged 9 duplicate sailor pairs (including SGP 29er HKRW 2026 profiles); registered 13 keep-separate pairs; backfilled 124 missing regatta_result_participants rows.',",
    "  jsonb_build_object(",
    "    'sailors_enriched', 22,",
    "    'duplicates_merged', 9,",
    "    'keep_separates_registered', 13,",
    "    'participants_backfilled', 124",
    "  ),",
    "  'migration_181',",
    "  clock_timestamp()",
    ");",
    "",
    "COMMIT;",
    "",
])

out_path = "src/db/migrations/181_daily_audit_enrichment_merges_and_participant_backfill.sql"
with open(out_path, "w") as f:
    f.write("\n".join(lines))
print(f"Wrote {out_path} ({len(lines)} lines)")
