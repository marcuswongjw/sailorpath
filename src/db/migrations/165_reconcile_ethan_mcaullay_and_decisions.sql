-- Migration 165: Consolidate Ethan McAullay & Record Keep-Separate for New ILCA Entries
--
-- 1. Merges 'Ethan Mcculley' (Thailand National Championships spelling typo) into Olympic sailor 'Ethan McAullay' (RPYC).
-- 2. Records 4 keep-separate decisions for distinct athletes (Sarah Yong/Young, Will James variants).
--
BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
BEGIN

  -----------------------------------------------------------------------------
  -- 1. CONSOLIDATION: Ethan McAullay <-- Ethan Mcculley
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5', updated_at = v_now WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  UPDATE public.regatta_result_participants SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5', updated_at = v_now WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5');
  UPDATE public.followed_sailors SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5' WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5');
  UPDATE public.coach_followed_sailors SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5' WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5');
  UPDATE public.coach_squad_members SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5' WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('53e1f8fb-197e-501c-97fc-10b918763ae5', 'Ethan Mcculley') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5' WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  UPDATE public.sailor_claims SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5' WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  UPDATE public.parent_notes SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5' WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  UPDATE public.equipment_items SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5' WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  UPDATE public.equipment_logs SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5' WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  UPDATE public.equipment_usages SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5' WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5' WHERE sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '53e1f8fb-197e-501c-97fc-10b918763ae5' WHERE candidate_sailor_id IN ('d3b97837-859c-59bd-81f5-9274a051f881');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '53e1f8fb-197e-501c-97fc-10b918763ae5', 'Ethan McAullay <-- Ethan Mcculley', 'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '53e1f8fb-197e-501c-97fc-10b918763ae5', 'survivorName', 'Ethan McAullay', 'mergedId', 'd3b97837-859c-59bd-81f5-9274a051f881', 'mergedName', 'Ethan Mcculley', 'reason', 'Spelling variation on Thailand National Championship sheet.'), 'migration_165', v_now);
  DELETE FROM public.sailors WHERE id IN ('d3b97837-859c-59bd-81f5-9274a051f881');

  -----------------------------------------------------------------------------
  -- 2. RECORD KEEP-SEPARATE DECISIONS
  -----------------------------------------------------------------------------
  CREATE TEMP TABLE temp_keep_separate (
    a_id uuid, b_id uuid, a_name text, b_name text, reason text
  ) ON COMMIT DROP;
  INSERT INTO temp_keep_separate (a_id, b_id, a_name, b_name, reason) VALUES
    ('82ab4ba4-a693-4e7d-a9c5-6531752cea6e', '8b0f5e16-7328-56bd-adb1-207cb7b3b6fd', 'Sarah Yong', 'Sarah Young', 'Distinct athletes: Sarah Yong (Singapore national ILCA sailor, DOB 2008-04-26) and Sarah Young (Australian youth sailor at Blairgowrie Yacht Squadron).'),
    ('6bb53a1d-beec-5217-a6bb-996c0f92b13f', '80c83919-78b9-5f7b-964c-50985463f6e0', 'William James', 'Will James', 'Distinct athletes: William James is a Tasmanian Optimist sailor at RYCT; Will James is a Victorian ILCA 6 sailor at Blairgowrie Yacht Squadron.'),
    ('80c83919-78b9-5f7b-964c-50985463f6e0', 'bc73fd04-fe8d-5903-a838-ff4570eda0e9', 'Will James', 'Will Hailes', 'Distinct athletes: Will Hailes and Will James (different surnames).'),
    ('1cec51d9-3f14-5426-ad36-4312608d8336', '80c83919-78b9-5f7b-964c-50985463f6e0', 'Will Chalmers', 'Will James', 'Distinct athletes: Will Chalmers and Will James (different surnames).');

  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  SELECT 'sailors.duplicates.keep_separate', 'sailor', t.a_id, t.a_name || ' / ' || t.b_name, 'Confirmed these are different sailors.',
    jsonb_build_object('pairKey', CASE WHEN t.a_id::text < t.b_id::text THEN t.a_id::text || '|' || t.b_id::text ELSE t.b_id::text || '|' || t.a_id::text END,
      'aId', t.a_id, 'bId', t.b_id, 'aName', t.a_name, 'bName', t.b_name, 'reason', t.reason), 'migration_165', v_now
  FROM temp_keep_separate t;

END $$;

COMMIT;
