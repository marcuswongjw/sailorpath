-- 124_point_x15_news_at_class_hub.sql
-- Point the published X-15 announcement at the public class hub. The article
-- renderer does not turn body text into links; the page adds that link when
-- related_class is X-15. This keeps the stored wording aligned with the fallback.

BEGIN;

UPDATE public.news_articles
SET
  body = 'The X-15 class hub brings together reviewed Ibiza and Thailand event context with a transparent beta methodology. It does not publish a numbered ranking before official final results are available and source-linked. Open the X-15 class hub for that context.',
  updated_at = now()
WHERE slug = 'x-15-pilot-opens-ahead-of-worlds';

COMMIT;
