-- Migration 180: Sailor Demographic Enrichments, Regional Duplicate Consolidations,
-- Keep-Separate Registrations, and Regatta Result Reconciliations
--
-- 1. Enriches 2 verified DOBs and 17 verified nationalities from unanimous official scoring sheets.
-- 2. Consolidates 16 verified duplicate sailor pairs (PHI, IND, KOR, SGP, AUS) with 0 shared regatta conflicts.
-- 3. Registers 3 verified keep-separate decisions in admin_change_log.
-- 4. Removes 25 mis-assigned HKRW 2026 29er rows from Langkawi 2026 29er (preserving the 6 official LIRP 2026 entries
--    and verifying all 25 rows remain intact on HKRW 2026 29er), and reconciles single-discard flags on 2026 ILCA 4 Youth Worlds.

BEGIN;

-- ============================================================================
-- 1. VERIFIED DEMOGRAPHIC ENRICHMENTS (2 DOBS + 17 NATIONALITIES)
-- ============================================================================

-- Muhammad Hadif Nabihan Bin Rashidi (7c98de8c-7b60-5fa7-a90e-d8349ed96b86) -> DOB: '2010-01-01' (Source: Thailand International Sailing Championships 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86' AND dob IS NULL;

-- Adam Iwan Carraz (91927627-a2be-5b01-a357-134fe82679f9) -> DOB: '2009-01-01' (Source: 17th Eastern Seaboard Regatta 2025 — ILCA 6)
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = '91927627-a2be-5b01-a357-134fe82679f9' AND dob IS NULL;

-- Nur Adlina Nasreen Binti Mohd Nasri (08805f7e-ee2e-52e8-823f-d9b7b81941ba) -> Nationality: 'MAS' (Source: 2024 ILCA Asian Open Championship (ILCA 6 Women))
UPDATE public.sailors
SET nationality = 'MAS', updated_at = clock_timestamp()
WHERE id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' AND (nationality IS NULL OR nationality = '');

-- Muhammad Asnawi Iqbal Bin Adam (1e4b724c-4571-5f4a-8f48-73f77141691d) -> Nationality: 'MAS' (Source: 19th Asian Games Hangzhou 2022; 2024 ILCA Asian Open Championship; Pre-33rd SEA Games 2025)
UPDATE public.sailors
SET nationality = 'MAS', updated_at = clock_timestamp()
WHERE id = '1e4b724c-4571-5f4a-8f48-73f77141691d' AND (nationality IS NULL OR nationality = '');

-- Kritkamon Prasertnopakun (2135c975-184e-5672-81ec-4fbcf85bcbf7) -> Nationality: 'THA' (Source: Children’s Day Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '2135c975-184e-5672-81ec-4fbcf85bcbf7' AND (nationality IS NULL OR nationality = '');

-- Kim Jong Hwi (2d5a08d0-b75a-5097-9d88-989426fe2f12) -> Nationality: 'KOR' (Source: 19th Asian Games Hangzhou 2022 (Boy's Dinghy - ILCA 4))
UPDATE public.sailors
SET nationality = 'KOR', updated_at = clock_timestamp()
WHERE id = '2d5a08d0-b75a-5097-9d88-989426fe2f12' AND (nationality IS NULL OR nationality = '');

-- Poramut Srisawaddisrilodom (499c67de-06e1-5c6f-a3f1-694b2342b326) -> Nationality: 'THA' (Source: Children’s Day Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '499c67de-06e1-5c6f-a3f1-694b2342b326' AND (nationality IS NULL OR nationality = '');

-- Htet Lin Zaw (5acb538c-6b7b-5ba7-8cb8-2aad97d20816) -> Nationality: 'MYA' (Source: Pre-33rd SEA Games 2025 — ILCA 7)
UPDATE public.sailors
SET nationality = 'MYA', updated_at = clock_timestamp()
WHERE id = '5acb538c-6b7b-5ba7-8cb8-2aad97d20816' AND (nationality IS NULL OR nationality = '');

-- Jeremy Ein (64a16ae0-dd22-57c2-9f39-cbcae2141900) -> Nationality: 'THA' (Source: Children’s Day Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '64a16ae0-dd22-57c2-9f39-cbcae2141900' AND (nationality IS NULL OR nationality = '');

-- Luck Puapitsirikul (68fea819-ebd7-5cec-9b89-de1d58136f05) -> Nationality: 'THA' (Source: Children’s Day Regatta 2025 — ILCA 4; Thailand National Championship 2025 — Long Distance — ILCA 4)
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '68fea819-ebd7-5cec-9b89-de1d58136f05' AND (nationality IS NULL OR nationality = '');

-- Nur Alia Amera Binti Mohamad Latif (8813d941-a761-5ea0-8a0b-f6ed49ff38b8) -> Nationality: 'MAS' (Source: 2024 ILCA Asian Open Championship (ILCA 6 Women))
UPDATE public.sailors
SET nationality = 'MAS', updated_at = clock_timestamp()
WHERE id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' AND (nationality IS NULL OR nationality = '');

-- Prapassorn Kaewprom (8d54107d-d292-5e13-9616-cf53bbd41c87) -> Nationality: 'THA' (Source: 2024 Optimist Asian & Oceanian Championship; Thailand National Championship 2025 — Long Distance — ILCA 4)
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '8d54107d-d292-5e13-9616-cf53bbd41c87' AND (nationality IS NULL OR nationality = '');

-- Thit Bone Khant Nyar (d878c3d4-9655-5857-b7e6-d576942f4cb3) -> Nationality: 'MYA' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET nationality = 'MYA', updated_at = clock_timestamp()
WHERE id = 'd878c3d4-9655-5857-b7e6-d576942f4cb3' AND (nationality IS NULL OR nationality = '');

-- Chanatip Tongglum (d9337400-b506-5662-9c3c-9c657c5c947b) -> Nationality: 'THA' (Source: 2023 Optimist Asian & Oceanian Championship (Optimist Overall))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'd9337400-b506-5662-9c3c-9c657c5c947b' AND (nationality IS NULL OR nationality = '');

-- Nur Shazrin Mohamad Latif (e65296f7-fdc4-582a-b74b-fc2463ea8228) -> Nationality: 'MAS' (Source: 19th Asian Games Hangzhou 2022 (Women's Single Dinghy - ILCA 6))
UPDATE public.sailors
SET nationality = 'MAS', updated_at = clock_timestamp()
WHERE id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' AND (nationality IS NULL OR nationality = '');

-- Shota Sratongsang (e89161ab-34e7-5022-a08c-5b00bea6532b) -> Nationality: 'THA' (Source: Children’s Day Regatta 2025 — Optimist Silver)
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'e89161ab-34e7-5022-a08c-5b00bea6532b' AND (nationality IS NULL OR nationality = '');

-- Phyu Cin Thadar (e9c8f1e1-acff-5660-ba36-6f75834f3421) -> Nationality: 'MYA' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET nationality = 'MYA', updated_at = clock_timestamp()
WHERE id = 'e9c8f1e1-acff-5660-ba36-6f75834f3421' AND (nationality IS NULL OR nationality = '');

-- Zwel La Yaung (eccf0a0e-a600-599a-b300-79f74309a169) -> Nationality: 'MYA' (Source: 18th Eastern Seaboard Regatta 2026 — Optimist Silver)
UPDATE public.sailors
SET nationality = 'MYA', updated_at = clock_timestamp()
WHERE id = 'eccf0a0e-a600-599a-b300-79f74309a169' AND (nationality IS NULL OR nationality = '');

-- Phumsamut Watetakarn (ef51229e-76d0-5295-ab12-5b7250335f85) -> Nationality: 'THA' (Source: Children’s Day Regatta 2025 — ILCA 4)
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'ef51229e-76d0-5295-ab12-5b7250335f85' AND (nationality IS NULL OR nationality = '');

-- ============================================================================
-- 2. DUPLICATE SAILOR CONSOLIDATIONS (16 PAIRS)
-- ============================================================================

-- Merge 'Baby Beverly Brylle C. Magramo' (7329e489-32e2-4a20-ac2a-d24146248c8b) into 'Baby Beverly Brylle Magramo' (c8b6f944-2891-5f53-b78e-4bf822624355)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c8b6f944-2891-5f53-b78e-4bf822624355', 'Baby Beverly Brylle C. Magramo')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355'
  WHERE rr_dup.sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355'
  WHERE rr_dup.sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355'
WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355'
WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355'
WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355');
DELETE FROM public.sailor_aliases WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355'
WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355');
DELETE FROM public.sailor_claims WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355'
WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355' WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355' WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355' WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355' WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355' WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';
  DELETE FROM public.followed_sailors WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355' WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'c8b6f944-2891-5f53-b78e-4bf822624355' WHERE sailor_id = '7329e489-32e2-4a20-ac2a-d24146248c8b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '7329e489-32e2-4a20-ac2a-d24146248c8b';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'c8b6f944-2891-5f53-b78e-4bf822624355',
  'Baby Beverly Brylle Magramo <- Baby Beverly Brylle C. Magramo',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'c8b6f944-2891-5f53-b78e-4bf822624355',
    'keepName', 'Baby Beverly Brylle Magramo',
    'mergeId', '7329e489-32e2-4a20-ac2a-d24146248c8b',
    'mergeName', 'Baby Beverly Brylle C. Magramo'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Ivan Matthew D Eseque' (8be1e07c-edcf-4426-971f-7fff75bdd8f6) into 'Ivan Matthew Eseque' (03207997-4a62-508b-abb9-15b43480a36b)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('03207997-4a62-508b-abb9-15b43480a36b', 'Ivan Matthew D Eseque')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '03207997-4a62-508b-abb9-15b43480a36b'
  WHERE rr_dup.sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '03207997-4a62-508b-abb9-15b43480a36b'
  WHERE rr_dup.sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '03207997-4a62-508b-abb9-15b43480a36b'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b'
WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '03207997-4a62-508b-abb9-15b43480a36b'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b'
WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b'
WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '03207997-4a62-508b-abb9-15b43480a36b');
DELETE FROM public.sailor_aliases WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b'
WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '03207997-4a62-508b-abb9-15b43480a36b');
DELETE FROM public.sailor_claims WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b'
WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b' WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b' WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b' WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b' WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b' WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';
  DELETE FROM public.followed_sailors WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b' WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '03207997-4a62-508b-abb9-15b43480a36b' WHERE sailor_id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '8be1e07c-edcf-4426-971f-7fff75bdd8f6';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '03207997-4a62-508b-abb9-15b43480a36b',
  'Ivan Matthew Eseque <- Ivan Matthew D Eseque',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '03207997-4a62-508b-abb9-15b43480a36b',
    'keepName', 'Ivan Matthew Eseque',
    'mergeId', '8be1e07c-edcf-4426-971f-7fff75bdd8f6',
    'mergeName', 'Ivan Matthew D Eseque'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Daniel Alonso Bantegui Subia' (4d904c1b-b1a3-5873-942b-69138cf8b4ab) into 'Daniel Alonso Subia' (ee47fb94-4096-5154-9620-8c29f4f0db0d)
-- 0. Backfill non-null attributes onto survivor
UPDATE public.sailors SET sail_number = 'PHI21', updated_at = clock_timestamp() WHERE id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d';

-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ee47fb94-4096-5154-9620-8c29f4f0db0d', 'Daniel Alonso Bantegui Subia')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d'
  WHERE rr_dup.sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d'
  WHERE rr_dup.sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d'
WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d'
WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d'
WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d');
DELETE FROM public.sailor_aliases WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d'
WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d');
DELETE FROM public.sailor_claims WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d'
WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d' WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d' WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d' WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d' WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d' WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';
  DELETE FROM public.followed_sailors WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d' WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'ee47fb94-4096-5154-9620-8c29f4f0db0d' WHERE sailor_id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '4d904c1b-b1a3-5873-942b-69138cf8b4ab';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'ee47fb94-4096-5154-9620-8c29f4f0db0d',
  'Daniel Alonso Subia <- Daniel Alonso Bantegui Subia',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'ee47fb94-4096-5154-9620-8c29f4f0db0d',
    'keepName', 'Daniel Alonso Subia',
    'mergeId', '4d904c1b-b1a3-5873-942b-69138cf8b4ab',
    'mergeName', 'Daniel Alonso Bantegui Subia'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Kesha Rose C. Hara' (5d322d72-01f5-4733-b2d1-7400189566c5) into 'Kesha Rose Hara' (d48c024a-3059-5f68-9a6a-7f678f9b2fb2)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d48c024a-3059-5f68-9a6a-7f678f9b2fb2', 'Kesha Rose C. Hara')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2'
  WHERE rr_dup.sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2'
  WHERE rr_dup.sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2'
WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2'
WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2'
WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2');
DELETE FROM public.sailor_aliases WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2'
WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2');
DELETE FROM public.sailor_claims WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2'
WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2' WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2' WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2' WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2' WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2' WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';
  DELETE FROM public.followed_sailors WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2' WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2' WHERE sailor_id = '5d322d72-01f5-4733-b2d1-7400189566c5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '5d322d72-01f5-4733-b2d1-7400189566c5';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'd48c024a-3059-5f68-9a6a-7f678f9b2fb2',
  'Kesha Rose Hara <- Kesha Rose C. Hara',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'd48c024a-3059-5f68-9a6a-7f678f9b2fb2',
    'keepName', 'Kesha Rose Hara',
    'mergeId', '5d322d72-01f5-4733-b2d1-7400189566c5',
    'mergeName', 'Kesha Rose C. Hara'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Rose Ann H. Marienau' (c9234597-3fc1-4610-b3ac-9c60a3924002) into 'Rose Ann Marienau' (2590130d-2e1e-5116-b5e6-4de3ac752482)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2590130d-2e1e-5116-b5e6-4de3ac752482', 'Rose Ann H. Marienau')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482'
  WHERE rr_dup.sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482'
  WHERE rr_dup.sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482'
WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482'
WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482'
WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482'
WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482');
DELETE FROM public.sailor_claims WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482'
WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482' WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482' WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482' WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482' WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482' WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482' WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '2590130d-2e1e-5116-b5e6-4de3ac752482' WHERE sailor_id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = 'c9234597-3fc1-4610-b3ac-9c60a3924002';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '2590130d-2e1e-5116-b5e6-4de3ac752482',
  'Rose Ann Marienau <- Rose Ann H. Marienau',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '2590130d-2e1e-5116-b5e6-4de3ac752482',
    'keepName', 'Rose Ann Marienau',
    'mergeId', 'c9234597-3fc1-4610-b3ac-9c60a3924002',
    'mergeName', 'Rose Ann H. Marienau'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Amanda S. Amadeo' (49f5428c-032e-4acf-828b-a3790dae9c13) into 'Amanda Amadeo' (611448bb-466a-5beb-b19e-a7a0c2348414)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('611448bb-466a-5beb-b19e-a7a0c2348414', 'Amanda S. Amadeo')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414'
  WHERE rr_dup.sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414'
  WHERE rr_dup.sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414'
WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414'
WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414'
WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414');
DELETE FROM public.sailor_aliases WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414'
WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414');
DELETE FROM public.sailor_claims WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414'
WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414' WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414' WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414' WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414' WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414' WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';
  DELETE FROM public.followed_sailors WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414' WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '611448bb-466a-5beb-b19e-a7a0c2348414' WHERE sailor_id = '49f5428c-032e-4acf-828b-a3790dae9c13';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '49f5428c-032e-4acf-828b-a3790dae9c13';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '611448bb-466a-5beb-b19e-a7a0c2348414',
  'Amanda Amadeo <- Amanda S. Amadeo',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '611448bb-466a-5beb-b19e-a7a0c2348414',
    'keepName', 'Amanda Amadeo',
    'mergeId', '49f5428c-032e-4acf-828b-a3790dae9c13',
    'mergeName', 'Amanda S. Amadeo'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Zyke D. Castillo' (e6d4c0c6-4f35-48f2-ad30-3cff006b0d08) into 'Zyke Castillo' (c198b673-3ee0-568e-af44-6f0dee646380)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c198b673-3ee0-568e-af44-6f0dee646380', 'Zyke D. Castillo')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380'
  WHERE rr_dup.sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380'
  WHERE rr_dup.sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380'
WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380'
WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380'
WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380'
WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380');
DELETE FROM public.sailor_claims WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380'
WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380' WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380' WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380' WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380' WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380' WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380' WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'c198b673-3ee0-568e-af44-6f0dee646380' WHERE sailor_id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'c198b673-3ee0-568e-af44-6f0dee646380',
  'Zyke Castillo <- Zyke D. Castillo',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'c198b673-3ee0-568e-af44-6f0dee646380',
    'keepName', 'Zyke Castillo',
    'mergeId', 'e6d4c0c6-4f35-48f2-ad30-3cff006b0d08',
    'mergeName', 'Zyke D. Castillo'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Fred Marienau' (a315221a-cfc2-4a46-ad03-130bc3498cc7) into 'Fred Julian Marienau' (c0226ff0-5edd-50b9-93c0-f95fe36e3c5c)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c0226ff0-5edd-50b9-93c0-f95fe36e3c5c', 'Fred Marienau')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c'
  WHERE rr_dup.sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c'
  WHERE rr_dup.sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c'
WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c'
WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c'
WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c'
WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c');
DELETE FROM public.sailor_claims WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c'
WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c' WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c' WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c' WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c' WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c' WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c' WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c' WHERE sailor_id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = 'a315221a-cfc2-4a46-ad03-130bc3498cc7';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c',
  'Fred Julian Marienau <- Fred Marienau',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'c0226ff0-5edd-50b9-93c0-f95fe36e3c5c',
    'keepName', 'Fred Julian Marienau',
    'mergeId', 'a315221a-cfc2-4a46-ad03-130bc3498cc7',
    'mergeName', 'Fred Marienau'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Mark Adrey M. Amadeo' (be357a39-d5b7-401b-8e1f-c2d361169222) into 'Mark Amadeo' (a6963324-b0a4-56dc-94f5-f78816b28b6b)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a6963324-b0a4-56dc-94f5-f78816b28b6b', 'Mark Adrey M. Amadeo')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b'
  WHERE rr_dup.sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b'
  WHERE rr_dup.sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b'
WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b'
WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b'
WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b'
WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b');
DELETE FROM public.sailor_claims WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b'
WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b' WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b' WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b' WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b' WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b' WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b' WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'a6963324-b0a4-56dc-94f5-f78816b28b6b' WHERE sailor_id = 'be357a39-d5b7-401b-8e1f-c2d361169222';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = 'be357a39-d5b7-401b-8e1f-c2d361169222';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'a6963324-b0a4-56dc-94f5-f78816b28b6b',
  'Mark Amadeo <- Mark Adrey M. Amadeo',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'a6963324-b0a4-56dc-94f5-f78816b28b6b',
    'keepName', 'Mark Amadeo',
    'mergeId', 'be357a39-d5b7-401b-8e1f-c2d361169222',
    'mergeName', 'Mark Adrey M. Amadeo'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Edmon A. Asejo Jr' (10e48363-4610-43d8-9a8d-3e175daaeffa) into 'Edmon Asejo Jr' (e08b2f5b-a819-5368-a628-1096d2723279)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e08b2f5b-a819-5368-a628-1096d2723279', 'Edmon A. Asejo Jr')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279'
  WHERE rr_dup.sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279'
  WHERE rr_dup.sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279'
WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279'
WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279'
WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279');
DELETE FROM public.sailor_aliases WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279'
WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279');
DELETE FROM public.sailor_claims WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279'
WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279' WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279' WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279' WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279' WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279' WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';
  DELETE FROM public.followed_sailors WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279' WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'e08b2f5b-a819-5368-a628-1096d2723279' WHERE sailor_id = '10e48363-4610-43d8-9a8d-3e175daaeffa';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '10e48363-4610-43d8-9a8d-3e175daaeffa';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'e08b2f5b-a819-5368-a628-1096d2723279',
  'Edmon Asejo Jr <- Edmon A. Asejo Jr',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'e08b2f5b-a819-5368-a628-1096d2723279',
    'keepName', 'Edmon Asejo Jr',
    'mergeId', '10e48363-4610-43d8-9a8d-3e175daaeffa',
    'mergeName', 'Edmon A. Asejo Jr'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Kommaravelly Lahari' (4cdb0d0e-8efc-562d-bcb9-563bed0079eb) into 'Lahari Kommaravelly' (a7e5107d-faf3-4a7d-88f4-44613744a575)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a7e5107d-faf3-4a7d-88f4-44613744a575', 'Kommaravelly Lahari')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575'
  WHERE rr_dup.sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575'
  WHERE rr_dup.sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575'
WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575'
WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575'
WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575');
DELETE FROM public.sailor_aliases WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575'
WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575');
DELETE FROM public.sailor_claims WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575'
WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575' WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575' WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575' WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575' WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575' WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';
  DELETE FROM public.followed_sailors WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575' WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'a7e5107d-faf3-4a7d-88f4-44613744a575' WHERE sailor_id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '4cdb0d0e-8efc-562d-bcb9-563bed0079eb';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'a7e5107d-faf3-4a7d-88f4-44613744a575',
  'Lahari Kommaravelly <- Kommaravelly Lahari',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'a7e5107d-faf3-4a7d-88f4-44613744a575',
    'keepName', 'Lahari Kommaravelly',
    'mergeId', '4cdb0d0e-8efc-562d-bcb9-563bed0079eb',
    'mergeName', 'Kommaravelly Lahari'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Tattari Chandralekha' (1086f572-4d3c-5707-926a-1f89c1684cf9) into 'Chandralekha Tattari' (c766be2b-32b7-4e38-9f7f-d31332e58c80)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c766be2b-32b7-4e38-9f7f-d31332e58c80', 'Tattari Chandralekha')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80'
  WHERE rr_dup.sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80'
  WHERE rr_dup.sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80'
WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80'
WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80'
WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80');
DELETE FROM public.sailor_aliases WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80'
WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80');
DELETE FROM public.sailor_claims WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80'
WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80' WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80' WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80' WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80' WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80' WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';
  DELETE FROM public.followed_sailors WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80' WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'c766be2b-32b7-4e38-9f7f-d31332e58c80' WHERE sailor_id = '1086f572-4d3c-5707-926a-1f89c1684cf9';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '1086f572-4d3c-5707-926a-1f89c1684cf9';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'c766be2b-32b7-4e38-9f7f-d31332e58c80',
  'Chandralekha Tattari <- Tattari Chandralekha',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'c766be2b-32b7-4e38-9f7f-d31332e58c80',
    'keepName', 'Chandralekha Tattari',
    'mergeId', '1086f572-4d3c-5707-926a-1f89c1684cf9',
    'mergeName', 'Tattari Chandralekha'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Yeji Lee' (eb4e503b-fd7a-5a05-bd7a-3908567eab8f) into 'Yeji Lee' (e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7)
