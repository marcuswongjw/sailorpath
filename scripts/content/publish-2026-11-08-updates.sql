-- Approved website updates, 8 November 2026. Copy mirrors src/lib/news.ts.
-- Two new posts and one existing-article correction. No competition data changes.
BEGIN;
SELECT pg_advisory_xact_lock(hashtext('sailorpath-news-2026-11-08'));
DO $$ BEGIN
  IF (SELECT count(*) FROM public.news_articles WHERE slug='18th-eastern-seaboard-regatta-2026-results-published' AND status='published') <> 1 THEN
    RAISE EXCEPTION 'Expected one published Eastern Seaboard article';
  END IF;
  IF EXISTS (SELECT 1 FROM public.news_articles WHERE slug IN ('more-racing-from-taiwan-and-japan','easier-browsing-for-race-results-and-sailor-awards') AND status <> 'published') THEN
    RAISE EXCEPTION 'A new article slug belongs to an unpublished editorial record';
  END IF;
END $$;

UPDATE public.news_articles SET title='Eastern Seaboard 2026: final results confirmed',
  summary='Final results are now available for ILCA 4, ILCA 6, Optimist Gold and Optimist Silver, covering 209 competitors and 1,672 individual race scores.',
  body='Final results are now available for ILCA 4, ILCA 6, Optimist Gold and Optimist Silver at the 18th Eastern Seaboard Regatta.

The four fleets cover 209 competitors and 1,672 individual race scores. Placings, scores, penalties and discards remain unchanged.

SailorPath now displays Final status in line with the organiser’s official notice-board labels. The retained source PDFs still contain provisional headers; this difference remains documented in the source evidence.',
  updated_at='2026-11-08T22:44:06.000+08:00',
  source_label='Explore the results'
WHERE slug='18th-eastern-seaboard-regatta-2026-results-published' AND status='published';

INSERT INTO public.news_articles (slug,kind,title,summary,body,author_display_name,published_at,updated_at,related_class,related_region,source_url,source_label,tags,status,reviewed_at)
VALUES
('more-racing-from-taiwan-and-japan','result_report','More racing from Taiwan and Japan','Explore newly added results from the Kaohsiung Lotus Pond Optimist Regatta, the 22nd Botchan Cup and Japan’s Youth Worlds selection regatta.','SailorPath’s results archive now includes the Kaohsiung Lotus Pond Optimist Regatta, the 22nd Botchan Cup and Japan’s Youth Worlds selection regatta.

Explore fleet standings and individual race scores, with links to the official source documents. Double-handed entries connect both sailors to their shared boat result.

Lotus Pond’s available fleet results remain provisional. Its team-racing bracket is linked separately and is not presented as a complete final classification.

These overseas results contribute to sailors’ competition histories and do not count toward Singapore national rankings.','SailorPath','2026-11-08T22:44:06.000+08:00','2026-11-08T22:44:06.000+08:00',NULL,'Asia','https://sailorpath.com/results','Browse the results','["taiwan","japan","optimist","ilca-4","ilca-6","420","29er","iqfoil","results"]'::jsonb,'published','2026-11-08T22:44:06.000+08:00'),
('easier-browsing-for-race-results-and-sailor-awards','product_update','Easier browsing for race results and sailor awards','Browse race-by-race results in a scrolling mobile table, and explore sailor awards with newest-first sorting and filters for dates, location, class and honours.','Regatta results on mobile now use the same table format as desktop. Scroll across individual race scores, totals and net scores while keeping sailor names in view.

On sailor profiles, awards appear newest first. Search and filter by year, location, boat class, medal or a custom date range, or change the order to explore earlier achievements and best placings.

Together, these changes make it easier to follow a regatta and explore a sailor’s competition history.','SailorPath','2026-11-08T22:44:05.000+08:00','2026-11-08T22:44:06.000+08:00',NULL,'International','https://sailorpath.com/sailors','Explore sailor profiles','["product","mobile","results","awards","profiles"]'::jsonb,'published','2026-11-08T22:44:06.000+08:00')
ON CONFLICT (slug) DO UPDATE SET
  kind=EXCLUDED.kind,
  title=EXCLUDED.title,
  summary=EXCLUDED.summary,
  body=EXCLUDED.body,
  author_display_name=EXCLUDED.author_display_name,
  updated_at=EXCLUDED.updated_at,
  related_class=EXCLUDED.related_class,
  related_region=EXCLUDED.related_region,
  source_url=EXCLUDED.source_url,
  source_label=EXCLUDED.source_label,
  tags=EXCLUDED.tags,
  reviewed_at=EXCLUDED.reviewed_at;

DO $$ BEGIN
  IF (SELECT count(*) FROM public.news_articles WHERE slug IN ('18th-eastern-seaboard-regatta-2026-results-published','more-racing-from-taiwan-and-japan','easier-browsing-for-race-results-and-sailor-awards') AND status='published') <> 3 THEN
    RAISE EXCEPTION 'Expected all three approved updates to be published';
  END IF;
END $$;
COMMIT;
