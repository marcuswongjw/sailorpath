-- Migration: 20261117083000_daily_audit_enrichments_and_monitor_review.sql
-- Description: Enrich 3 verified sailor genders and update ILCA District Championships 2026 monitor.
-- Staged for user review during scheduled daily data scan (2026-11-17).

BEGIN;

-- ============================================================================
-- 1. VERIFIED SAILOR GENDER ENRICHMENTS (3 SAILORS)
-- Corroborated against official R.O.C. Kosmos & Chesva 2.0 Final Results PDFs
-- ============================================================================

-- Konstantinos Sofronas (GRE) -> M
-- Source: 2024 (Bronze), 2025 (Silver), 2026 (Gold) The R.O.C. Kosmos official PDFs
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '475eab2a-5c6d-5c55-834a-ca1b4a48a502' AND gender IS NULL;

-- Paris Kolokotronis (GRE) -> M
-- Source: 2024 The R.O.C. Kosmos Gold & 2024 Chesva 2.0 R.O.C. official PDFs
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '265bf7c3-bd8e-5be2-8cb3-9a21cd69488d' AND gender IS NULL;

-- Qingying Zhang (CHN) -> F
-- Source: 2025 The R.O.C. Kosmos Bronze official PDF
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '0e3d38de-c7d0-480f-b238-0b620d9b287f' AND gender IS NULL;

-- ============================================================================
-- 2. RESULT IMPORT MONITORS UPDATE (ACKNOWLEDGE NOR AMENDMENT 2)
-- ============================================================================

-- ILCA District Championships 2026: Amendment 2 Notice of Race reviewed; race results already fully published and final
UPDATE public.result_import_monitors
SET report = jsonb_set(
  jsonb_set(report, '{status}', '"reviewed"'::jsonb),
  '{pdfCorroboration}', '"verified"'::jsonb
)
WHERE event_id = 'd205b6c5-2728-572a-8726-8d78e4afdb2b';

COMMIT;
