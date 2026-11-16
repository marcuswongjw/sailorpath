-- Combine Eastern Seaboard 2026 Gold (68) + Silver (67) into 135-boat overall classification
BEGIN;

UPDATE public.asian_optimist_index_events
SET
  regatta_slugs = ARRAY[
    'eastern-seaboard-regatta-2026-optimist-gold',
    'eastern-seaboard-regatta-2026-optimist-silver'
  ],
  fleet_size = 135,
  notes = 'Combined 135-boat Gold (68) + Silver (67) classification following the qualifying series.',
  updated_at = now()
WHERE id = 'eastern-seaboard-regatta-2026';

COMMIT;
