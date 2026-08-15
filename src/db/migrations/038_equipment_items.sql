-- Multi-item equipment inventory + usage log
-- Run in Supabase SQL Editor.

CREATE TABLE IF NOT EXISTS public.equipment_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  sailor_id uuid NOT NULL REFERENCES public.sailors(id) ON DELETE CASCADE,
  boat_class text NOT NULL DEFAULT 'optimist',
  category text NOT NULL,
  brand text,
  model text,
  label text,
  status text NOT NULL DEFAULT 'active',
  condition text NOT NULL DEFAULT 'good',
  is_primary boolean NOT NULL DEFAULT false,
  tags text,
  acquired_on date,
  retired_on date,
  use_count integer NOT NULL DEFAULT 0,
  last_used_on date,
  notes text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS equipment_items_sailor_idx
  ON public.equipment_items (sailor_id, boat_class, category);

CREATE TABLE IF NOT EXISTS public.equipment_usages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  equipment_item_id uuid NOT NULL REFERENCES public.equipment_items(id) ON DELETE CASCADE,
  sailor_id uuid NOT NULL REFERENCES public.sailors(id) ON DELETE CASCADE,
  used_on date NOT NULL,
  regatta_id uuid REFERENCES public.regattas(id) ON DELETE SET NULL,
  source text NOT NULL DEFAULT 'manual',
  note text,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS equipment_usages_item_idx
  ON public.equipment_usages (equipment_item_id, used_on DESC);

CREATE INDEX IF NOT EXISTS equipment_usages_sailor_idx
  ON public.equipment_usages (sailor_id, used_on DESC);

-- Backfill Optimist primary gear from sailor columns
INSERT INTO public.equipment_items (
  sailor_id, boat_class, category, brand, status, condition, is_primary, tags
)
SELECT s.id, 'optimist', 'hull', s.hull_brand, 'active', 'good', true, 'racing'
FROM public.sailors s
WHERE s.hull_brand IS NOT NULL AND trim(s.hull_brand) <> ''
  AND NOT EXISTS (
    SELECT 1 FROM public.equipment_items e
    WHERE e.sailor_id = s.id AND e.boat_class = 'optimist' AND e.category = 'hull'
  );

INSERT INTO public.equipment_items (
  sailor_id, boat_class, category, brand, status, condition, is_primary, tags
)
SELECT s.id, 'optimist', 'sail', s.sail_make, 'active', 'good', true, 'racing'
FROM public.sailors s
WHERE s.sail_make IS NOT NULL AND trim(s.sail_make) <> ''
  AND NOT EXISTS (
    SELECT 1 FROM public.equipment_items e
    WHERE e.sailor_id = s.id AND e.boat_class = 'optimist' AND e.category = 'sail'
  );

INSERT INTO public.equipment_items (
  sailor_id, boat_class, category, brand, status, condition, is_primary, tags
)
SELECT s.id, 'optimist', 'daggerboard', s.foil_brand, 'active', 'good', true, 'racing'
FROM public.sailors s
WHERE s.foil_brand IS NOT NULL AND trim(s.foil_brand) <> ''
  AND NOT EXISTS (
    SELECT 1 FROM public.equipment_items e
    WHERE e.sailor_id = s.id AND e.boat_class = 'optimist' AND e.category = 'daggerboard'
  );

INSERT INTO public.equipment_items (
  sailor_id, boat_class, category, brand, status, condition, is_primary, tags
)
SELECT s.id, 'optimist', 'mast', s.mast, 'active', 'good', true, 'racing'
FROM public.sailors s
WHERE s.mast IS NOT NULL AND trim(s.mast) <> ''
  AND NOT EXISTS (
    SELECT 1 FROM public.equipment_items e
    WHERE e.sailor_id = s.id AND e.boat_class = 'optimist' AND e.category = 'mast'
  );

-- Backfill ILCA 4 when columns set
INSERT INTO public.equipment_items (
  sailor_id, boat_class, category, brand, status, condition, is_primary, tags
)
SELECT s.id, 'ilca4', 'hull', s.hull_brand_ilca4, 'active', 'good', true, 'racing'
FROM public.sailors s
WHERE s.hull_brand_ilca4 IS NOT NULL AND trim(s.hull_brand_ilca4) <> ''
  AND NOT EXISTS (
    SELECT 1 FROM public.equipment_items e
    WHERE e.sailor_id = s.id AND e.boat_class = 'ilca4' AND e.category = 'hull'
  );

INSERT INTO public.equipment_items (
  sailor_id, boat_class, category, brand, status, condition, is_primary, tags
)
SELECT s.id, 'ilca4', 'sail', s.sail_make_ilca4, 'active', 'good', true, 'racing'
FROM public.sailors s
WHERE s.sail_make_ilca4 IS NOT NULL AND trim(s.sail_make_ilca4) <> ''
  AND NOT EXISTS (
    SELECT 1 FROM public.equipment_items e
    WHERE e.sailor_id = s.id AND e.boat_class = 'ilca4' AND e.category = 'sail'
  );

INSERT INTO public.equipment_items (
  sailor_id, boat_class, category, brand, status, condition, is_primary, tags
)
SELECT s.id, 'ilca4', 'daggerboard', s.foil_brand_ilca4, 'active', 'good', true, 'racing'
FROM public.sailors s
WHERE s.foil_brand_ilca4 IS NOT NULL AND trim(s.foil_brand_ilca4) <> ''
  AND NOT EXISTS (
    SELECT 1 FROM public.equipment_items e
    WHERE e.sailor_id = s.id AND e.boat_class = 'ilca4' AND e.category = 'daggerboard'
  );

INSERT INTO public.equipment_items (
  sailor_id, boat_class, category, brand, status, condition, is_primary, tags
)
SELECT s.id, 'ilca4', 'mast', s.mast_ilca4, 'active', 'good', true, 'racing'
FROM public.sailors s
WHERE s.mast_ilca4 IS NOT NULL AND trim(s.mast_ilca4) <> ''
  AND NOT EXISTS (
    SELECT 1 FROM public.equipment_items e
    WHERE e.sailor_id = s.id AND e.boat_class = 'ilca4' AND e.category = 'mast'
  );
