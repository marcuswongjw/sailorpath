-- Public event-hub copy under the regatta name.
-- Null keeps the built-in description and scoring text.
ALTER TABLE public.regatta_events
  ADD COLUMN IF NOT EXISTS schedule_summary text,
  ADD COLUMN IF NOT EXISTS scoring_rules text;
