-- Migration 145: Reconcile Duplicate Sailors Batch 8 (27 Confirmed Identity Groups + 7 Separations)
--
-- Consolidates 27 confirmed sailor duplicate groups across Singapore, Hong Kong,
-- Taiwan, Korea, Malaysia, Thailand, and China, and records 7 durable keep-separate
-- decisions for verified distinct sailors and siblings sharing equipment.
--
-- All operations executed in a single atomic transaction.

BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
BEGIN

-- ----------------------------------------------------------------------
-- Group 1: Wai Zhi Tong (wai-zhi-tong)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Wai Zhi Tong',
    nationality = COALESCE(nationality, 'SGP'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '225226'),
    updated_at = v_now
WHERE id = '903d2cf9-2099-4411-8cf0-e6074ac2c369';

-- Move regatta results from Zhi Tong Wai (ilca4-worlds26-sgp-zhi-tong-wai-e31f27)
UPDATE public.regatta_results
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369', updated_at = v_now
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';

UPDATE public.regatta_result_participants
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369', updated_at = v_now
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';

DELETE FROM public.followed_sailors
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
  );
UPDATE public.followed_sailors
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
  );
UPDATE public.coach_squad_members
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('903d2cf9-2099-4411-8cf0-e6074ac2c369', 'Wai Zhi Tong'),
  ('903d2cf9-2099-4411-8cf0-e6074ac2c369', 'Zhi Tong Wai')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';

UPDATE public.sailor_claims
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';

UPDATE public.parent_notes
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';
UPDATE public.equipment_items
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';
UPDATE public.equipment_logs
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';
UPDATE public.equipment_usages
SET sailor_id = '903d2cf9-2099-4411-8cf0-e6074ac2c369'
WHERE sailor_id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '903d2cf9-2099-4411-8cf0-e6074ac2c369',
  'Wai Zhi Tong <-- Zhi Tong Wai',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '903d2cf9-2099-4411-8cf0-e6074ac2c369',
    'survivorName', 'Wai Zhi Tong',
    'mergedId', '59b22629-a644-4b51-ed15-7664b2f8b9ab',
    'mergedName', 'Zhi Tong Wai',
    'reason', 'Singapore national sailor: Zhi Tong Wai at Aarhus Youth Worlds matches Wai Zhi Tong (sail 3458 / SGP 225226).'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '59b22629-a644-4b51-ed15-7664b2f8b9ab';


-- ----------------------------------------------------------------------
-- Group 2: Wong Weikai Zachary (wong-weikai-zachary-ft0rnv9)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Wong Weikai Zachary',
    nationality = COALESCE(nationality, 'SGP'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '221061'),
    updated_at = v_now
WHERE id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a';

-- Move regatta results from Zachary Wong (ilca4-worlds26-sgp-zachary-wong-d0bc30)
UPDATE public.regatta_results
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a', updated_at = v_now
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';

UPDATE public.regatta_result_participants
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a', updated_at = v_now
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';

DELETE FROM public.followed_sailors
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
  );
UPDATE public.followed_sailors
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
  );
UPDATE public.coach_squad_members
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a', 'Wong Weikai Zachary'),
  ('ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a', 'Zachary Wong')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';

UPDATE public.sailor_claims
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';

UPDATE public.parent_notes
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';
UPDATE public.equipment_items
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';
UPDATE public.equipment_logs
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';
UPDATE public.equipment_usages
SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'
WHERE sailor_id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a',
  'Wong Weikai Zachary <-- Zachary Wong',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a',
    'survivorName', 'Wong Weikai Zachary',
    'mergedId', '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f',
    'mergedName', 'Zachary Wong',
    'reason', 'Singapore sailor: Zachary Wong at Aarhus Youth Worlds matches Wong Weikai Zachary (sail SGP 221061).'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '0e12a9b9-90d6-9df2-24c0-e2f42ff7065f';


-- ----------------------------------------------------------------------
-- Group 3: Pee Teck Woon (pee-teck-woon)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Pee Teck Woon',
    nationality = COALESCE(nationality, 'SGP'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '228472'),
    updated_at = v_now
WHERE id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0';

-- Move regatta results from Pee Teckwoon (ilca4-worlds26-sgp-pee-teckwoon-a57565)
UPDATE public.regatta_results
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0', updated_at = v_now
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';

UPDATE public.regatta_result_participants
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0', updated_at = v_now
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';

DELETE FROM public.followed_sailors
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
  );
UPDATE public.followed_sailors
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
  );
UPDATE public.coach_squad_members
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('4c24ef37-0d0c-4d89-aba8-b60b619eabf0', 'Pee Teck Woon'),
  ('4c24ef37-0d0c-4d89-aba8-b60b619eabf0', 'Pee Teckwoon')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';

UPDATE public.sailor_claims
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';

UPDATE public.parent_notes
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';
UPDATE public.equipment_items
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';
UPDATE public.equipment_logs
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';
UPDATE public.equipment_usages
SET sailor_id = '4c24ef37-0d0c-4d89-aba8-b60b619eabf0'
WHERE sailor_id = '95e668d9-1933-46ff-5f44-33a6386258fb';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '4c24ef37-0d0c-4d89-aba8-b60b619eabf0',
  'Pee Teck Woon <-- Pee Teckwoon',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '4c24ef37-0d0c-4d89-aba8-b60b619eabf0',
    'survivorName', 'Pee Teck Woon',
    'mergedId', '95e668d9-1933-46ff-5f44-33a6386258fb',
    'mergedName', 'Pee Teckwoon',
    'reason', 'Singapore sailor: Pee Teckwoon at Aarhus Youth Worlds matches Pee Teck Woon (sail 3146 / SGP 228472).'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '95e668d9-1933-46ff-5f44-33a6386258fb';


-- ----------------------------------------------------------------------
-- Group 4: Chen Yu Kai (chen-yu-kai-thai25-ad7a6b)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Chen Yu Kai',
    nationality = COALESCE(nationality, 'TPE'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'Penghu SA / RVYC' ELSE club END,
    dob = COALESCE(dob, '2010-01-01'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '222236'),
    updated_at = v_now
WHERE id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4';

-- Move regatta results from Yu Kai Chen (yu-kai-chen-sr26-76e668)
UPDATE public.regatta_results
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', updated_at = v_now
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';

UPDATE public.regatta_result_participants
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', updated_at = v_now
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';

DELETE FROM public.followed_sailors
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
  );
UPDATE public.followed_sailors
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
  );
UPDATE public.coach_squad_members
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', 'Chen Yu Kai'),
  ('ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', 'Yu Kai Chen')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';

UPDATE public.sailor_claims
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';

UPDATE public.parent_notes
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';
UPDATE public.equipment_items
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';
UPDATE public.equipment_logs
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';
UPDATE public.equipment_usages
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4',
  'Chen Yu Kai <-- Yu Kai Chen',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4',
    'survivorName', 'Chen Yu Kai',
    'mergedId', '76e668c0-57c9-50d2-b8d5-abd0f966d313',
    'mergedName', 'Yu Kai Chen',
    'reason', 'Taiwanese ILCA 4 sailor: Chen Yu Kai, Yu Kai Chen, and Yu-Kai Chen share TPE, sail 222236, and DOB 2010-01-01.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '76e668c0-57c9-50d2-b8d5-abd0f966d313';

-- Move regatta results from Yu-Kai Chen (ilca4-tpe-yu-kai-chen-222236)
UPDATE public.regatta_results
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', updated_at = v_now
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';

UPDATE public.regatta_result_participants
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', updated_at = v_now
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';

DELETE FROM public.followed_sailors
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
  );
UPDATE public.followed_sailors
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
  );
UPDATE public.coach_squad_members
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', 'Chen Yu Kai'),
  ('ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', 'Yu-Kai Chen')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';

UPDATE public.sailor_claims
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';

