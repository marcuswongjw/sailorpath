#!/usr/bin/env python3
"""Generate migration for approved daily audit tasks (2026-11-16):
1. Register 2 new keep-separate pairs in admin_change_log.
2. Enrich 3 verified sailor genders (Thurein Lin, Annika Chui, Su Latt Lin Tun).
3. Update monitor status for 22nd Botchan Cup 2026 and X-15 World Championships 2026 to reviewed.
"""

migration_content = """-- Migration: 20261116083000_daily_audit_enrichments_and_keep_separates.sql
-- Description: Register 2 keep-separate pairs, enrich 3 verified sailor genders, and update result import monitors.
-- Staged for user review during scheduled daily data scan (2026-11-16).

BEGIN;

-- ============================================================================
-- 1. KEEP-SEPARATE PAIR REGISTRATIONS (2 PAIRS)
-- ============================================================================

-- Pair 1: Abdullah Mohamed (BRN) / Muhammad Iskandar Zulqarnain Bin Daniel Tay Abdullah (MAS)
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '71640762-eaff-4bda-9561-c138782b2c88',
  'Abdullah Mohamed / Muhammad Iskandar Zulqarnain Bin Daniel Tay Abdullah',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '71640762-eaff-4bda-9561-c138782b2c88|d5420b7d-7c56-5026-8bc1-c3c568b26bce',
    'reason', 'Distinct athletes: Bahrain national sailor (BRN, sail 345) vs Malaysian youth athlete (MAS, Kedah Sailing Association, sail MAS9022, born 2013-01-01) sharing patronymic token Abdullah.'
  ),
  'daily_audit_20261116',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '71640762-eaff-4bda-9561-c138782b2c88|d5420b7d-7c56-5026-8bc1-c3c568b26bce'
);

-- Pair 2: Khalil Ibrahim (BRN) / Ali Ibrahim (UAE)
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '49760b46-9005-40c5-9c92-6fd8a98a6b54',
  'Khalil Ibrahim / Ali Ibrahim',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '49760b46-9005-40c5-9c92-6fd8a98a6b54|546e76b8-0d49-49f4-86b9-2f230b5edfdf',
    'reason', 'Distinct athletes: Bahrain youth sailor (BRN, sail 5) vs Emirati youth sailor (UAE, sail 54) with different given names sharing patronymic Ibrahim.'
  ),
  'daily_audit_20261116',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '49760b46-9005-40c5-9c92-6fd8a98a6b54|546e76b8-0d49-49f4-86b9-2f230b5edfdf'
);

-- ============================================================================
-- 2. VERIFIED SAILOR GENDER ENRICHMENTS (3 SAILORS)
-- ============================================================================

-- Thurein Lin (MYA) -> M (Source: Olympic Day Movement Regatta 2026 Optimist & Yangon Sailing Club Combined Fleet Championships 2026 Optimist)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '293148bf-0533-5e0f-934a-6567b089996a' AND gender IS NULL;

-- Annika Chui (SGP) -> F (Source: CSC ILCA & 29er Championships 2024 29er)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'a6478204-66b5-4e50-ac84-b3a6fe942909' AND gender IS NULL;

-- Su Latt Lin Tun (MYA) -> F (Source: Olympic Day Movement Regatta 2026 ILCA 4)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'ba1644c5-63ee-5037-bed9-a6621cdf326a' AND gender IS NULL;

-- ============================================================================
-- 3. RESULT IMPORT MONITORS UPDATE (ACKNOWLEDGE NOR/SI REVISIONS)
-- ============================================================================

-- 22nd Botchan Cup 2026: Rev1 Notice of Race reviewed; race results already fully published
UPDATE public.result_import_monitors
SET report = jsonb_set(
  jsonb_set(report, '{status}', '"reviewed"'::jsonb),
  '{pdfCorroboration}', '"verified"'::jsonb
)
WHERE event_id = '8d8bbdc1-a75a-4d3b-ab7c-275bc078b6b9';

-- X-15 World Championships 2026: NOR-SI document reviewed; race results already fully published
UPDATE public.result_import_monitors
SET report = jsonb_set(
  jsonb_set(report, '{status}', '"reviewed"'::jsonb),
  '{pdfCorroboration}', '"verified"'::jsonb
)
WHERE event_id = '25eaa021-d579-4db6-adef-8450d57ca77f';

COMMIT;
"""

if __name__ == "__main__":
    out_path = "src/db/migrations/20261116083000_daily_audit_enrichments_and_keep_separates.sql"
    with open(out_path, "w") as f:
        f.write(migration_content.strip() + "\n")
    print(f"Staged migration written to: {out_path}")
