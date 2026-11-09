-- Migration 182: Daily Audit Enrichments, Duplicate Merges, Keep-Separates, and RSYC Monitor Configuration
--
-- 1. Consolidates 2 verified duplicate sailor pairs (Oscar Gayland -> Oscar Gaylard; Kim Do Hwan -> Dohwan Kim)
--    and enriches survivor profiles with verified demographic attributes (gender, DOB, nationality, club).
-- 2. Registers 10 confirmed distinct keep-separate sailor pairs in admin_change_log.
-- 3. Updates RSYC 2026 Knockout Championship (Gold & Silver) monitor URLs and links official results PDFs.

BEGIN;

-- ============================================================================
-- 1. DUPLICATE SAILOR CONSOLIDATIONS & DEMOGRAPHIC ENRICHMENTS (2 PAIRS)
-- ============================================================================

-- Enrich Dohwan Kim's regatta_results rows with verified gender, nationality, and birth_year
UPDATE public.regatta_results
SET gender = COALESCE(NULLIF(gender, ''), 'M'),
    nationality = COALESCE(NULLIF(nationality, ''), 'KOR'),
    birth_year = COALESCE(birth_year, 2012),
    updated_at = clock_timestamp()
WHERE sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1';

-- Merge 'Oscar Gayland' (3ea3b023-5098-5bf8-a819-bb881de0adf5) into 'Oscar Gaylard' (53552b36-236f-58d8-b189-d1c7a9086d1c)
-- 0. Backfill verified attributes onto survivor
UPDATE public.sailors SET gender = 'M', club = 'LBSC', nationality = 'AUS', updated_at = clock_timestamp() WHERE id = '53552b36-236f-58d8-b189-d1c7a9086d1c';

-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('53552b36-236f-58d8-b189-d1c7a9086d1c', 'Oscar Gayland')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c'
  WHERE rr_dup.sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c'
  WHERE rr_dup.sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c', updated_at = clock_timestamp()
WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c'
WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c'
WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c');
DELETE FROM public.sailor_aliases WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c'
WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c');
DELETE FROM public.sailor_claims WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c'
WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c' WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c' WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c' WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c' WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c' WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';
  DELETE FROM public.followed_sailors WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c' WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '53552b36-236f-58d8-b189-d1c7a9086d1c' WHERE sailor_id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '3ea3b023-5098-5bf8-a819-bb881de0adf5';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '53552b36-236f-58d8-b189-d1c7a9086d1c',
  'Oscar Gaylard <- Oscar Gayland',
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '53552b36-236f-58d8-b189-d1c7a9086d1c',
    'keepName', 'Oscar Gaylard',
    'mergeId', '3ea3b023-5098-5bf8-a819-bb881de0adf5',
    'mergeName', 'Oscar Gayland'
  ),
  'migration_182',
  clock_timestamp()
);

-- Merge 'Kim Do Hwan' (3033206a-5327-54a1-b767-1509caf170bb) into 'Dohwan Kim' (969d699b-ac23-51dc-b1ac-00e7070595e1)
-- 0. Backfill verified attributes onto survivor
UPDATE public.sailors SET gender = 'M', dob = COALESCE(dob, '2012-01-01'::date), nationality = 'KOR', updated_at = clock_timestamp() WHERE id = '969d699b-ac23-51dc-b1ac-00e7070595e1';

-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('969d699b-ac23-51dc-b1ac-00e7070595e1', 'Kim Do Hwan')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1'
  WHERE rr_dup.sailor_id = '3033206a-5327-54a1-b767-1509caf170bb'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1'
  WHERE rr_dup.sailor_id = '3033206a-5327-54a1-b767-1509caf170bb'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '3033206a-5327-54a1-b767-1509caf170bb'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1', updated_at = clock_timestamp()
WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';

-- 4. Repoint regatta_result_participants
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '3033206a-5327-54a1-b767-1509caf170bb'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1'
WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1'
WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1');
DELETE FROM public.sailor_aliases WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1'
WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1');
DELETE FROM public.sailor_claims WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1'
WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1' WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1' WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1' WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1' WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1' WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';
  DELETE FROM public.followed_sailors WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1' WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '969d699b-ac23-51dc-b1ac-00e7070595e1' WHERE sailor_id = '3033206a-5327-54a1-b767-1509caf170bb';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor and log merge
