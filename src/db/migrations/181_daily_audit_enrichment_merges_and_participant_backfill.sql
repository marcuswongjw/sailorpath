-- Migration 181: Daily Audit Enrichments, Duplicate Merges, Keep-Separates, and Participant Backfill
--
-- 1. Enriches 22 verified sailor profiles with corroborated gender and nationality from gender-specific official divisions.
-- 2. Consolidates 9 verified duplicate sailor pairs (including SGP 29er teams at HKRW 2026: Cheryl Ho Hai Yan,
--    Febe Wong Qi Ke, and Gemma Chen Huang Heng; plus THA, IND, PHI, CHN profiles) with 0 shared regatta conflicts.
-- 3. Registers 13 keep-separate pairs in admin_change_log.
-- 4. Backfills 124 missing regatta_result_participants rows for Thailand Optimist 2026 (65) and Langkawi 2026 Optimist Gold (59).

BEGIN;

-- ============================================================================
-- 1. VERIFIED DEMOGRAPHIC ENRICHMENTS (22 SAILORS)
-- ============================================================================

-- Pham Khanh Ngoc Nguyen (0054671b-b92c-5436-9f55-93096948fd98) -> Gender: 'F', Nationality: 'VIE' (Source: 33rd SEA Games 2025 — Sailing — ILCA 4 Girls)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'F'), nationality = COALESCE(NULLIF(nationality, ''), 'VIE'), updated_at = clock_timestamp()
WHERE id = '0054671b-b92c-5436-9f55-93096948fd98';

-- Khim Ashley Albo (108d0eda-d379-5e23-bcde-6732a7f489cb) -> Gender: 'F', Nationality: 'PHI' (Source: 33rd SEA Games 2025 — Sailing — ILCA 4 Girls)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'F'), nationality = COALESCE(NULLIF(nationality, ''), 'PHI'), updated_at = clock_timestamp()
WHERE id = '108d0eda-d379-5e23-bcde-6732a7f489cb';

-- Carlstein Jade Dulay (243ed8f1-783f-4c3c-b69c-5a39442342ab) -> Gender: 'M' (Source: 33rd SEA Games 2025 — Sailing — Optimist Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), updated_at = clock_timestamp()
WHERE id = '243ed8f1-783f-4c3c-b69c-5a39442342ab';

-- Anya Zahadi (2a686543-6915-54dc-80db-b8781caabdc7) -> Gender: 'F', Nationality: 'INA' (Source: Pre-33rd SEA Games 2025 — Optimist Girls)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'F'), nationality = COALESCE(NULLIF(nationality, ''), 'INA'), updated_at = clock_timestamp()
WHERE id = '2a686543-6915-54dc-80db-b8781caabdc7';

-- Le Phuong Anh Phan (8fb29ccf-ffa1-5d78-bf3c-80c3b8836e98) -> Gender: 'F' (Source: 33rd SEA Games 2025 — Sailing — Optimist Girls)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'F'), updated_at = clock_timestamp()
WHERE id = '8fb29ccf-ffa1-5d78-bf3c-80c3b8836e98';

-- Muhammad Adhit (a92a882b-f3f4-5fb0-83d2-efd88dc6a54e) -> Gender: 'M' (Source: 33rd SEA Games 2025 & Pre-33rd SEA Games 2025 — Optimist Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), updated_at = clock_timestamp()
WHERE id = 'a92a882b-f3f4-5fb0-83d2-efd88dc6a54e';

-- Thanh Nhat Mai (b7076ceb-74cd-5fbc-b529-681c6842ebd1) -> Gender: 'M' (Source: 33rd SEA Games 2025 — Sailing — ILCA 4 Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), updated_at = clock_timestamp()
WHERE id = 'b7076ceb-74cd-5fbc-b529-681c6842ebd1';

-- Xu Xiaorong (c261ebe9-0054-4de8-ad6f-31899871703f) -> Gender: 'M' (Source: 22nd Langkawi International Regatta Perdana 2026 — ILCA 4 Men)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), updated_at = clock_timestamp()
WHERE id = 'c261ebe9-0054-4de8-ad6f-31899871703f';

