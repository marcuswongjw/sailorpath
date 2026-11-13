#!/usr/bin/env python3
"""Generate migration 20261113091500_consolidate_regional_merges_and_monitors.sql:
1. Consolidate 5 verified regional progression/transliteration duplicate sailor pairs.
2. Update result_import_monitors status for fully imported and corroborated events.
"""

migration_content = """-- Migration: 20261113091500_consolidate_regional_merges_and_monitors.sql
-- Description: Consolidate 5 verified regional duplicate sailor profiles (Albahri, Almasoud, Almansour, Bohamad, Enki)
-- and mark fully corroborated regatta event monitors as reviewed.

BEGIN;

-- ============================================================================
-- 1. REGIONAL ATHLETE CONSOLIDATIONS (5 PAIRS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Merge 1: Abdulrahman / Abdelrahman Albahri (UAE)
-- Survivor: b3cebd0e-9985-43f4-9b02-b1583bd0a9ee (Abdelrahman Albahri, Abu Dhabi Sailing Club)
-- Merged:   22e3d1ba-097d-4d88-b9dd-c714f5ccc639 (Abdulrahman Albahri, ILCA 4 Mussanah 2026)
-- ----------------------------------------------------------------------------

-- Add alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b3cebd0e-9985-43f4-9b02-b1583bd0a9ee', 'Abdulrahman Albahri')
ON CONFLICT (alias_name) DO NOTHING;

-- Repoint regatta_results
UPDATE public.regatta_results
SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee',
    updated_at = clock_timestamp()
WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';

-- Repoint regatta_result_participants
UPDATE public.regatta_result_participants
SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee'
WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';

-- Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee'
WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee');
DELETE FROM public.sailor_aliases WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';

-- Repoint claims if any
UPDATE public.sailor_claims
SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee'
WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee');
DELETE FROM public.sailor_claims WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';

-- Repoint equipment if any
UPDATE public.equipment_items
SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee'
WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';

-- Repoint coaching records/notes if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';
  UPDATE public.parent_notes SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';
  UPDATE public.coach_squad_members SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';
  UPDATE public.coach_followed_sailors SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';
  UPDATE public.followed_sailors SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';
  DELETE FROM public.followed_sailors WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';
  UPDATE public.coach_sailor_notes SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';
  UPDATE public.coach_development_records SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '22e3d1ba-097d-4d88-b9dd-c714f5ccc639';

-- Log merge to admin_change_log
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee',
  'Abdelrahman Albahri / Abdulrahman Albahri (UAE)',
  'Merged duplicate profile 22e3d1ba-097d-4d88-b9dd-c714f5ccc639 into survivor b3cebd0e-9985-43f4-9b02-b1583bd0a9ee.',
  jsonb_build_object(
    'survivor_id', 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee',
    'merged_id', '22e3d1ba-097d-4d88-b9dd-c714f5ccc639',
    'survivor_name', 'Abdelrahman Albahri',
    'merged_name', 'Abdulrahman Albahri',
    'reason', 'UAE national youth athlete from Abu Dhabi Marine Sports Club Academy transitioning from Optimist (2023-2024) to ILCA 4 champion at Mussanah Race Week 2026.'
  ),
  'daily_audit_20261113',
  clock_timestamp()
);

-- ----------------------------------------------------------------------------
-- Merge 2: Hamad Almasoud / Almasour (KUW)
-- Survivor: b96ae292-97c1-4cf5-bc77-99edc38e06d4 (Hamad Almasoud, YOB 2010, Opti 2025)
-- Merged:   58f86abc-6e1e-4931-a865-d8ca84103ba8 (Hamad Almasour, ILCA 4 Mussanah 2026, sail 223933)
-- ----------------------------------------------------------------------------

-- Add alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b96ae292-97c1-4cf5-bc77-99edc38e06d4', 'Hamad Almasour')
ON CONFLICT (alias_name) DO NOTHING;

-- Repoint regatta_results
UPDATE public.regatta_results
SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4',
    updated_at = clock_timestamp()
WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';

-- Repoint regatta_result_participants
UPDATE public.regatta_result_participants
SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4'
WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';

-- Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4'
WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4');
DELETE FROM public.sailor_aliases WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';

-- Repoint claims if any
UPDATE public.sailor_claims
SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4'
WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4');
DELETE FROM public.sailor_claims WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';

-- Repoint equipment if any
UPDATE public.equipment_items
SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4'
WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';

-- Repoint coaching records/notes if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4' WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';
  UPDATE public.parent_notes SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4' WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';
  UPDATE public.coach_squad_members SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4' WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';
  UPDATE public.coach_followed_sailors SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4' WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';
  UPDATE public.followed_sailors SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4' WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';
  DELETE FROM public.followed_sailors WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';
  UPDATE public.coach_sailor_notes SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4' WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';
  UPDATE public.coach_development_records SET sailor_id = 'b96ae292-97c1-4cf5-bc77-99edc38e06d4' WHERE sailor_id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '58f86abc-6e1e-4931-a865-d8ca84103ba8';

-- Log merge to admin_change_log
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'b96ae292-97c1-4cf5-bc77-99edc38e06d4',
  'Hamad Almasoud / Hamad Almasour (KUW)',
  'Merged duplicate profile 58f86abc-6e1e-4931-a865-d8ca84103ba8 into survivor b96ae292-97c1-4cf5-bc77-99edc38e06d4.',
  jsonb_build_object(
    'survivor_id', 'b96ae292-97c1-4cf5-bc77-99edc38e06d4',
    'merged_id', '58f86abc-6e1e-4931-a865-d8ca84103ba8',
    'survivor_name', 'Hamad Almasoud',
    'merged_name', 'Hamad Almasour',
    'reason', 'Kuwait national sailor transitioning from Optimist (born 2010) to ILCA 4 (sail 223933) at Mussanah Race Week 2026; Almasour is an Arabic transliteration/OCR artifact.'
  ),
  'daily_audit_20261113',
  clock_timestamp()
);

-- ----------------------------------------------------------------------------
-- Merge 3: Abdulaziz / Abdullaziz Almansour (KUW)
-- Survivor: f264291a-405d-4edf-892e-0facabbee42f (Abdulaziz Almansour, YOB 2014, Opti 2025)
-- Merged:   70a91db6-a20f-46af-81dd-a202edf02e44 (Abdullaziz Almansour, Opti Mussanah 2026)
-- ----------------------------------------------------------------------------

-- Add alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f264291a-405d-4edf-892e-0facabbee42f', 'Abdullaziz Almansour')
ON CONFLICT (alias_name) DO NOTHING;

-- Repoint regatta_results
UPDATE public.regatta_results
SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f',
    updated_at = clock_timestamp()
WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';

-- Repoint regatta_result_participants
UPDATE public.regatta_result_participants
SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f'
WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';

-- Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f'
WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f');
DELETE FROM public.sailor_aliases WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';

-- Repoint claims if any
UPDATE public.sailor_claims
SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f'
WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f');
DELETE FROM public.sailor_claims WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';

-- Repoint equipment if any
UPDATE public.equipment_items
SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f'
WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';

-- Repoint coaching records/notes if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f' WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';
  UPDATE public.parent_notes SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f' WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';
  UPDATE public.coach_squad_members SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f' WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';
  UPDATE public.coach_followed_sailors SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f' WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';
  UPDATE public.followed_sailors SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f' WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';
  DELETE FROM public.followed_sailors WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';
  UPDATE public.coach_sailor_notes SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f' WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';
  UPDATE public.coach_development_records SET sailor_id = 'f264291a-405d-4edf-892e-0facabbee42f' WHERE sailor_id = '70a91db6-a20f-46af-81dd-a202edf02e44';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '70a91db6-a20f-46af-81dd-a202edf02e44';

-- Log merge to admin_change_log
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'f264291a-405d-4edf-892e-0facabbee42f',
  'Abdulaziz Almansour / Abdullaziz Almansour (KUW)',
  'Merged duplicate profile 70a91db6-a20f-46af-81dd-a202edf02e44 into survivor f264291a-405d-4edf-892e-0facabbee42f.',
  jsonb_build_object(
    'survivor_id', 'f264291a-405d-4edf-892e-0facabbee42f',
    'merged_id', '70a91db6-a20f-46af-81dd-a202edf02e44',
    'survivor_name', 'Abdulaziz Almansour',
    'merged_name', 'Abdullaziz Almansour',
    'reason', 'Kuwait youth national squad Optimist sailor competing at 2025 Asian & Oceanian Championship and Mussanah Race Week 2026; spelling variant with double l.'
  ),
  'daily_audit_20261113',
  clock_timestamp()
);

-- ----------------------------------------------------------------------------
-- Merge 4: Zakaria / Zakareya Bohamad (KUW)
-- Survivor: 4e8d7fca-e9b8-46e4-8541-cccaed77eb10 (Zakareya Bohamad, YOB 2016, Opti 2025-2026)
-- Merged:   550c8cfa-6dbd-42a0-9486-ed91d3ab0829 (Zakaria Bohamad, Opti Mussanah 2026)
-- ----------------------------------------------------------------------------

-- Add alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4e8d7fca-e9b8-46e4-8541-cccaed77eb10', 'Zakaria Bohamad')
ON CONFLICT (alias_name) DO NOTHING;

-- Repoint regatta_results
UPDATE public.regatta_results
SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10',
    updated_at = clock_timestamp()
WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';

-- Repoint regatta_result_participants
UPDATE public.regatta_result_participants
SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10'
WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';

-- Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10'
WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10');
DELETE FROM public.sailor_aliases WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';

-- Repoint claims if any
UPDATE public.sailor_claims
SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10'
WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10');
DELETE FROM public.sailor_claims WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';

-- Repoint equipment if any
UPDATE public.equipment_items
SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10'
WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';

-- Repoint coaching records/notes if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10' WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';
  UPDATE public.parent_notes SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10' WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';
  UPDATE public.coach_squad_members SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10' WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';
  UPDATE public.coach_followed_sailors SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10' WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';
  UPDATE public.followed_sailors SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10' WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';
  DELETE FROM public.followed_sailors WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';
  UPDATE public.coach_sailor_notes SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10' WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';
  UPDATE public.coach_development_records SET sailor_id = '4e8d7fca-e9b8-46e4-8541-cccaed77eb10' WHERE sailor_id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '550c8cfa-6dbd-42a0-9486-ed91d3ab0829';

-- Log merge to admin_change_log
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '4e8d7fca-e9b8-46e4-8541-cccaed77eb10',
  'Zakareya Bohamad / Zakaria Bohamad (KUW)',
  'Merged duplicate profile 550c8cfa-6dbd-42a0-9486-ed91d3ab0829 into survivor 4e8d7fca-e9b8-46e4-8541-cccaed77eb10.',
  jsonb_build_object(
    'survivor_id', '4e8d7fca-e9b8-46e4-8541-cccaed77eb10',
    'merged_id', '550c8cfa-6dbd-42a0-9486-ed91d3ab0829',
    'survivor_name', 'Zakareya Bohamad',
    'merged_name', 'Zakaria Bohamad',
    'reason', 'Kuwait junior Optimist national sailor winning silver in Junior category at Mussanah Race Week 2026; Zakareya and Zakaria are transliteration variants of زكريا.'
  ),
  'daily_audit_20261113',
  clock_timestamp()
);

-- ----------------------------------------------------------------------------
-- Merge 5: Ali Enki (KUW)
-- Survivor: d4f28d24-04a7-57fd-bdb4-96e9541efe95 (Ali Enki, YOB 2011, Opti Silver 2025)
-- Merged:   9ce31233-af22-42bd-81b0-b753d68f9fdc (Ali Enki, ILCA 6 Mussanah 2026)
-- ----------------------------------------------------------------------------

-- Repoint regatta_results
UPDATE public.regatta_results
SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95',
    updated_at = clock_timestamp()
WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';

-- Repoint regatta_result_participants
UPDATE public.regatta_result_participants
SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95'
WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';

-- Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95'
WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95');
DELETE FROM public.sailor_aliases WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';

-- Repoint claims if any
UPDATE public.sailor_claims
SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95'
WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95');
DELETE FROM public.sailor_claims WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';

-- Repoint equipment if any
UPDATE public.equipment_items
SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95'
WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';

-- Repoint coaching records/notes if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95' WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';
  UPDATE public.parent_notes SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95' WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';
  UPDATE public.coach_squad_members SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95' WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';
  UPDATE public.coach_followed_sailors SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95' WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';
  UPDATE public.followed_sailors SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95' WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';
  DELETE FROM public.followed_sailors WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';
  UPDATE public.coach_sailor_notes SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95' WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';
  UPDATE public.coach_development_records SET sailor_id = 'd4f28d24-04a7-57fd-bdb4-96e9541efe95' WHERE sailor_id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '9ce31233-af22-42bd-81b0-b753d68f9fdc';

-- Log merge to admin_change_log
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  'd4f28d24-04a7-57fd-bdb4-96e9541efe95',
  'Ali Enki (KUW)',
  'Merged duplicate profile 9ce31233-af22-42bd-81b0-b753d68f9fdc into survivor d4f28d24-04a7-57fd-bdb4-96e9541efe95.',
  jsonb_build_object(
    'survivor_id', 'd4f28d24-04a7-57fd-bdb4-96e9541efe95',
    'merged_id', '9ce31233-af22-42bd-81b0-b753d68f9fdc',
    'survivor_name', 'Ali Enki',
    'merged_name', 'Ali Enki',
    'reason', 'Kuwait youth national sailor (born 2011) progressing from Optimist (2025) to ILCA 6 at Mussanah Race Week 2026.'
  ),
  'daily_audit_20261113',
  clock_timestamp()
);

-- ============================================================================
-- 2. UPDATE RESULT IMPORT MONITORS FOR FULLY CORROBORATED EVENTS
-- ============================================================================

UPDATE public.result_import_monitors
SET report = jsonb_set(
      jsonb_set(report, '{status}', '"reviewed"'),
      '{pdfCorroboration}', '"verified"'
    )
WHERE event_id IN (
  '4e02379f-9d68-45e3-9a09-de0ff3aa4702', -- 18th Eastern Seaboard Regatta 2026
  '8d8bbdc1-a75a-4d3b-ab7c-275bc078b6b9', -- 22nd Botchan Cup 2026
  '25eaa021-d579-4db6-adef-8450d57ca77f', -- X-15 World Championships 2026
  'dd16f02b-2b0a-48bd-b058-5b5ee9f39b11', -- Japan Youth Worlds Selection Regatta 2026
  '76502024-d455-4a18-98fb-bb329a17e6e7', -- RSYC Optimist Silver Knockout 2026
  '5d1c38fe-f2cd-41bc-bb24-a2d8af62ef8b', -- RSYC Optimist Gold Knockout 2026
  'a9c9af76-240d-4a4b-950b-de5ea77dc495'  -- Kaohsiung Lotus Pond Optimist Regatta 2026
);

COMMIT;
"""

output_path = "src/db/migrations/20261113091500_consolidate_regional_merges_and_monitors.sql"
with open(output_path, "w") as f:
    f.write(migration_content)

print(f"Generated {output_path}")