UPDATE public.parent_notes
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';
UPDATE public.equipment_items
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';
UPDATE public.equipment_logs
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';
UPDATE public.equipment_usages
SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4'
WHERE sailor_id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4',
  'Chen Yu Kai <-- Yu-Kai Chen',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4',
    'survivorName', 'Chen Yu Kai',
    'mergedId', '894cc01e-0eff-40ed-8bb1-6ccd7b4326da',
    'mergedName', 'Yu-Kai Chen',
    'reason', 'Taiwanese ILCA 4 sailor: Chen Yu Kai, Yu Kai Chen, and Yu-Kai Chen share TPE, sail 222236, and DOB 2010-01-01.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '894cc01e-0eff-40ed-8bb1-6ccd7b4326da';


-- ----------------------------------------------------------------------
-- Group 5: Thomas Yong Jin Ko (ilca4-hkg-thomas-yong-jin-ko-211709)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Thomas Yong Jin Ko',
    nationality = COALESCE(nationality, 'HKG'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'Royal Hong Kong Yacht Club' ELSE club END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '211709'),
    updated_at = v_now
WHERE id = '298e864e-f79f-4e91-9caf-4a8c980f9282';

-- Move regatta results from Ko Thomas Yong Jin (ko-thomas-yong-jin-lqdwzzm)
UPDATE public.regatta_results
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282', updated_at = v_now
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';

UPDATE public.regatta_result_participants
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282', updated_at = v_now
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';

DELETE FROM public.followed_sailors
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
  );
UPDATE public.followed_sailors
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
  );
UPDATE public.coach_squad_members
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('298e864e-f79f-4e91-9caf-4a8c980f9282', 'Thomas Yong Jin Ko'),
  ('298e864e-f79f-4e91-9caf-4a8c980f9282', 'Ko Thomas Yong Jin')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';

UPDATE public.sailor_claims
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';

UPDATE public.parent_notes
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';
UPDATE public.equipment_items
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';
UPDATE public.equipment_logs
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';
UPDATE public.equipment_usages
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = '0298474b-204f-4714-abe8-85d7945bbe3c';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '298e864e-f79f-4e91-9caf-4a8c980f9282',
  'Thomas Yong Jin Ko <-- Ko Thomas Yong Jin',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '298e864e-f79f-4e91-9caf-4a8c980f9282',
    'survivorName', 'Thomas Yong Jin Ko',
    'mergedId', '0298474b-204f-4714-abe8-85d7945bbe3c',
    'mergedName', 'Ko Thomas Yong Jin',
    'reason', 'Hong Kong sailor: Thomas Yong Jin Ko, Ko Thomas Yong Jin, and Thomas Ko share HKG and ILCA sail 211709.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '0298474b-204f-4714-abe8-85d7945bbe3c';

-- Move regatta results from Thomas Ko (ilca4-hkg-thomas-ko-211709)
UPDATE public.regatta_results
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282', updated_at = v_now
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';

UPDATE public.regatta_result_participants
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282', updated_at = v_now
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';

DELETE FROM public.followed_sailors
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
  );
UPDATE public.followed_sailors
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';

DELETE FROM public.coach_squad_members
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
  );
UPDATE public.coach_squad_members
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('298e864e-f79f-4e91-9caf-4a8c980f9282', 'Thomas Yong Jin Ko'),
  ('298e864e-f79f-4e91-9caf-4a8c980f9282', 'Thomas Ko')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';

UPDATE public.sailor_claims
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';

UPDATE public.parent_notes
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';
UPDATE public.equipment_items
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';
UPDATE public.equipment_logs
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';
UPDATE public.equipment_usages
SET sailor_id = '298e864e-f79f-4e91-9caf-4a8c980f9282'
WHERE sailor_id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '298e864e-f79f-4e91-9caf-4a8c980f9282',
  'Thomas Yong Jin Ko <-- Thomas Ko',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '298e864e-f79f-4e91-9caf-4a8c980f9282',
    'survivorName', 'Thomas Yong Jin Ko',
    'mergedId', 'c09d32dd-7749-4284-89a0-051aa3539ca3',
    'mergedName', 'Thomas Ko',
    'reason', 'Hong Kong sailor: Thomas Yong Jin Ko, Ko Thomas Yong Jin, and Thomas Ko share HKG and ILCA sail 211709.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = 'c09d32dd-7749-4284-89a0-051aa3539ca3';


-- ----------------------------------------------------------------------
-- Group 6: Yilin Elaine Dong (ilca4-hkg-yilin-elaine-dong-211688)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Yilin Elaine Dong',
    nationality = COALESCE(nationality, 'HKG'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'HKSF' ELSE club END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '211688'),
    updated_at = v_now
WHERE id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52';

-- Move regatta results from Dong Yilin Elaine (dong-yilin-elaine-lwxonfj)
UPDATE public.regatta_results
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52', updated_at = v_now
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';

UPDATE public.regatta_result_participants
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52', updated_at = v_now
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';

DELETE FROM public.followed_sailors
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
  );
UPDATE public.followed_sailors
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
  );
UPDATE public.coach_squad_members
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('fa5098ea-478e-449b-beaf-f0f3b101ab52', 'Yilin Elaine Dong'),
  ('fa5098ea-478e-449b-beaf-f0f3b101ab52', 'Dong Yilin Elaine')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';

UPDATE public.sailor_claims
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';

UPDATE public.parent_notes
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';
UPDATE public.equipment_items
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';
UPDATE public.equipment_logs
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';
UPDATE public.equipment_usages
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = '6ba5b8db-582a-419c-9346-18a47f6a7524';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  'fa5098ea-478e-449b-beaf-f0f3b101ab52',
  'Yilin Elaine Dong <-- Dong Yilin Elaine',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', 'fa5098ea-478e-449b-beaf-f0f3b101ab52',
    'survivorName', 'Yilin Elaine Dong',
    'mergedId', '6ba5b8db-582a-419c-9346-18a47f6a7524',
    'mergedName', 'Dong Yilin Elaine',
    'reason', 'Hong Kong sailor: Yilin Elaine Dong, Dong Yilin Elaine, and Elaine Dong share HKG and ILCA sail 211688.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '6ba5b8db-582a-419c-9346-18a47f6a7524';

-- Move regatta results from Elaine Dong (ilca4-hkg-elaine-dong-211688)
UPDATE public.regatta_results
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52', updated_at = v_now
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';

UPDATE public.regatta_result_participants
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52', updated_at = v_now
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';

DELETE FROM public.followed_sailors
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
  );
UPDATE public.followed_sailors
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';

DELETE FROM public.coach_squad_members
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
  );
UPDATE public.coach_squad_members
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('fa5098ea-478e-449b-beaf-f0f3b101ab52', 'Yilin Elaine Dong'),
  ('fa5098ea-478e-449b-beaf-f0f3b101ab52', 'Elaine Dong')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';

UPDATE public.sailor_claims
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';

UPDATE public.parent_notes
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';
UPDATE public.equipment_items
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';
UPDATE public.equipment_logs
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';
UPDATE public.equipment_usages
SET sailor_id = 'fa5098ea-478e-449b-beaf-f0f3b101ab52'
WHERE sailor_id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  'fa5098ea-478e-449b-beaf-f0f3b101ab52',
  'Yilin Elaine Dong <-- Elaine Dong',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', 'fa5098ea-478e-449b-beaf-f0f3b101ab52',
    'survivorName', 'Yilin Elaine Dong',
    'mergedId', 'e746e3eb-33b5-499a-8439-cbf3fbaf517d',
    'mergedName', 'Elaine Dong',
    'reason', 'Hong Kong sailor: Yilin Elaine Dong, Dong Yilin Elaine, and Elaine Dong share HKG and ILCA sail 211688.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = 'e746e3eb-33b5-499a-8439-cbf3fbaf517d';


