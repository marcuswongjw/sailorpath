-- Migration 150: Publish 5 Verified 2023 Singapore Regattas
--
-- Publishes 5 historical Singapore regattas with 100% complete results and race-by-race scores:
--   1. CSC ILCA Monsoon Regatta 2023 (ILCA 4 — Day 1 only) [40 entries, 160 race scores]
--   2. CSC ILCA Monsoon Regatta 2023 (ILCA 6 — Day 1 only) [15 entries, 60 race scores]
--   3. 46th Singapore ILCA Open 2023 (ILCA 4) [43 entries, 129 race scores]
--   4. CSC Optimist Championships 2023 (Optimist Gold) [73 entries, 584 race scores]
--   5. CSC Optimist Championships 2023 (Optimist Silver) [87 entries, 696 race scores]
--
-- All operations executed in a single atomic transaction.

BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
BEGIN

  -- 1. Update verification_status to 'verified' on results
  UPDATE public.regatta_results
  SET verification_status = 'verified',
      verified_at = v_now,
      updated_at = v_now
  WHERE regatta_id IN (
    '0905fb85-7eb5-5f91-8087-3d6d61ecbf36',
    '35e2a6e4-4326-5d1f-9cb5-e38438212dd2',
    'a23754cd-6639-481d-83a3-5765fde71a87',
    'aa79df34-7ac7-443f-97e7-d56e35f03179',
    'fe37b5fb-57c3-45fb-858c-2fff3d23866d'
  );

  -- 2. Update regattas status to 'published'
  UPDATE public.regattas
  SET status = 'published',
      reviewed_at = v_now,
      updated_at = v_now
  WHERE id IN (
    '0905fb85-7eb5-5f91-8087-3d6d61ecbf36',
    '35e2a6e4-4326-5d1f-9cb5-e38438212dd2',
    'a23754cd-6639-481d-83a3-5765fde71a87',
    'aa79df34-7ac7-443f-97e7-d56e35f03179',
    'fe37b5fb-57c3-45fb-858c-2fff3d23866d'
  );

  -- 3. Record in admin_change_log
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES
  (
    'regattas.publish', 'regatta', '0905fb85-7eb5-5f91-8087-3d6d61ecbf36',
    'CSC ILCA Monsoon Regatta 2023 (ILCA 4 — Day 1 only)',
    'Published regatta with 40 verified competitor finishes.',
    '{"slug": "csc-ilca-monsoon-regatta-2023-ilca4", "fleetSize": 40, "boatClass": "ILCA 4"}'::jsonb,
    'migration_150', v_now
  ),
  (
    'regattas.publish', 'regatta', '35e2a6e4-4326-5d1f-9cb5-e38438212dd2',
    'CSC ILCA Monsoon Regatta 2023 (ILCA 6 — Day 1 only)',
    'Published regatta with 15 verified competitor finishes.',
    '{"slug": "csc-ilca-monsoon-regatta-2023-ilca6", "fleetSize": 15, "boatClass": "ILCA 6"}'::jsonb,
    'migration_150', v_now
  ),
  (
    'regattas.publish', 'regatta', 'a23754cd-6639-481d-83a3-5765fde71a87',
    '46th Singapore ILCA Open 2023 (ILCA 4)',
    'Published regatta with 43 verified competitor finishes.',
    '{"slug": "singapore-ilca-open-ilca4-2023", "fleetSize": 43, "boatClass": "ILCA 4"}'::jsonb,
    'migration_150', v_now
  ),
  (
    'regattas.publish', 'regatta', 'aa79df34-7ac7-443f-97e7-d56e35f03179',
    'CSC Optimist Championships 2023 (Optimist Gold)',
    'Published regatta with 73 verified competitor finishes.',
    '{"slug": "csc-optimist-gold-2023", "fleetSize": 73, "boatClass": "Optimist"}'::jsonb,
    'migration_150', v_now
  ),
  (
    'regattas.publish', 'regatta', 'fe37b5fb-57c3-45fb-858c-2fff3d23866d',
    'CSC Optimist Championships 2023 (Optimist Silver)',
    'Published regatta with 87 verified competitor finishes.',
    '{"slug": "csc-optimist-silver-2023", "fleetSize": 87, "boatClass": "Optimist"}'::jsonb,
    'migration_150', v_now
  );

END $$;

COMMIT;
