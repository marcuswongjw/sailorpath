-- Migration: 20261118101000_daily_audit_enrichments_merges_and_monitors.sql
-- Description: Daily audit (2026-11-18) verified demographic enrichments, gender/nationality fixes,
--              27 duplicate sailor merges, 10 keep-separate registrations, monitor updates,
--              SNSC 2026 official result URLs, and SNSC 2026 Gold 6-race Index fix.

BEGIN;

-- ============================================================================
-- 1. VERIFIED DEMOGRAPHIC ENRICHMENTS & CORRECTIONS
-- ============================================================================

-- Lara Dorling (AUS 1729) -> F (82460.12 (Optimist Open))
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = 'a68e8e7f-d347-5326-a405-7f795be50f87' AND (gender IS NULL OR gender = '');
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = 'a68e8e7f-d347-5326-a405-7f795be50f87' AND (gender IS NULL OR gender = '');
-- Laura OHara (AUS 1214) -> F (82460.12 (Optimist Open))
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '23b717b1-7d59-5014-b1ae-3358bf3e8445' AND (gender IS NULL OR gender = '');
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = '23b717b1-7d59-5014-b1ae-3358bf3e8445' AND (gender IS NULL OR gender = '');
-- Willow Murray (AUS 1863) -> F (82460.12 (Optimist Open))
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = 'c720156e-a4fc-5c44-8505-4ad78bb60d73' AND (gender IS NULL OR gender = '');
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = 'c720156e-a4fc-5c44-8505-4ad78bb60d73' AND (gender IS NULL OR gender = '');
-- Amelia McKelvey (AUS 162) -> F (82460.11 (Optimist Intermediate))
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '0f1dbaf1-c074-5cba-9abc-c91bdde4434f' AND (gender IS NULL OR gender = '');
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = '0f1dbaf1-c074-5cba-9abc-c91bdde4434f' AND (gender IS NULL OR gender = '');
-- Ebba Nixey (AUS 1786) -> F (82460.11 (Optimist Intermediate))
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '97f0b854-923f-5124-9cfa-8360389bc308' AND (gender IS NULL OR gender = '');
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = '97f0b854-923f-5124-9cfa-8360389bc308' AND (gender IS NULL OR gender = '');
-- Ellery Chai (AUS 1078) -> F (82460.11 (Optimist Intermediate))
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '6809147a-acdc-5a68-9d3a-a6ff1f4ecd6e' AND (gender IS NULL OR gender = '');
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = '6809147a-acdc-5a68-9d3a-a6ff1f4ecd6e' AND (gender IS NULL OR gender = '');
-- Maelyn Gilchrist (AUS 1624) -> F (82460.11 (Optimist Intermediate))
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = 'dd86222a-4380-55f0-b7c9-f727b6f32f65' AND (gender IS NULL OR gender = '');
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = 'dd86222a-4380-55f0-b7c9-f727b6f32f65' AND (gender IS NULL OR gender = '');
-- Molly O'Donnell (AUS 48) -> F (82460.11 (Optimist Intermediate))
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '98067f40-3792-57bb-9716-fc7bca16d664' AND (gender IS NULL OR gender = '');
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = '98067f40-3792-57bb-9716-fc7bca16d664' AND (gender IS NULL OR gender = '');
-- Sylvia Carlson (AUS 1236) -> F (82460.11 (Optimist Intermediate))
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '9b4f7a85-aa7d-5d77-9cd7-afb06469bc69' AND (gender IS NULL OR gender = '');
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = '9b4f7a85-aa7d-5d77-9cd7-afb06469bc69' AND (gender IS NULL OR gender = '');

-- Songha Lee (KOR 223204): M -> F (2026 ILCA 4 Youth Worlds Girls, 2026 LYSC ILCA 4 Women, 2026 Asian Games Girls Bronze)
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d';
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d' AND gender IS DISTINCT FROM 'F';