-- Aguero Pratama Syabani (d4ac1747-65f6-57eb-aac2-aa3247f79da9) -> Gender: 'M', Nationality: 'INA' (Source: Pre-33rd SEA Games 2025 — Optimist Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'INA'), updated_at = clock_timestamp()
WHERE id = 'd4ac1747-65f6-57eb-aac2-aa3247f79da9';

-- Huynh Thai Son Pham (eb4f8426-a71a-5b09-88bb-93b30260a5e6) -> Gender: 'M' (Source: 33rd SEA Games 2025 — Sailing — Optimist Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), updated_at = clock_timestamp()
WHERE id = 'eb4f8426-a71a-5b09-88bb-93b30260a5e6';

-- 金田 惺吾 (025dc288-9bc5-5669-9222-9e3e1663e9ab) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 29er Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = '025dc288-9bc5-5669-9222-9e3e1663e9ab';

-- 宇留野 遥斗 (17808d6a-0599-592b-a66f-7e33cb3acda5) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 29er Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = '17808d6a-0599-592b-a66f-7e33cb3acda5';

-- 関 颯一郎 (1a60f694-7f83-59b1-be24-c3f9f930793e) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 29er Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = '1a60f694-7f83-59b1-be24-c3f9f930793e';

-- 後藤 晴人 (4d01c91c-7fd5-5d8d-817c-c6d1ac9cab82) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 29er Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = '4d01c91c-7fd5-5d8d-817c-c6d1ac9cab82';

-- 岡田 晴 (553dba2f-58d9-54c1-bd31-4bd37a7f3489) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 420 Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = '553dba2f-58d9-54c1-bd31-4bd37a7f3489';

-- 畠中 康佑 (8aa3b54b-684e-5eef-afc7-47e359202408) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 420 Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = '8aa3b54b-684e-5eef-afc7-47e359202408';

-- 渕上 幸星 (977d76ad-0559-5022-a08d-e3366282d003) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 420 Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = '977d76ad-0559-5022-a08d-e3366282d003';

-- 白石 征也 (a777bff8-7bb8-519c-825a-5b9deeb90080) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 29er Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = 'a777bff8-7bb8-519c-825a-5b9deeb90080';

-- マーズデン 珀空 (a8fd220f-14f1-5610-88bb-ed6681ce72c6) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 29er Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = 'a8fd220f-14f1-5610-88bb-ed6681ce72c6';

-- 山本 汐穏 (acc560b9-f226-51ca-9606-a32206715912) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 420 Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = 'acc560b9-f226-51ca-9606-a32206715912';

-- 田中 大基 (ed724e62-5752-5327-8d54-4fcad0c02a4b) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 420 Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = 'ed724e62-5752-5327-8d54-4fcad0c02a4b';

-- 青山 侑友 (f261f31b-599c-5d97-bf9e-582efa0d366b) -> Gender: 'M', Nationality: 'JPN' (Source: Japan Youth Worlds Selection Regatta 2026 — 420 Boys)
UPDATE public.sailors
SET gender = COALESCE(NULLIF(gender, ''), 'M'), nationality = COALESCE(NULLIF(nationality, ''), 'JPN'), updated_at = clock_timestamp()
WHERE id = 'f261f31b-599c-5d97-bf9e-582efa0d366b';

-- ============================================================================
-- 2. DUPLICATE SAILOR CONSOLIDATIONS (9 PAIRS)
-- ============================================================================

-- Ensure HKRW 2026 29er SGP charter boat results carry SGP nationality and Roahnne Roy Santos results carry PHI nationality
UPDATE public.regatta_results
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id IN ('ba93b3b4-5d09-5891-bfce-ce85f6aa08cc', '9c8184da-16ba-590f-91db-8364b07abef6');

UPDATE public.regatta_results
SET nationality = 'PHI', updated_at = clock_timestamp()
WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2' AND nationality = 'SGP';