-- ----------------------------------------------------------------------
-- Group 7: Zhuowen Sophie Shao (ilca4-hkg-zhuowen-sophie-shao-191718)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Zhuowen Sophie Shao',
    nationality = COALESCE(nationality, 'HKG'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'HHYC' ELSE club END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '191718'),
    updated_at = v_now
WHERE id = '51c49278-d004-470a-9cc5-4ca495ae17b7';

-- Move regatta results from Shao Zhuowen Sophie (shao-zhuowen-sophie-0bxv7fx)
UPDATE public.regatta_results
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7', updated_at = v_now
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';

UPDATE public.regatta_result_participants
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7', updated_at = v_now
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';

DELETE FROM public.followed_sailors
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
  );
UPDATE public.followed_sailors
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
  );
UPDATE public.coach_squad_members
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('51c49278-d004-470a-9cc5-4ca495ae17b7', 'Zhuowen Sophie Shao'),
  ('51c49278-d004-470a-9cc5-4ca495ae17b7', 'Shao Zhuowen Sophie')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';

UPDATE public.sailor_claims
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';

UPDATE public.parent_notes
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';
UPDATE public.equipment_items
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';
UPDATE public.equipment_logs
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';
UPDATE public.equipment_usages
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '51c49278-d004-470a-9cc5-4ca495ae17b7',
  'Zhuowen Sophie Shao <-- Shao Zhuowen Sophie',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '51c49278-d004-470a-9cc5-4ca495ae17b7',
    'survivorName', 'Zhuowen Sophie Shao',
    'mergedId', '622f6f16-95ee-4816-a2f8-a30cd48b1f6c',
    'mergedName', 'Shao Zhuowen Sophie',
    'reason', 'Hong Kong sailor: Zhuowen Sophie Shao, Shao Zhuowen Sophie, and Sophie Shao share HKG and ILCA sail 191718 / 215314.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '622f6f16-95ee-4816-a2f8-a30cd48b1f6c';

-- Move regatta results from Sophie Shao (ilca4-hkg-sophie-shao-215314)
UPDATE public.regatta_results
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7', updated_at = v_now
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';

UPDATE public.regatta_result_participants
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7', updated_at = v_now
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';

DELETE FROM public.followed_sailors
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
  );
UPDATE public.followed_sailors
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';

DELETE FROM public.coach_squad_members
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
  );
UPDATE public.coach_squad_members
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('51c49278-d004-470a-9cc5-4ca495ae17b7', 'Zhuowen Sophie Shao'),
  ('51c49278-d004-470a-9cc5-4ca495ae17b7', 'Sophie Shao')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';

UPDATE public.sailor_claims
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';

UPDATE public.parent_notes
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';
UPDATE public.equipment_items
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';
UPDATE public.equipment_logs
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';
UPDATE public.equipment_usages
SET sailor_id = '51c49278-d004-470a-9cc5-4ca495ae17b7'
WHERE sailor_id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '51c49278-d004-470a-9cc5-4ca495ae17b7',
  'Zhuowen Sophie Shao <-- Sophie Shao',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '51c49278-d004-470a-9cc5-4ca495ae17b7',
    'survivorName', 'Zhuowen Sophie Shao',
    'mergedId', 'eaef4797-80e6-4c53-abc6-691cae49a19c',
    'mergedName', 'Sophie Shao',
    'reason', 'Hong Kong sailor: Zhuowen Sophie Shao, Shao Zhuowen Sophie, and Sophie Shao share HKG and ILCA sail 191718 / 215314.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = 'eaef4797-80e6-4c53-abc6-691cae49a19c';


-- ----------------------------------------------------------------------
-- Group 8: Seoyi An (asian-kor-seoyi-an-4eb55a)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Seoyi An',
    nationality = COALESCE(nationality, 'KOR'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'Gangwon Sailing Team' ELSE club END,
    dob = COALESCE(dob, '2013-01-01'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '190953'),
    updated_at = v_now
WHERE id = '40a23367-69df-42e3-8907-be4a7919fb4e';

-- Move regatta results from An Seoyi (an-seoyi-sr26-47cfa1)
UPDATE public.regatta_results
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e', updated_at = v_now
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';

UPDATE public.regatta_result_participants
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e', updated_at = v_now
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';

DELETE FROM public.followed_sailors
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
  );
UPDATE public.followed_sailors
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
  );
UPDATE public.coach_squad_members
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('40a23367-69df-42e3-8907-be4a7919fb4e', 'Seoyi An'),
  ('40a23367-69df-42e3-8907-be4a7919fb4e', 'An Seoyi')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';

UPDATE public.sailor_claims
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';

UPDATE public.parent_notes
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';
UPDATE public.equipment_items
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';
UPDATE public.equipment_logs
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';
UPDATE public.equipment_usages
SET sailor_id = '40a23367-69df-42e3-8907-be4a7919fb4e'
WHERE sailor_id = '47cfa169-dc99-599b-b90c-020a461aef30';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '40a23367-69df-42e3-8907-be4a7919fb4e',
  'Seoyi An <-- An Seoyi',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '40a23367-69df-42e3-8907-be4a7919fb4e',
    'survivorName', 'Seoyi An',
    'mergedId', '47cfa169-dc99-599b-b90c-020a461aef30',
    'mergedName', 'An Seoyi',
    'reason', 'Korean sailor: Seoyi An and An Seoyi share KOR, Gangwon club, DOB 2013-01-01, and equipment transition.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '47cfa169-dc99-599b-b90c-020a461aef30';


-- ----------------------------------------------------------------------
-- Group 9: Yeh Chen Yang (yeh-chen-yang-thai25-077c93)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Yeh Chen Yang',
    nationality = COALESCE(nationality, 'TPE'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'Penghu SA / RVYC' ELSE club END,
    dob = COALESCE(dob, '2012-01-01'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214553'),
    updated_at = v_now
WHERE id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e';

-- Move regatta results from Chen-Yang Yeh (ilca4-tpe-chen-yang-yeh-214553)
UPDATE public.regatta_results
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e', updated_at = v_now
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';

UPDATE public.regatta_result_participants
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e', updated_at = v_now
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';

DELETE FROM public.followed_sailors
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
  );
UPDATE public.followed_sailors
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
  );
UPDATE public.coach_squad_members
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e', 'Yeh Chen Yang'),
  ('077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e', 'Chen-Yang Yeh')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';

UPDATE public.sailor_claims
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';

UPDATE public.parent_notes
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';
UPDATE public.equipment_items
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';
UPDATE public.equipment_logs
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';
UPDATE public.equipment_usages
SET sailor_id = '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e'
WHERE sailor_id = '5a75e565-4a2a-4237-b167-34acf3240927';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e',
  'Yeh Chen Yang <-- Chen-Yang Yeh',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e',
    'survivorName', 'Yeh Chen Yang',
    'mergedId', '5a75e565-4a2a-4237-b167-34acf3240927',
    'mergedName', 'Chen-Yang Yeh',
    'reason', 'Taiwanese sailor: Yeh Chen Yang and Chen-Yang Yeh share TPE, DOB 2012-01-01, and equipment transition (Opti 422 -> ILCA 4 214553).'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '5a75e565-4a2a-4237-b167-34acf3240927';


-- ----------------------------------------------------------------------
-- Group 10: Cheung Manchak (cheung-manchak-64rzofu)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Cheung Manchak',
    nationality = COALESCE(nationality, 'HKG'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'HHYC' ELSE club END,
    dob = COALESCE(dob, '2011-09-12'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '190912'),
    updated_at = v_now
WHERE id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80';

-- Move regatta results from Manchak Cheung (ilca4-hkg-manchak-cheung-190912)
UPDATE public.regatta_results
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80', updated_at = v_now
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';

UPDATE public.regatta_result_participants
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80', updated_at = v_now
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';

DELETE FROM public.followed_sailors
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
  );
