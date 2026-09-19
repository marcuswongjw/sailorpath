-- 059_admin_regattas_verified.sql: Mark all admin-uploaded & official series regattas as verified

UPDATE public.regatta_results
SET verification_status = 'verified',
    verified_at = COALESCE(verified_at, NOW())
WHERE regatta_id IN (
  SELECT id FROM public.regattas
  WHERE (slug IS NOT NULL AND slug NOT LIKE 'log-%')
     OR counts_for_ranking = true
     OR reviewed_at IS NOT NULL
);
