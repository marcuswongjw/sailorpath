-- Migration 154: Record Keep-Separate Decision for Wang Yenchen and Yen-Chen Wang
--
-- Distinct athletes verified:
--   Wang Yenchen (6d053bcf-7741-5ee8-8028-e14d1a4f4396): Female Taiwanese Optimist sailor representing LOTUS POND (sail TPE 303, born 2011)
--   Yen-Chen Wang (b393c33b-604a-44a2-a38f-8007c7c7864c): Male Taiwanese ILCA 4 sailor representing Penghu Sailing Association (sail 163120)

BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
  v_a_id uuid := '6d053bcf-7741-5ee8-8028-e14d1a4f4396';
  v_b_id uuid := 'b393c33b-604a-44a2-a38f-8007c7c7864c';
  v_pair_key text;
BEGIN
  IF v_a_id::text < v_b_id::text THEN
    v_pair_key := v_a_id::text || '|' || v_b_id::text;
  ELSE
    v_pair_key := v_b_id::text || '|' || v_a_id::text;
  END IF;

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.duplicates.keep_separate',
    'sailor',
    v_a_id,
    'Wang Yenchen / Yen-Chen Wang',
    'Confirmed these are different sailors.',
    jsonb_build_object(
      'pairKey', v_pair_key,
      'aId', v_a_id,
      'bId', v_b_id,
      'aName', 'Wang Yenchen',
      'bName', 'Yen-Chen Wang',
      'reason', 'Distinct athletes: Wang Yenchen is a female Taiwanese Optimist sailor representing LOTUS POND (sail TPE 303, born 2011); Yen-Chen Wang is a male Taiwanese ILCA 4 sailor representing Penghu Sailing Association (sail 163120).'
    ),
    'migration_154',
    v_now
  );

END $$;

COMMIT;
