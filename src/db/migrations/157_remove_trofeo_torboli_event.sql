-- Migration 157: Remove Trofeo Torboli from SailorPath
--
-- Deletes event '8th-autumn-meeting-48th-trofeo-torboli-2026', cleans up monitors,
-- records persistent deletion tombstone in regatta_event_deletions, and logs admin change.

BEGIN;

DO $$
DECLARE
  v_slug text := '8th-autumn-meeting-48th-trofeo-torboli-2026';
  v_event_id uuid;
  v_now timestamptz := clock_timestamp();
BEGIN
  -- 1. Find event if present in database
  SELECT id INTO v_event_id FROM public.regatta_events WHERE slug = v_slug LIMIT 1;

  IF v_event_id IS NOT NULL THEN
    -- Clean up associated result import scans and monitors
    DELETE FROM public.result_import_monitors WHERE event_id = v_event_id;
    DELETE FROM public.result_import_scans WHERE event_id = v_event_id;
    
    -- Clean up associated regattas / results if any
    DELETE FROM public.regatta_result_participants WHERE regatta_result_id IN (
      SELECT rr.id FROM public.regatta_results rr
      JOIN public.regattas r ON r.id = rr.regatta_id
      WHERE r.event_id = v_event_id
    );
    DELETE FROM public.regatta_results WHERE regatta_id IN (SELECT id FROM public.regattas WHERE event_id = v_event_id);
    DELETE FROM public.regattas WHERE event_id = v_event_id;
    
    -- Delete the event
    DELETE FROM public.regatta_events WHERE id = v_event_id;
  END IF;

  -- 2. Ensure tombstone exists in regatta_event_deletions to prevent built-in calendar re-population
  INSERT INTO public.regatta_event_deletions (slug, deleted_at)
  VALUES (v_slug, v_now)
  ON CONFLICT (slug) DO UPDATE
    SET deleted_at = EXCLUDED.deleted_at;

  -- 3. Record in admin_change_log
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'regatta_event_delete',
    'regatta_event',
    COALESCE(v_event_id, gen_random_uuid()),
    '8th Autumn Meeting & 50th Trofeo Torboli',
    'Removed Trofeo Torboli from SailorPath per administrative directive.',
    jsonb_build_object('slug', v_slug, 'reason', 'Removed per user request.'),
    'migration_157',
    v_now
  );

END $$;

COMMIT;
