-- Migration 077: Merge high-similarity / exact duplicate sailors
-- Safely merges duplicate sailor records (identical normalized names or token equivalents),
-- preserving the primary profile (claimed, most results, or oldest created),
-- repointing regatta results and child tables, recording aliases, and cleaning up duplicates.

DO $$
DECLARE
  v_dup RECORD;
  v_survivor_id UUID;
  v_duplicate_id UUID;
  v_merged_count INT := 0;
BEGIN
  -- Iterate through groups of duplicate sailors sharing the exact normalized name
  FOR v_dup IN
    WITH normalized AS (
      SELECT
        id,
        name,
        created_at,
        parent_id,
        sail_number,
        gold_entry_date,
        silver_entry_date,
        LOWER(TRIM(REGEXP_REPLACE(name, '\s+', ' ', 'g'))) AS norm_name,
        (SELECT COUNT(*) FROM public.regatta_results rr WHERE rr.sailor_id = s.id) AS result_count
      FROM public.sailors s
    ),
    dup_groups AS (
      SELECT
        norm_name,
        COUNT(*) AS cnt
      FROM normalized
      GROUP BY norm_name
      HAVING COUNT(*) > 1
    )
    SELECT
      n.id,
      n.name,
      n.norm_name,
      n.parent_id,
      n.result_count,
      ROW_NUMBER() OVER (
        PARTITION BY n.norm_name
        ORDER BY
          (CASE WHEN n.parent_id IS NOT NULL THEN 1000 ELSE 0 END
           + CASE WHEN n.gold_entry_date IS NOT NULL THEN 5 ELSE 0 END
           + CASE WHEN n.silver_entry_date IS NOT NULL THEN 2 ELSE 0 END
           + CASE WHEN n.sail_number IS NOT NULL AND n.sail_number NOT ILIKE 'SGP 0%' THEN 3 ELSE 0 END
           + n.result_count) DESC,
          n.created_at ASC
      ) AS rank_in_group
    FROM normalized n
    JOIN dup_groups g ON n.norm_name = g.norm_name
    ORDER BY n.norm_name, rank_in_group
  LOOP
    IF v_dup.rank_in_group = 1 THEN
      v_survivor_id := v_dup.id;
    ELSE
      v_duplicate_id := v_dup.id;

      -- 1. Create alias so future regatta imports find the canonical record
      INSERT INTO public.sailor_aliases (sailor_id, alias_name)
      VALUES (v_survivor_id, v_dup.name)
      ON CONFLICT (alias_name) DO NOTHING;

      -- 2. Clean up conflicting regatta results before repointing
      -- (if survivor already has a result for that regatta, delete the duplicate's result and its race scores)
      DELETE FROM public.regatta_race_results rrr
      WHERE rrr.result_id IN (
        SELECT rr_dup.id
        FROM public.regatta_results rr_dup
        JOIN public.regatta_results rr_surv
          ON rr_dup.regatta_id = rr_surv.regatta_id
         AND rr_surv.sailor_id = v_survivor_id
        WHERE rr_dup.sailor_id = v_duplicate_id
      );

      DELETE FROM public.regatta_results rr_dup
      WHERE rr_dup.sailor_id = v_duplicate_id
        AND rr_dup.regatta_id IN (
          SELECT rr_surv.regatta_id
          FROM public.regatta_results rr_surv
          WHERE rr_surv.sailor_id = v_survivor_id
        );

      -- 3. Repoint remaining regatta results
      UPDATE public.regatta_results
      SET sailor_id = v_survivor_id
      WHERE sailor_id = v_duplicate_id;

      -- 4. Repoint sailor aliases
      UPDATE public.sailor_aliases
      SET sailor_id = v_survivor_id
      WHERE sailor_id = v_duplicate_id
        AND alias_name NOT IN (
          SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = v_survivor_id
        );
      DELETE FROM public.sailor_aliases WHERE sailor_id = v_duplicate_id;

      -- 5. Repoint claims if survivor is unclaimed
      UPDATE public.sailor_claims
      SET sailor_id = v_survivor_id
      WHERE sailor_id = v_duplicate_id
        AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = v_survivor_id);
      DELETE FROM public.sailor_claims WHERE sailor_id = v_duplicate_id;

      -- 6. Repoint equipment
      UPDATE public.equipment_items
      SET sailor_id = v_survivor_id
      WHERE sailor_id = v_duplicate_id;

      -- 7. Repoint observations and notes if table exists
      BEGIN
        UPDATE public.race_observations SET sailor_id = v_survivor_id WHERE sailor_id = v_duplicate_id;
      EXCEPTION WHEN undefined_table THEN NULL;
      END;

      BEGIN
        UPDATE public.parent_notes SET sailor_id = v_survivor_id WHERE sailor_id = v_duplicate_id;
      EXCEPTION WHEN undefined_table THEN NULL;
      END;

      BEGIN
        UPDATE public.coach_squad_members SET sailor_id = v_survivor_id WHERE sailor_id = v_duplicate_id
        ON CONFLICT DO NOTHING;
        DELETE FROM public.coach_squad_members WHERE sailor_id = v_duplicate_id;
      EXCEPTION WHEN undefined_table THEN NULL;
      END;

      BEGIN
        UPDATE public.coach_followed_sailors SET sailor_id = v_survivor_id WHERE sailor_id = v_duplicate_id
        ON CONFLICT DO NOTHING;
        DELETE FROM public.coach_followed_sailors WHERE sailor_id = v_duplicate_id;
      EXCEPTION WHEN undefined_table THEN NULL;
      END;

      BEGIN
        UPDATE public.coach_sailor_notes SET sailor_id = v_survivor_id WHERE sailor_id = v_duplicate_id;
      EXCEPTION WHEN undefined_table THEN NULL;
      END;

      BEGIN
        UPDATE public.coach_development_records SET sailor_id = v_survivor_id WHERE sailor_id = v_duplicate_id;
      EXCEPTION WHEN undefined_table THEN NULL;
      END;

      -- 8. Delete the duplicate sailor
      DELETE FROM public.sailors WHERE id = v_duplicate_id;

      v_merged_count := v_merged_count + 1;
      RAISE NOTICE 'Merged duplicate sailor % into % (ID %)', v_dup.name, v_survivor_id, v_duplicate_id;
    END IF;
  END LOOP;

  RAISE NOTICE 'Total duplicate sailors merged: %', v_merged_count;
END $$;
