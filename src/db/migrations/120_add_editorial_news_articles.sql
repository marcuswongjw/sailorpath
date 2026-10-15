-- 120_add_editorial_news_articles.sql
-- Public editorial records. Browser roles can read published records only;
-- author, reviewer and draft workflow remain server/admin concerns.

BEGIN;

CREATE TABLE IF NOT EXISTS public.news_articles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text NOT NULL UNIQUE,
  status text NOT NULL DEFAULT 'draft'
    CHECK (status IN ('draft', 'in_review', 'published', 'archived')),
  kind text NOT NULL DEFAULT 'product_update'
    CHECK (kind IN ('result_report', 'correction', 'class_announcement', 'product_update', 'partner_update')),
  title text NOT NULL,
  summary text NOT NULL,
  body text NOT NULL,
  author_display_name text NOT NULL DEFAULT 'SailorPath',
  reviewed_by uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  reviewed_at timestamptz,
  published_at timestamptz,
  updated_at timestamptz NOT NULL DEFAULT now(),
  related_event_id uuid REFERENCES public.regatta_events(id) ON DELETE SET NULL,
  related_regatta_id uuid REFERENCES public.regattas(id) ON DELETE SET NULL,
  related_class text,
  related_region text,
  related_sailor_id uuid REFERENCES public.sailors(id) ON DELETE SET NULL,
  source_url text,
  source_label text,
  tags jsonb NOT NULL DEFAULT '[]'::jsonb CHECK (jsonb_typeof(tags) = 'array'),
  CHECK (
    status <> 'published'
    OR (published_at IS NOT NULL AND reviewed_at IS NOT NULL)
  )
);

CREATE INDEX IF NOT EXISTS news_articles_publication_idx
  ON public.news_articles (status, published_at DESC);
CREATE INDEX IF NOT EXISTS news_articles_related_event_idx
  ON public.news_articles (related_event_id)
  WHERE related_event_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS news_articles_related_regatta_idx
  ON public.news_articles (related_regatta_id)
  WHERE related_regatta_id IS NOT NULL;

ALTER TABLE public.news_articles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS news_articles_public_read ON public.news_articles;
CREATE POLICY news_articles_public_read ON public.news_articles
  FOR SELECT TO anon, authenticated
  USING (status = 'published');

INSERT INTO public.news_articles (
  slug, status, kind, title, summary, body, author_display_name,
  reviewed_at, published_at, updated_at, related_region, related_class, tags
)
VALUES
  (
    'a-clearer-public-sailing-record',
    'published',
    'product_update',
    'A clearer public sailing record',
    'SailorPath now separates public results discovery from private account, parent and coach workspaces.',
    'SailorPath now separates public results discovery from private account, parent and coach workspaces. Public profiles use a verified-results-first default and optional profile sharing is off until an authorised owner chooses it.',
    'SailorPath',
    '2026-10-15 00:00:00+08',
    '2026-10-15 00:00:00+08',
    '2026-10-15 00:00:00+08',
    'Singapore',
    NULL,
    '["product", "public-records", "privacy"]'::jsonb
  ),
  (
    'x-15-pilot-opens-ahead-of-worlds',
    'published',
    'class_announcement',
    'X-15 pilot opens ahead of Worlds',
    'The X-15 hub brings together event context and verified foundation history without publishing an unsupported ranking.',
    'The X-15 class hub brings together the Ibiza and Pattaya event context, verified foundation history and a transparent beta methodology. It does not publish a numbered ranking before official final results are available and source-linked.',
    'SailorPath',
    '2026-10-15 00:00:00+08',
    '2026-10-15 00:00:00+08',
    '2026-10-15 00:00:00+08',
    'International',
    'X-15',
    '["x-15", "class-hub", "methodology"]'::jsonb
  )
ON CONFLICT (slug) DO NOTHING;

COMMIT;