-- En-Rui Hsu (TPE 208532): M -> F (115th President's Cup ILCA 4 Girls 女子組, 2024 Asians)
UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '70371bac-6222-4625-8df8-296f67f622dc';
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = '70371bac-6222-4625-8df8-296f67f622dc' AND gender IS DISTINCT FROM 'F';

-- Sync rsyc-2026-silver result-level gender for An Hu & Yu An Li (both F)
UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp()
WHERE sailor_id IN ('0d6be542-5e52-496c-b9e9-cb30fb83b218', '05a5835e-9845-4a66-9357-c901f95ecea7') AND gender IS DISTINCT FROM 'F';

-- Ethan Kiu & Zihan Liu: override auto-guessed SGP nationality_from_sail -> HKG (HKSI)
UPDATE public.sailors SET nationality = 'HKG', nationality_from_sail = false, updated_at = clock_timestamp()
WHERE id IN ('abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3');

-- ============================================================================
-- 2. MERGE 27 VERIFIED DUPLICATE SAILOR PAIRS
-- ============================================================================

-- Merge Alexandros Seiko Thomaidis: f64c17d3-dbd0-57b1-a8dc-24c13826fbe0 -> 513cb803-c254-5aa2-9e32-f0f84e91c476
UPDATE public.regatta_results
SET sailor_id = '513cb803-c254-5aa2-9e32-f0f84e91c476', updated_at = clock_timestamp()
WHERE sailor_id = 'f64c17d3-dbd0-57b1-a8dc-24c13826fbe0'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '513cb803-c254-5aa2-9e32-f0f84e91c476' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '513cb803-c254-5aa2-9e32-f0f84e91c476', updated_at = clock_timestamp()
WHERE sailor_id = 'f64c17d3-dbd0-57b1-a8dc-24c13826fbe0';
UPDATE public.sailor_aliases
SET sailor_id = '513cb803-c254-5aa2-9e32-f0f84e91c476'
WHERE sailor_id = 'f64c17d3-dbd0-57b1-a8dc-24c13826fbe0'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '513cb803-c254-5aa2-9e32-f0f84e91c476' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '513cb803-c254-5aa2-9e32-f0f84e91c476', updated_at = clock_timestamp()
WHERE sailor_id = 'f64c17d3-dbd0-57b1-a8dc-24c13826fbe0';
DELETE FROM public.sailors WHERE id = 'f64c17d3-dbd0-57b1-a8dc-24c13826fbe0';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '513cb803-c254-5aa2-9e32-f0f84e91c476', 'Alexandros Seiko Thomaidis',
  'Merged duplicate profile f64c17d3-dbd0-57b1-a8dc-24c13826fbe0 into 513cb803-c254-5aa2-9e32-f0f84e91c476.',
  jsonb_build_object('survivorId', '513cb803-c254-5aa2-9e32-f0f84e91c476', 'mergedId', 'f64c17d3-dbd0-57b1-a8dc-24c13826fbe0', 'reason', 'Same Greek athlete (GRE3231 / GRE5) with reversed surname order at R.O.C. 2026.'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '513cb803-c254-5aa2-9e32-f0f84e91c476');

-- Merge Carl Birgersson: 618bac98-6dcb-5c94-b553-3b827d12f461 -> 691e47b3-3ada-582b-a8e6-576466fdffbc
UPDATE public.regatta_results
SET sailor_id = '691e47b3-3ada-582b-a8e6-576466fdffbc', updated_at = clock_timestamp()
WHERE sailor_id = '618bac98-6dcb-5c94-b553-3b827d12f461'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '691e47b3-3ada-582b-a8e6-576466fdffbc' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '691e47b3-3ada-582b-a8e6-576466fdffbc', updated_at = clock_timestamp()
WHERE sailor_id = '618bac98-6dcb-5c94-b553-3b827d12f461';
UPDATE public.sailor_aliases
SET sailor_id = '691e47b3-3ada-582b-a8e6-576466fdffbc'
WHERE sailor_id = '618bac98-6dcb-5c94-b553-3b827d12f461'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '691e47b3-3ada-582b-a8e6-576466fdffbc' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '691e47b3-3ada-582b-a8e6-576466fdffbc', updated_at = clock_timestamp()
WHERE sailor_id = '618bac98-6dcb-5c94-b553-3b827d12f461';
DELETE FROM public.sailors WHERE id = '618bac98-6dcb-5c94-b553-3b827d12f461';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '691e47b3-3ada-582b-a8e6-576466fdffbc', 'Carl Birgersson',
  'Merged duplicate profile 618bac98-6dcb-5c94-b553-3b827d12f461 into 691e47b3-3ada-582b-a8e6-576466fdffbc.',
  jsonb_build_object('survivorId', '691e47b3-3ada-582b-a8e6-576466fdffbc', 'mergedId', '618bac98-6dcb-5c94-b553-3b827d12f461', 'reason', 'Same athlete (SWE 4946 / DEN 2 / DEN8756) across 2024 Kosmos, 2025 R.O.C., and 2026 Worlds.'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '691e47b3-3ada-582b-a8e6-576466fdffbc');

-- Merge Ethan Kiu: d00ec375-6dc8-55f8-8b0e-9505719e0f4e -> abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6
UPDATE public.regatta_results
SET sailor_id = 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', updated_at = clock_timestamp()
WHERE sailor_id = 'd00ec375-6dc8-55f8-8b0e-9505719e0f4e'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', updated_at = clock_timestamp()
WHERE sailor_id = 'd00ec375-6dc8-55f8-8b0e-9505719e0f4e';
UPDATE public.sailor_aliases
SET sailor_id = 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6'
WHERE sailor_id = 'd00ec375-6dc8-55f8-8b0e-9505719e0f4e'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', updated_at = clock_timestamp()
WHERE sailor_id = 'd00ec375-6dc8-55f8-8b0e-9505719e0f4e';
DELETE FROM public.sailors WHERE id = 'd00ec375-6dc8-55f8-8b0e-9505719e0f4e';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', 'Ethan Kiu',
  'Merged duplicate profile d00ec375-6dc8-55f8-8b0e-9505719e0f4e into abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6.',
  jsonb_build_object('survivorId', 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', 'mergedId', 'd00ec375-6dc8-55f8-8b0e-9505719e0f4e', 'reason', 'Same HKSI/RHKYC athlete sailing under HKG 506 in SNSC 2023 and 2024 Kosmos.'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6');

-- Merge Giorgos Papavasileiou: 1e650ba8-9500-5942-972b-7b5e6e7ac8c4 -> 8ece753b-6d66-acf3-f6c0-f7b73cef8100
UPDATE public.regatta_results
SET sailor_id = '8ece753b-6d66-acf3-f6c0-f7b73cef8100', updated_at = clock_timestamp()
WHERE sailor_id = '1e650ba8-9500-5942-972b-7b5e6e7ac8c4'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '8ece753b-6d66-acf3-f6c0-f7b73cef8100' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '8ece753b-6d66-acf3-f6c0-f7b73cef8100', updated_at = clock_timestamp()
WHERE sailor_id = '1e650ba8-9500-5942-972b-7b5e6e7ac8c4';
UPDATE public.sailor_aliases
SET sailor_id = '8ece753b-6d66-acf3-f6c0-f7b73cef8100'
WHERE sailor_id = '1e650ba8-9500-5942-972b-7b5e6e7ac8c4'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '8ece753b-6d66-acf3-f6c0-f7b73cef8100' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '8ece753b-6d66-acf3-f6c0-f7b73cef8100', updated_at = clock_timestamp()
WHERE sailor_id = '1e650ba8-9500-5942-972b-7b5e6e7ac8c4';
DELETE FROM public.sailors WHERE id = '1e650ba8-9500-5942-972b-7b5e6e7ac8c4';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '8ece753b-6d66-acf3-f6c0-f7b73cef8100', 'Giorgos Papavasileiou',
  'Merged duplicate profile 1e650ba8-9500-5942-972b-7b5e6e7ac8c4 into 8ece753b-6d66-acf3-f6c0-f7b73cef8100.',
  jsonb_build_object('survivorId', '8ece753b-6d66-acf3-f6c0-f7b73cef8100', 'mergedId', '1e650ba8-9500-5942-972b-7b5e6e7ac8c4', 'reason', 'Same athlete (GRE3161 -> MON 227175) across 2024 Kosmos and 2026 ILCA 4 Youth Worlds.'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '8ece753b-6d66-acf3-f6c0-f7b73cef8100');

-- Merge Luca Nueschen: 6884967e-5f08-59ac-82dd-05f8a1e04465 -> 8209fc88-14a4-5642-a10e-b99459c49348
UPDATE public.regatta_results
SET sailor_id = '8209fc88-14a4-5642-a10e-b99459c49348', updated_at = clock_timestamp()
WHERE sailor_id = '6884967e-5f08-59ac-82dd-05f8a1e04465'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '8209fc88-14a4-5642-a10e-b99459c49348' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '8209fc88-14a4-5642-a10e-b99459c49348', updated_at = clock_timestamp()
WHERE sailor_id = '6884967e-5f08-59ac-82dd-05f8a1e04465';
UPDATE public.sailor_aliases
SET sailor_id = '8209fc88-14a4-5642-a10e-b99459c49348'
WHERE sailor_id = '6884967e-5f08-59ac-82dd-05f8a1e04465'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '8209fc88-14a4-5642-a10e-b99459c49348' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '8209fc88-14a4-5642-a10e-b99459c49348', updated_at = clock_timestamp()
WHERE sailor_id = '6884967e-5f08-59ac-82dd-05f8a1e04465';
DELETE FROM public.sailors WHERE id = '6884967e-5f08-59ac-82dd-05f8a1e04465';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '8209fc88-14a4-5642-a10e-b99459c49348', 'Luca Nueschen',
  'Merged duplicate profile 6884967e-5f08-59ac-82dd-05f8a1e04465 into 8209fc88-14a4-5642-a10e-b99459c49348.',
  jsonb_build_object('survivorId', '8209fc88-14a4-5642-a10e-b99459c49348', 'mergedId', '6884967e-5f08-59ac-82dd-05f8a1e04465', 'reason', 'Same athlete (USA23661 charter at 2024 Kosmos -> ESP 3733 at 2026 Europeans).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '8209fc88-14a4-5642-a10e-b99459c49348');

-- Merge Mark Slotboom: beb0f823-82d4-595b-af29-0592606fefc9 -> fb1901c9-319b-8180-7310-a0ba953118d3
UPDATE public.regatta_results
SET sailor_id = 'fb1901c9-319b-8180-7310-a0ba953118d3', updated_at = clock_timestamp()
WHERE sailor_id = 'beb0f823-82d4-595b-af29-0592606fefc9'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = 'fb1901c9-319b-8180-7310-a0ba953118d3' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = 'fb1901c9-319b-8180-7310-a0ba953118d3', updated_at = clock_timestamp()
WHERE sailor_id = 'beb0f823-82d4-595b-af29-0592606fefc9';
UPDATE public.sailor_aliases
SET sailor_id = 'fb1901c9-319b-8180-7310-a0ba953118d3'
WHERE sailor_id = 'beb0f823-82d4-595b-af29-0592606fefc9'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = 'fb1901c9-319b-8180-7310-a0ba953118d3' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'fb1901c9-319b-8180-7310-a0ba953118d3', updated_at = clock_timestamp()
WHERE sailor_id = 'beb0f823-82d4-595b-af29-0592606fefc9';
DELETE FROM public.sailors WHERE id = 'beb0f823-82d4-595b-af29-0592606fefc9';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', 'fb1901c9-319b-8180-7310-a0ba953118d3', 'Mark Slotboom',
  'Merged duplicate profile beb0f823-82d4-595b-af29-0592606fefc9 into fb1901c9-319b-8180-7310-a0ba953118d3.',
  jsonb_build_object('survivorId', 'fb1901c9-319b-8180-7310-a0ba953118d3', 'mergedId', 'beb0f823-82d4-595b-af29-0592606fefc9', 'reason', 'Same Yacht Club de Monaco athlete (GRE3081 charter at 2025 Kosmos -> MON 221163).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = 'fb1901c9-319b-8180-7310-a0ba953118d3');

-- Merge Maryam Consolini: b14c9b83-610d-5762-ba00-99b8b05d52d9 -> cf755c52-e110-54fa-b05f-84b31fd1e84c
UPDATE public.regatta_results
SET sailor_id = 'cf755c52-e110-54fa-b05f-84b31fd1e84c', updated_at = clock_timestamp()
WHERE sailor_id = 'b14c9b83-610d-5762-ba00-99b8b05d52d9'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = 'cf755c52-e110-54fa-b05f-84b31fd1e84c' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = 'cf755c52-e110-54fa-b05f-84b31fd1e84c', updated_at = clock_timestamp()
WHERE sailor_id = 'b14c9b83-610d-5762-ba00-99b8b05d52d9';
UPDATE public.sailor_aliases
SET sailor_id = 'cf755c52-e110-54fa-b05f-84b31fd1e84c'
WHERE sailor_id = 'b14c9b83-610d-5762-ba00-99b8b05d52d9'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = 'cf755c52-e110-54fa-b05f-84b31fd1e84c' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'cf755c52-e110-54fa-b05f-84b31fd1e84c', updated_at = clock_timestamp()
WHERE sailor_id = 'b14c9b83-610d-5762-ba00-99b8b05d52d9';
DELETE FROM public.sailors WHERE id = 'b14c9b83-610d-5762-ba00-99b8b05d52d9';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', 'cf755c52-e110-54fa-b05f-84b31fd1e84c', 'Maryam Consolini',
  'Merged duplicate profile b14c9b83-610d-5762-ba00-99b8b05d52d9 into cf755c52-e110-54fa-b05f-84b31fd1e84c.',
  jsonb_build_object('survivorId', 'cf755c52-e110-54fa-b05f-84b31fd1e84c', 'mergedId', 'b14c9b83-610d-5762-ba00-99b8b05d52d9', 'reason', 'Same athlete (ITA249 -> MAR 127) across 2025 Kosmos and 2026 Worlds.'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = 'cf755c52-e110-54fa-b05f-84b31fd1e84c');

-- Merge Nikole Victoria Douglass: 0179f2ce-0a77-5da6-bd83-9e98b6ec9101 -> bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48
UPDATE public.regatta_results
SET sailor_id = 'bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48', updated_at = clock_timestamp()
WHERE sailor_id = '0179f2ce-0a77-5da6-bd83-9e98b6ec9101'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = 'bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = 'bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48', updated_at = clock_timestamp()
WHERE sailor_id = '0179f2ce-0a77-5da6-bd83-9e98b6ec9101';
UPDATE public.sailor_aliases
SET sailor_id = 'bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48'
WHERE sailor_id = '0179f2ce-0a77-5da6-bd83-9e98b6ec9101'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = 'bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48', updated_at = clock_timestamp()
WHERE sailor_id = '0179f2ce-0a77-5da6-bd83-9e98b6ec9101';
DELETE FROM public.sailors WHERE id = '0179f2ce-0a77-5da6-bd83-9e98b6ec9101';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', 'bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48', 'Nikole Victoria Douglass',
  'Merged duplicate profile 0179f2ce-0a77-5da6-bd83-9e98b6ec9101 into bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48.',
  jsonb_build_object('survivorId', 'bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48', 'mergedId', '0179f2ce-0a77-5da6-bd83-9e98b6ec9101', 'reason', 'Same athlete (ESP3111 -> UKR 317) across 2025 Kosmos, 2026 Worlds, and 2026 R.O.C.'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = 'bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48');

-- Merge Toprak Caglayan: b8a5d0ac-8d18-4dde-b5d8-a21d950c75fe -> 9947ea73-32cb-5599-a5b8-6410fa10d206
UPDATE public.regatta_results
SET sailor_id = '9947ea73-32cb-5599-a5b8-6410fa10d206', updated_at = clock_timestamp()
WHERE sailor_id = 'b8a5d0ac-8d18-4dde-b5d8-a21d950c75fe'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '9947ea73-32cb-5599-a5b8-6410fa10d206' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '9947ea73-32cb-5599-a5b8-6410fa10d206', updated_at = clock_timestamp()
WHERE sailor_id = 'b8a5d0ac-8d18-4dde-b5d8-a21d950c75fe';
UPDATE public.sailor_aliases
SET sailor_id = '9947ea73-32cb-5599-a5b8-6410fa10d206'
WHERE sailor_id = 'b8a5d0ac-8d18-4dde-b5d8-a21d950c75fe'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '9947ea73-32cb-5599-a5b8-6410fa10d206' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '9947ea73-32cb-5599-a5b8-6410fa10d206', updated_at = clock_timestamp()
WHERE sailor_id = 'b8a5d0ac-8d18-4dde-b5d8-a21d950c75fe';
DELETE FROM public.sailors WHERE id = 'b8a5d0ac-8d18-4dde-b5d8-a21d950c75fe';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '9947ea73-32cb-5599-a5b8-6410fa10d206', 'Toprak Caglayan',
  'Merged duplicate profile b8a5d0ac-8d18-4dde-b5d8-a21d950c75fe into 9947ea73-32cb-5599-a5b8-6410fa10d206.',
  jsonb_build_object('survivorId', '9947ea73-32cb-5599-a5b8-6410fa10d206', 'mergedId', 'b8a5d0ac-8d18-4dde-b5d8-a21d950c75fe', 'reason', 'Same athlete (TUR1123 at 2024 Kosmos -> Team Abu Dhabi UAE 217415 at 2026 Mussanah).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '9947ea73-32cb-5599-a5b8-6410fa10d206');

-- Merge Youjia Xu: 7ec7f344-b352-5fb5-beb1-324dfe74025e -> 31b6b1e2-632c-48c2-bd63-3cb98fcefd31
UPDATE public.regatta_results
SET sailor_id = '31b6b1e2-632c-48c2-bd63-3cb98fcefd31', updated_at = clock_timestamp()
WHERE sailor_id = '7ec7f344-b352-5fb5-beb1-324dfe74025e'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '31b6b1e2-632c-48c2-bd63-3cb98fcefd31' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '31b6b1e2-632c-48c2-bd63-3cb98fcefd31', updated_at = clock_timestamp()
WHERE sailor_id = '7ec7f344-b352-5fb5-beb1-324dfe74025e';
UPDATE public.sailor_aliases
SET sailor_id = '31b6b1e2-632c-48c2-bd63-3cb98fcefd31'
WHERE sailor_id = '7ec7f344-b352-5fb5-beb1-324dfe74025e'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '31b6b1e2-632c-48c2-bd63-3cb98fcefd31' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '31b6b1e2-632c-48c2-bd63-3cb98fcefd31', updated_at = clock_timestamp()
WHERE sailor_id = '7ec7f344-b352-5fb5-beb1-324dfe74025e';
DELETE FROM public.sailors WHERE id = '7ec7f344-b352-5fb5-beb1-324dfe74025e';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '31b6b1e2-632c-48c2-bd63-3cb98fcefd31', 'Youjia Xu',
  'Merged duplicate profile 7ec7f344-b352-5fb5-beb1-324dfe74025e into 31b6b1e2-632c-48c2-bd63-3cb98fcefd31.',
  jsonb_build_object('survivorId', '31b6b1e2-632c-48c2-bd63-3cb98fcefd31', 'mergedId', '7ec7f344-b352-5fb5-beb1-324dfe74025e', 'reason', 'Same athlete (CHN 272 / GRE3083 charter at 2026 Kosmos, identical DOB 2011-01-01).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '31b6b1e2-632c-48c2-bd63-3cb98fcefd31');

-- Merge Zihan Liu: 042e1398-2b8b-5dc5-943c-9b5024b549a7 -> 3ecd12a0-9c8f-42e7-adfe-1094e760c0b3
UPDATE public.regatta_results
SET sailor_id = '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3', updated_at = clock_timestamp()
WHERE sailor_id = '042e1398-2b8b-5dc5-943c-9b5024b549a7'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3', updated_at = clock_timestamp()
WHERE sailor_id = '042e1398-2b8b-5dc5-943c-9b5024b549a7';
UPDATE public.sailor_aliases
SET sailor_id = '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3'
WHERE sailor_id = '042e1398-2b8b-5dc5-943c-9b5024b549a7'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3', updated_at = clock_timestamp()
WHERE sailor_id = '042e1398-2b8b-5dc5-943c-9b5024b549a7';
DELETE FROM public.sailors WHERE id = '042e1398-2b8b-5dc5-943c-9b5024b549a7';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3', 'Zihan Liu',
  'Merged duplicate profile 042e1398-2b8b-5dc5-943c-9b5024b549a7 into 3ecd12a0-9c8f-42e7-adfe-1094e760c0b3.',
  jsonb_build_object('survivorId', '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3', 'mergedId', '042e1398-2b8b-5dc5-943c-9b5024b549a7', 'reason', 'Same HKSI athlete sailing under HKG 253 in SNSC 2023, 2023 Asians, and 2024 Kosmos.'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3');

-- Merge Nicolas Rigas Charalambous: e239a714-2ba4-5e49-9263-2cec118db750 -> 7798f226-3db1-54d0-939e-dfc42047e352
UPDATE public.regatta_results
SET sailor_id = '7798f226-3db1-54d0-939e-dfc42047e352', updated_at = clock_timestamp()
WHERE sailor_id = 'e239a714-2ba4-5e49-9263-2cec118db750'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '7798f226-3db1-54d0-939e-dfc42047e352' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '7798f226-3db1-54d0-939e-dfc42047e352', updated_at = clock_timestamp()
WHERE sailor_id = 'e239a714-2ba4-5e49-9263-2cec118db750';
UPDATE public.sailor_aliases
SET sailor_id = '7798f226-3db1-54d0-939e-dfc42047e352'
WHERE sailor_id = 'e239a714-2ba4-5e49-9263-2cec118db750'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '7798f226-3db1-54d0-939e-dfc42047e352' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '7798f226-3db1-54d0-939e-dfc42047e352', updated_at = clock_timestamp()
WHERE sailor_id = 'e239a714-2ba4-5e49-9263-2cec118db750';
DELETE FROM public.sailors WHERE id = 'e239a714-2ba4-5e49-9263-2cec118db750';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '7798f226-3db1-54d0-939e-dfc42047e352', 'Nicolas Rigas Charalambous',
  'Merged duplicate profile e239a714-2ba4-5e49-9263-2cec118db750 into 7798f226-3db1-54d0-939e-dfc42047e352.',
  jsonb_build_object('survivorId', '7798f226-3db1-54d0-939e-dfc42047e352', 'mergedId', 'e239a714-2ba4-5e49-9263-2cec118db750', 'reason', 'Same CYP100 athlete (middle name vs initial).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '7798f226-3db1-54d0-939e-dfc42047e352');

-- Merge Theodoros Georgios Eracleous: 4f29a097-e2e5-519d-80d8-9e0f02ffeba5 -> 45d8b966-72b2-53e5-b56e-416f0b3b398c
UPDATE public.regatta_results
SET sailor_id = '45d8b966-72b2-53e5-b56e-416f0b3b398c', updated_at = clock_timestamp()
WHERE sailor_id = '4f29a097-e2e5-519d-80d8-9e0f02ffeba5'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '45d8b966-72b2-53e5-b56e-416f0b3b398c' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '45d8b966-72b2-53e5-b56e-416f0b3b398c', updated_at = clock_timestamp()
WHERE sailor_id = '4f29a097-e2e5-519d-80d8-9e0f02ffeba5';
UPDATE public.sailor_aliases
SET sailor_id = '45d8b966-72b2-53e5-b56e-416f0b3b398c'
WHERE sailor_id = '4f29a097-e2e5-519d-80d8-9e0f02ffeba5'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '45d8b966-72b2-53e5-b56e-416f0b3b398c' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '45d8b966-72b2-53e5-b56e-416f0b3b398c', updated_at = clock_timestamp()
WHERE sailor_id = '4f29a097-e2e5-519d-80d8-9e0f02ffeba5';
DELETE FROM public.sailors WHERE id = '4f29a097-e2e5-519d-80d8-9e0f02ffeba5';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '45d8b966-72b2-53e5-b56e-416f0b3b398c', 'Theodoros Georgios Eracleous',
  'Merged duplicate profile 4f29a097-e2e5-519d-80d8-9e0f02ffeba5 into 45d8b966-72b2-53e5-b56e-416f0b3b398c.',
  jsonb_build_object('survivorId', '45d8b966-72b2-53e5-b56e-416f0b3b398c', 'mergedId', '4f29a097-e2e5-519d-80d8-9e0f02ffeba5', 'reason', 'Same CYP105 athlete (Georgios vs Georghios spelling variant).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '45d8b966-72b2-53e5-b56e-416f0b3b398c');

-- Merge Rafael Nicolaou: 03e7d6d9-6b80-568f-b591-747cbc88b7a5 -> 347488c5-18ea-5414-9f73-ed83525d4b94
UPDATE public.regatta_results
SET sailor_id = '347488c5-18ea-5414-9f73-ed83525d4b94', updated_at = clock_timestamp()
WHERE sailor_id = '03e7d6d9-6b80-568f-b591-747cbc88b7a5'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '347488c5-18ea-5414-9f73-ed83525d4b94' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '347488c5-18ea-5414-9f73-ed83525d4b94', updated_at = clock_timestamp()
WHERE sailor_id = '03e7d6d9-6b80-568f-b591-747cbc88b7a5';
UPDATE public.sailor_aliases
SET sailor_id = '347488c5-18ea-5414-9f73-ed83525d4b94'
WHERE sailor_id = '03e7d6d9-6b80-568f-b591-747cbc88b7a5'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '347488c5-18ea-5414-9f73-ed83525d4b94' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '347488c5-18ea-5414-9f73-ed83525d4b94', updated_at = clock_timestamp()
WHERE sailor_id = '03e7d6d9-6b80-568f-b591-747cbc88b7a5';
DELETE FROM public.sailors WHERE id = '03e7d6d9-6b80-568f-b591-747cbc88b7a5';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '347488c5-18ea-5414-9f73-ed83525d4b94', 'Rafael Nicolaou',
  'Merged duplicate profile 03e7d6d9-6b80-568f-b591-747cbc88b7a5 into 347488c5-18ea-5414-9f73-ed83525d4b94.',
  jsonb_build_object('survivorId', '347488c5-18ea-5414-9f73-ed83525d4b94', 'mergedId', '03e7d6d9-6b80-568f-b591-747cbc88b7a5', 'reason', 'Same CYP12 athlete (Nicolaou vs Nikolaou spelling variant).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '347488c5-18ea-5414-9f73-ed83525d4b94');

-- Merge Juan Pablo Garcia Laconico: 5f64c816-b5fb-53e9-b2ac-e4aec68abce9 -> 9e2d9e84-b37b-5c44-a92b-3b761b515cfd
UPDATE public.regatta_results
SET sailor_id = '9e2d9e84-b37b-5c44-a92b-3b761b515cfd', updated_at = clock_timestamp()
WHERE sailor_id = '5f64c816-b5fb-53e9-b2ac-e4aec68abce9'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '9e2d9e84-b37b-5c44-a92b-3b761b515cfd' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '9e2d9e84-b37b-5c44-a92b-3b761b515cfd', updated_at = clock_timestamp()
WHERE sailor_id = '5f64c816-b5fb-53e9-b2ac-e4aec68abce9';
UPDATE public.sailor_aliases
SET sailor_id = '9e2d9e84-b37b-5c44-a92b-3b761b515cfd'
WHERE sailor_id = '5f64c816-b5fb-53e9-b2ac-e4aec68abce9'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '9e2d9e84-b37b-5c44-a92b-3b761b515cfd' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '9e2d9e84-b37b-5c44-a92b-3b761b515cfd', updated_at = clock_timestamp()
WHERE sailor_id = '5f64c816-b5fb-53e9-b2ac-e4aec68abce9';
DELETE FROM public.sailors WHERE id = '5f64c816-b5fb-53e9-b2ac-e4aec68abce9';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '9e2d9e84-b37b-5c44-a92b-3b761b515cfd', 'Juan Pablo Garcia Laconico',
  'Merged duplicate profile 5f64c816-b5fb-53e9-b2ac-e4aec68abce9 into 9e2d9e84-b37b-5c44-a92b-3b761b515cfd.',
  jsonb_build_object('survivorId', '9e2d9e84-b37b-5c44-a92b-3b761b515cfd', 'mergedId', '5f64c816-b5fb-53e9-b2ac-e4aec68abce9', 'reason', 'Same CYP46 athlete (full surname vs short surname).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '9e2d9e84-b37b-5c44-a92b-3b761b515cfd');

-- Merge Lucia Pascual Cabrera: ddc9bd35-9933-57de-a19f-50ee7e70afd9 -> cd5d1fbb-1eff-54a7-b23d-c17ca21246ba
UPDATE public.regatta_results
SET sailor_id = 'cd5d1fbb-1eff-54a7-b23d-c17ca21246ba', updated_at = clock_timestamp()
WHERE sailor_id = 'ddc9bd35-9933-57de-a19f-50ee7e70afd9'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = 'cd5d1fbb-1eff-54a7-b23d-c17ca21246ba' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = 'cd5d1fbb-1eff-54a7-b23d-c17ca21246ba', updated_at = clock_timestamp()
WHERE sailor_id = 'ddc9bd35-9933-57de-a19f-50ee7e70afd9';
UPDATE public.sailor_aliases
SET sailor_id = 'cd5d1fbb-1eff-54a7-b23d-c17ca21246ba'
WHERE sailor_id = 'ddc9bd35-9933-57de-a19f-50ee7e70afd9'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = 'cd5d1fbb-1eff-54a7-b23d-c17ca21246ba' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'cd5d1fbb-1eff-54a7-b23d-c17ca21246ba', updated_at = clock_timestamp()
WHERE sailor_id = 'ddc9bd35-9933-57de-a19f-50ee7e70afd9';
DELETE FROM public.sailors WHERE id = 'ddc9bd35-9933-57de-a19f-50ee7e70afd9';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', 'cd5d1fbb-1eff-54a7-b23d-c17ca21246ba', 'Lucia Pascual Cabrera',
  'Merged duplicate profile ddc9bd35-9933-57de-a19f-50ee7e70afd9 into cd5d1fbb-1eff-54a7-b23d-c17ca21246ba.',
  jsonb_build_object('survivorId', 'cd5d1fbb-1eff-54a7-b23d-c17ca21246ba', 'mergedId', 'ddc9bd35-9933-57de-a19f-50ee7e70afd9', 'reason', 'Same ESP3481 athlete (middle name vs initial).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = 'cd5d1fbb-1eff-54a7-b23d-c17ca21246ba');

-- Merge Hugo Gonzalez Morales: 602a2ecb-bafd-5d5e-8922-402e75ec72b4 -> 1d9f0584-544c-5d76-8353-d29c2fd2c3d0
UPDATE public.regatta_results
SET sailor_id = '1d9f0584-544c-5d76-8353-d29c2fd2c3d0', updated_at = clock_timestamp()
WHERE sailor_id = '602a2ecb-bafd-5d5e-8922-402e75ec72b4'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '1d9f0584-544c-5d76-8353-d29c2fd2c3d0' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '1d9f0584-544c-5d76-8353-d29c2fd2c3d0', updated_at = clock_timestamp()
WHERE sailor_id = '602a2ecb-bafd-5d5e-8922-402e75ec72b4';
UPDATE public.sailor_aliases
SET sailor_id = '1d9f0584-544c-5d76-8353-d29c2fd2c3d0'
WHERE sailor_id = '602a2ecb-bafd-5d5e-8922-402e75ec72b4'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '1d9f0584-544c-5d76-8353-d29c2fd2c3d0' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '1d9f0584-544c-5d76-8353-d29c2fd2c3d0', updated_at = clock_timestamp()
WHERE sailor_id = '602a2ecb-bafd-5d5e-8922-402e75ec72b4';
DELETE FROM public.sailors WHERE id = '602a2ecb-bafd-5d5e-8922-402e75ec72b4';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '1d9f0584-544c-5d76-8353-d29c2fd2c3d0', 'Hugo Gonzalez Morales',
  'Merged duplicate profile 602a2ecb-bafd-5d5e-8922-402e75ec72b4 into 1d9f0584-544c-5d76-8353-d29c2fd2c3d0.',
  jsonb_build_object('survivorId', '1d9f0584-544c-5d76-8353-d29c2fd2c3d0', 'mergedId', '602a2ecb-bafd-5d5e-8922-402e75ec72b4', 'reason', 'Same ESP3584 athlete (two surnames vs one).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '1d9f0584-544c-5d76-8353-d29c2fd2c3d0');

-- Merge Tomas Carbonell Monte: eacd5ff6-0d47-5ab6-94bd-56fcf198a233 -> f8188019-23f4-5c5e-89c3-6af6513381d3
UPDATE public.regatta_results
SET sailor_id = 'f8188019-23f4-5c5e-89c3-6af6513381d3', updated_at = clock_timestamp()
WHERE sailor_id = 'eacd5ff6-0d47-5ab6-94bd-56fcf198a233'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = 'f8188019-23f4-5c5e-89c3-6af6513381d3' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = 'f8188019-23f4-5c5e-89c3-6af6513381d3', updated_at = clock_timestamp()
WHERE sailor_id = 'eacd5ff6-0d47-5ab6-94bd-56fcf198a233';
UPDATE public.sailor_aliases
SET sailor_id = 'f8188019-23f4-5c5e-89c3-6af6513381d3'
WHERE sailor_id = 'eacd5ff6-0d47-5ab6-94bd-56fcf198a233'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = 'f8188019-23f4-5c5e-89c3-6af6513381d3' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'f8188019-23f4-5c5e-89c3-6af6513381d3', updated_at = clock_timestamp()
WHERE sailor_id = 'eacd5ff6-0d47-5ab6-94bd-56fcf198a233';
DELETE FROM public.sailors WHERE id = 'eacd5ff6-0d47-5ab6-94bd-56fcf198a233';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', 'f8188019-23f4-5c5e-89c3-6af6513381d3', 'Tomas Carbonell Monte',
  'Merged duplicate profile eacd5ff6-0d47-5ab6-94bd-56fcf198a233 into f8188019-23f4-5c5e-89c3-6af6513381d3.',
  jsonb_build_object('survivorId', 'f8188019-23f4-5c5e-89c3-6af6513381d3', 'mergedId', 'eacd5ff6-0d47-5ab6-94bd-56fcf198a233', 'reason', 'Same ESP3651 athlete (Carbonell Monte vs Carbonnell).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = 'f8188019-23f4-5c5e-89c3-6af6513381d3');

-- Merge Thodoris N. Andritsopoulos: e3728eba-92fc-5234-a431-2bede3a04c8d -> 175248f9-87d6-5472-b98a-b6aaa587b8d9
UPDATE public.regatta_results
SET sailor_id = '175248f9-87d6-5472-b98a-b6aaa587b8d9', updated_at = clock_timestamp()
WHERE sailor_id = 'e3728eba-92fc-5234-a431-2bede3a04c8d'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '175248f9-87d6-5472-b98a-b6aaa587b8d9' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '175248f9-87d6-5472-b98a-b6aaa587b8d9', updated_at = clock_timestamp()
WHERE sailor_id = 'e3728eba-92fc-5234-a431-2bede3a04c8d';
UPDATE public.sailor_aliases
SET sailor_id = '175248f9-87d6-5472-b98a-b6aaa587b8d9'
WHERE sailor_id = 'e3728eba-92fc-5234-a431-2bede3a04c8d'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '175248f9-87d6-5472-b98a-b6aaa587b8d9' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '175248f9-87d6-5472-b98a-b6aaa587b8d9', updated_at = clock_timestamp()
WHERE sailor_id = 'e3728eba-92fc-5234-a431-2bede3a04c8d';
DELETE FROM public.sailors WHERE id = 'e3728eba-92fc-5234-a431-2bede3a04c8d';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '175248f9-87d6-5472-b98a-b6aaa587b8d9', 'Thodoris N. Andritsopoulos',
  'Merged duplicate profile e3728eba-92fc-5234-a431-2bede3a04c8d into 175248f9-87d6-5472-b98a-b6aaa587b8d9.',
  jsonb_build_object('survivorId', '175248f9-87d6-5472-b98a-b6aaa587b8d9', 'mergedId', 'e3728eba-92fc-5234-a431-2bede3a04c8d', 'reason', 'Same GRE1027 athlete (with/without middle initial N.).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '175248f9-87d6-5472-b98a-b6aaa587b8d9');

-- Merge Odysseas Apostolos Moschos: 2b943667-c7f5-5062-ae20-baf70f413538 -> 8cdc808c-126e-5b0d-b612-5dbecfc9c160
UPDATE public.regatta_results
SET sailor_id = '8cdc808c-126e-5b0d-b612-5dbecfc9c160', updated_at = clock_timestamp()
WHERE sailor_id = '2b943667-c7f5-5062-ae20-baf70f413538'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '8cdc808c-126e-5b0d-b612-5dbecfc9c160' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '8cdc808c-126e-5b0d-b612-5dbecfc9c160', updated_at = clock_timestamp()
WHERE sailor_id = '2b943667-c7f5-5062-ae20-baf70f413538';
UPDATE public.sailor_aliases
SET sailor_id = '8cdc808c-126e-5b0d-b612-5dbecfc9c160'
WHERE sailor_id = '2b943667-c7f5-5062-ae20-baf70f413538'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '8cdc808c-126e-5b0d-b612-5dbecfc9c160' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '8cdc808c-126e-5b0d-b612-5dbecfc9c160', updated_at = clock_timestamp()
WHERE sailor_id = '2b943667-c7f5-5062-ae20-baf70f413538';
DELETE FROM public.sailors WHERE id = '2b943667-c7f5-5062-ae20-baf70f413538';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '8cdc808c-126e-5b0d-b612-5dbecfc9c160', 'Odysseas Apostolos Moschos',
  'Merged duplicate profile 2b943667-c7f5-5062-ae20-baf70f413538 into 8cdc808c-126e-5b0d-b612-5dbecfc9c160.',
  jsonb_build_object('survivorId', '8cdc808c-126e-5b0d-b612-5dbecfc9c160', 'mergedId', '2b943667-c7f5-5062-ae20-baf70f413538', 'reason', 'Same GRE1030 athlete (with/without middle name Apostolos).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '8cdc808c-126e-5b0d-b612-5dbecfc9c160');

-- Merge Magdalini D. Panagiotopoulou: a78c773b-f55f-526c-8396-d792eaeaa191 -> 91a26841-850c-56ae-942f-62b3d29b4125
UPDATE public.regatta_results
SET sailor_id = '91a26841-850c-56ae-942f-62b3d29b4125', updated_at = clock_timestamp()
WHERE sailor_id = 'a78c773b-f55f-526c-8396-d792eaeaa191'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '91a26841-850c-56ae-942f-62b3d29b4125' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '91a26841-850c-56ae-942f-62b3d29b4125', updated_at = clock_timestamp()
WHERE sailor_id = 'a78c773b-f55f-526c-8396-d792eaeaa191';
UPDATE public.sailor_aliases
SET sailor_id = '91a26841-850c-56ae-942f-62b3d29b4125'
WHERE sailor_id = 'a78c773b-f55f-526c-8396-d792eaeaa191'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '91a26841-850c-56ae-942f-62b3d29b4125' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '91a26841-850c-56ae-942f-62b3d29b4125', updated_at = clock_timestamp()
WHERE sailor_id = 'a78c773b-f55f-526c-8396-d792eaeaa191';
DELETE FROM public.sailors WHERE id = 'a78c773b-f55f-526c-8396-d792eaeaa191';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '91a26841-850c-56ae-942f-62b3d29b4125', 'Magdalini D. Panagiotopoulou',
  'Merged duplicate profile a78c773b-f55f-526c-8396-d792eaeaa191 into 91a26841-850c-56ae-942f-62b3d29b4125.',
  jsonb_build_object('survivorId', '91a26841-850c-56ae-942f-62b3d29b4125', 'mergedId', 'a78c773b-f55f-526c-8396-d792eaeaa191', 'reason', 'Same GRE2698 athlete (Panagiotopoulou vs Papagiotopoulou typo).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '91a26841-850c-56ae-942f-62b3d29b4125');

-- Merge Marios Panagiotis Moschos: 0decba07-172c-5fb3-9218-9d153f63eb6b -> caf3d567-b590-55f6-ab08-9ad79cf8bd3f
UPDATE public.regatta_results
SET sailor_id = 'caf3d567-b590-55f6-ab08-9ad79cf8bd3f', updated_at = clock_timestamp()
WHERE sailor_id = '0decba07-172c-5fb3-9218-9d153f63eb6b'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = 'caf3d567-b590-55f6-ab08-9ad79cf8bd3f' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = 'caf3d567-b590-55f6-ab08-9ad79cf8bd3f', updated_at = clock_timestamp()
WHERE sailor_id = '0decba07-172c-5fb3-9218-9d153f63eb6b';
UPDATE public.sailor_aliases
SET sailor_id = 'caf3d567-b590-55f6-ab08-9ad79cf8bd3f'
WHERE sailor_id = '0decba07-172c-5fb3-9218-9d153f63eb6b'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = 'caf3d567-b590-55f6-ab08-9ad79cf8bd3f' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'caf3d567-b590-55f6-ab08-9ad79cf8bd3f', updated_at = clock_timestamp()
WHERE sailor_id = '0decba07-172c-5fb3-9218-9d153f63eb6b';
DELETE FROM public.sailors WHERE id = '0decba07-172c-5fb3-9218-9d153f63eb6b';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', 'caf3d567-b590-55f6-ab08-9ad79cf8bd3f', 'Marios Panagiotis Moschos',
  'Merged duplicate profile 0decba07-172c-5fb3-9218-9d153f63eb6b into caf3d567-b590-55f6-ab08-9ad79cf8bd3f.',
  jsonb_build_object('survivorId', 'caf3d567-b590-55f6-ab08-9ad79cf8bd3f', 'mergedId', '0decba07-172c-5fb3-9218-9d153f63eb6b', 'reason', 'Same GRE2820 athlete (with/without middle name Panagiotis).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = 'caf3d567-b590-55f6-ab08-9ad79cf8bd3f');

-- Merge Agis Christos Angelopoulos: cfb4eb58-8611-5931-a847-b7e5d61f9d38 -> 181bc8bc-31fc-505a-9990-6263a0fd88aa
UPDATE public.regatta_results
SET sailor_id = '181bc8bc-31fc-505a-9990-6263a0fd88aa', updated_at = clock_timestamp()
WHERE sailor_id = 'cfb4eb58-8611-5931-a847-b7e5d61f9d38'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '181bc8bc-31fc-505a-9990-6263a0fd88aa' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = '181bc8bc-31fc-505a-9990-6263a0fd88aa', updated_at = clock_timestamp()
WHERE sailor_id = 'cfb4eb58-8611-5931-a847-b7e5d61f9d38';
UPDATE public.sailor_aliases
SET sailor_id = '181bc8bc-31fc-505a-9990-6263a0fd88aa'
WHERE sailor_id = 'cfb4eb58-8611-5931-a847-b7e5d61f9d38'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '181bc8bc-31fc-505a-9990-6263a0fd88aa' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = '181bc8bc-31fc-505a-9990-6263a0fd88aa', updated_at = clock_timestamp()
WHERE sailor_id = 'cfb4eb58-8611-5931-a847-b7e5d61f9d38';
DELETE FROM public.sailors WHERE id = 'cfb4eb58-8611-5931-a847-b7e5d61f9d38';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', '181bc8bc-31fc-505a-9990-6263a0fd88aa', 'Agis Christos Angelopoulos',
  'Merged duplicate profile cfb4eb58-8611-5931-a847-b7e5d61f9d38 into 181bc8bc-31fc-505a-9990-6263a0fd88aa.',
  jsonb_build_object('survivorId', '181bc8bc-31fc-505a-9990-6263a0fd88aa', 'mergedId', 'cfb4eb58-8611-5931-a847-b7e5d61f9d38', 'reason', 'Same GRE3074 athlete (Christos vs C.).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '181bc8bc-31fc-505a-9990-6263a0fd88aa');

-- Merge Maria Paisia Kelli: eb850c44-35bf-5aa5-95c1-c2312c02a071 -> d468159b-f0f9-54db-bcbe-128f8b936eaf
UPDATE public.regatta_results
SET sailor_id = 'd468159b-f0f9-54db-bcbe-128f8b936eaf', updated_at = clock_timestamp()
WHERE sailor_id = 'eb850c44-35bf-5aa5-95c1-c2312c02a071'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = 'd468159b-f0f9-54db-bcbe-128f8b936eaf' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = 'd468159b-f0f9-54db-bcbe-128f8b936eaf', updated_at = clock_timestamp()
WHERE sailor_id = 'eb850c44-35bf-5aa5-95c1-c2312c02a071';
UPDATE public.sailor_aliases
SET sailor_id = 'd468159b-f0f9-54db-bcbe-128f8b936eaf'
WHERE sailor_id = 'eb850c44-35bf-5aa5-95c1-c2312c02a071'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = 'd468159b-f0f9-54db-bcbe-128f8b936eaf' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'd468159b-f0f9-54db-bcbe-128f8b936eaf', updated_at = clock_timestamp()
WHERE sailor_id = 'eb850c44-35bf-5aa5-95c1-c2312c02a071';
DELETE FROM public.sailors WHERE id = 'eb850c44-35bf-5aa5-95c1-c2312c02a071';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', 'd468159b-f0f9-54db-bcbe-128f8b936eaf', 'Maria Paisia Kelli',
  'Merged duplicate profile eb850c44-35bf-5aa5-95c1-c2312c02a071 into d468159b-f0f9-54db-bcbe-128f8b936eaf.',
  jsonb_build_object('survivorId', 'd468159b-f0f9-54db-bcbe-128f8b936eaf', 'mergedId', 'eb850c44-35bf-5aa5-95c1-c2312c02a071', 'reason', 'Same GRE3128 athlete (Paisia vs P.).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = 'd468159b-f0f9-54db-bcbe-128f8b936eaf');

-- Merge Christos Diangelakis: 5771a286-e87a-56c8-8d83-829b9b410335 -> dfb04a34-e6c2-5381-a9c2-19455f3486e1
UPDATE public.regatta_results
SET sailor_id = 'dfb04a34-e6c2-5381-a9c2-19455f3486e1', updated_at = clock_timestamp()
WHERE sailor_id = '5771a286-e87a-56c8-8d83-829b9b410335'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = 'dfb04a34-e6c2-5381-a9c2-19455f3486e1' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = 'dfb04a34-e6c2-5381-a9c2-19455f3486e1', updated_at = clock_timestamp()
WHERE sailor_id = '5771a286-e87a-56c8-8d83-829b9b410335';
UPDATE public.sailor_aliases
SET sailor_id = 'dfb04a34-e6c2-5381-a9c2-19455f3486e1'
WHERE sailor_id = '5771a286-e87a-56c8-8d83-829b9b410335'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = 'dfb04a34-e6c2-5381-a9c2-19455f3486e1' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'dfb04a34-e6c2-5381-a9c2-19455f3486e1', updated_at = clock_timestamp()
WHERE sailor_id = '5771a286-e87a-56c8-8d83-829b9b410335';
DELETE FROM public.sailors WHERE id = '5771a286-e87a-56c8-8d83-829b9b410335';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', 'dfb04a34-e6c2-5381-a9c2-19455f3486e1', 'Christos Diangelakis',
  'Merged duplicate profile 5771a286-e87a-56c8-8d83-829b9b410335 into dfb04a34-e6c2-5381-a9c2-19455f3486e1.',
  jsonb_build_object('survivorId', 'dfb04a34-e6c2-5381-a9c2-19455f3486e1', 'mergedId', '5771a286-e87a-56c8-8d83-829b9b410335', 'reason', 'Same GRE3242 athlete (Diangelakis vs Diaggelakis transliteration).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = 'dfb04a34-e6c2-5381-a9c2-19455f3486e1');

-- Merge Jorge Munoz Uribe: 4383d548-cb49-53d2-be7f-4fca586de4de -> de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2
UPDATE public.regatta_results
SET sailor_id = 'de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2', updated_at = clock_timestamp()
WHERE sailor_id = '4383d548-cb49-53d2-be7f-4fca586de4de'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = 'de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = 'de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2', updated_at = clock_timestamp()
WHERE sailor_id = '4383d548-cb49-53d2-be7f-4fca586de4de';
UPDATE public.sailor_aliases
SET sailor_id = 'de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2'
WHERE sailor_id = '4383d548-cb49-53d2-be7f-4fca586de4de'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = 'de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2', updated_at = clock_timestamp()
WHERE sailor_id = '4383d548-cb49-53d2-be7f-4fca586de4de';
DELETE FROM public.sailors WHERE id = '4383d548-cb49-53d2-be7f-4fca586de4de';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', 'de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2', 'Jorge Munoz Uribe',
  'Merged duplicate profile 4383d548-cb49-53d2-be7f-4fca586de4de into de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2.',
  jsonb_build_object('survivorId', 'de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2', 'mergedId', '4383d548-cb49-53d2-be7f-4fca586de4de', 'reason', 'Same MEX1041 athlete (with/without accent & second surname).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = 'de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2');

-- Merge Hilda Wallstrom: 29ddfa4f-539c-562f-a972-71323cabb063 -> c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8
UPDATE public.regatta_results
SET sailor_id = 'c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8', updated_at = clock_timestamp()
WHERE sailor_id = '29ddfa4f-539c-562f-a972-71323cabb063'
  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = 'c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8' AND r2.regatta_id = regatta_results.regatta_id);
UPDATE public.regatta_result_participants
SET sailor_id = 'c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8', updated_at = clock_timestamp()
WHERE sailor_id = '29ddfa4f-539c-562f-a972-71323cabb063';
UPDATE public.sailor_aliases
SET sailor_id = 'c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8'
WHERE sailor_id = '29ddfa4f-539c-562f-a972-71323cabb063'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = 'c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8' AND sa2.alias_name = sailor_aliases.alias_name);
UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8', updated_at = clock_timestamp()
WHERE sailor_id = '29ddfa4f-539c-562f-a972-71323cabb063';
DELETE FROM public.sailors WHERE id = '29ddfa4f-539c-562f-a972-71323cabb063';
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.merge', 'sailor', 'c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8', 'Hilda Wallstrom',
  'Merged duplicate profile 29ddfa4f-539c-562f-a972-71323cabb063 into c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8.',
  jsonb_build_object('survivorId', 'c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8', 'mergedId', '29ddfa4f-539c-562f-a972-71323cabb063', 'reason', 'Same SWE4882 athlete (Wallström vs Wallstrom).'),
  'daily_audit_20261118', clock_timestamp()
WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = 'c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8');

-- ============================================================================
-- 3. REGISTER 10 KEEP-SEPARATE PAIRS IN ADMIN_CHANGE_LOG
-- ============================================================================

INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.keep_separate', 'sailor',
  '9ef5cb54-a5f2-5c06-9c07-14abd1f76215', 'Christos Psaltis / Christos Michalakis', 'Confirmed these are different sailors.',
  jsonb_build_object('pairKey', '9ef5cb54-a5f2-5c06-9c07-14abd1f76215|b6ece983-f66d-52c7-b559-1bc2f2dc387c', 'reason', 'Distinct Greek sailors sharing charter sail GRE3077 across 2024 vs 2025 Kosmos.'),
  'daily_audit_20261118', clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate' AND details->>'pairKey' = '9ef5cb54-a5f2-5c06-9c07-14abd1f76215|b6ece983-f66d-52c7-b559-1bc2f2dc387c'
);
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.keep_separate', 'sailor',
  '8139af57-2867-51a4-880d-ea4548b04c6c', 'Diego Andres Delgado Ripepi / Diego C. Marrero', 'Confirmed these are different sailors.',
  jsonb_build_object('pairKey', '8139af57-2867-51a4-880d-ea4548b04c6c|f9bed12a-11a2-55ed-8404-87f8a5a4f14c', 'reason', 'Distinct Puerto Rican sailors sharing R.O.C. charter code PUR 2 across 2024 and 2025.'),
  'daily_audit_20261118', clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate' AND details->>'pairKey' = '8139af57-2867-51a4-880d-ea4548b04c6c|f9bed12a-11a2-55ed-8404-87f8a5a4f14c'
);
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.keep_separate', 'sailor',
  '8139af57-2867-51a4-880d-ea4548b04c6c', 'Diego Andres Delgado Ripepi / Diego J. Marrero', 'Confirmed these are different sailors.',
  jsonb_build_object('pairKey', '8139af57-2867-51a4-880d-ea4548b04c6c|fd9ef3af-9d28-5346-a57a-cca7a4cce2df', 'reason', 'Distinct Puerto Rican sailors sharing R.O.C. charter code PUR 2 across 2023 and 2025.'),
  'daily_audit_20261118', clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate' AND details->>'pairKey' = '8139af57-2867-51a4-880d-ea4548b04c6c|fd9ef3af-9d28-5346-a57a-cca7a4cce2df'
);
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.keep_separate', 'sailor',
  '19971e93-836b-40bc-b75d-7720eb3a0ba7', 'Russell Xavier Quek / Russell Lim', 'Confirmed these are different sailors.',
  jsonb_build_object('pairKey', '19971e93-836b-40bc-b75d-7720eb3a0ba7|ab1187f5-9a3a-50a5-9407-60769dd0a492', 'reason', 'Distinct Singapore sailors who used sail number 3008 in different years.'),
  'daily_audit_20261118', clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate' AND details->>'pairKey' = '19971e93-836b-40bc-b75d-7720eb3a0ba7|ab1187f5-9a3a-50a5-9407-60769dd0a492'
);
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.keep_separate', 'sailor',
  '87aee68c-038c-53d5-8294-6daf8fb1167a', 'Caleb Lim Xinquan / Caleb Aaron Quek', 'Confirmed these are different sailors.',
  jsonb_build_object('pairKey', '87aee68c-038c-53d5-8294-6daf8fb1167a|b22f69f0-2da0-539b-b720-1eb2c1316008', 'reason', 'Distinct Singapore sailors who used sail number 3286.'),
  'daily_audit_20261118', clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate' AND details->>'pairKey' = '87aee68c-038c-53d5-8294-6daf8fb1167a|b22f69f0-2da0-539b-b720-1eb2c1316008'
);
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.keep_separate', 'sailor',
  '2b3ed2fa-a6ec-59ac-9227-b780e15f2b69', 'マーズデン 琥海 / マーズデン 珀空', 'Confirmed these are different sailors.',
  jsonb_build_object('pairKey', '2b3ed2fa-a6ec-59ac-9227-b780e15f2b69|a8fd220f-14f1-5610-88bb-ed6681ce72c6', 'reason', 'Distinct Japanese siblings sharing family sail JPN 1526.'),
  'daily_audit_20261118', clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate' AND details->>'pairKey' = '2b3ed2fa-a6ec-59ac-9227-b780e15f2b69|a8fd220f-14f1-5610-88bb-ed6681ce72c6'
);
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.keep_separate', 'sailor',
  '08ea54bb-85c7-57ec-852e-b4e43ec045ec', '舩澤 夏美 / 舩澤 夏子', 'Confirmed these are different sailors.',
  jsonb_build_object('pairKey', '08ea54bb-85c7-57ec-852e-b4e43ec045ec|96dac3a2-4d7f-53b0-af17-808c44056f3d', 'reason', 'Distinct Japanese sisters sharing family sail JPN 3525.'),
  'daily_audit_20261118', clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate' AND details->>'pairKey' = '08ea54bb-85c7-57ec-852e-b4e43ec045ec|96dac3a2-4d7f-53b0-af17-808c44056f3d'
);
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.keep_separate', 'sailor',
  '5b9e6612-96be-592e-bd9b-06b558b96f63', 'Muhammad Abrisam Athmar Bin Aslan / Muhammad Yusri Bin Syahrizan', 'Confirmed these are different sailors.',
  jsonb_build_object('pairKey', '5b9e6612-96be-592e-bd9b-06b558b96f63|c9df556b-7b8e-5944-92c8-0cc863207d9b', 'reason', 'Distinct Malaysian sailors sharing sail 56051.'),
  'daily_audit_20261118', clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate' AND details->>'pairKey' = '5b9e6612-96be-592e-bd9b-06b558b96f63|c9df556b-7b8e-5944-92c8-0cc863207d9b'
);
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.keep_separate', 'sailor',
  '7d79261f-75e1-5069-a10e-567d9c9816f3', 'Nur Aqilah Raifana Binti Aslan / Nur Asma Binti Syahrizan', 'Confirmed these are different sailors.',
  jsonb_build_object('pairKey', '7d79261f-75e1-5069-a10e-567d9c9816f3|f1d035dc-2510-5f18-a6d0-09b8f9827d52', 'reason', 'Distinct Malaysian sailors sharing sail 56054.'),
  'daily_audit_20261118', clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate' AND details->>'pairKey' = '7d79261f-75e1-5069-a10e-567d9c9816f3|f1d035dc-2510-5f18-a6d0-09b8f9827d52'
);
INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
SELECT 'sailors.duplicates.keep_separate', 'sailor',
  '580a0306-cd4c-548f-a98c-38bde8e7846c', 'Muhammad Nazmi Qusyairi Bin Mohd Nazri / Muhammad Idris Bin Mohd Zahawi', 'Confirmed these are different sailors.',
  jsonb_build_object('pairKey', '580a0306-cd4c-548f-a98c-38bde8e7846c|9e4c2cd7-24d6-51e0-8d7e-5e6d91ee137a', 'reason', 'Distinct Malaysian sailors sharing sail 57346.'),
  'daily_audit_20261118', clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate' AND details->>'pairKey' = '580a0306-cd4c-548f-a98c-38bde8e7846c|9e4c2cd7-24d6-51e0-8d7e-5e6d91ee137a'
);

-- ============================================================================
-- 4. RESULT IMPORT MONITORS, SNSC 2026 OFFICIAL URLS & 6-RACE INDEX FIX
-- ============================================================================

-- 2026 Chesva Regatta of Champions: Race 14 final PDF already published
UPDATE public.result_import_monitors
SET report = jsonb_set(jsonb_set(COALESCE(report, '{}'::jsonb), '{status}', '"reviewed"'::jsonb), '{pdfCorroboration}', '"verified"'::jsonb)
WHERE event_id = '52e16c9b-ea1a-5698-a3fa-2ba518e1bb6f';

-- Singapore National Sailing Championships 2026: mark reviewed + backfill official URLs
UPDATE public.result_import_monitors
SET report = jsonb_set(jsonb_set(COALESCE(report, '{}'::jsonb), '{status}', '"reviewed"'::jsonb), '{pdfCorroboration}', '"verified"'::jsonb)
WHERE event_id = 'f248e22e-34bf-4dcb-8a3c-50ec8c68ce3e';

UPDATE public.regattas SET official_results_url = 'https://www.racingrulesofsailing.org/documents/206850', official_results_source_name = 'OP Gold Final Results.pdf (SSF, 6 races)', updated_at = clock_timestamp() WHERE slug = 'singapore-national-sailing-championships-2026-gold';
UPDATE public.regattas SET official_results_url = 'https://drive.google.com/file/d/1KzATo7dIxvyxAJQ1Zip5lTOFikYCKdx2/view?usp=sharing', official_results_source_name = 'SSF SNSC 2026 Optimist Silver Fleet PDF', updated_at = clock_timestamp() WHERE slug = 'singapore-national-sailing-championships-2026-silver';
UPDATE public.regattas SET official_results_url = 'https://drive.google.com/file/d/1mBVnXEmo7osTdfynhF_kngZBXeknEz_O/view?usp=sharing', official_results_source_name = 'SSF SNSC 2026 ILCA 4 PDF', updated_at = clock_timestamp() WHERE slug = 'singapore-national-sailing-championships-2026-ilca4';
UPDATE public.regattas SET official_results_url = 'https://drive.google.com/file/d/18TAmgj9r-5-bhifp2AMr_N9tF_iXZRxx/view?usp=sharing', official_results_source_name = 'SSF SNSC 2026 ILCA 6 PDF', updated_at = clock_timestamp() WHERE slug = 'snsc-ilca-6-sep-26';

-- SNSC 2026 Gold official final PDF has 6 races (1 discard, 5 to count)
UPDATE public.asian_optimist_index_events
SET race_count = 6, discard_count = 1, updated_at = clock_timestamp()
WHERE id = 'snsc-gold-sep-26-2026-09-11';

-- 2026 WAIODA Optimist WA State Championships: point monitor to RFBYC portal & mark reviewed
UPDATE public.result_import_monitors
SET event_url = 'https://rfbyc.asn.au/web/pages/optimiststatechampionships2026',
    report = jsonb_set(jsonb_set(COALESCE(report, '{}'::jsonb), '{status}', '"reviewed"'::jsonb), '{pdfCorroboration}', '"not_found_in_checked_pages"'::jsonb)
WHERE event_id = 'f30715c5-c80c-433a-a6e2-6f7b61e5ed2b';

COMMIT;
