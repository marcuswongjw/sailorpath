-- Approved inaugural X-15 Worlds championship post. Copy mirrors src/lib/news.ts.
-- Photo: Drive file 1WVoXt-Z9Uu4JsYsJwvSftH4PNqE1wQ2w, supplied by user for publication.
BEGIN;
SELECT pg_advisory_xact_lock(hashtext('news-first-x15-worlds-2026'));
DO $$ BEGIN
 IF EXISTS (SELECT 1 FROM public.news_articles WHERE slug='first-x15-world-championships-ibiza-2026' AND status <> 'published') THEN RAISE EXCEPTION 'Article slug belongs to an unpublished editorial record';END IF;
 IF (SELECT count(*) FROM public.regatta_events WHERE slug='x15-world-championships-2026')<>1 THEN RAISE EXCEPTION 'Missing X-15 Worlds event';END IF;
END $$;
INSERT INTO public.news_articles (slug,kind,title,summary,body,author_display_name,published_at,updated_at,related_class,related_region,source_url,source_label,tags,status,reviewed_at,related_event_id)
VALUES ('first-x15-world-championships-ibiza-2026','result_report','History made in Ibiza at the first X-15 World Championships','Five inaugural world champions were crowned as 107 riders from 24 nations gathered in Ibiza for the first-ever X-15 World Championships.','The first-ever X-15 World Championships brought 107 riders from 24 nations to Ibiza, Spain, from 4–8 November 2026, with five inaugural world titles on the line.

Hosted by Club Mare Nostrum at Port Nàutic Ibiza, the championship united experienced international sailors and emerging young wingfoilers on one-design equipment.

## The first X-15 world champions

• Senior Men: Kamil Manowiecki — Poland
• Senior Women: Jette Koep — Germany
• U19 Men: Holland Vierling — USA
• U19 Women: Yana Li — China
• U15: Benjamin Almeida — Brazil

Light winds limited racing during the week, leaving the senior titles decided by the opening-day results. A late breeze on Sunday gave the youth and junior fleets another opportunity to race and settle their championships.

Beyond the results, Ibiza marked the beginning of a new world championship community, bringing riders of different ages and backgrounds together to compete and share their experience.

Explore all five fleet standings and individual race scores on SailorPath.','SailorPath','2026-11-09T16:10:59.000+08:00','2026-11-09T16:10:59.000+08:00','X-15','Europe','https://sailorpath.com/regattas/x15-world-championships-2026','View the X-15 World Championships results','["x15","world-championships","ibiza","spain","wingfoiling","results"]'::jsonb,'published','2026-11-09T16:10:59.000+08:00',(SELECT id FROM public.regatta_events WHERE slug='x15-world-championships-2026'))
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
 published_at=COALESCE(public.news_articles.published_at,EXCLUDED.published_at),
 reviewed_at=EXCLUDED.reviewed_at,related_event_id=EXCLUDED.related_event_id;
COMMIT;
