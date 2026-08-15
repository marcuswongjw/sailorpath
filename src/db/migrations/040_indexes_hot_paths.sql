-- Hot-path indexes for regatta detail, parent dashboard, and usage analytics.
-- Run in Supabase SQL Editor.

-- Regatta detail / list results by event (unique is on sailor_id, regatta_id only)
CREATE INDEX IF NOT EXISTS regatta_results_regatta_id_idx
  ON public.regatta_results (regatta_id);

-- Parent dashboard / linked profiles (partial: claimed only)
CREATE INDEX IF NOT EXISTS sailors_parent_id_idx
  ON public.sailors (parent_id)
  WHERE parent_id IS NOT NULL;

-- Admin usage stats: window + group by type
CREATE INDEX IF NOT EXISTS usage_events_created_type_idx
  ON public.usage_events (created_at DESC, event_type);
