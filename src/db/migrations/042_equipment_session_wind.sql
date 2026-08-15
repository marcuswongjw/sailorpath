-- Equipment session log: wind on usages; source may be training
ALTER TABLE public.equipment_usages
  ADD COLUMN IF NOT EXISTS wind text;
