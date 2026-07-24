-- Drop date alone ends Gold/Silver ranking. Remove obsolete flag.
ALTER TABLE public.sailors DROP COLUMN IF EXISTS manually_dropped;