UPDATE public.followed_sailors
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
  );
UPDATE public.coach_squad_members
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('ed8074f6-7f84-48b5-8152-fcb78572ac80', 'Cheung Manchak'),
  ('ed8074f6-7f84-48b5-8152-fcb78572ac80', 'Manchak Cheung')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';

UPDATE public.sailor_claims
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';

UPDATE public.parent_notes
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';
UPDATE public.equipment_items
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';
UPDATE public.equipment_logs
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';
UPDATE public.equipment_usages
SET sailor_id = 'ed8074f6-7f84-48b5-8152-fcb78572ac80'
WHERE sailor_id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  'ed8074f6-7f84-48b5-8152-fcb78572ac80',
  'Cheung Manchak <-- Manchak Cheung',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', 'ed8074f6-7f84-48b5-8152-fcb78572ac80',
    'survivorName', 'Cheung Manchak',
    'mergedId', '83fc0396-575e-48e5-bb65-11d0cc4513a8',
    'mergedName', 'Manchak Cheung',
    'reason', 'Hong Kong sailor: Cheung Manchak and Manchak Cheung share HKG, DOB 2011-09-12, and equipment transition (Opti 302 -> ILCA 4 190912).'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '83fc0396-575e-48e5-bb65-11d0cc4513a8';


-- ----------------------------------------------------------------------
-- Group 11: Huang Chi Fang (huang-chi-fang-thai25-9bdb02)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Huang Chi Fang',
    nationality = COALESCE(nationality, 'TPE'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'KSAF / RVYC' ELSE club END,
    dob = COALESCE(dob, '2010-01-01'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '220975'),
    updated_at = v_now
WHERE id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24';

-- Move regatta results from Chi-Fang Huang (ilca4-tpe-chi-fang-huang-220975)
UPDATE public.regatta_results
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24', updated_at = v_now
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';

UPDATE public.regatta_result_participants
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24', updated_at = v_now
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';

DELETE FROM public.followed_sailors
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
  );
UPDATE public.followed_sailors
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';

DELETE FROM public.coach_squad_members
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
  );
UPDATE public.coach_squad_members
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24', 'Huang Chi Fang'),
  ('9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24', 'Chi-Fang Huang')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';

UPDATE public.sailor_claims
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';

UPDATE public.parent_notes
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';
UPDATE public.equipment_items
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';
UPDATE public.equipment_logs
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';
UPDATE public.equipment_usages
SET sailor_id = '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24'
WHERE sailor_id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24',
  'Huang Chi Fang <-- Chi-Fang Huang',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24',
    'survivorName', 'Huang Chi Fang',
    'mergedId', 'cebf0f71-d1ae-4087-9173-81e58a2d9694',
    'mergedName', 'Chi-Fang Huang',
    'reason', 'Taiwanese sailor: Huang Chi Fang and Chi-Fang Huang share TPE, DOB 2010-01-01, and equipment transition (Opti 306 -> ILCA 4 220975).'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = 'cebf0f71-d1ae-4087-9173-81e58a2d9694';


-- ----------------------------------------------------------------------
-- Group 12: Jihoo Kim (asian-kor-jihoo-kim-263754)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Jihoo Kim',
    nationality = COALESCE(nationality, 'KOR'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'KSAF' ELSE club END,
    dob = COALESCE(dob, '2012-01-01'),
    updated_at = v_now
WHERE id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e';

-- Move regatta results from Kim Jihoo (kim-jihoo-sr26-a1a0f3)
UPDATE public.regatta_results
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e', updated_at = v_now
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';

UPDATE public.regatta_result_participants
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e', updated_at = v_now
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';

DELETE FROM public.followed_sailors
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
  );
UPDATE public.followed_sailors
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';

DELETE FROM public.coach_squad_members
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
  );
UPDATE public.coach_squad_members
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e', 'Jihoo Kim'),
  ('8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e', 'Kim Jihoo')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';

UPDATE public.sailor_claims
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';

UPDATE public.parent_notes
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';
UPDATE public.equipment_items
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';
UPDATE public.equipment_logs
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';
UPDATE public.equipment_usages
SET sailor_id = '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e'
WHERE sailor_id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e',
  'Jihoo Kim <-- Kim Jihoo',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e',
    'survivorName', 'Jihoo Kim',
    'mergedId', 'a1a0f318-2766-5caa-b62f-13326d532d4e',
    'mergedName', 'Kim Jihoo',
    'reason', 'Korean sailor: Jihoo Kim and Kim Jihoo share KOR, KSAF, sail 562, and DOB 2012-01-01.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = 'a1a0f318-2766-5caa-b62f-13326d532d4e';


-- ----------------------------------------------------------------------
-- Group 13: Songha Lee (ilca4-kor-songha-lee-223204)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Songha Lee',
    nationality = COALESCE(nationality, 'KOR'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'Busan Sailing Federation' ELSE club END,
    dob = COALESCE(dob, '2011-01-01'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '223204'),
    updated_at = v_now
WHERE id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d';

-- Move regatta results from Lee Songha (lee-songha-thai25-1417d1)
UPDATE public.regatta_results
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d', updated_at = v_now
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';

UPDATE public.regatta_result_participants
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d', updated_at = v_now
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';

DELETE FROM public.followed_sailors
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
  );
UPDATE public.followed_sailors
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
  );
UPDATE public.coach_squad_members
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('d3bdd575-51a9-46c8-8b02-b254b18b100d', 'Songha Lee'),
  ('d3bdd575-51a9-46c8-8b02-b254b18b100d', 'Lee Songha')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';

UPDATE public.sailor_claims
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';

UPDATE public.parent_notes
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';
UPDATE public.equipment_items
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';
UPDATE public.equipment_logs
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';
UPDATE public.equipment_usages
SET sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d'
WHERE sailor_id = '1417d151-f47b-5780-8ab8-efbc022a440f';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  'd3bdd575-51a9-46c8-8b02-b254b18b100d',
  'Songha Lee <-- Lee Songha',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', 'd3bdd575-51a9-46c8-8b02-b254b18b100d',
    'survivorName', 'Songha Lee',
    'mergedId', '1417d151-f47b-5780-8ab8-efbc022a440f',
    'mergedName', 'Lee Songha',
    'reason', 'Korean sailor: Songha Lee and Lee Songha share KOR, DOB 2011-01-01, and equipment transition (Opti KOR 520 -> ILCA 4 223204).'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '1417d151-f47b-5780-8ab8-efbc022a440f';


-- ----------------------------------------------------------------------
-- Group 14: Tzu-Ho Liu (ilca4-tpe-tzu-ho-liu-217714)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Tzu-Ho Liu',
    nationality = COALESCE(nationality, 'TPE'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'Penghu SA' ELSE club END,
    dob = COALESCE(dob, '2009-01-01'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '217714'),
    updated_at = v_now
WHERE id = 'f661a603-313b-472f-a363-9d58914e04c0';

-- Move regatta results from Liu Tzu Ho (liu-tzu-ho-sr26-6b17e3)
UPDATE public.regatta_results
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0', updated_at = v_now
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';

UPDATE public.regatta_result_participants
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0', updated_at = v_now
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';

DELETE FROM public.followed_sailors
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
  );
UPDATE public.followed_sailors
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
  );
UPDATE public.coach_squad_members
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('f661a603-313b-472f-a363-9d58914e04c0', 'Tzu-Ho Liu'),
  ('f661a603-313b-472f-a363-9d58914e04c0', 'Liu Tzu Ho')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';

UPDATE public.sailor_claims
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';

