-- Migration 162: Reconcile Duplicate Sailors Batch 11 (Final 3 High-Confidence Duplicates)
--
-- Consolidates:
--   1. Hidetoshi Mori (RVYC, JPN) <-- Mori Hidetoshi (RVYC, JPN)
--   2. Arthit Mikhail Romanyk (THA, ILCA 7) <-- Romanyk Arthit Mikhail (THA, Asian Games)
--   3. Abdelrahman Albahri (UAE, Optimist UAE 81) <-- Abdurahman Al Bahri (Abu Dhabi SC, sail 97)
--
BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
BEGIN

  -----------------------------------------------------------------------------
  -- 1. CONSOLIDATION: Hidetoshi Mori
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02', updated_at = v_now
  WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02', updated_at = v_now
  WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02');
  UPDATE public.followed_sailors SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02');
  UPDATE public.coach_followed_sailors SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02');
  UPDATE public.coach_squad_members SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES
    ('a0781ffc-2650-5388-90bc-79429ef7ba02', 'Hidetoshi Mori'),
    ('a0781ffc-2650-5388-90bc-79429ef7ba02', 'Mori Hidetoshi')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');

  UPDATE public.sailor_claims SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');
  UPDATE public.parent_notes SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');
  UPDATE public.equipment_items SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');
  UPDATE public.equipment_logs SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');
  UPDATE public.equipment_usages SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' WHERE sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' WHERE candidate_sailor_id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'a0781ffc-2650-5388-90bc-79429ef7ba02',
    'Hidetoshi Mori <-- Mori Hidetoshi',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'a0781ffc-2650-5388-90bc-79429ef7ba02', 'survivorName', 'Hidetoshi Mori',
      'mergedId', '4fde7c15-fd39-511e-9f80-9a25c613d060', 'mergedName', 'Mori Hidetoshi',
      'reason', 'Same sailor: Mori Hidetoshi (RVYC, JPN) competed in ILCA District Championship 2025.'
    ),
    'migration_162', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('4fde7c15-fd39-511e-9f80-9a25c613d060');

  -----------------------------------------------------------------------------
  -- 2. CONSOLIDATION: Arthit Mikhail Romanyk
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb', updated_at = v_now
  WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb', updated_at = v_now
  WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb');
  UPDATE public.followed_sailors SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb');
  UPDATE public.coach_followed_sailors SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb');
  UPDATE public.coach_squad_members SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES
    ('f724016b-a2d6-5d4b-82a0-5ad506ba3bfb', 'Arthit Mikhail Romanyk'),
    ('f724016b-a2d6-5d4b-82a0-5ad506ba3bfb', 'Romanyk Arthit Mikhail')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');

  UPDATE public.sailor_claims SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');
  UPDATE public.parent_notes SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');
  UPDATE public.equipment_items SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');
  UPDATE public.equipment_logs SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');
  UPDATE public.equipment_usages SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' WHERE sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb' WHERE candidate_sailor_id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb',
    'Arthit Mikhail Romanyk <-- Romanyk Arthit Mikhail',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'f724016b-a2d6-5d4b-82a0-5ad506ba3bfb', 'survivorName', 'Arthit Mikhail Romanyk',
      'mergedId', 'dee45061-8ac2-45fb-9b3f-5e054a4ee12d', 'mergedName', 'Romanyk Arthit Mikhail',
      'reason', 'Same sailor: Thai ILCA 7 athlete competing in Asian Games and Asian Open under sail 213137.'
    ),
    'migration_162', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('dee45061-8ac2-45fb-9b3f-5e054a4ee12d');

  -----------------------------------------------------------------------------
  -- 3. CONSOLIDATION: Abdelrahman Albahri
  -----------------------------------------------------------------------------
  UPDATE public.sailors
  SET
    club = CASE WHEN club IS NULL OR club = '' OR club = 'N/A' THEN 'Abu Dhabi Sailing Club' ELSE club END,
    sail_number = COALESCE(NULLIF(sail_number, ''), '81'),
    updated_at = v_now
  WHERE id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee';

  UPDATE public.regatta_results
  SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee', updated_at = v_now
  WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee', updated_at = v_now
  WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee');
  UPDATE public.followed_sailors SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee');
  UPDATE public.coach_followed_sailors SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee');
  UPDATE public.coach_squad_members SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES
    ('b3cebd0e-9985-43f4-9b02-b1583bd0a9ee', 'Abdelrahman Albahri'),
    ('b3cebd0e-9985-43f4-9b02-b1583bd0a9ee', 'Abdurahman Al Bahri')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');

  UPDATE public.sailor_claims SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');
  UPDATE public.parent_notes SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');
  UPDATE public.equipment_items SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');
  UPDATE public.equipment_logs SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');
  UPDATE public.equipment_usages SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee' WHERE candidate_sailor_id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee',
    'Abdelrahman Albahri <-- Abdurahman Al Bahri',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'b3cebd0e-9985-43f4-9b02-b1583bd0a9ee', 'survivorName', 'Abdelrahman Albahri',
      'mergedId', 'aa1bd78d-d835-450c-85cf-fe7f28b2c0c6', 'mergedName', 'Abdurahman Al Bahri',
      'reason', 'Same sailor: UAE Optimist competitor representing Abu Dhabi Sailing Club at Singapore Youth Champs and Asian & Oceanian Championship.'
    ),
    'migration_162', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6');

END $$;

COMMIT;