-- Merge 'Cheryl Ho' (3114c493-b297-5031-8b50-eb75a88a9d3f) into 'Cheryl Ho Hai Yan' (61b1d74c-edcd-4730-b606-d3ae3264d658)
-- 0. Backfill verified attributes onto survivor
UPDATE public.sailors SET nationality = 'SGP', updated_at = clock_timestamp() WHERE id = '61b1d74c-edcd-4730-b606-d3ae3264d658';

-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('61b1d74c-edcd-4730-b606-d3ae3264d658', 'Cheryl Ho')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658'
  WHERE rr_dup.sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658'
  WHERE rr_dup.sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658'
WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658'
WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658'
WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658');
DELETE FROM public.sailor_aliases WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658'
WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658');
DELETE FROM public.sailor_claims WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658'
WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658' WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658' WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658' WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658' WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658' WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';
  DELETE FROM public.followed_sailors WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658' WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '61b1d74c-edcd-4730-b606-d3ae3264d658' WHERE sailor_id = '3114c493-b297-5031-8b50-eb75a88a9d3f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '3114c493-b297-5031-8b50-eb75a88a9d3f';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '61b1d74c-edcd-4730-b606-d3ae3264d658',
  'Cheryl Ho Hai Yan <- Cheryl Ho',
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '61b1d74c-edcd-4730-b606-d3ae3264d658',
    'keepName', 'Cheryl Ho Hai Yan',
    'mergeId', '3114c493-b297-5031-8b50-eb75a88a9d3f',
    'mergeName', 'Cheryl Ho'
  ),
  'migration_181',
  clock_timestamp()
);

-- Merge 'Febe Wong' (bfa40b34-a5ab-5948-a2a2-7078eace1d91) into 'Febe Wong Qi Ke' (97297f2f-45a3-4a42-bb8b-7de07d9a5cde)
-- 0. Backfill verified attributes onto survivor
UPDATE public.sailors SET nationality = 'SGP', updated_at = clock_timestamp() WHERE id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde';

-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('97297f2f-45a3-4a42-bb8b-7de07d9a5cde', 'Febe Wong')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde'
  WHERE rr_dup.sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde'
  WHERE rr_dup.sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde'
WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde'
WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde'
WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde'
WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde');
DELETE FROM public.sailor_claims WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde'
WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde' WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde' WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde' WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde' WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde' WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde' WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '97297f2f-45a3-4a42-bb8b-7de07d9a5cde' WHERE sailor_id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = 'bfa40b34-a5ab-5948-a2a2-7078eace1d91';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '97297f2f-45a3-4a42-bb8b-7de07d9a5cde',
  'Febe Wong Qi Ke <- Febe Wong',
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '97297f2f-45a3-4a42-bb8b-7de07d9a5cde',
    'keepName', 'Febe Wong Qi Ke',
    'mergeId', 'bfa40b34-a5ab-5948-a2a2-7078eace1d91',
    'mergeName', 'Febe Wong'
  ),
  'migration_181',
  clock_timestamp()
);

-- Merge 'Gemma Chen' (2113225c-9122-535a-ac52-cf5b2143de4d) into 'Gemma Chen Huang Heng' (688cc8ae-873e-40a3-9bc4-7d05a496994a)
-- 0. Backfill verified attributes onto survivor
UPDATE public.sailors SET nationality = 'SGP', updated_at = clock_timestamp() WHERE id = '688cc8ae-873e-40a3-9bc4-7d05a496994a';

-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('688cc8ae-873e-40a3-9bc4-7d05a496994a', 'Gemma Chen')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a'
  WHERE rr_dup.sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a'
  WHERE rr_dup.sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a'
WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a'
WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a'
WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a');
DELETE FROM public.sailor_aliases WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a'
WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a');
DELETE FROM public.sailor_claims WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a'
WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a' WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a' WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a' WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a' WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a' WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';
  DELETE FROM public.followed_sailors WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a' WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '688cc8ae-873e-40a3-9bc4-7d05a496994a' WHERE sailor_id = '2113225c-9122-535a-ac52-cf5b2143de4d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '2113225c-9122-535a-ac52-cf5b2143de4d';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '688cc8ae-873e-40a3-9bc4-7d05a496994a',
  'Gemma Chen Huang Heng <- Gemma Chen',
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '688cc8ae-873e-40a3-9bc4-7d05a496994a',
    'keepName', 'Gemma Chen Huang Heng',
    'mergeId', '2113225c-9122-535a-ac52-cf5b2143de4d',
    'mergeName', 'Gemma Chen'
  ),
  'migration_181',
  clock_timestamp()
);

