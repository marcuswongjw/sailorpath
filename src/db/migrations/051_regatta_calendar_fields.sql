-- 051_regatta_calendar_fields.sql: Add calendar event metadata to regattas
ALTER TABLE public.regattas
  ADD COLUMN IF NOT EXISTS venue text,
  ADD COLUMN IF NOT EXISTS end_date date,
  ADD COLUMN IF NOT EXISTS nor_url text,
  ADD COLUMN IF NOT EXISTS registration_url text,
  ADD COLUMN IF NOT EXISTS is_selection_trial boolean DEFAULT false NOT NULL,
  ADD COLUMN IF NOT EXISTS organizer text,
  ADD COLUMN IF NOT EXISTS schedule_notes text;
