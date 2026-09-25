-- Deadline line shown on the public calendar card ("Status / Deadline: …").
ALTER TABLE public.regatta_events
  ADD COLUMN IF NOT EXISTS key_deadlines text;