-- Merge 'Hirunsiri Munkhongpornpaiboon' (7e0abc5a-75d5-5273-b0f8-4cec7d106914) into 'Hirunsira Munkhongpornpaiboon' (1ff55ac5-256c-42da-9fa5-a85d4f8d7f22)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ff55ac5-256c-42da-9fa5-a85d4f8d7f22', 'Hirunsiri Munkhongpornpaiboon')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22'
  WHERE rr_dup.sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22'
  WHERE rr_dup.sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22'
WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22'
WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22'
WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22');
DELETE FROM public.sailor_aliases WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22'
WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22');
DELETE FROM public.sailor_claims WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22'
WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22' WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22' WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22' WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22' WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22' WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';
  DELETE FROM public.followed_sailors WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22' WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22' WHERE sailor_id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '7e0abc5a-75d5-5273-b0f8-4cec7d106914';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22',
  'Hirunsira Munkhongpornpaiboon <- Hirunsiri Munkhongpornpaiboon',
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '1ff55ac5-256c-42da-9fa5-a85d4f8d7f22',
    'keepName', 'Hirunsira Munkhongpornpaiboon',
    'mergeId', '7e0abc5a-75d5-5273-b0f8-4cec7d106914',
    'mergeName', 'Hirunsiri Munkhongpornpaiboon'
  ),
  'migration_181',
  clock_timestamp()
);

-- Merge 'Alia Sabren Faisal' (8fd6382c-05d0-4980-8ada-ac6bb25c6afc) into 'Alia Sabreen Faisal' (eff0fe49-b3da-5a1c-a71b-f997f26b3e48)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eff0fe49-b3da-5a1c-a71b-f997f26b3e48', 'Alia Sabren Faisal')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48'
  WHERE rr_dup.sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48'
  WHERE rr_dup.sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48'
WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48'
WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48'
WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48');
DELETE FROM public.sailor_aliases WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48'
WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48');
DELETE FROM public.sailor_claims WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48'
WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48' WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48' WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48' WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48' WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48' WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';
  DELETE FROM public.followed_sailors WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48' WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48' WHERE sailor_id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '8fd6382c-05d0-4980-8ada-ac6bb25c6afc';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'eff0fe49-b3da-5a1c-a71b-f997f26b3e48',
  'Alia Sabreen Faisal <- Alia Sabren Faisal',
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'eff0fe49-b3da-5a1c-a71b-f997f26b3e48',
    'keepName', 'Alia Sabreen Faisal',
    'mergeId', '8fd6382c-05d0-4980-8ada-ac6bb25c6afc',
    'mergeName', 'Alia Sabren Faisal'
  ),
  'migration_181',
  clock_timestamp()
);

-- Merge 'Prince July Monticer' (d8d91597-0448-4284-9b31-73b2a7f5fd6d) into 'Prince July Montecer' (06f7dd80-c725-5e9f-bbea-e69503a06eac)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('06f7dd80-c725-5e9f-bbea-e69503a06eac', 'Prince July Monticer')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac'
  WHERE rr_dup.sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac'
  WHERE rr_dup.sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac'
WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac'
WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac'
WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac'
WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac');
DELETE FROM public.sailor_claims WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac'
WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac' WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac' WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac' WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac' WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac' WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac' WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '06f7dd80-c725-5e9f-bbea-e69503a06eac' WHERE sailor_id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = 'd8d91597-0448-4284-9b31-73b2a7f5fd6d';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '06f7dd80-c725-5e9f-bbea-e69503a06eac',
  'Prince July Montecer <- Prince July Monticer',
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '06f7dd80-c725-5e9f-bbea-e69503a06eac',
    'keepName', 'Prince July Montecer',
    'mergeId', 'd8d91597-0448-4284-9b31-73b2a7f5fd6d',
    'mergeName', 'Prince July Monticer'
  ),
  'migration_181',
  clock_timestamp()
);

