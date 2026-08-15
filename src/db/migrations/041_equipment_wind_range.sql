-- Sail wind range + tag migration notes
ALTER TABLE public.equipment_items
  ADD COLUMN IF NOT EXISTS wind_range text;

-- Optional: normalize legacy travel tag to spare in app layer (no SQL required)
