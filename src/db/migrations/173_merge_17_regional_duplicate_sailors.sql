-- Migration 173: Merge 17 Definitive Regional Duplicate Sailor Profiles
--
-- Merges 17 verified duplicate pairs from recent regional imports (HKG, MAS, INA, THA, JPN, KOR)
-- preserving the canonical profile, repointing results and participants, adding aliases,
-- and safely resolving any conflicting result rows.

BEGIN;

-- Merge 'Avelino Shin' (17bf03a1-784e-52bd-b3d4-c3fa2f47086d) into 'Avelino Paulo Shin' (c47da38a-3c0f-4723-95e3-5b9aa740a6d0)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c47da38a-3c0f-4723-95e3-5b9aa740a6d0', 'Avelino Shin')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0'
  WHERE rr_dup.sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0'
  WHERE rr_dup.sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0'
WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0'
WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0'
WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0');
DELETE FROM public.sailor_aliases WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0'
WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0');
DELETE FROM public.sailor_claims WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0'
WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';
  DELETE FROM public.followed_sailors WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '17bf03a1-784e-52bd-b3d4-c3fa2f47086d';

-- Merge 'Kam Hing Hu' (ec92b0f6-3e15-5ef2-bc96-222ffec71b47) into 'Hu Kam Hing' (5badeb1d-e41c-549d-af7b-66e65845a726)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5badeb1d-e41c-549d-af7b-66e65845a726', 'Kam Hing Hu')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726'
  WHERE rr_dup.sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726'
  WHERE rr_dup.sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726'
WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726'
WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726'
WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726'
WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726');
DELETE FROM public.sailor_claims WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726'
WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726' WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726' WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726' WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726' WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726' WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726' WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '5badeb1d-e41c-549d-af7b-66e65845a726' WHERE sailor_id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47';

-- Merge 'Kai Story' (69990555-b9fc-532f-a922-1c502dc62ec6) into 'Kai Storey' (501d0faa-3edc-4c25-84c6-1681e7f36e48)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('501d0faa-3edc-4c25-84c6-1681e7f36e48', 'Kai Story')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'
  WHERE rr_dup.sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'
  WHERE rr_dup.sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'
WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'
WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'
WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48');
DELETE FROM public.sailor_aliases WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'
WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48');
DELETE FROM public.sailor_claims WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48'
WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48' WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48' WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48' WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48' WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48' WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';
  DELETE FROM public.followed_sailors WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48' WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '501d0faa-3edc-4c25-84c6-1681e7f36e48' WHERE sailor_id = '69990555-b9fc-532f-a922-1c502dc62ec6';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '69990555-b9fc-532f-a922-1c502dc62ec6';

-- Merge 'Ned Tyson' (0e9d3e8f-7c78-5e7e-9087-e7defa5953c7) into 'Ned Conrad Tyson' (632b2a41-4a6e-558c-b791-4acb6a460442)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('632b2a41-4a6e-558c-b791-4acb6a460442', 'Ned Tyson')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442'
  WHERE rr_dup.sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442'
  WHERE rr_dup.sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442'
WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442'
WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442'
WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442');
DELETE FROM public.sailor_aliases WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442'
WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442');
DELETE FROM public.sailor_claims WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442'
WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442' WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442' WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442' WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442' WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442' WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';
  DELETE FROM public.followed_sailors WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442' WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '632b2a41-4a6e-558c-b791-4acb6a460442' WHERE sailor_id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7';

-- Merge 'Haziq Mustaqim b. Mohd Husni' (bbf3e47c-823f-43d7-8eca-35932e5a9949) into 'Haziq Mustaqim Bin Mohd Husni' (3f8e7331-d3fe-56d2-b62d-14b9f485452b)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3f8e7331-d3fe-56d2-b62d-14b9f485452b', 'Haziq Mustaqim b. Mohd Husni')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b'
  WHERE rr_dup.sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b'
  WHERE rr_dup.sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b'
WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b'
WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b'
WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b'
WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b');
DELETE FROM public.sailor_claims WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b'
WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b' WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b' WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b' WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b' WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b' WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b' WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '3f8e7331-d3fe-56d2-b62d-14b9f485452b' WHERE sailor_id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';

-- Merge 'Muhammad Faizal Bin Ahmad Asri' (bd3ea917-2821-539f-a858-91ae716fa34b) into 'Muhamad Faizal Bin Ahmad Asri' (c0f5986d-b0c5-58fc-b6d0-6324db45b52e)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c0f5986d-b0c5-58fc-b6d0-6324db45b52e', 'Muhammad Faizal Bin Ahmad Asri')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e'
  WHERE rr_dup.sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e'
  WHERE rr_dup.sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e'
WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e'
WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e'
WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e'
WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e');
DELETE FROM public.sailor_claims WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e'
WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id = 'bd3ea917-2821-539f-a858-91ae716fa34b';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = 'bd3ea917-2821-539f-a858-91ae716fa34b';

