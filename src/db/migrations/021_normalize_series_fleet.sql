-- Legacy current_fleet Gold/Silver tags mean In SG Fleet (Series).
-- Ranking Gold vs Silver is derived from gold_entry_date / drop_date only.
UPDATE public.sailors
SET current_fleet = 'Series',
    updated_at = now()
WHERE lower(trim(current_fleet)) IN ('gold', 'silver');
