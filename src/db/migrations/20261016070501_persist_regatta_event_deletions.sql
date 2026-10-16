-- Persist deletions independently of the event row so built-in calendar entries stay removed.
CREATE TABLE IF NOT EXISTS public.regatta_event_deletions (
  slug text PRIMARY KEY,
  deleted_at timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.regatta_event_deletions ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.regatta_event_deletions FROM PUBLIC, anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.regatta_event_deletions TO service_role;
COMMENT ON TABLE public.regatta_event_deletions IS
  'Server-managed calendar deletion records. No browser access; saved events may explicitly recreate a deleted slug.';

-- Honor deletions already made in admin, even though the event rows no longer exist.
INSERT INTO public.regatta_event_deletions (slug, deleted_at)
SELECT lower(btrim(details->>'slug')), max(created_at)
FROM public.admin_change_log
WHERE action = 'regatta_event_delete'
  AND jsonb_typeof(details->'slug') = 'string'
  AND btrim(details->>'slug') <> ''
GROUP BY lower(btrim(details->>'slug'))
ON CONFLICT (slug) DO UPDATE
  SET deleted_at = greatest(regatta_event_deletions.deleted_at, EXCLUDED.deleted_at);