UPDATE public.parent_notes
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';
UPDATE public.equipment_items
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';
UPDATE public.equipment_logs
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';
UPDATE public.equipment_usages
SET sailor_id = 'f661a603-313b-472f-a363-9d58914e04c0'
WHERE sailor_id = '6b17e39b-16cf-50f3-ab55-ee809710b347';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  'f661a603-313b-472f-a363-9d58914e04c0',
  'Tzu-Ho Liu <-- Liu Tzu Ho',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', 'f661a603-313b-472f-a363-9d58914e04c0',
    'survivorName', 'Tzu-Ho Liu',
    'mergedId', '6b17e39b-16cf-50f3-ab55-ee809710b347',
    'mergedName', 'Liu Tzu Ho',
    'reason', 'Taiwanese sailor: Tzu-Ho Liu and Liu Tzu Ho share TPE, Penghu SA, sail 217714, and DOB 2009-01-01.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '6b17e39b-16cf-50f3-ab55-ee809710b347';


-- ----------------------------------------------------------------------
-- Group 15: Yixiu Luo (yixiu-luo-thai25-850d22)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Yixiu Luo',
    nationality = COALESCE(nationality, 'CHN'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'Vanhang Sailing' ELSE club END,
    dob = COALESCE(dob, '2009-01-01'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '210703'),
    updated_at = v_now
WHERE id = '850d22a6-c404-5711-b0ab-e99507659b38';

-- Move regatta results from Luo Yixiu (luo-yixiu-sr26-a4b376)
UPDATE public.regatta_results
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38', updated_at = v_now
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';

UPDATE public.regatta_result_participants
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38', updated_at = v_now
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';

DELETE FROM public.followed_sailors
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
  );
UPDATE public.followed_sailors
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';

DELETE FROM public.coach_squad_members
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
  );
UPDATE public.coach_squad_members
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('850d22a6-c404-5711-b0ab-e99507659b38', 'Yixiu Luo'),
  ('850d22a6-c404-5711-b0ab-e99507659b38', 'Luo Yixiu')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';

UPDATE public.sailor_claims
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';

UPDATE public.parent_notes
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';
UPDATE public.equipment_items
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';
UPDATE public.equipment_logs
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';
UPDATE public.equipment_usages
SET sailor_id = '850d22a6-c404-5711-b0ab-e99507659b38'
WHERE sailor_id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '850d22a6-c404-5711-b0ab-e99507659b38',
  'Yixiu Luo <-- Luo Yixiu',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '850d22a6-c404-5711-b0ab-e99507659b38',
    'survivorName', 'Yixiu Luo',
    'mergedId', 'a4b3769f-96a6-5f1b-a38c-58b6da594d40',
    'mergedName', 'Luo Yixiu',
    'reason', 'Chinese sailor: Yixiu Luo and Luo Yixiu share CHN, Vanhang Sailing, sail 210703, and DOB 2009-01-01.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = 'a4b3769f-96a6-5f1b-a38c-58b6da594d40';


-- ----------------------------------------------------------------------
-- Group 16: Sai Kit Tse (ilca4-hkg-sai-kit-tse-211740)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Sai Kit Tse',
    nationality = COALESCE(nationality, 'HKG'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'HKSF' ELSE club END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '211740'),
    updated_at = v_now
WHERE id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887';

-- Move regatta results from Tse Sai Kit (tse-sai-kit-lzoeucw)
UPDATE public.regatta_results
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887', updated_at = v_now
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';

UPDATE public.regatta_result_participants
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887', updated_at = v_now
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';

DELETE FROM public.followed_sailors
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
  );
UPDATE public.followed_sailors
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
  );
UPDATE public.coach_squad_members
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('a09d2e38-b5d8-4f1b-976d-f2e2dd38a887', 'Sai Kit Tse'),
  ('a09d2e38-b5d8-4f1b-976d-f2e2dd38a887', 'Tse Sai Kit')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';

UPDATE public.sailor_claims
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';

UPDATE public.parent_notes
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';
UPDATE public.equipment_items
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';
UPDATE public.equipment_logs
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';
UPDATE public.equipment_usages
SET sailor_id = 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887'
WHERE sailor_id = '856c1281-5b0f-47de-b947-a5689c1f6a97';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887',
  'Sai Kit Tse <-- Tse Sai Kit',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', 'a09d2e38-b5d8-4f1b-976d-f2e2dd38a887',
    'survivorName', 'Sai Kit Tse',
    'mergedId', '856c1281-5b0f-47de-b947-a5689c1f6a97',
    'mergedName', 'Tse Sai Kit',
    'reason', 'Hong Kong sailor: Sai Kit Tse and Tse Sai Kit share HKG, HKSF, and ILCA sail 211740.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '856c1281-5b0f-47de-b947-a5689c1f6a97';


-- ----------------------------------------------------------------------
-- Group 17: Chen Yu Shin (chen-yu-shin-thai25-27cdb9)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Chen Yu Shin',
    nationality = COALESCE(nationality, 'TPE'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'RVYC' ELSE club END,
    dob = COALESCE(dob, '2008-01-01'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '213037'),
    updated_at = v_now
WHERE id = '27cdb9d1-3035-5a39-b85a-94533038a886';

-- Move regatta results from Yu Shin Chen (yu-shin-chen-sr26-9922c4)
UPDATE public.regatta_results
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886', updated_at = v_now
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';

UPDATE public.regatta_result_participants
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886', updated_at = v_now
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';

DELETE FROM public.followed_sailors
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
  );
UPDATE public.followed_sailors
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
  );
UPDATE public.coach_squad_members
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('27cdb9d1-3035-5a39-b85a-94533038a886', 'Chen Yu Shin'),
  ('27cdb9d1-3035-5a39-b85a-94533038a886', 'Yu Shin Chen')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';

UPDATE public.sailor_claims
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';

UPDATE public.parent_notes
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';
UPDATE public.equipment_items
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';
UPDATE public.equipment_logs
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';
UPDATE public.equipment_usages
SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886'
WHERE sailor_id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '27cdb9d1-3035-5a39-b85a-94533038a886',
  'Chen Yu Shin <-- Yu Shin Chen',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '27cdb9d1-3035-5a39-b85a-94533038a886',
    'survivorName', 'Chen Yu Shin',
    'mergedId', '9922c443-cb7b-5e62-b6c6-0c78d8d89164',
    'mergedName', 'Yu Shin Chen',
    'reason', 'Taiwanese sailor: Chen Yu Shin and Yu Shin Chen share TPE, RVYC, sail 213037, and DOB 2008-01-01.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '9922c443-cb7b-5e62-b6c6-0c78d8d89164';


-- ----------------------------------------------------------------------
-- Group 18: Muhammad Aiman Aqeel Bin Mohd Firdaus (muhammad-aiman-aqeel-bin-mohd-firdaus-29c7tud)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Muhammad Aiman Aqeel Bin Mohd Firdaus',
    nationality = COALESCE(nationality, 'MAS'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '209885'),
    updated_at = v_now
WHERE id = '9a560745-0f52-4fd7-b4f9-f6409489ae84';

-- Move regatta results from Muhammad Aiman Aqeel Mohd Firdaus (ilca4-worlds26-mas-muhammad-aiman-aqeel-mohd-firdaus-19fa5b)
UPDATE public.regatta_results
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84', updated_at = v_now
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';

UPDATE public.regatta_result_participants
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84', updated_at = v_now
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';

DELETE FROM public.followed_sailors
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
  );
UPDATE public.followed_sailors
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
  );
UPDATE public.coach_squad_members
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('9a560745-0f52-4fd7-b4f9-f6409489ae84', 'Muhammad Aiman Aqeel Bin Mohd Firdaus'),
  ('9a560745-0f52-4fd7-b4f9-f6409489ae84', 'Muhammad Aiman Aqeel Mohd Firdaus')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';

UPDATE public.sailor_claims
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';