-- 0. Backfill non-null attributes onto survivor
UPDATE public.sailors SET nationality = 'KOR', sail_number = 'B6338', updated_at = clock_timestamp() WHERE id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7';

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7'
  WHERE rr_dup.sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7'
  WHERE rr_dup.sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7'
WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7'
WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7'
WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7'
WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7');
DELETE FROM public.sailor_claims WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7'
WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7' WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7' WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7' WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7' WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7' WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7' WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7' WHERE sailor_id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7',
  'Yeji Lee <- Yeji Lee',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', 'e1db7d5e-13a1-56cf-a7e3-d8af1db9aeb7',
    'keepName', 'Yeji Lee',
    'mergeId', 'eb4e503b-fd7a-5a05-bd7a-3908567eab8f',
    'mergeName', 'Yeji Lee'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Addy Armand Bin Anuar' (d5b73423-e2a1-558b-829c-44b824606225) into 'Addy Armand Anuar' (4b4c1623-a048-417c-acf2-af278aeffba3)
-- 0. Backfill non-null attributes onto survivor
UPDATE public.sailors SET sail_number = 'SGP 143', updated_at = clock_timestamp() WHERE id = '4b4c1623-a048-417c-acf2-af278aeffba3';

-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4b4c1623-a048-417c-acf2-af278aeffba3', 'Addy Armand Bin Anuar')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3'
  WHERE rr_dup.sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3'
  WHERE rr_dup.sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3'
WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3'
WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3'
WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3'
WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3');
DELETE FROM public.sailor_claims WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3'
WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3' WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3' WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3' WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3' WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3' WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3' WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '4b4c1623-a048-417c-acf2-af278aeffba3' WHERE sailor_id = 'd5b73423-e2a1-558b-829c-44b824606225';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = 'd5b73423-e2a1-558b-829c-44b824606225';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '4b4c1623-a048-417c-acf2-af278aeffba3',
  'Addy Armand Anuar <- Addy Armand Bin Anuar',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '4b4c1623-a048-417c-acf2-af278aeffba3',
    'keepName', 'Addy Armand Anuar',
    'mergeId', 'd5b73423-e2a1-558b-829c-44b824606225',
    'mergeName', 'Addy Armand Bin Anuar'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Ilsa Ren Cohen' (832131a0-a4ef-579b-9a6d-1d242d8d2db1) into 'Isla Ren Cohen' (122c11af-b3e3-5e08-9bc7-cc28a33ce040)
-- 0. Backfill non-null attributes onto survivor
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040';

-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('122c11af-b3e3-5e08-9bc7-cc28a33ce040', 'Ilsa Ren Cohen')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040'
  WHERE rr_dup.sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040'
  WHERE rr_dup.sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040'
WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040'
WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040'
WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040');
DELETE FROM public.sailor_aliases WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040'
WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040');
DELETE FROM public.sailor_claims WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040'
WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040' WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040' WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040' WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040' WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040' WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';
  DELETE FROM public.followed_sailors WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040' WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '122c11af-b3e3-5e08-9bc7-cc28a33ce040' WHERE sailor_id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '832131a0-a4ef-579b-9a6d-1d242d8d2db1';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '122c11af-b3e3-5e08-9bc7-cc28a33ce040',
  'Isla Ren Cohen <- Ilsa Ren Cohen',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '122c11af-b3e3-5e08-9bc7-cc28a33ce040',
    'keepName', 'Isla Ren Cohen',
    'mergeId', '832131a0-a4ef-579b-9a6d-1d242d8d2db1',
    'mergeName', 'Ilsa Ren Cohen'
  ),
  'migration_180',
  clock_timestamp()
);

