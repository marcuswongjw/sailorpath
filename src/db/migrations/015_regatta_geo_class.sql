-- Geography + boat class tags on regattas (multi-geo / multi-class ready)
ALTER TABLE public.regattas
  ADD COLUMN IF NOT EXISTS geography text DEFAULT 'SG' NOT NULL,
  ADD COLUMN IF NOT EXISTS boat_class text DEFAULT 'Optimist' NOT NULL;

-- Tag all existing events as SG Optimist
UPDATE public.regattas
SET
  geography = COALESCE(NULLIF(trim(geography), ''), 'SG'),
  boat_class = COALESCE(NULLIF(trim(boat_class), ''), 'Optimist')
WHERE TRUE;