UPDATE public.parent_notes
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';
UPDATE public.equipment_items
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';
UPDATE public.equipment_logs
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';
UPDATE public.equipment_usages
SET sailor_id = '9a560745-0f52-4fd7-b4f9-f6409489ae84'
WHERE sailor_id = '232e6810-5909-fa33-4190-d98339f997ba';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '9a560745-0f52-4fd7-b4f9-f6409489ae84',
  'Muhammad Aiman Aqeel Bin Mohd Firdaus <-- Muhammad Aiman Aqeel Mohd Firdaus',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '9a560745-0f52-4fd7-b4f9-f6409489ae84',
    'survivorName', 'Muhammad Aiman Aqeel Bin Mohd Firdaus',
    'mergedId', '232e6810-5909-fa33-4190-d98339f997ba',
    'mergedName', 'Muhammad Aiman Aqeel Mohd Firdaus',
    'reason', 'Malaysian sailor: Bin omitted on international Aarhus entry (Opti 1030 -> ILCA 4 MAS 209885).'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '232e6810-5909-fa33-4190-d98339f997ba';


-- ----------------------------------------------------------------------
-- Group 19: Nur Hafizanah Binti Zailan (nur-hafizanah-binti-zailan-25131kd)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Nur Hafizanah Binti Zailan',
    nationality = COALESCE(nationality, 'MAS'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '209887'),
    updated_at = v_now
WHERE id = '96bfe722-1e1a-4e2c-901e-dae4789973ac';

-- Move regatta results from Nur Hafizanah Zailan (ilca4-worlds26-mas-nur-hafizanah-zailan-55c9c4)
UPDATE public.regatta_results
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac', updated_at = v_now
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';

UPDATE public.regatta_result_participants
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac', updated_at = v_now
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';

DELETE FROM public.followed_sailors
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
  );
UPDATE public.followed_sailors
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
  );
UPDATE public.coach_squad_members
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('96bfe722-1e1a-4e2c-901e-dae4789973ac', 'Nur Hafizanah Binti Zailan'),
  ('96bfe722-1e1a-4e2c-901e-dae4789973ac', 'Nur Hafizanah Zailan')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';

UPDATE public.sailor_claims
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';

UPDATE public.parent_notes
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';
UPDATE public.equipment_items
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';
UPDATE public.equipment_logs
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';
UPDATE public.equipment_usages
SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac'
WHERE sailor_id = '29e003c3-5609-22ac-8091-5da873471aab';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '96bfe722-1e1a-4e2c-901e-dae4789973ac',
  'Nur Hafizanah Binti Zailan <-- Nur Hafizanah Zailan',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '96bfe722-1e1a-4e2c-901e-dae4789973ac',
    'survivorName', 'Nur Hafizanah Binti Zailan',
    'mergedId', '29e003c3-5609-22ac-8091-5da873471aab',
    'mergedName', 'Nur Hafizanah Zailan',
    'reason', 'Malaysian sailor: Binti omitted at Aarhus (Opti 1031 -> ILCA 4 MAS 209887).'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '29e003c3-5609-22ac-8091-5da873471aab';


-- ----------------------------------------------------------------------
-- Group 20: John James Dwyer (ilca4-worlds26-jpn-john-james-dwyer-cdbe59)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'John James Dwyer',
    nationality = COALESCE(nationality, 'JPN'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '184018'),
    updated_at = v_now
WHERE id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b';

-- Move regatta results from John Dwyer (ilca4-jpn-john-dwyer-184018)
UPDATE public.regatta_results
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b', updated_at = v_now
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';

UPDATE public.regatta_result_participants
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b', updated_at = v_now
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';

DELETE FROM public.followed_sailors
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
  );
UPDATE public.followed_sailors
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';

DELETE FROM public.coach_squad_members
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
  );
UPDATE public.coach_squad_members
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('5d5f8208-435a-96b2-3d1c-2f5386b9a65b', 'John James Dwyer'),
  ('5d5f8208-435a-96b2-3d1c-2f5386b9a65b', 'John Dwyer')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';

UPDATE public.sailor_claims
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';

UPDATE public.parent_notes
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';
UPDATE public.equipment_items
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';
UPDATE public.equipment_logs
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';
UPDATE public.equipment_usages
SET sailor_id = '5d5f8208-435a-96b2-3d1c-2f5386b9a65b'
WHERE sailor_id = 'bbc98c87-4365-4da5-880a-59a124e838ef';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '5d5f8208-435a-96b2-3d1c-2f5386b9a65b',
  'John James Dwyer <-- John Dwyer',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '5d5f8208-435a-96b2-3d1c-2f5386b9a65b',
    'survivorName', 'John James Dwyer',
    'mergedId', 'bbc98c87-4365-4da5-880a-59a124e838ef',
    'mergedName', 'John Dwyer',
    'reason', 'Japanese sailor: John James Dwyer and John Dwyer share JPN and ILCA sail 184018.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = 'bbc98c87-4365-4da5-880a-59a124e838ef';


-- ----------------------------------------------------------------------
-- Group 21: Jiun Choi (ilca4-worlds26-kor-jiun-choi-614785)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Jiun Choi',
    nationality = COALESCE(nationality, 'KOR'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'Busan Sailing Federation' ELSE club END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '225770'),
    updated_at = v_now
WHERE id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04';

-- Move regatta results from Ji Un Choi (ilca4-kor-ji-un-choi-223205)
UPDATE public.regatta_results
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04', updated_at = v_now
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';

UPDATE public.regatta_result_participants
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04', updated_at = v_now
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';

DELETE FROM public.followed_sailors
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
  );
UPDATE public.followed_sailors
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
  );
UPDATE public.coach_squad_members
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('ce173919-c652-6d75-85d7-bd3ed17f9a04', 'Jiun Choi'),
  ('ce173919-c652-6d75-85d7-bd3ed17f9a04', 'Ji Un Choi')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';

UPDATE public.sailor_claims
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';

UPDATE public.parent_notes
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';
UPDATE public.equipment_items
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';
UPDATE public.equipment_logs
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';
UPDATE public.equipment_usages
SET sailor_id = 'ce173919-c652-6d75-85d7-bd3ed17f9a04'
WHERE sailor_id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  'ce173919-c652-6d75-85d7-bd3ed17f9a04',
  'Jiun Choi <-- Ji Un Choi',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', 'ce173919-c652-6d75-85d7-bd3ed17f9a04',
    'survivorName', 'Jiun Choi',
    'mergedId', '3edbd449-8bb5-49f1-b73a-9e7a47a9c953',
    'mergedName', 'Ji Un Choi',
    'reason', 'Korean sailor: Jiun Choi and Ji Un Choi share KOR and Busan Sailing Federation.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '3edbd449-8bb5-49f1-b73a-9e7a47a9c953';


-- ----------------------------------------------------------------------
-- Group 22: Aueangkun Jadsanam (aueangkun-jadsanam-sr26-2b2f39)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Aueangkun Jadsanam',
    nationality = COALESCE(nationality, 'THA'),
    dob = COALESCE(dob, '2009-01-01'),
    updated_at = v_now
WHERE id = '2b2f3955-49bf-5a67-8643-70307409f211';

-- Move regatta results from Auengkun Jadsanam (auengkun-jadsanam-sr26-525c8f)
UPDATE public.regatta_results
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211', updated_at = v_now
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';

UPDATE public.regatta_result_participants
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211', updated_at = v_now
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';

DELETE FROM public.followed_sailors
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
  );
UPDATE public.followed_sailors
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
  );
UPDATE public.coach_squad_members
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('2b2f3955-49bf-5a67-8643-70307409f211', 'Aueangkun Jadsanam'),
  ('2b2f3955-49bf-5a67-8643-70307409f211', 'Auengkun Jadsanam')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';

UPDATE public.sailor_claims
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';