-- Merge 'Lee Songha' (59978bb7-0c9a-5e65-85de-bd7153301709) into 'Songha Lee' (d3bdd575-51a9-46c8-8b02-b254b18b100d)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d3bdd575-51a9-46c8-8b02-b254b18b100d', 'Lee Songha')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
  WHERE rr_dup.sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
  WHERE rr_dup.sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d');
DELETE FROM public.sailor_aliases WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d');
DELETE FROM public.sailor_claims WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d' WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d' WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d' WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d' WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d' WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';
  DELETE FROM public.followed_sailors WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d' WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d' WHERE sailor_id = '59978bb7-0c9a-5e65-85de-bd7153301709';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '59978bb7-0c9a-5e65-85de-bd7153301709';

-- Merge 'Tombe Yumiko' (a4daca19-3019-4442-9d86-7d1b9f419b9a) into 'Yumiko Tombe' (f2fc7707-469f-5bfc-b583-e4c2e93829ac)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f2fc7707-469f-5bfc-b583-e4c2e93829ac', 'Tombe Yumiko')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac'
  WHERE rr_dup.sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac'
  WHERE rr_dup.sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac'
WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac'
WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac'
WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac'
WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac');
DELETE FROM public.sailor_claims WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac'
WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac' WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac' WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac' WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac' WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac' WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac' WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'f2fc7707-469f-5bfc-b583-e4c2e93829ac' WHERE sailor_id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = 'a4daca19-3019-4442-9d86-7d1b9f419b9a';

-- Merge 'Binti Mohamad Latif Nur Shazrin' (a04779e4-b849-4819-8b77-532006111145) into 'Nur Shazrin Mohamad Latif' (e65296f7-fdc4-582a-b74b-fc2463ea8228)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e65296f7-fdc4-582a-b74b-fc2463ea8228', 'Binti Mohamad Latif Nur Shazrin')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228'
  WHERE rr_dup.sailor_id = 'a04779e4-b849-4819-8b77-532006111145'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228'
  WHERE rr_dup.sailor_id = 'a04779e4-b849-4819-8b77-532006111145'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'a04779e4-b849-4819-8b77-532006111145'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228'
WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'a04779e4-b849-4819-8b77-532006111145'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228'
WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228'
WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228'
WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228');
DELETE FROM public.sailor_claims WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228'
WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id = 'a04779e4-b849-4819-8b77-532006111145';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = 'a04779e4-b849-4819-8b77-532006111145';

-- Merge 'Norton Stephanie Louise' (64976605-8d4e-4367-b023-14e7bd62e628) into 'Stephanie Norton' (98bf4b68-3283-5b87-bbbe-d11c1977eafc)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('98bf4b68-3283-5b87-bbbe-d11c1977eafc', 'Norton Stephanie Louise')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc'
  WHERE rr_dup.sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc'
  WHERE rr_dup.sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc'
WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc'
WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc'
WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc');
DELETE FROM public.sailor_aliases WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc'
WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc');
DELETE FROM public.sailor_claims WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc'
WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc' WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc' WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc' WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc' WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc' WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';
  DELETE FROM public.followed_sailors WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc' WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '98bf4b68-3283-5b87-bbbe-d11c1977eafc' WHERE sailor_id = '64976605-8d4e-4367-b023-14e7bd62e628';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '64976605-8d4e-4367-b023-14e7bd62e628';

-- Merge 'Muhammad Hadif Nabihn Bin Rashidi' (e4c9ae24-c1f1-5cd0-a975-6421bd493de7) into 'Muhammad Hadif Nabihan Bin Rashidi' (7c98de8c-7b60-5fa7-a90e-d8349ed96b86)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('7c98de8c-7b60-5fa7-a90e-d8349ed96b86', 'Muhammad Hadif Nabihn Bin Rashidi')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86'
  WHERE rr_dup.sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86'
  WHERE rr_dup.sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86'
WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86'
WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86'
WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86'
WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86');
DELETE FROM public.sailor_claims WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86'
WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86' WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86' WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86' WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86' WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86' WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86' WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '7c98de8c-7b60-5fa7-a90e-d8349ed96b86' WHERE sailor_id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7';

-- Merge 'Muhammad Hilfi Nafael Bin Mohd Hasrizan' (4ab81121-eed4-5d26-84a0-7c233e31bc6d) into 'Muhammad Hilfi Nafael Bin Hasrizan' (1153aed7-1732-4cd4-a60b-b4229ddee14e)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1153aed7-1732-4cd4-a60b-b4229ddee14e', 'Muhammad Hilfi Nafael Bin Mohd Hasrizan')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e'
  WHERE rr_dup.sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e'
  WHERE rr_dup.sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e'
WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e'
WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e'
WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e');
DELETE FROM public.sailor_aliases WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e'
WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e');
DELETE FROM public.sailor_claims WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e'
WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';
  DELETE FROM public.followed_sailors WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '4ab81121-eed4-5d26-84a0-7c233e31bc6d';

-- Merge 'Muhammad Adam Aierell Bin Moh Azizol Amirul' (f69c3030-ab08-5bfd-8037-74c8e4696b72) into 'Muhammad Adam Aierell Mohd Azizol Amirul' (5878691c-f01b-4ab4-976c-e6ad27b8782d)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5878691c-f01b-4ab4-976c-e6ad27b8782d', 'Muhammad Adam Aierell Bin Moh Azizol Amirul')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d'
  WHERE rr_dup.sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d'
  WHERE rr_dup.sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d'
WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d'
WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d'
WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d'
WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d');
DELETE FROM public.sailor_claims WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d'
WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = 'f69c3030-ab08-5bfd-8037-74c8e4696b72';

-- Merge 'Xu Xiaoring' (48f7a683-cf70-51e3-932a-e1544f08f6cd) into 'Xu Xiaorong' (c261ebe9-0054-4de8-ad6f-31899871703f)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c261ebe9-0054-4de8-ad6f-31899871703f', 'Xu Xiaoring')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f'
  WHERE rr_dup.sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f'
  WHERE rr_dup.sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f'
WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f'
  );

UPDATE public.regatta_result_participants
SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f'
WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f'
WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f');
DELETE FROM public.sailor_aliases WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f'
WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f');
DELETE FROM public.sailor_claims WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f'
WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f' WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f' WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f' WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f' WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f' WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';
  DELETE FROM public.followed_sailors WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f' WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = 'c261ebe9-0054-4de8-ad6f-31899871703f' WHERE sailor_id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '48f7a683-cf70-51e3-932a-e1544f08f6cd';

-- Merge 'Adam Lwan Carraz' (42b8bae3-8035-58e9-8efd-b67e3597a437) into 'Adam Iwan Carraz' (91927627-a2be-5b01-a357-134fe82679f9)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('91927627-a2be-5b01-a357-134fe82679f9', 'Adam Lwan Carraz')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '91927627-a2be-5b01-a357-134fe82679f9'
  WHERE rr_dup.sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '91927627-a2be-5b01-a357-134fe82679f9'
  WHERE rr_dup.sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '91927627-a2be-5b01-a357-134fe82679f9'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9'
WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '91927627-a2be-5b01-a357-134fe82679f9'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9'
WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9'
WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '91927627-a2be-5b01-a357-134fe82679f9');
DELETE FROM public.sailor_aliases WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9'
WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '91927627-a2be-5b01-a357-134fe82679f9');
DELETE FROM public.sailor_claims WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9'
WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9' WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9' WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9' WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9' WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9' WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';
  DELETE FROM public.followed_sailors WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9' WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '91927627-a2be-5b01-a357-134fe82679f9' WHERE sailor_id = '42b8bae3-8035-58e9-8efd-b67e3597a437';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '42b8bae3-8035-58e9-8efd-b67e3597a437';

-- Merge 'Torn Rattana' (efba7d9a-d71a-55b9-90fc-5ec21941baa1) into 'Ton Rattana' (717ef058-5716-5951-a848-0723f95e8f28)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('717ef058-5716-5951-a848-0723f95e8f28', 'Torn Rattana')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '717ef058-5716-5951-a848-0723f95e8f28'
  WHERE rr_dup.sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '717ef058-5716-5951-a848-0723f95e8f28'
  WHERE rr_dup.sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '717ef058-5716-5951-a848-0723f95e8f28'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28'
WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '717ef058-5716-5951-a848-0723f95e8f28'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28'
WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28'
WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '717ef058-5716-5951-a848-0723f95e8f28');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28'
WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '717ef058-5716-5951-a848-0723f95e8f28');
DELETE FROM public.sailor_claims WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28'
WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28' WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28' WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28' WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28' WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28' WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28' WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '717ef058-5716-5951-a848-0723f95e8f28' WHERE sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1';

-- Merge 'Muhamad Zahir Naiman' (bcd38552-fa4d-5998-9a5c-4f11719e6642) into 'Muhammad Zahir Naiman Bin Ismail' (6b9c77fe-5a8d-490a-bc66-34f60695132b)
-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6b9c77fe-5a8d-490a-bc66-34f60695132b', 'Muhamad Zahir Naiman')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b'
  WHERE rr_dup.sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b'
  WHERE rr_dup.sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b'
WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b'
WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b'
WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b'
WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b');
DELETE FROM public.sailor_claims WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b'
WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = 'bcd38552-fa4d-5998-9a5c-4f11719e6642';

COMMIT;