-- Merge 'Zachariah Boyd' (f309cdc5-86b9-5851-ac8f-1e70f9f7ccee) into 'Zac Boyd' (31374565-e925-521a-a074-93c0d364cbc2)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('31374565-e925-521a-a074-93c0d364cbc2', 'Zachariah Boyd')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '31374565-e925-521a-a074-93c0d364cbc2'
  WHERE rr_dup.sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '31374565-e925-521a-a074-93c0d364cbc2'
  WHERE rr_dup.sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '31374565-e925-521a-a074-93c0d364cbc2'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2'
WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '31374565-e925-521a-a074-93c0d364cbc2'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2'
WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2'
WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '31374565-e925-521a-a074-93c0d364cbc2');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2'
WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '31374565-e925-521a-a074-93c0d364cbc2');
DELETE FROM public.sailor_claims WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2'
WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2' WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2' WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2' WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2' WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2' WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2' WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '31374565-e925-521a-a074-93c0d364cbc2' WHERE sailor_id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '31374565-e925-521a-a074-93c0d364cbc2',
  'Zac Boyd <- Zachariah Boyd',
  'Consolidated verified regional duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '31374565-e925-521a-a074-93c0d364cbc2',
    'keepName', 'Zac Boyd',
    'mergeId', 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee',
    'mergeName', 'Zachariah Boyd'
  ),
  'migration_180',
  clock_timestamp()
);

