-- Migration 157: Demographic Enrichment — Genders (5 Sailors) and Nationality (1 Sailor)
--
-- Enriches demographic fields for 6 active sailors with 100% verified corroboration
-- from official international championship scoring sheets (Optimist Asian & Oceanian
-- Championships and 19th Asian Games).
--
-- Compliance with AGENTS.md:
--   - Corroborated strictly against official federation result records.
--   - Zero speculative guessing.
--
-- All operations executed in a single atomic transaction.

BEGIN;

-- 1. Pitipoom Jaroenpon (d1624d92-8fde-5d56-9acb-69df6f18cb75) -> Gender: 'M'
-- Source: 2023 Optimist Asian & Oceanian Championship — Official Final Results (THA 1978, Male division)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'd1624d92-8fde-5d56-9acb-69df6f18cb75' AND (gender IS NULL OR gender = '');

-- 2. Yuechen Liu (09f2bdaa-0bdf-4228-acd5-fab4a5ff3189) -> Gender: 'F'
-- Source: 2023 & 2024 Optimist Asian & Oceanian Championships — Official Final Results (CHN 8011, Female division)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '09f2bdaa-0bdf-4228-acd5-fab4a5ff3189' AND (gender IS NULL OR gender = '');

-- 3. Zhongling Qi (4220cbc3-f523-5575-8abd-00610c01c3c3) -> Gender: 'F'
-- Source: 2023 Optimist Asian & Oceanian Championship — Official Final Results (CHN 111, Female division)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '4220cbc3-f523-5575-8abd-00610c01c3c3' AND (gender IS NULL OR gender = '');

-- 4. Yong Liang Chuang (6bb8044b-6e37-4e15-84d2-605f5fecb2b7) -> Gender: 'M'
-- Source: 2023 Optimist Asian & Oceanian Championship — Official Final Results (TPE 132, Male division)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '6bb8044b-6e37-4e15-84d2-605f5fecb2b7' AND (gender IS NULL OR gender = '');

-- 5. BingJie Yan (58fb912f-79c6-5649-8b60-27ac74b3f452) -> Gender: 'F'
-- Source: 2023 Optimist Asian & Oceanian Championship — Official Final Results (CHN 567, Female division)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '58fb912f-79c6-5649-8b60-27ac74b3f452' AND (gender IS NULL OR gender = '');

-- 6. Muhammad Asnawi Iqbal Bin Adam (1e4b724c-4571-5f4a-8f48-73f77141691d) -> Nationality: 'MAS', Gender: 'M'
-- Source: 19th Asian Games 2023 ILCA 4 Boy's Dinghy Official Results (MAS, Bronze Medalist)
UPDATE public.sailors
SET nationality = 'MAS', gender = 'M', updated_at = clock_timestamp()
WHERE id = '1e4b724c-4571-5f4a-8f48-73f77141691d' AND (nationality IS NULL OR nationality = '');

-- Audit log record
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.demographics_enrichment',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'Demographic Enrichment — Asian Championships & Asian Games',
  'Enriched gender for 5 active sailors and nationality for 1 sailor from verified official championship results.',
  '{"genders_updated": 5, "nationalities_updated": 1, "sailor_ids": ["d1624d92-8fde-5d56-9acb-69df6f18cb75", "09f2bdaa-0bdf-4228-acd5-fab4a5ff3189", "4220cbc3-f523-5575-8abd-00610c01c3c3", "6bb8044b-6e37-4e15-84d2-605f5fecb2b7", "58fb912f-79c6-5649-8b60-27ac74b3f452", "1e4b724c-4571-5f4a-8f48-73f77141691d"]}'::jsonb,
  'migration_157',
  clock_timestamp()
);

COMMIT;