-- Merge 'Samuel Tolentino' (0cc2b490-0422-5b10-a4b8-14435ff94dbd) into 'Samuel Rodolfo R. Tolentino' (dffea961-6ebf-47bc-8ce8-f9a134a539b8)
-- 0. Backfill verified attributes onto survivor
UPDATE public.sailors SET gender = 'M', club = 'Philippine Sailing Association', updated_at = clock_timestamp() WHERE id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8';

-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dffea961-6ebf-47bc-8ce8-f9a134a539b8', 'Samuel Tolentino')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8'
  WHERE rr_dup.sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8'
  WHERE rr_dup.sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8'
WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8'
WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8'
WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8');
DELETE FROM public.sailor_aliases WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8'
WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8');
DELETE FROM public.sailor_claims WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8'
WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8' WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8' WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8' WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8' WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8' WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';
  DELETE FROM public.followed_sailors WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8' WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'dffea961-6ebf-47bc-8ce8-f9a134a539b8' WHERE sailor_id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '0cc2b490-0422-5b10-a4b8-14435ff94dbd';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'dffea961-6ebf-47bc-8ce8-f9a134a539b8',
  'Samuel Rodolfo R. Tolentino <- Samuel Tolentino',
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'dffea961-6ebf-47bc-8ce8-f9a134a539b8',
    'keepName', 'Samuel Rodolfo R. Tolentino',
    'mergeId', '0cc2b490-0422-5b10-a4b8-14435ff94dbd',
    'mergeName', 'Samuel Tolentino'
  ),
  'migration_181',
  clock_timestamp()
);

-- Merge 'RoahnneRoy T Santos' (a5b6a7b9-622e-45c2-9051-d81b22fec7f2) into 'Roahnne Roy Santos' (f6b26ef3-658c-54c1-97f6-77b99166f040)
-- 0. Backfill verified attributes onto survivor
UPDATE public.sailors SET nationality = 'PHI', club = 'Philippine Sailing Association', updated_at = clock_timestamp() WHERE id = 'f6b26ef3-658c-54c1-97f6-77b99166f040';

-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f6b26ef3-658c-54c1-97f6-77b99166f040', 'RoahnneRoy T Santos')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040'
  WHERE rr_dup.sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040'
  WHERE rr_dup.sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040'
WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040'
WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040'
WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040'
WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040');
DELETE FROM public.sailor_claims WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040'
WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040' WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040' WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040' WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040' WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040' WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040' WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'f6b26ef3-658c-54c1-97f6-77b99166f040' WHERE sailor_id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'f6b26ef3-658c-54c1-97f6-77b99166f040',
  'Roahnne Roy Santos <- RoahnneRoy T Santos',
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'f6b26ef3-658c-54c1-97f6-77b99166f040',
    'keepName', 'Roahnne Roy Santos',
    'mergeId', 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2',
    'mergeName', 'RoahnneRoy T Santos'
  ),
  'migration_181',
  clock_timestamp()
);

-- Merge 'Ling Er Zhou' (3dd68c8f-98b7-4632-b5c1-ddbada92d55b) into 'Linger Zhou' (aa564db6-5ef3-5666-a821-425146fc692e)
-- 0. Backfill verified attributes onto survivor
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = 'aa564db6-5ef3-5666-a821-425146fc692e';

-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('aa564db6-5ef3-5666-a821-425146fc692e', 'Ling Er Zhou')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e'
  WHERE rr_dup.sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e'
  WHERE rr_dup.sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e'
WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e'
WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e'
WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e');
DELETE FROM public.sailor_aliases WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e'
WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e');
DELETE FROM public.sailor_claims WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e'
WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e' WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e' WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e' WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e' WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e' WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';
  DELETE FROM public.followed_sailors WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e' WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'aa564db6-5ef3-5666-a821-425146fc692e' WHERE sailor_id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '3dd68c8f-98b7-4632-b5c1-ddbada92d55b';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'aa564db6-5ef3-5666-a821-425146fc692e',
  'Linger Zhou <- Ling Er Zhou',
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'aa564db6-5ef3-5666-a821-425146fc692e',
    'keepName', 'Linger Zhou',
    'mergeId', '3dd68c8f-98b7-4632-b5c1-ddbada92d55b',
    'mergeName', 'Ling Er Zhou'
  ),
  'migration_181',
  clock_timestamp()
);

-- ============================================================================
-- 3. KEEP-SEPARATE REGISTRATIONS (13 PAIRS)
-- ============================================================================

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '2626c2a3-e937-5606-a38f-683128a5cf5d',
  'Chanyul Park / Hayul Park',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '2626c2a3-e937-5606-a38f-683128a5cf5d|d9f3075d-4b63-576d-b544-b7991dcaa603',
    'aId', '2626c2a3-e937-5606-a38f-683128a5cf5d',
    'aName', 'Chanyul Park',
    'bId', 'd9f3075d-4b63-576d-b544-b7991dcaa603',
    'bName', 'Hayul Park',
    'reason', 'Distinct athletes: Chanyul Park (Haegang Middle School, Q359) and Hayul Park (Godeok Hambaek Elementary School, O474) are separate Korean youth sailors.'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '3a2198bc-fe35-49c3-a5ba-2a32a35c81c6',
  'Muhammad Yaasin Bin Syahrizan / Muhammad Yusri Bin Syahrizan',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '3a2198bc-fe35-49c3-a5ba-2a32a35c81c6|c9df556b-7b8e-5944-92c8-0cc863207d9b',
    'aId', '3a2198bc-fe35-49c3-a5ba-2a32a35c81c6',
    'aName', 'Muhammad Yaasin Bin Syahrizan',
    'bId', 'c9df556b-7b8e-5944-92c8-0cc863207d9b',
    'bName', 'Muhammad Yusri Bin Syahrizan',
    'reason', 'Distinct athletes: Malaysian brothers (Yaasin sail 115 and Yusri sail 56051, MSN Sarawak).'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '0a103a01-a892-5c7f-a671-634fa5565dc9',
  'Ibuki Watanabe / Itsuki Watanabe',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '0a103a01-a892-5c7f-a671-634fa5565dc9|101de41c-3d78-5248-a9b2-36a88119d281',
    'aId', '0a103a01-a892-5c7f-a671-634fa5565dc9',
    'aName', 'Ibuki Watanabe',
    'bId', '101de41c-3d78-5248-a9b2-36a88119d281',
    'bName', 'Itsuki Watanabe',
    'reason', 'Distinct athletes: Ibuki Watanabe (Tsu Technical High School, JPN 55936) and Itsuki Watanabe (YJYC, JPN 3246).'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '309280c8-279c-518f-8673-2496c0bf7172',
  'Yu-Cheng Kao / Yu-Heng Kao',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '309280c8-279c-518f-8673-2496c0bf7172|f1676640-6736-5ced-aa15-5d34ece931db',
    'aId', '309280c8-279c-518f-8673-2496c0bf7172',
    'aName', 'Yu-Cheng Kao',
    'bId', 'f1676640-6736-5ced-aa15-5d34ece931db',
    'bName', 'Yu-Heng Kao',
    'reason', 'Distinct athletes: Taiwanese teammates/brothers at Ximen Elementary Sailing Team (TPE 41009 vs TPE 399).'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  'bf5455bc-c310-5bc1-85f1-372889e90934',
  'Suphachok Chueatathong / Suphachai Chueatathong',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', 'bf5455bc-c310-5bc1-85f1-372889e90934|c4a8af93-b344-5b96-a9e4-bef4c6f0107b',
    'aId', 'bf5455bc-c310-5bc1-85f1-372889e90934',
    'aName', 'Suphachok Chueatathong',
    'bId', 'c4a8af93-b344-5b96-a9e4-bef4c6f0107b',
    'bName', 'Suphachai Chueatathong',
    'reason', 'Distinct athletes: Thai brothers competing for WATH under sail numbers 999 and 31.'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '78ac9250-8763-5e62-a94a-e25440100616',
  'Shan-Ya Lee / Shan-Yu Lee',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '78ac9250-8763-5e62-a94a-e25440100616|d2384e74-ecef-53b2-8006-54f4ccdcbc36',
    'aId', '78ac9250-8763-5e62-a94a-e25440100616',
    'aName', 'Shan-Ya Lee',
    'bId', 'd2384e74-ecef-53b2-8006-54f4ccdcbc36',
    'bName', 'Shan-Yu Lee',
    'reason', 'Distinct athletes: Taiwanese siblings competing for Lotus Pond Sailing Team (TPE 427 vs TPE 773).'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '489d4743-1a7b-5f61-b3c2-2576df0df2fe',
  'Shohei Hayashi / Kohei Hayashi',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '489d4743-1a7b-5f61-b3c2-2576df0df2fe|6a8873bc-12ed-58a4-be8b-14f9d6ff1fe3',
    'aId', '489d4743-1a7b-5f61-b3c2-2576df0df2fe',
    'aName', 'Shohei Hayashi',
    'bId', '6a8873bc-12ed-58a4-be8b-14f9d6ff1fe3',
    'bName', 'Kohei Hayashi',
    'reason', 'Distinct athletes: Japanese brothers/teammates at Hayama Town Sailing Association (JPN 3469 vs JPN 2940).'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  'bbc40d80-aedd-5383-8e46-063b2f8cabe0',
  'Ting-Jen Lin / Ting-En Lin',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', 'bbc40d80-aedd-5383-8e46-063b2f8cabe0|fc743756-eaa4-5d96-9dc9-b9c22ffe845c',
    'aId', 'bbc40d80-aedd-5383-8e46-063b2f8cabe0',
    'aName', 'Ting-Jen Lin',
    'bId', 'fc743756-eaa4-5d96-9dc9-b9c22ffe845c',
    'bName', 'Ting-En Lin',
    'reason', 'Distinct athletes: Taiwanese siblings competing for YMES Sail Team.'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '57a1f9c5-bf57-5654-85a6-68f16b64ab40',
  'Muhammad Zafir Bin Mohd Zailan / Muhammad Zafrin Bin Mohd Zailan',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '57a1f9c5-bf57-5654-85a6-68f16b64ab40|d09b7f61-8e4b-58e0-bfa9-21af32b8fb1b',
    'aId', '57a1f9c5-bf57-5654-85a6-68f16b64ab40',
    'aName', 'Muhammad Zafir Bin Mohd Zailan',
    'bId', 'd09b7f61-8e4b-58e0-bfa9-21af32b8fb1b',
    'bName', 'Muhammad Zafrin Bin Mohd Zailan',
    'reason', 'Distinct athletes: Selangor brothers competing under sail numbers 207095 and 22.'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  'ad6fa7a4-fafc-4dc8-8bd7-92fcb8e39a0d',
  'Ela Murat / Eva Murat',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', 'ad6fa7a4-fafc-4dc8-8bd7-92fcb8e39a0d|b434b981-9f3a-514a-974c-fbf63700fd1b',
    'aId', 'ad6fa7a4-fafc-4dc8-8bd7-92fcb8e39a0d',
    'aName', 'Ela Murat',
    'bId', 'b434b981-9f3a-514a-974c-fbf63700fd1b',
    'bName', 'Eva Murat',
    'reason', 'Distinct athletes: RHKYC sisters competing under sail numbers 205828 and 61377.'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '0eb30de4-6e06-50f3-b8d4-3f02cc0130dd',
  'Nana Yamamura / Kanna Yamamura',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '0eb30de4-6e06-50f3-b8d4-3f02cc0130dd|523be7c2-3db8-5273-a02a-9c840f48bf5f',
    'aId', '0eb30de4-6e06-50f3-b8d4-3f02cc0130dd',
    'aName', 'Nana Yamamura',
    'bId', '523be7c2-3db8-5273-a02a-9c840f48bf5f',
    'bName', 'Kanna Yamamura',
    'reason', 'Distinct athletes: Yumenoshima YC sisters competing under sail numbers JPN 3480 and JPN 338.'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '0285e1be-3c9f-5d9e-a21a-21f995a09436',
  'Nur Hafizahanani Binti Zailan / Nur Hafizanah Binti Zailan',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '0285e1be-3c9f-5d9e-a21a-21f995a09436|96bfe722-1e1a-4e2c-901e-dae4789973ac',
    'aId', '0285e1be-3c9f-5d9e-a21a-21f995a09436',
    'aName', 'Nur Hafizahanani Binti Zailan',
    'bId', '96bfe722-1e1a-4e2c-901e-dae4789973ac',
    'bName', 'Nur Hafizanah Binti Zailan',
    'reason', 'Distinct athletes: Malaysian sailors (Nur Hafizahanani of Sabah sail 224712 vs Nur Hafizanah of MSN/MSA sail 1031).'
  ),
  'migration_181',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '604b8e9d-46c9-5dfb-a85a-0398148f64c8',
  'Ho-Yen Chen / He-Yen Chen',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '604b8e9d-46c9-5dfb-a85a-0398148f64c8|a3a56f5a-b9a0-55f9-be09-78ce57354464',
    'aId', '604b8e9d-46c9-5dfb-a85a-0398148f64c8',
    'aName', 'Ho-Yen Chen',
    'bId', 'a3a56f5a-b9a0-55f9-be09-78ce57354464',
    'bName', 'He-Yen Chen',
    'reason', 'Kept separate pending Chinese roster verification: Ho-Yen Chen (President''s Cup ILCA 4, TPE220704) vs He-Yen Chen (ASAF Cup Optimist Boys, R25) of Penghu Sailing Association.'
  ),
  'migration_181',
  clock_timestamp()
);