-- ============================================================================
-- 3. KEEP-SEPARATE REGISTRATIONS (3 PAIRS)
-- ============================================================================

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '08350803-1171-57de-a0b6-4c9f6f8a4771',
  'Yun-Yun Chuang / Yun-Hao Chuang',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '08350803-1171-57de-a0b6-4c9f6f8a4771|5a624207-08d4-53e9-8381-42cf361b8e70',
    'aId', '08350803-1171-57de-a0b6-4c9f6f8a4771',
    'aName', 'Yun-Yun Chuang',
    'bId', '5a624207-08d4-53e9-8381-42cf361b8e70',
    'bName', 'Yun-Hao Chuang',
    'reason', 'Distinct athletes: Yun-Yun Chuang and Yun-Hao Chuang are Taiwanese brothers competing concurrently for 舊城蓮潭帆船隊 (Lotus Pond Sailing Team).'
  ),
  'migration_180',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '60fc244e-f889-52e0-bb3b-00e8bedff4d7',
  'Yasuhiro Nishimura / Tooko Nishimura',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '60fc244e-f889-52e0-bb3b-00e8bedff4d7|6581432e-6145-5bfc-800a-7c7cd7a5619d',
    'aId', '60fc244e-f889-52e0-bb3b-00e8bedff4d7',
    'aName', 'Yasuhiro Nishimura',
    'bId', '6581432e-6145-5bfc-800a-7c7cd7a5619d',
    'bName', 'Tooko Nishimura',
    'reason', 'Distinct athletes: Yasuhiro Nishimura (male) and Tooko Nishimura (female) are family members competing in different years/divisions for EYCJ using family boat JPN 3365.'
  ),
  'migration_180',
  clock_timestamp()
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '5264ce32-f38f-507a-8d4b-e4757f4b2e64',
  'Jun Han / Ryan Lo Jun Han',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '5264ce32-f38f-507a-8d4b-e4757f4b2e64|df7c6bd6-12f7-412b-994a-f116e820e30d',
    'aId', '5264ce32-f38f-507a-8d4b-e4757f4b2e64',
    'aName', 'Jun Han',
    'bId', 'df7c6bd6-12f7-412b-994a-f116e820e30d',
    'bName', 'Ryan Lo Jun Han',
    'reason', 'Distinct athletes: Jun Han is a Korean youth Optimist sailor (KOR); Ryan Lo Jun Han is a Singapore national Olympic ILCA 7 sailor (SGP).'
  ),
  'migration_180',
  clock_timestamp()
);

