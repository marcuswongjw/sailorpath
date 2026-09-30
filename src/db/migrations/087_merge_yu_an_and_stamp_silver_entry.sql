-- Migration 087: Merge Yu An's duplicate profiles and stamp silver_entry_date
-- 1. Ensure Cincapura 2026 Gold and Silver regattas are published
-- 2. Merge Yu An's duplicate records (Yu an Li, LI YU'AN, Li Yu'An) into canonical Yu An Li
-- 3. Stamp silver_entry_date as the date of the first silver fleet regatta each sailor took part in

-- Step 1: Ensure Cincapura 2026 regattas have status = 'published'
UPDATE public.regattas
SET status = 'published', updated_at = now()
WHERE slug IN ('cincapura-regatta-2026-gold', 'cincapura-regatta-2026-silver')
  AND status != 'published';

-- Step 2: Merge Yu An profiles
DO $$
DECLARE
  v_survivor_id UUID;
  v_dup RECORD;
  v_merged_count INT := 0;
BEGIN
  -- Identify canonical survivor record for Yu An
  SELECT id INTO v_survivor_id
  FROM public.sailors
  WHERE (
    regexp_replace(lower(name), '[^a-z]', '', 'g') IN ('yuanli', 'liyuan')
    OR lower(trim(name)) IN ('yu an li', 'yu an', 'li yu''an', 'li yu an', 'yu an, li', 'li, yu an')
  )
  ORDER BY
    CASE WHEN lower(trim(name)) = 'yu an li' THEN 100 ELSE 0 END +
    CASE WHEN sail_number = '2056' THEN 50 ELSE 0 END +
    (SELECT count(*) FROM public.regatta_results WHERE sailor_id = sailors.id) * 10
    DESC,
    created_at ASC
  LIMIT 1;

  IF v_survivor_id IS NOT NULL THEN
    -- Update canonical survivor record attributes
    UPDATE public.sailors
    SET
      name = 'Yu An Li',
      sail_number = '2056',
      gender = 'F',
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(NULLIF(trim(school), ''), 'TAO NAN SCHOOL'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      current_fleet = COALESCE(NULLIF(trim(current_fleet), ''), 'Series'),
      updated_at = now()
    WHERE id = v_survivor_id;

    -- Add canonical name variations as aliases for future imports
    INSERT INTO public.sailor_aliases (sailor_id, alias_name)
    VALUES
      (v_survivor_id, 'Yu an Li'),
      (v_survivor_id, 'LI YU''AN'),
      (v_survivor_id, 'Li Yu''An'),
      (v_survivor_id, 'Li Yu An'),
      (v_survivor_id, 'Yu An Li')
    ON CONFLICT (alias_name) DO UPDATE SET sailor_id = EXCLUDED.sailor_id;

    -- Merge each duplicate profile into survivor
    FOR v_dup IN
      SELECT id, name
      FROM public.sailors
      WHERE (
        regexp_replace(lower(name), '[^a-z]', '', 'g') IN ('yuanli', 'liyuan')
        OR lower(trim(name)) IN ('yu an li', 'yu an', 'li yu''an', 'li yu an', 'yu an, li', 'li, yu an')
      )
      AND id != v_survivor_id
    LOOP
      -- 1. Alias the duplicate name to the survivor
      INSERT INTO public.sailor_aliases (sailor_id, alias_name)
      VALUES (v_survivor_id, v_dup.name)
      ON CONFLICT (alias_name) DO UPDATE SET sailor_id = EXCLUDED.sailor_id;

      -- 2. Clean up conflicting race results and regatta results
      DELETE FROM public.regatta_race_results
      WHERE regatta_result_id IN (
        SELECT rr_dup.id
        FROM public.regatta_results rr_dup
        JOIN public.regatta_results rr_surv
          ON rr_dup.regatta_id = rr_surv.regatta_id
         AND rr_surv.sailor_id = v_survivor_id
        WHERE rr_dup.sailor_id = v_dup.id
      );

      DELETE FROM public.regatta_results rr_dup
      WHERE rr_dup.sailor_id = v_dup.id
        AND rr_dup.regatta_id IN (
          SELECT rr_surv.regatta_id
          FROM public.regatta_results rr_surv
          WHERE rr_surv.sailor_id = v_survivor_id
        );

      -- 3. Repoint non-conflicting regatta results
      UPDATE public.regatta_results
      SET sailor_id = v_survivor_id
      WHERE sailor_id = v_dup.id;

      -- 4. Repoint sailor aliases
      UPDATE public.sailor_aliases
      SET sailor_id = v_survivor_id
      WHERE sailor_id = v_dup.id;

      -- 5. Repoint claims if survivor is unclaimed
      UPDATE public.sailor_claims
      SET sailor_id = v_survivor_id
      WHERE sailor_id = v_dup.id
        AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = v_survivor_id);
      DELETE FROM public.sailor_claims WHERE sailor_id = v_dup.id;

      -- 6. Repoint equipment
      UPDATE public.equipment_items
      SET sailor_id = v_survivor_id
      WHERE sailor_id = v_dup.id;

      -- 7. Repoint observations and notes if table exists
      BEGIN
        UPDATE public.race_observations SET sailor_id = v_survivor_id WHERE sailor_id = v_dup.id;
      EXCEPTION WHEN undefined_table THEN NULL;
      END;

      BEGIN
        UPDATE public.parent_notes SET sailor_id = v_survivor_id WHERE sailor_id = v_dup.id;
      EXCEPTION WHEN undefined_table THEN NULL;
      END;

      BEGIN
        UPDATE public.coach_squad_members SET sailor_id = v_survivor_id
        WHERE sailor_id = v_dup.id;
      EXCEPTION WHEN undefined_table THEN NULL; WHEN unique_violation THEN
        DELETE FROM public.coach_squad_members WHERE sailor_id = v_dup.id;
      END;

      BEGIN
        UPDATE public.coach_followed_sailors SET sailor_id = v_survivor_id
        WHERE sailor_id = v_dup.id;
      EXCEPTION WHEN undefined_table THEN NULL; WHEN unique_violation THEN
        DELETE FROM public.coach_followed_sailors WHERE sailor_id = v_dup.id;
      END;

      BEGIN
        UPDATE public.coach_sailor_notes SET sailor_id = v_survivor_id WHERE sailor_id = v_dup.id;
      EXCEPTION WHEN undefined_table THEN NULL;
      END;

      BEGIN
        UPDATE public.coach_development_records SET sailor_id = v_survivor_id WHERE sailor_id = v_dup.id;
      EXCEPTION WHEN undefined_table THEN NULL;
      END;

      -- 8. Delete the duplicate sailor profile
      DELETE FROM public.sailors WHERE id = v_dup.id;
      v_merged_count := v_merged_count + 1;
    END LOOP;

    RAISE NOTICE 'Merged % Yu An duplicate profiles into %', v_merged_count, v_survivor_id;
  END IF;