UPDATE public.parent_notes
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';
UPDATE public.equipment_items
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';
UPDATE public.equipment_logs
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';
UPDATE public.equipment_usages
SET sailor_id = '2b2f3955-49bf-5a67-8643-70307409f211'
WHERE sailor_id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '2b2f3955-49bf-5a67-8643-70307409f211',
  'Aueangkun Jadsanam <-- Auengkun Jadsanam',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '2b2f3955-49bf-5a67-8643-70307409f211',
    'survivorName', 'Aueangkun Jadsanam',
    'mergedId', '525c8f5b-4c1f-538c-87c7-cb13aa28fb15',
    'mergedName', 'Auengkun Jadsanam',
    'reason', 'Thai sailor: 1-character vowel variation (Aueangkun vs Auengkun), same DOB 2009-01-01.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '525c8f5b-4c1f-538c-87c7-cb13aa28fb15';


-- ----------------------------------------------------------------------
-- Group 23: Yiming Jason Wu (yiming-jason-wu-sr26-4feb0a)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Yiming Jason Wu',
    nationality = COALESCE(nationality, 'CHN'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'Vanhang Sailing' ELSE club END,
    dob = COALESCE(dob, '2009-01-01'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214250'),
    updated_at = v_now
WHERE id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c';

-- Move regatta results from Yiming Wu (yiming-wu-thai25-471946)
UPDATE public.regatta_results
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c', updated_at = v_now
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';

UPDATE public.regatta_result_participants
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c', updated_at = v_now
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';

DELETE FROM public.followed_sailors
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
  );
UPDATE public.followed_sailors
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
  );
UPDATE public.coach_squad_members
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('4feb0abb-02a8-5276-8afb-c1bbe5a85d7c', 'Yiming Jason Wu'),
  ('4feb0abb-02a8-5276-8afb-c1bbe5a85d7c', 'Yiming Wu')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';

UPDATE public.sailor_claims
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';

UPDATE public.parent_notes
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';
UPDATE public.equipment_items
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';
UPDATE public.equipment_logs
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';
UPDATE public.equipment_usages
SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c'
WHERE sailor_id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c',
  'Yiming Jason Wu <-- Yiming Wu',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c',
    'survivorName', 'Yiming Jason Wu',
    'mergedId', '471946e4-4cdb-5541-aa11-255fcc0f38bc',
    'mergedName', 'Yiming Wu',
    'reason', 'Chinese sailor: Yiming Jason Wu and Yiming Wu share CHN, Vanhang Sailing, sail 214250, and DOB 2009-01-01.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '471946e4-4cdb-5541-aa11-255fcc0f38bc';


-- ----------------------------------------------------------------------
-- Group 24: Cheryl Sitong Shen (cheryl-shen-thai25-83677e)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Cheryl Sitong Shen',
    nationality = COALESCE(nationality, 'HKG'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'Vanhang Sailing' ELSE club END,
    dob = COALESCE(dob, '2011-01-01'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214466'),
    updated_at = v_now
WHERE id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6';

-- Move regatta results from Cheryl Sitong (cheryl-sitong-sr26-21b5d6)
UPDATE public.regatta_results
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6', updated_at = v_now
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';

UPDATE public.regatta_result_participants
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6', updated_at = v_now
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';

DELETE FROM public.followed_sailors
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
  );
UPDATE public.followed_sailors
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
  );
UPDATE public.coach_squad_members
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('83677ec0-5aca-5fb3-b23f-80e291dbcad6', 'Cheryl Sitong Shen'),
  ('83677ec0-5aca-5fb3-b23f-80e291dbcad6', 'Cheryl Sitong')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';

UPDATE public.sailor_claims
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';

UPDATE public.parent_notes
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';
UPDATE public.equipment_items
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';
UPDATE public.equipment_logs
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';
UPDATE public.equipment_usages
SET sailor_id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6'
WHERE sailor_id = '21b5d619-dc42-591b-87e9-0be3d2336594';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '83677ec0-5aca-5fb3-b23f-80e291dbcad6',
  'Cheryl Sitong Shen <-- Cheryl Sitong',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '83677ec0-5aca-5fb3-b23f-80e291dbcad6',
    'survivorName', 'Cheryl Sitong Shen',
    'mergedId', '21b5d619-dc42-591b-87e9-0be3d2336594',
    'mergedName', 'Cheryl Sitong',
    'reason', 'Hong Kong sailor: Cheryl Sitong Shen and Cheryl Sitong share HKG, Vanhang Sailing, sail 214466, and DOB 2011-01-01.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '21b5d619-dc42-591b-87e9-0be3d2336594';


-- ----------------------------------------------------------------------
-- Group 25: Tasanatham Suthamgosal (asian-tha-tasanatham-481c84)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Tasanatham Suthamgosal',
    nationality = COALESCE(nationality, 'THA'),
    club = CASE WHEN club IN ('N/A', 'Official regatta entry', 'Imported official result', 'Others') THEN 'ACDC' ELSE club END,
    dob = COALESCE(dob, '2015-01-01'),
    updated_at = v_now
WHERE id = '7a475df7-bc47-43cf-bab3-815222279ece';

-- Move regatta results from Tasanatham (tasanatham-sr26-99affe)
UPDATE public.regatta_results
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece', updated_at = v_now
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';

UPDATE public.regatta_result_participants
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece', updated_at = v_now
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';

DELETE FROM public.followed_sailors
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
  );
UPDATE public.followed_sailors
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
  );
UPDATE public.coach_squad_members
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('7a475df7-bc47-43cf-bab3-815222279ece', 'Tasanatham Suthamgosal'),
  ('7a475df7-bc47-43cf-bab3-815222279ece', 'Tasanatham')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';

UPDATE public.sailor_claims
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';

UPDATE public.parent_notes
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';
UPDATE public.equipment_items
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';
UPDATE public.equipment_logs
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';
UPDATE public.equipment_usages
SET sailor_id = '7a475df7-bc47-43cf-bab3-815222279ece'
WHERE sailor_id = '99affeff-5c90-56f6-a8a9-82a74805a519';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '7a475df7-bc47-43cf-bab3-815222279ece',
  'Tasanatham Suthamgosal <-- Tasanatham',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '7a475df7-bc47-43cf-bab3-815222279ece',
    'survivorName', 'Tasanatham Suthamgosal',
    'mergedId', '99affeff-5c90-56f6-a8a9-82a74805a519',
    'mergedName', 'Tasanatham',
    'reason', 'Single-name placeholder Tasanatham from Trat Regatta matches Tasanatham Suthamgosal (ACDC, sail 1979, DOB 2015-01-01).'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '99affeff-5c90-56f6-a8a9-82a74805a519';


-- ----------------------------------------------------------------------
-- Group 26: Dani Pieter Mahmoud van Olphen (dani-pieter-mahmoud-van-olphen-gjqupp4)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Dani Pieter Mahmoud van Olphen',
    nationality = COALESCE(nationality, 'HKG'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '213234'),
    updated_at = v_now
WHERE id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d';

-- Move regatta results from Dani Van Olphen (ilca4-hkg-dani-van-olphen-213234)
UPDATE public.regatta_results
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d', updated_at = v_now
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';

UPDATE public.regatta_result_participants
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d', updated_at = v_now
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';

DELETE FROM public.followed_sailors
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
  );
UPDATE public.followed_sailors
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
  );
UPDATE public.coach_squad_members
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d', 'Dani Pieter Mahmoud van Olphen'),
  ('1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d', 'Dani Van Olphen')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';

UPDATE public.sailor_claims
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';