-- ============================================================================
-- 4. REGATTA DISCREPANCY CORRECTIONS
-- ============================================================================

-- 4A. Remove 25 mis-assigned HKRW 2026 29er result rows from Langkawi 2026 29er (cd329052-dd4e-5b0b-985a-00a096b2b6ba)
DO $$
DECLARE
  v_hkrw_count integer;
  v_langkawi_remaining integer;
BEGIN
  -- Verify HKRW 2026 29er (c92a7017-4779-5f9b-8a56-4ca469fed159) already has all 25 entries intact
  SELECT count(*) INTO v_hkrw_count
  FROM public.regatta_results
  WHERE regatta_id = 'c92a7017-4779-5f9b-8a56-4ca469fed159';

  IF v_hkrw_count <> 25 THEN
    RAISE EXCEPTION 'Expected 25 entries in HKRW 2026 29er before cleanup, found %', v_hkrw_count;
  END IF;

  DELETE FROM public.regatta_race_results
  WHERE regatta_result_id IN (
    SELECT id FROM public.regatta_results
    WHERE regatta_id = 'cd329052-dd4e-5b0b-985a-00a096b2b6ba'
      AND evidence_name = 'Official HKRW 2026 29er Asian Championship Results (RHKYC)'
  );

  DELETE FROM public.regatta_result_participants
  WHERE regatta_result_id IN (
    SELECT id FROM public.regatta_results
    WHERE regatta_id = 'cd329052-dd4e-5b0b-985a-00a096b2b6ba'
      AND evidence_name = 'Official HKRW 2026 29er Asian Championship Results (RHKYC)'
  );

  DELETE FROM public.regatta_results
  WHERE regatta_id = 'cd329052-dd4e-5b0b-985a-00a096b2b6ba'
    AND evidence_name = 'Official HKRW 2026 29er Asian Championship Results (RHKYC)';

  SELECT count(*) INTO v_langkawi_remaining
  FROM public.regatta_results
  WHERE regatta_id = 'cd329052-dd4e-5b0b-985a-00a096b2b6ba';

  IF v_langkawi_remaining <> 6 THEN
    RAISE EXCEPTION 'Expected 6 official Langkawi 29er entries remaining, found %', v_langkawi_remaining;
  END IF;
END $$;

-- 4B. Reconcile single-discard flags on 2026 ILCA 4 Youth World Championships (Boys & Girls)
WITH matched_discards AS (
  SELECT DISTINCT ON (rr.id)
    rrr.id AS race_result_id
  FROM public.regatta_results rr
  JOIN public.regattas r ON r.id = rr.regatta_id
  JOIN public.regatta_race_results rrr ON rrr.regatta_result_id = rr.id
  WHERE r.slug IN ('2026-ilca-4-youth-worlds-boys', '2026-ilca-4-youth-worlds-girls')
    AND rr.total_score > rr.nett_score
    AND abs(rrr.score - (rr.total_score - rr.nett_score)) < 0.05
    AND COALESCE(rrr.scoring_code, '') <> 'DNE'
  ORDER BY rr.id, rrr.race_number
)
UPDATE public.regatta_race_results rrr
SET discarded = true, updated_at = clock_timestamp()
FROM matched_discards md
WHERE rrr.id = md.race_result_id
  AND rrr.discarded = false;

-- 5. Summary audit log entry
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.demographics_enrichment',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'Daily Audit Remediation — Migration 180',
  'Enriched 2 DOBs and 17 nationalities; merged 16 duplicate sailor pairs; registered 3 keep-separate pairs; cleaned 25 mis-assigned HKRW 29er rows from Langkawi 2026 29er and reconciled 447 ILCA 4 Youth Worlds discard flags.',
  jsonb_build_object(
    'dobs_updated', 2,
    'nationalities_updated', 17,
    'duplicates_merged', 16,
    'keep_separates_registered', 3,
    'langkawi_29er_orphan_hkrw_rows_removed', 25,
    'ilca4_worlds_discards_reconciled', 447
  ),
  'migration_180',
  clock_timestamp()
);

COMMIT;
