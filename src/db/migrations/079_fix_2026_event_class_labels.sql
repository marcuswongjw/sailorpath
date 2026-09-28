-- Keep event class labels aligned with the actual scoreboard sheets.
-- Pesta Sukan has separate Optimist Gold and Silver results; RSYC has one
-- Optimist class even though "Silver Fleet" is part of the event title.
update regatta_events
set classes = '["Optimist Gold", "Optimist Silver", "ILCA 4", "ILCA 6", "ILCA 7", "29er", "Techno 293", "iQFOiL", "WingFoil"]'::jsonb,
    updated_at = now()
where slug = 'pesta-sukan-2026';

update regatta_events
set classes = '["Optimist"]'::jsonb,
    updated_at = now()
where slug = 'rsyc-optimist-silver-fleet-knockout-championship-2026';

update regattas
set name = 'Pesta Sukan 2026 (Gold)',
    updated_at = now()
where slug = 'pesta-sukan-gold-aug-26'
  and name = 'Pesta Sukan 2026 (Colg)';
