-- 121_correct_x15_editorial_source_copy.sql
-- Keep the seeded X-15 announcement aligned with the reviewed class-calendar
-- source. Migration 120 may already be applied in production, so correct its
-- published row through a forward-only migration.

BEGIN;

UPDATE public.news_articles
SET
  summary = 'The X-15 hub brings together reviewed Ibiza and Thailand event context without publishing an unsupported ranking.',
  body = 'The X-15 class hub brings together reviewed Ibiza and Thailand event context with a transparent beta methodology. It does not publish a numbered ranking before official final results are available and source-linked.',
  updated_at = now()
WHERE slug = 'x-15-pilot-opens-ahead-of-worlds';

COMMIT;