END $$;

-- Step 3: Stamp silver_entry_date as the date of the first silver fleet regatta each sailor took part in
WITH earliest_silver AS (
  SELECT
    rr.sailor_id,
    MIN(r.date) AS first_silver_date
  FROM public.regatta_results rr
  JOIN public.regattas r ON rr.regatta_id = r.id
  WHERE lower(trim(coalesce(r.boat_class, 'optimist'))) = 'optimist'
    AND lower(trim(coalesce(r.division, 'gold'))) = 'silver'
    AND r.counts_for_ranking IS NOT FALSE
    AND (r.race_count IS NULL OR r.race_count >= 3)
  GROUP BY rr.sailor_id
)
UPDATE public.sailors s
SET
  silver_entry_date = es.first_silver_date,
  current_fleet = CASE
    WHEN lower(trim(coalesce(s.current_fleet, ''))) = 'guest' THEN s.current_fleet
    WHEN s.current_fleet IS NULL OR trim(s.current_fleet) = '' OR lower(trim(s.current_fleet)) IN ('silver', 'member', 'in sg fleet') THEN 'Series'
    ELSE s.current_fleet
  END,
  updated_at = now()
FROM earliest_silver es
WHERE s.id = es.sailor_id
  AND (s.silver_entry_date IS NULL OR s.silver_entry_date != es.first_silver_date);
