-- Series (In SG Fleet) without any entry date cannot rank.
-- Stamp silver_entry_date = today (UTC calendar; app prefers SG today via API).
-- Prefer admin "Stamp silver entry for empty Series" for SG-calendar accuracy.
UPDATE public.sailors
SET silver_entry_date = CURRENT_DATE,
    current_fleet = 'Series',
    updated_at = now()
WHERE lower(trim(coalesce(current_fleet, ''))) IN (
    'series', 'gold', 'silver', 'in sg fleet', 'member'
  )
  AND gold_entry_date IS NULL
  AND silver_entry_date IS NULL;