-- ============================================================================
-- 4. BACKFILL 124 MISSING REGATTA_RESULT_PARTICIPANTS ROWS
-- ============================================================================

UPDATE public.regatta_results rr
SET entry_label = COALESCE(rr.entry_label, s.name)
FROM public.sailors s
WHERE s.id = rr.sailor_id
  AND rr.entry_label IS NULL;

INSERT INTO public.regatta_result_participants (
  regatta_result_id,
  sailor_id,
  source_name,
  display_order,
  role,
  match_status,
  ranking_credit
)
SELECT
  rr.id,
  rr.sailor_id,
  s.name,
  1,
  CASE WHEN rr.entry_type = 'crew' THEN 'unknown' ELSE 'solo' END,
  'matched',
  CASE WHEN rr.entry_type = 'crew' THEN false ELSE true END
FROM public.regatta_results rr
JOIN public.sailors s ON s.id = rr.sailor_id
WHERE NOT EXISTS (
  SELECT 1 FROM public.regatta_result_participants rrp WHERE rrp.regatta_result_id = rr.id
)
ON CONFLICT (regatta_result_id, display_order) DO NOTHING;

DO $$
DECLARE
  v_orphaned_results integer;
BEGIN
  SELECT count(*) INTO v_orphaned_results
  FROM public.regatta_results rr
  LEFT JOIN public.regatta_result_participants rrp ON rrp.regatta_result_id = rr.id
  WHERE rrp.id IS NULL;

  IF v_orphaned_results <> 0 THEN
    RAISE EXCEPTION 'Expected 0 orphaned regatta_results after participant backfill, found %', v_orphaned_results;
  END IF;
END $$;

-- 5. Summary audit log entry
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.demographics_enrichment',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'Daily Audit Remediation — Migration 181',
  'Enriched 22 sailor profiles with gender/nationality; merged 9 duplicate sailor pairs (including SGP 29er HKRW 2026 profiles); registered 13 keep-separate pairs; backfilled 124 missing regatta_result_participants rows.',
  jsonb_build_object(
    'sailors_enriched', 22,
    'duplicates_merged', 9,
    'keep_separates_registered', 13,
    'participants_backfilled', 124
  ),
  'migration_181',
  clock_timestamp()
);

COMMIT;
