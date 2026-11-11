-- Migration 188: Populate brief public biography for Adison Ein from verified public sources and regatta records.
-- Sources: 33rd SEA Games (2025 Boys' Optimist Silver), YRAT / Royal Varuna Yacht Club (RVYC),
-- IODA 2024/2025 Optimist Asian & Oceanian Championships, 2026 Thailand International Sailing Championships (ILCA 4),
-- and 2026 ACDC Cup International Sailing Championship (ILCA 4).

BEGIN;

UPDATE public.sailors
SET bio = 'Thai youth sailor representing YRAT and the Royal Varuna Yacht Club across the Optimist and ILCA 4 classes. Silver medallist in Boys'' Optimist at the 33rd SEA Games (2025) and top-20 finisher at the 2025 Optimist Asian & Oceanian Championship, before winning the 2026 Thailand International Sailing Championships and ACDC Cup in ILCA 4.',
    updated_at = clock_timestamp()
WHERE id = 'a6769ca7-9204-43b3-bbb5-82e0182efd7e'
  AND (bio IS NULL OR trim(bio) = '');

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.bio_enrichment',
  'sailor',
  'a6769ca7-9204-43b3-bbb5-82e0182efd7e',
  'Adison Ein — Profile Bio',
  'Added verified brief biography for Adison Ein covering YRAT/RVYC, 33rd SEA Games Optimist silver medal, Asian & Oceanian Championship, and 2026 ILCA 4 wins.',
  jsonb_build_object(
    'sources', jsonb_build_array(
      'racingrulesofsailing.org / channelnewsasia.com (33rd SEA Games 2025 Boys Optimist Silver)',
      'kingscup.com / YRAT / Royal Varuna Yacht Club',
      'worldofsailors.com (Optimist Asian & Oceanian Championship)',
      'SailorPath imported regatta results (Thailand International Sailing Championships 2026, ACDC Cup 2026)'
    )
  ),
  'migration_188',
  clock_timestamp()
);

COMMIT;
