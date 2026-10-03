-- Pesta Sukan 2026 ILCA 4: sailors who registered and did not start
-- still receive the ranking place (38th in a fleet of 43 = 6 high points).
-- ILCA scoring treats is_dns as 0, so clear that flag and keep the place.
-- Sailors with no result row did not register and stay at 0.
-- Caleb Peck Rui Kai stays DNS at 44 and scores 0.

UPDATE public.regatta_results rr
SET
  is_dns = false,
  evidence_notes = 'Registered for Pesta Sukan 2026 ILCA 4 and did not start. Place 38 scores 6 national ranking points.',
  updated_at = now()
FROM public.sailors s, public.regattas r
WHERE rr.sailor_id = s.id
  AND rr.regatta_id = r.id
  AND r.slug = 'pesta-sukan-26-ilca4'
  AND rr.rank = 38
  AND rr.is_dns = true
  AND lower(trim(s.name)) IN (
    'alaric shenthil naidu',
    'wenxin ji',
    'ethan goy',
    'febe wong qi ke',
    'yong heng yi',
    'yunosuke ogawa'
  );
