-- No active ILCA 6 programme for now — reclassify any ILCA 6 regattas as ILCA 4.
UPDATE public.regattas
SET boat_class = 'ILCA 4', updated_at = now()
WHERE lower(trim(coalesce(boat_class, ''))) IN (
  'ilca 6',
  'ilca6',
  'laser radial',
  'radial'
);
