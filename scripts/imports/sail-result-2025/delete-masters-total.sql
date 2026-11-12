-- Permanently remove 2025 YRAT Cup Series 5 — ILCA 7 Master and orphaned records
-- Applied to live database: 12 November 2026
BEGIN;

DO $$
DECLARE
  v_sheet_id uuid := '06645ac7-6a03-5dcf-b0cf-dda3359e380e';
  v_races_deleted int;
  v_parts_deleted int;
  v_results_deleted int;
  v_sheets_deleted int;
  v_sailors_deleted int;
BEGIN
  -- 1. Delete race results
  WITH deleted AS (
    DELETE FROM public.regatta_race_results
    WHERE regatta_result_id IN (
      SELECT id FROM public.regatta_results WHERE regatta_id = v_sheet_id
    )
    RETURNING id
  )
  SELECT count(*) INTO v_races_deleted FROM deleted;

  -- 2. Delete result participants
  WITH deleted AS (
    DELETE FROM public.regatta_result_participants
    WHERE regatta_result_id IN (
      SELECT id FROM public.regatta_results WHERE regatta_id = v_sheet_id
    )
    RETURNING id
  )
  SELECT count(*) INTO v_parts_deleted FROM deleted;

  -- 3. Delete regatta results
  WITH deleted AS (
    DELETE FROM public.regatta_results
    WHERE regatta_id = v_sheet_id
    RETURNING id
  )
  SELECT count(*) INTO v_results_deleted FROM deleted;

  -- 4. Delete the class sheet
  WITH deleted AS (
    DELETE FROM public.regattas
    WHERE id = v_sheet_id
    RETURNING id
  )
  SELECT count(*) INTO v_sheets_deleted FROM deleted;

  -- 5. Delete orphaned sailors who have no other results or references
  WITH deleted AS (
    DELETE FROM public.sailors
    WHERE id IN ('58b7b23a-debb-5dd7-a384-ea2fc04e1840', '896f126d-aafb-5064-908d-ac7dac738531')
      AND NOT EXISTS (SELECT 1 FROM public.regatta_results WHERE sailor_id = sailors.id)
    RETURNING id
  )
  SELECT count(*) INTO v_sailors_deleted FROM deleted;

  -- 6. Log in admin_change_log
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'regatta.delete', 'regatta', v_sheet_id,
    '2025 YRAT Cup Series 5 — ILCA 7 Master',
    'Permanently deleted 2025 YRAT Cup Series 5 — ILCA 7 Master sheet and associated records.',
    jsonb_build_object(
      'sheet_id', v_sheet_id,
      'races_deleted', v_races_deleted,
      'participants_deleted', v_parts_deleted,
      'results_deleted', v_results_deleted,
      'sheets_deleted', v_sheets_deleted,
      'orphaned_sailors_deleted', v_sailors_deleted
    ),
    'user-instruction-2026-11-12', clock_timestamp()
  );

  RAISE NOTICE 'Deleted: % sheet, % results, % participants, % race results, % orphaned sailors',
    v_sheets_deleted, v_results_deleted, v_parts_deleted, v_races_deleted, v_sailors_deleted;
END $$;

COMMIT;
