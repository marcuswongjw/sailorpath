-- Live rows imported after 031 still stored ISO2 "SG". Store Singapore as SGP.
UPDATE public.regattas
SET geography = 'SGP', updated_at = now()
WHERE upper(btrim(geography)) = 'SG';

ALTER TABLE public.regattas
  ALTER COLUMN geography SET DEFAULT 'SGP';
