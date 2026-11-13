#!/usr/bin/env python3
"""Generate migration for approved daily audit tasks:
1. Register 2 new keep-separate pairs in admin_change_log.
2. Consolidate 2 verified duplicate sailor pairs (Ya Zhang, Laila Mohamed).
"""

import sys

migration_content = """-- Migration: 20261113091000_daily_audit_merges_and_keep_separates.sql
-- Description: Register 2 confirmed keep-separate pairs and consolidate 2 verified duplicate sailor profiles.
-- Approved by user during daily scheduled data scan.

BEGIN;

-- ============================================================================
-- 1. KEEP-SEPARATE REGISTRATIONS (2 PAIRS)
-- ============================================================================

-- Keep-separate: Aran Klangmueang / Aranya Klangmueang
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '07bf0465-389d-5487-b6f7-b248a3cb859b',
  'Aran Klangmueang / Aranya Klangmueang',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '07bf0465-389d-5487-b6f7-b248a3cb859b|9122c3b5-7b7d-43c1-ab7b-c5d2d2f2fb96',
    'reason', 'Distinct athletes: Thai brother/sister youth sailors from Yacht Racing Association of Thailand (YRAT) who competed head-to-head in Children''s Day Regatta 2025 — Optimist Silver on 2025-01-17 (Rank 20 THA1903 vs Rank 25 THA1775).'
  ),
  'daily_audit_20261113',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '07bf0465-389d-5487-b6f7-b248a3cb859b|9122c3b5-7b7d-43c1-ab7b-c5d2d2f2fb96'
);

-- Keep-separate: Alkhalil Ibrahim Al Amri / Alkhalil Ibrahim Al Fori
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '069a5317-e290-4e4a-a9e1-75ac7ea646fc',
  'Alkhalil Ibrahim Al Amri / Alkhalil Ibrahim Al Fori',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '069a5317-e290-4e4a-a9e1-75ac7ea646fc|a09cd932-c0d6-4dc6-b72a-da5b8162c1fe',
    'reason', 'Distinct athletes: Omani youth sailors from distinct families/tribes who competed head-to-head in Mussanah Race Week 2026 (Optimist) on 2026-10-15 under sail numbers 1 vs 316.'
  ),
  'daily_audit_20261113',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '069a5317-e290-4e4a-a9e1-75ac7ea646fc|a09cd932-c0d6-4dc6-b72a-da5b8162c1fe'
);

-- ============================================================================
-- 2. PROFILE MERGE 1: Ya Zhang (CHN)
-- Survivor: 51a8b92d-74d1-52a1-bf87-4328eb92040c (ACDC Cup 2025, CHN122, Qingdao)
-- Merged:   fb90d81d-fee0-5545-81ce-a65f75e0acfe (Victorian Champs 2025, CHN122, Qingdao)
-- ============================================================================

-- Repoint regatta_results
UPDATE public.regatta_results
SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c',
    updated_at = clock_timestamp()
WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';

-- Repoint regatta_result_participants
UPDATE public.regatta_result_participants
SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c'
WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';

-- Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c'
WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c');
DELETE FROM public.sailor_aliases WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';

-- Repoint claims if any
UPDATE public.sailor_claims
SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c'
WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c');
DELETE FROM public.sailor_claims WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';

-- Repoint equipment if any
UPDATE public.equipment_items
SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c'
WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';

-- Repoint coaching records/notes if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c' WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';
  UPDATE public.parent_notes SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c' WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';
  UPDATE public.coach_squad_members SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c' WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';
  DELETE FROM public.coach_squad_members WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';
  UPDATE public.coach_followed_sailors SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c' WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';
  UPDATE public.followed_sailors SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c' WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';
  DELETE FROM public.followed_sailors WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';
  UPDATE public.coach_sailor_notes SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c' WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';
  UPDATE public.coach_development_records SET sailor_id = '51a8b92d-74d1-52a1-bf87-4328eb92040c' WHERE sailor_id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe';

-- Log merge to admin_change_log
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '51a8b92d-74d1-52a1-bf87-4328eb92040c',
  'Ya Zhang (CHN / Qingdao)',
  'Merged duplicate profile fb90d81d-fee0-5545-81ce-a65f75e0acfe into survivor 51a8b92d-74d1-52a1-bf87-4328eb92040c.',
  jsonb_build_object(
    'survivor_id', '51a8b92d-74d1-52a1-bf87-4328eb92040c',
    'merged_id', 'fb90d81d-fee0-5545-81ce-a65f75e0acfe',
    'survivor_name', 'Ya Zhang',
    'merged_name', 'Ya Zhang',
    'reason', 'Duplicate profiles for Chinese youth sailor from Qingdao sailing under CHN122 in 2025 Optimist events.'
  ),
  'daily_audit_20261113',
  clock_timestamp()
);

-- ============================================================================
-- 3. PROFILE MERGE 2: Laila Mohamed Diaaeldin Mohamed Abdelazim (EGY)
-- Survivor: 69a5a030-5918-56ed-823a-8682ebf7baf3 (2026 Worlds, EGY 725)
-- Merged:   8f088b4d-6c49-4d10-931a-0ddbaa173218 (Mussanah 2026, 725)
-- ============================================================================

-- Add alias on survivor for shortened regatta entry name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('69a5a030-5918-56ed-823a-8682ebf7baf3', 'Laila Mohamed')
ON CONFLICT (alias_name) DO NOTHING;

-- Repoint regatta_results
UPDATE public.regatta_results
SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3',
    updated_at = clock_timestamp()
WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';

-- Repoint regatta_result_participants
UPDATE public.regatta_result_participants
SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3'
WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';

-- Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3'
WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3');
DELETE FROM public.sailor_aliases WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';

-- Repoint claims if any
UPDATE public.sailor_claims
SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3'
WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3');
DELETE FROM public.sailor_claims WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';

-- Repoint equipment if any
UPDATE public.equipment_items
SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3'
WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';

-- Repoint coaching records/notes if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3' WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';
  UPDATE public.parent_notes SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3' WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';
  UPDATE public.coach_squad_members SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3' WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';
  UPDATE public.coach_followed_sailors SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3' WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';
  UPDATE public.followed_sailors SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3' WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';
  DELETE FROM public.followed_sailors WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';
  UPDATE public.coach_sailor_notes SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3' WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';
  UPDATE public.coach_development_records SET sailor_id = '69a5a030-5918-56ed-823a-8682ebf7baf3' WHERE sailor_id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '8f088b4d-6c49-4d10-931a-0ddbaa173218';

-- Log merge to admin_change_log
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.merge',
  'sailor',
  '69a5a030-5918-56ed-823a-8682ebf7baf3',
  'Laila Mohamed Diaaeldin Mohamed Abdelazim (EGY)',
  'Merged duplicate profile 8f088b4d-6c49-4d10-931a-0ddbaa173218 (Laila Mohamed) into survivor 69a5a030-5918-56ed-823a-8682ebf7baf3.',
  jsonb_build_object(
    'survivor_id', '69a5a030-5918-56ed-823a-8682ebf7baf3',
    'merged_id', '8f088b4d-6c49-4d10-931a-0ddbaa173218',
    'survivor_name', 'Laila Mohamed Diaaeldin Mohamed Abdelazim',
    'merged_name', 'Laila Mohamed',
    'reason', 'Duplicate profiles for Egyptian Optimist sailor sailing under sail 725 / EGY 725 at 2026 Optimist Worlds and Mussanah Race Week 2026.'
  ),
  'daily_audit_20261113',
  clock_timestamp()
);

COMMIT;
"""

output_path = "src/db/migrations/20261113091000_daily_audit_merges_and_keep_separates.sql"
with open(output_path, "w") as f:
    f.write(migration_content)

print(f"Generated {output_path}")
