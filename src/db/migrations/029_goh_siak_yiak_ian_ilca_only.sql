-- Goh Siak Yiak Ian is an ILCA 4 sailor only.
-- Clear incorrect Optimist silver entry and remove Optimist silver results
-- (likely bad import / name match). Idempotent.
-- Matches name variants that include both "siak" and "yiak".

-- 1) Clear Optimist series membership fields
UPDATE public.sailors
SET
  silver_entry_date = NULL,
  gold_entry_date = NULL,
  drop_date = NULL,
  current_fleet = 'Guest',
  updated_at = now()
WHERE lower(trim(name)) = lower('Goh Siak Yiak Ian')
   OR (
     lower(name) LIKE '%siak%'
     AND lower(name) LIKE '%yiak%'
     AND lower(name) LIKE '%goh%'
   );

-- 2) Delete Optimist silver results for that sailor
DELETE FROM public.regatta_results rr
USING public.sailors s, public.regattas r
WHERE rr.sailor_id = s.id
  AND rr.regatta_id = r.id
  AND (
    lower(trim(s.name)) = lower('Goh Siak Yiak Ian')
    OR (
      lower(s.name) LIKE '%siak%'
      AND lower(s.name) LIKE '%yiak%'
      AND lower(s.name) LIKE '%goh%'
    )
  )
  AND lower(coalesce(nullif(trim(r.boat_class), ''), 'optimist')) IN (
    'optimist',
    'opti'
  )
  AND lower(coalesce(r.division, '')) LIKE '%silver%';
