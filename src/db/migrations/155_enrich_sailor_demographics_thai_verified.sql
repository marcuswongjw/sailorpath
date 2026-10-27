-- Migration 155: Demographic Enrichment — Sailor Date of Birth (15 Sailors)
--
-- Enriches dob for 15 sailors with 100% consistent official birth_year recorded
-- across verified Thai and Asian championship regatta results (ACDC Cup International,
-- ACDC Sailing Cup, Admiral's Cup, Thailand International).
--
-- Follows platform standard convention of 'YYYY-01-01' when only birth year is corroborated.
-- All operations executed in a single atomic transaction.

BEGIN;

-- 1. Sorawit Naksuk (5d26c5a2-fefa-462b-9aea-23fc1092f5cf) -> 2012-01-01 (Official results: ACDC Cup International 2026 — Optimist, Rank 1, THA 1493)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '5d26c5a2-fefa-462b-9aea-23fc1092f5cf' AND dob IS NULL;

-- 2. Rachata Sadtrakulwattana (071e2770-8de0-4d2f-b8c3-bd6cb31fef05) -> 2011-01-01 (Official results: ACDC Cup 2026 & Admiral's Cup 2025 — Optimist, THA 1963)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '071e2770-8de0-4d2f-b8c3-bd6cb31fef05' AND dob IS NULL;

-- 3. Surapha Maungngam (3b9072c4-2980-4557-b1f1-b9993c803824) -> 2011-01-01 (Official results: ACDC Cup 2026 & Admiral's Cup 2025 — Optimist, THA 1941)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '3b9072c4-2980-4557-b1f1-b9993c803824' AND dob IS NULL;

-- 4. Pariyaporn Chantarawong (1534bdb9-90d3-4736-aeb0-03a64ef4cf48) -> 2011-01-01 (Official results: ACDC Cup 2026 & Admiral's Cup 2025 — Optimist, THA 1223)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1534bdb9-90d3-4736-aeb0-03a64ef4cf48' AND dob IS NULL;

-- 5. Theerakan Klaysomboon (8a200ad6-5c43-4b86-97bb-d0905a158577) -> 2015-01-01 (Official results: ACDC Cup International 2026 — Optimist, Rank 9, THA 1935)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8a200ad6-5c43-4b86-97bb-d0905a158577' AND dob IS NULL;

-- 6. Pornyamol Sawaengkhun (bade8bf5-70d2-4e22-ac85-4d72e4ac45de) -> 2013-01-01 (Official results: ACDC Cup International 2026 — Optimist, Rank 10, THA 1900)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'bade8bf5-70d2-4e22-ac85-4d72e4ac45de' AND dob IS NULL;

-- 7. Jiratiwat Peungchurn (50f0e128-c292-4a16-b203-f5bd3e3cd040) -> 2012-01-01 (Official results: ACDC Cup International 2026 — Optimist, Rank 11, THA 1220)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '50f0e128-c292-4a16-b203-f5bd3e3cd040' AND dob IS NULL;

-- 8. Kyan Tan (60ea1195-0d40-470a-b7c9-4cfa16ac3517) -> 2015-01-01 (Official results: ACDC Sailing Cup 2026 — Optimist, Rank 1, SGP 4712)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = '60ea1195-0d40-470a-b7c9-4cfa16ac3517' AND dob IS NULL;

-- 9. Punthita Werotjanakul (c26a34a0-0b0a-44d0-9951-99974c45b023) -> 2012-01-01 (Official results: ACDC Sailing Cup 2026 — Optimist, Rank 2, THA 1888)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'c26a34a0-0b0a-44d0-9951-99974c45b023' AND dob IS NULL;

-- 10. Krishna Venkitachalam Ramakrishnan (5acf2723-193a-4697-a38b-d5d23302bef3) -> 2012-01-01 (Official results: Admiral's Cup 2026 & 2025 — Optimist, IND 1639)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '5acf2723-193a-4697-a38b-d5d23302bef3' AND dob IS NULL;

-- 11. Qiheng Liu (04d423bc-bd18-47ad-967a-45b1ef44cefd) -> 2014-01-01 (Official results: Admiral's Cup 2026 — Optimist, Rank 8, HKG 246)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '04d423bc-bd18-47ad-967a-45b1ef44cefd' AND dob IS NULL;

-- 12. Thawaree Raksapan (2a50e8b6-d73b-4adc-a76c-644c854db7f1) -> 2013-01-01 (Official results: Admiral's Cup 2026 — Optimist, Rank 11, THA 1253)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2a50e8b6-d73b-4adc-a76c-644c854db7f1' AND dob IS NULL;

-- 13. Arunee Raksapan (809488f6-20f4-45c4-b53c-4a904c636c9b) -> 2015-01-01 (Official results: Admiral's Cup 2026 — Optimist, Rank 15, THA 1396)
UPDATE public.sailors
SET dob = '2015-01-01'::date, updated_at = clock_timestamp()
WHERE id = '809488f6-20f4-45c4-b53c-4a904c636c9b' AND dob IS NULL;

-- 14. Vantava Raguraman (980021fb-887b-4445-9db6-c1f3f431fa33) -> 2013-01-01 (Official results: Admiral's Cup 2026 — Optimist, Rank 20, IND 1148)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '980021fb-887b-4445-9db6-c1f3f431fa33' AND dob IS NULL;

-- 15. Luo Amy Aiwei (5bd7e58b-e148-4d69-b605-90b0ef68f650) -> 2013-01-01 (Official results: Thailand International 2026 — Optimist, Rank 23, HKG 343)
UPDATE public.sailors
SET dob = '2013-01-01'::date, updated_at = clock_timestamp()
WHERE id = '5bd7e58b-e148-4d69-b605-90b0ef68f650' AND dob IS NULL;

-- Audit log record
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.dob_backfill',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'Demographic Enrichment — DOB (15 Sailors)',
  'Backfilled dob for 15 sailors with verified consistent birth_year in official results.',
  '{"updated_count": 15}'::jsonb,
  'migration_155',
  clock_timestamp()
);

COMMIT;