DELETE FROM public.sailors WHERE id = '3033206a-5327-54a1-b767-1509caf170bb';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '969d699b-ac23-51dc-b1ac-00e7070595e1',
  'Dohwan Kim <- Kim Do Hwan',
  'Consolidated verified duplicate profile into canonical sailor profile.',
  jsonb_build_object(
    'keepId', '969d699b-ac23-51dc-b1ac-00e7070595e1',
    'keepName', 'Dohwan Kim',
    'mergeId', '3033206a-5327-54a1-b767-1509caf170bb',
    'mergeName', 'Kim Do Hwan'
  ),
  'migration_182',
  clock_timestamp()
);

-- ============================================================================
-- 2. KEEP-SEPARATE REGISTRATIONS (10 PAIRS)
-- ============================================================================

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
)
SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  'f45e0130-7dca-5f3f-bc95-6271720a6550',
  'Yu-Hsin Kang / Yu-Ching Kang',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', 'f45e0130-7dca-5f3f-bc95-6271720a6550|f6be3f6f-ca95-510a-8dc1-2cd5e34d0b3a',
    'aId', 'f45e0130-7dca-5f3f-bc95-6271720a6550',
    'aName', 'Yu-Hsin Kang',
    'bId', 'f6be3f6f-ca95-510a-8dc1-2cd5e34d0b3a',
    'bName', 'Yu-Ching Kang',
    'reason', 'Distinct athletes: Direct head-to-head competitors in 115th Academic Year National President''s Cup Sailing Regatta 2026 — ILCA 4 (G) (Yilan Sailing Committee, TPE211956 vs TPE211389).'
  ),
  'migration_182',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = 'f45e0130-7dca-5f3f-bc95-6271720a6550|f6be3f6f-ca95-510a-8dc1-2cd5e34d0b3a'
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
)
SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '8eb39919-2873-52ba-b924-5caceb21772b',
  'Ching-Heng Chen / Chi-Sheng Chen',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '8eb39919-2873-52ba-b924-5caceb21772b|b1a7dd64-fe8a-5606-9782-3049cdc83425',
    'aId', '8eb39919-2873-52ba-b924-5caceb21772b',
    'aName', 'Ching-Heng Chen',
    'bId', 'b1a7dd64-fe8a-5606-9782-3049cdc83425',
    'bName', 'Chi-Sheng Chen',
    'reason', 'Distinct athletes: Direct head-to-head competitors in 2026 ASAF Cup Optimist Open Championships — Boys Fleet (Ci-Xin Waldorf TPE305 vs Penghu Sailing Association TPE500).'
  ),
  'migration_182',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '8eb39919-2873-52ba-b924-5caceb21772b|b1a7dd64-fe8a-5606-9782-3049cdc83425'
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
)
SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '72201bba-eca0-5022-bc09-619dd58d66ff',
  'Yu-Chi Chen / Chih-Yu Chen',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '72201bba-eca0-5022-bc09-619dd58d66ff|b2c05554-8405-55c8-bcbf-9c8b2e209f90',
    'aId', '72201bba-eca0-5022-bc09-619dd58d66ff',
    'aName', 'Yu-Chi Chen',
    'bId', 'b2c05554-8405-55c8-bcbf-9c8b2e209f90',
    'bName', 'Chih-Yu Chen',
    'reason', 'Distinct athletes: Direct head-to-head competitors in 115th Academic Year National President''s Cup Sailing Regatta 2026 — Optimist (B) (Yueming Elementary & Junior High School, TPE206 vs TPE202).'
  ),
  'migration_182',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '72201bba-eca0-5022-bc09-619dd58d66ff|b2c05554-8405-55c8-bcbf-9c8b2e209f90'
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
)
SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '115073fc-e588-5843-9cbd-99fcd5990874',
  'Daniel Shan / Daniel Chan',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '115073fc-e588-5843-9cbd-99fcd5990874|9fb849be-bfc1-5c19-b827-f95a2c775fc4',
    'aId', '115073fc-e588-5843-9cbd-99fcd5990874',
    'aName', 'Daniel Shan',
    'bId', '9fb849be-bfc1-5c19-b827-f95a2c775fc4',
    'bName', 'Daniel Chan',
    'reason', 'Distinct athletes: Daniel Shan is an RHKYC youth Optimist sailor (sail 230); Daniel Chan is a Hong Kong ILCA 6 sailor (sail 223750).'
  ),
  'migration_182',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '115073fc-e588-5843-9cbd-99fcd5990874|9fb849be-bfc1-5c19-b827-f95a2c775fc4'
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
)
SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '56cdc1b0-297b-55f1-ab53-18ce968dba2b',
  'Yu-Chen Chen / Chen You Jhen',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '56cdc1b0-297b-55f1-ab53-18ce968dba2b|605abece-e556-4c50-a947-ff64a6792ff4',
    'aId', '56cdc1b0-297b-55f1-ab53-18ce968dba2b',
    'aName', 'Yu-Chen Chen',
    'bId', '605abece-e556-4c50-a947-ff64a6792ff4',
    'bName', 'Chen You Jhen',
    'reason', 'Distinct athletes: Taiwanese youth sailors with distinct given names and sail numbers (463 vs Simen Elementary Sailing Team TPE317).'
  ),
  'migration_182',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '56cdc1b0-297b-55f1-ab53-18ce968dba2b|605abece-e556-4c50-a947-ff64a6792ff4'
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
)
SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '83015dcb-6cd8-5b4e-9040-55d10d913849',
  'Lie Huan Cheng / Cheng-Hsuan Lee',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '83015dcb-6cd8-5b4e-9040-55d10d913849|ca5a740b-f83f-59ba-9e8c-71171b957085',
    'aId', '83015dcb-6cd8-5b4e-9040-55d10d913849',
    'aName', 'Lie Huan Cheng',
    'bId', 'ca5a740b-f83f-59ba-9e8c-71171b957085',
    'bName', 'Cheng-Hsuan Lee',
    'reason', 'Distinct athletes: Lie Huan Cheng (Singapore SAFYC Optimist sailor, sail 3140) vs Cheng-Hsuan Lee (Taiwan Yilan Sailing Committee ILCA sailor, sail TPE 206219).'
  ),
  'migration_182',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '83015dcb-6cd8-5b4e-9040-55d10d913849|ca5a740b-f83f-59ba-9e8c-71171b957085'
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
)
SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '1acada38-b48d-5cb1-9016-563f3ae24665',
  'Huang Yu Chieh / Chien-Yu Huang',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '1acada38-b48d-5cb1-9016-563f3ae24665|86b36815-73c2-5333-8a7c-bbb82e3688be',
    'aId', '1acada38-b48d-5cb1-9016-563f3ae24665',
    'aName', 'Huang Yu Chieh',
    'bId', '86b36815-73c2-5333-8a7c-bbb82e3688be',
    'bName', 'Chien-Yu Huang',
    'reason', 'Distinct athletes: Taiwanese sailors from different municipal teams and given names (Simen Tainan TPE326 vs Taipei Sailing Committee TPE351).'
  ),
  'migration_182',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '1acada38-b48d-5cb1-9016-563f3ae24665|86b36815-73c2-5333-8a7c-bbb82e3688be'
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
)
SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '8ff74b8a-c2cc-544f-ada9-17b2f4e44527',
  'Chia-Cheng Chen / Chi-Sheng Chen',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '8ff74b8a-c2cc-544f-ada9-17b2f4e44527|b1a7dd64-fe8a-5606-9782-3049cdc83425',
    'aId', '8ff74b8a-c2cc-544f-ada9-17b2f4e44527',
    'aName', 'Chia-Cheng Chen',
    'bId', 'b1a7dd64-fe8a-5606-9782-3049cdc83425',
    'bName', 'Chi-Sheng Chen',
    'reason', 'Distinct athletes: Taiwanese sailors from different associations and classes (Yueming ILCA TPE 211738 vs Penghu Optimist TPE500).'
  ),
  'migration_182',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '8ff74b8a-c2cc-544f-ada9-17b2f4e44527|b1a7dd64-fe8a-5606-9782-3049cdc83425'
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
)
SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '23f21394-9b28-5e5b-8a72-c105f459ee3d',
  'Chiao-Chen Chang / Chia-Che Chang',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '23f21394-9b28-5e5b-8a72-c105f459ee3d|8bf566f5-98b6-5eec-b7fe-e23defb55572',
    'aId', '23f21394-9b28-5e5b-8a72-c105f459ee3d',
    'aName', 'Chiao-Chen Chang',
    'bId', '8bf566f5-98b6-5eec-b7fe-e23defb55572',
    'bName', 'Chia-Che Chang',
    'reason', 'Distinct athletes: Taiwanese sailors from different county associations and classes (Taoyuan Sailing Committee TPE163105 vs Penghu Sailing Association TPE5188).'
  ),
  'migration_182',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '23f21394-9b28-5e5b-8a72-c105f459ee3d|8bf566f5-98b6-5eec-b7fe-e23defb55572'
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
)
SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '06575f3d-3a87-5420-acbc-8693b2325462',
  'Chen-Yueh Wu / Yu-Chen Wu',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '06575f3d-3a87-5420-acbc-8693b2325462|fa95f8cf-a1aa-5899-8a7b-a103437ccb66',
    'aId', '06575f3d-3a87-5420-acbc-8693b2325462',
    'aName', 'Chen-Yueh Wu',
    'bId', 'fa95f8cf-a1aa-5899-8a7b-a103437ccb66',
    'bName', 'Yu-Chen Wu',
    'reason', 'Distinct athletes: Taiwanese youth sailors from different schools (Simen Elementary Sailing Team TPE329 vs Ci-Xin Waldorf TPE0438).'
  ),
  'migration_182',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '06575f3d-3a87-5420-acbc-8693b2325462|fa95f8cf-a1aa-5899-8a7b-a103437ccb66'
);