UPDATE public.parent_notes
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';
UPDATE public.equipment_items
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';
UPDATE public.equipment_logs
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';
UPDATE public.equipment_usages
SET sailor_id = '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d'
WHERE sailor_id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d',
  'Dani Pieter Mahmoud van Olphen <-- Dani Van Olphen',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '1e9bcb95-6468-4891-9aed-5f5bd1fc8d7d',
    'survivorName', 'Dani Pieter Mahmoud van Olphen',
    'mergedId', '98c5bc6a-61d4-4027-b51d-5589ee1d719b',
    'mergedName', 'Dani Van Olphen',
    'reason', 'Hong Kong sailor: Dani Van Olphen matches Dani Pieter Mahmoud van Olphen (ILCA sail 213234).'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '98c5bc6a-61d4-4027-b51d-5589ee1d719b';


-- ----------------------------------------------------------------------
-- Group 27: Lyora Hong-yi Wallier (ilca4-hkg-lyora-hong-yi-wallier-213316)
-- ----------------------------------------------------------------------
UPDATE public.sailors
SET name = 'Lyora Hong-yi Wallier',
    nationality = COALESCE(nationality, 'HKG'),
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '213316'),
    updated_at = v_now
WHERE id = 'c12e846f-6188-40f5-adab-89e8522999cf';

-- Move regatta results from Lyora Wallier (lyora-wallier-zq6g66t)
UPDATE public.regatta_results
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf', updated_at = v_now
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';

UPDATE public.regatta_result_participants
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf', updated_at = v_now
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';

DELETE FROM public.followed_sailors
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
  );
UPDATE public.followed_sailors
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';

DELETE FROM public.coach_followed_sailors
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa'
  AND coach_id IN (
    SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
  );
UPDATE public.coach_followed_sailors
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';

DELETE FROM public.coach_squad_members
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa'
  AND squad_id IN (
    SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
  );
UPDATE public.coach_squad_members
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';

UPDATE public.asian_optimist_index_sailors
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';

INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('c12e846f-6188-40f5-adab-89e8522999cf', 'Lyora Hong-yi Wallier'),
  ('c12e846f-6188-40f5-adab-89e8522999cf', 'Lyora Wallier')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailor_aliases
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';

UPDATE public.sailor_claims
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';

UPDATE public.parent_notes
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';
UPDATE public.equipment_items
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';
UPDATE public.equipment_logs
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';
UPDATE public.equipment_usages
SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf'
WHERE sailor_id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.merge',
  'sailor',
  'c12e846f-6188-40f5-adab-89e8522999cf',
  'Lyora Hong-yi Wallier <-- Lyora Wallier',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', 'c12e846f-6188-40f5-adab-89e8522999cf',
    'survivorName', 'Lyora Hong-yi Wallier',
    'mergedId', '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa',
    'mergedName', 'Lyora Wallier',
    'reason', 'Sailor Lyora Wallier matches Lyora Hong-yi Wallier, sharing ILCA sail 213316.'
  ),
  'admin-duplicate-review',
  v_now
);

DELETE FROM public.sailors
WHERE id = '9bafd3b6-0a83-48c5-9aaf-cbfe951160aa';


-- ----------------------------------------------------------------------
-- Section 2: Record Durable Keep-Separate Decisions for False Positives
-- ----------------------------------------------------------------------
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  'd4749289-b2f3-5607-9ae1-fa33bdbcdad5',
  'Maiko Higaki / Nanako Higaki',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', 'c764b218-e565-5b0b-905e-d56b0c7d4a9d::d4749289-b2f3-5607-9ae1-fa33bdbcdad5',
    'aId', 'd4749289-b2f3-5607-9ae1-fa33bdbcdad5',
    'bId', 'c764b218-e565-5b0b-905e-d56b0c7d4a9d',
    'aName', 'Maiko Higaki',
    'bName', 'Nanako Higaki',
    'reason', 'Sisters in Japan sharing family boat JPN 3434.'
  ),
  'admin-duplicate-review',
  v_now
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  'be617744-2ecc-57fe-b837-85b80ab95e06',
  'Tomoharu Shiroishi / Yasuharu Shiroishi',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '3c9f092c-76ef-56f9-a0c9-7e858a2450be::be617744-2ecc-57fe-b837-85b80ab95e06',
    'aId', 'be617744-2ecc-57fe-b837-85b80ab95e06',
    'bId', '3c9f092c-76ef-56f9-a0c9-7e858a2450be',
    'aName', 'Tomoharu Shiroishi',
    'bName', 'Yasuharu Shiroishi',
    'reason', 'Brothers in Japan sharing family boat JPN 3250.'
  ),
  'admin-duplicate-review',
  v_now
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  'ad6fa7a4-fafc-4dc8-8bd7-92fcb8e39a0d',
  'Ela Murat / Eva Murat',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', 'ad6fa7a4-fafc-4dc8-8bd7-92fcb8e39a0d::b434b981-9f3a-514a-974c-fbf63700fd1b',
    'aId', 'ad6fa7a4-fafc-4dc8-8bd7-92fcb8e39a0d',
    'bId', 'b434b981-9f3a-514a-974c-fbf63700fd1b',
    'aName', 'Ela Murat',
    'bName', 'Eva Murat',
    'reason', 'Sisters in Hong Kong (Ela and Eva Murat).'
  ),
  'admin-duplicate-review',
  v_now
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '49236d1e-749d-1777-2be1-b7c698aac538',
  'Maia Lim Laurie / Misa Lim Laurie',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '3b802239-ec10-402e-8ced-5499c5a1ea57::49236d1e-749d-1777-2be1-b7c698aac538',
    'aId', '49236d1e-749d-1777-2be1-b7c698aac538',
    'bId', '3b802239-ec10-402e-8ced-5499c5a1ea57',
    'aName', 'Maia Lim Laurie',
    'bName', 'Misa Lim Laurie',
    'reason', 'Sisters (Maia and Misa Lim Laurie).'
  ),
  'admin-duplicate-review',
  v_now
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '523be7c2-3db8-5273-a02a-9c840f48bf5f',
  'Kanna Yamamura / Nana Yamamura',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '0eb30de4-6e06-50f3-b8d4-3f02cc0130dd::523be7c2-3db8-5273-a02a-9c840f48bf5f',
    'aId', '523be7c2-3db8-5273-a02a-9c840f48bf5f',
    'bId', '0eb30de4-6e06-50f3-b8d4-3f02cc0130dd',
    'aName', 'Kanna Yamamura',
    'bName', 'Nana Yamamura',
    'reason', 'Sisters in Japan (Kanna and Nana Yamamura).'
  ),
  'admin-duplicate-review',
  v_now
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '6a8873bc-12ed-58a4-be8b-14f9d6ff1fe3',
  'Kohei Hayashi / Shohei Hayashi',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '489d4743-1a7b-5f61-b3c2-2576df0df2fe::6a8873bc-12ed-58a4-be8b-14f9d6ff1fe3',
    'aId', '6a8873bc-12ed-58a4-be8b-14f9d6ff1fe3',
    'bId', '489d4743-1a7b-5f61-b3c2-2576df0df2fe',
    'aName', 'Kohei Hayashi',
    'bName', 'Shohei Hayashi',
    'reason', 'Brothers in Japan (Kohei and Shohei Hayashi).'
  ),
  'admin-duplicate-review',
  v_now
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.duplicates.keep_separate',
  'sailor',
  '1a887b11-45b2-4ec6-a8a9-91f81663ba57',
  'Chen-Yi Kai / Yu Kai Chen',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '1a887b11-45b2-4ec6-a8a9-91f81663ba57::76e668c0-57c9-50d2-b8d5-abd0f966d313',
    'aId', '1a887b11-45b2-4ec6-a8a9-91f81663ba57',
    'bId', '76e668c0-57c9-50d2-b8d5-abd0f966d313',
    'aName', 'Chen-Yi Kai',
    'bName', 'Yu Kai Chen',
    'reason', 'Unrelated sailors: Chen-Yi Kai (SGP, 2016) vs Yu Kai Chen (TPE, 2010).'
  ),
  'admin-duplicate-review',
  v_now
);

END $$;

COMMIT;
