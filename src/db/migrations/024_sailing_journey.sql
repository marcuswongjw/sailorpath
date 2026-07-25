-- Owner-editable sailing journey highlights (JSON text).
ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS sailing_journey text;