-- ============================================================================
-- 3. RSYC 2026 KNOCKOUT MONITOR CONFIGURATION & OFFICIAL RESULTS LINKS
-- ============================================================================

-- Point RSYC Gold monitor to official regatta page instead of registration form link
UPDATE public.result_import_monitors
SET event_url = 'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-gold-fleet-knockout-championship-2026/'
WHERE event_id = '5d1c38fe-f2cd-41bc-bb24-a2d8af62ef8b';

-- Point RSYC Silver monitor to official regatta page explicitly
UPDATE public.result_import_monitors
SET event_url = 'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2026/'
WHERE event_id = '76502024-d455-4a18-98fb-bb329a17e6e7';

-- Ensure RSYC Silver event nor_url points to the official NoR PDF
UPDATE public.regatta_events
SET nor_url = 'https://rsyc.org.sg/wp-content/uploads/2026/08/NOR_RSYC_Silver_KO_2026.pdf',
    updated_at = clock_timestamp()
WHERE id = '76502024-d455-4a18-98fb-bb329a17e6e7';

-- Link official overall ranking PDFs and NoR URLs on RSYC Gold and Silver regattas
UPDATE public.regattas
SET official_results_url = 'https://rsyc.org.sg/wp-content/uploads/2026/10/RSYC_Gold_Knockout_Race_2026_Results_Print_Overall_Rankings.pdf',
    official_results_source_name = 'RSYC Official Overall Rankings PDF',
    nor_url = COALESCE(nor_url, 'https://rsyc.org.sg/wp-content/uploads/2026/08/NOR_RSYC_Gold_KO_2026.pdf'),
    updated_at = clock_timestamp()
WHERE slug = 'rsyc-2026-gold';

UPDATE public.regattas
SET official_results_url = 'https://rsyc.org.sg/wp-content/uploads/2026/09/RSYC_Silver_Knockout_Race_2026_Results_Print_No_Race_Overall_Rankings.pdf',
    official_results_source_name = 'RSYC Official Overall Rankings PDF',
    nor_url = COALESCE(nor_url, 'https://rsyc.org.sg/wp-content/uploads/2026/08/NOR_RSYC_Silver_KO_2026.pdf'),
    updated_at = clock_timestamp()
WHERE slug = 'rsyc-2026-silver';

-- 4. Summary audit log entry
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.demographics_enrichment',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'Daily Audit Remediation — Migration 182',
  'Consolidated 2 verified duplicate sailor pairs (Oscar Gaylard, Dohwan Kim) with demographic enrichments; registered 10 keep-separate pairs; updated RSYC 2026 Knockout monitor URLs and official results PDF links.',
  jsonb_build_object(
    'sailors_enriched', 2,
    'duplicates_merged', 2,
    'keep_separates_registered', 10,
    'monitors_updated', 2
  ),
  'migration_182',
  clock_timestamp()
);

COMMIT;
