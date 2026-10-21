-- Migration 133: Purge CSC Orphan Stubs and Manually Tracked Profiles with Zero Results
--
-- 1. Purges 12 orphan sailor stubs left over from CSC Monthly Dinghy Races removal.
-- 2. Purges 2 manually tracked sailor profiles created in August 2026 without linked results.
--
-- All changes wrapped in a single transaction.

BEGIN;

DO $$
DECLARE
  v_now timestamptz := now();
  v_target_ids uuid[] := ARRAY[
    -- 12 CSC orphan stubs
    'd39efdfe-e2bc-5dbf-bb51-c0dc2813cc3e'::uuid, -- Amanda Jayn Seah
    '4b3dfd72-f161-5c5d-85ce-a70816123171'::uuid, -- William Clark
    '8dd56337-bfe3-5569-b467-9d20d50edda6'::uuid, -- Morris Beugel
    'dd431f57-3b05-543e-8cff-d1b88a579002'::uuid, -- Theo Kiesselbach
    '536630d6-1b6d-5ca8-88c0-8953f94af447'::uuid, -- Richard Ames
    'c30685af-36f0-5990-b4db-b52828a63771'::uuid, -- Shaun Lim
    '7836a49c-eb1a-5ba9-a745-b9f652acb00a'::uuid, -- Tristan Tham Zheng Qi
    'ae282ff9-81be-578f-804f-55aa4844cc23'::uuid, -- Khalisha Mohamed
    'd8abf07d-f07c-52f6-9d74-b2d436b856c1'::uuid, -- Daniel Knoben
    '5a81b572-541d-5454-8712-cf0b0d0299e4'::uuid, -- Mailee O'Shea
    'e7d2c197-c9fe-5019-9555-168b15ef3b29'::uuid, -- Lura Yang
    '3007867c-9740-55f1-94e8-504176434fd0'::uuid, -- Ryan Loke

    -- 2 Manually tracked profiles with 0 results
    '8797fa3f-8724-4ecb-a69e-278539bab653'::uuid, -- Low Zhi Raynor Ng
    '3e0247c1-8a97-4b3d-a79f-d57e6541d3eb'::uuid  -- Xi Ng
  ];
BEGIN

  -- Safety check: Ensure none of these 14 profiles have any regatta results
  IF EXISTS (
    SELECT 1 FROM public.regatta_results WHERE sailor_id = ANY(v_target_ids)
  ) THEN
    RAISE EXCEPTION 'Aborting purge: One or more target sailors unexpectedly have regatta results';
  END IF;

  -- Safety check: Ensure none of these 14 profiles have crew participant records
  IF EXISTS (
    SELECT 1 FROM public.regatta_result_participants WHERE sailor_id = ANY(v_target_ids)
  ) THEN
    RAISE EXCEPTION 'Aborting purge: One or more target sailors unexpectedly have participant records';
  END IF;

  -- 1. Remove from followed_sailors
  DELETE FROM public.followed_sailors
  WHERE sailor_id = ANY(v_target_ids);

  -- 2. Remove from sailor_aliases
  DELETE FROM public.sailor_aliases
  WHERE sailor_id = ANY(v_target_ids);

  -- 3. Log audit event
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  )
  SELECT
    'sailors.purge_orphans',
    'sailor',
    s.id,
    s.name,
    'Purged orphan/unlinked profile with zero results.',
    jsonb_build_object(
      'sailorId', s.id,
      'name', s.name,
      'handle', s.handle,
      'reason', 'User requested purge of CSC orphan stubs and manually tracked empty profiles'
    ),
    'admin-cleanup',
    v_now
  FROM public.sailors s
  WHERE s.id = ANY(v_target_ids);

  -- 4. Delete the 14 sailor records
  DELETE FROM public.sailors
  WHERE id = ANY(v_target_ids);

END $$;

COMMIT;
