-- Drop date alone ends Gold/Silver ranking membership.
-- Clear "manually dropped" flags that were used as a stand-in when drop_date is set.

UPDATE public.sailors
SET
  manually_dropped = false,
  updated_at = now()
WHERE drop_date IS NOT NULL
  AND manually_dropped = true;
