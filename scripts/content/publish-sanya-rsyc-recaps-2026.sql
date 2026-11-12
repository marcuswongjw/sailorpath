-- Reviewed 12 November 2026. Publish only the two user-approved existing drafts.
-- Apply after the corresponding news images have reached production.
BEGIN;

DO $$
BEGIN
  IF (SELECT count(*) FROM public.news_articles
      WHERE (slug = 'singapore-sailing-medals-asian-beach-games-2026'
             AND status = 'draft' AND updated_at = '2026-11-12 00:31:19.745769+00')
         OR (slug = 'rsyc-optimist-gold-knockout-2026-recap'
             AND status = 'draft' AND updated_at = '2026-11-11 14:49:24.626861+00')) <> 2 THEN
    RAISE EXCEPTION 'Drafts changed since editorial review; review again before publishing';
  END IF;
END $$;

UPDATE public.news_articles SET
  title = 'Singapore sailors win three medals at Asian Beach Games',
  summary = 'Ian Goh, Anya Alessia Zahedi and Nia Mehry Zahedi earned gold, silver and bronze in Sanya in April 2026.',
  body = $article$Singapore’s sailors returned from the sixth Asian Beach Games with a medal of each colour when the sailing competition concluded in Sanya, China, on 28 April 2026.

Ian Goh took the boys’ ILCA 4 title, securing Singapore’s first gold of the Games. In the girls’ events, Anya Alessia Zahedi earned Optimist silver and Nia Mehry Zahedi took ILCA 4 bronze.

The Olympic Council of Asia’s closing sailing report records five titles for China, two for Thailand and one for Singapore across the eight events.

This retrospective celebrates Singapore’s three medallists. Full race-by-race scorecards for the event are not yet available on SailorPath; the official medal report is linked below.$article$,
  source_url = 'https://oca.asia/news/7248-china-sails-to-five-more-gold-medals-at-sanya-2026.html',
  source_label = 'Olympic Council of Asia — official medal report',
  status = 'published', reviewed_at = now(), published_at = now(), updated_at = now()
WHERE slug = 'singapore-sailing-medals-asian-beach-games-2026';

UPDATE public.news_articles SET
  title = 'Lyric Li wins RSYC Optimist Gold Knockout Championship',
  summary = 'Lyric Li Yuxuan finished ahead of Ashlyn Tham and Nathaniel K Ng at the October championship in Singapore.',
  body = $article$Lyric Li Yuxuan won the RSYC Optimist Gold Fleet Knockout Championship at Republic of Singapore Yacht Club on 3–4 October 2026.

RSYC’s final ranking, updated on 4 October, places Ashlyn Tham second and Nathaniel K Ng third, completing the overall podium.

The championship used a knockout format, with qualifying, repechage and final rounds. The organiser published the stage results alongside the overall ranking, allowing sailors to follow how the competition unfolded across the weekend.

SailorPath’s event page brings together the available results and prize information. Open the event below to explore the championship and its official sources.$article$,
  source_url = 'https://sailorpath.com/regattas/rsyc-optimist-gold-fleet-knockout-championship-2026',
  source_label = 'Explore the RSYC championship results',
  related_event_id = '5d1c38fe-f2cd-41bc-bb24-a2d8af62ef8b',
  status = 'published', reviewed_at = now(), published_at = now(), updated_at = now()
WHERE slug = 'rsyc-optimist-gold-knockout-2026-recap';

COMMIT;

SELECT slug, status, title, published_at FROM public.news_articles
WHERE slug IN ('singapore-sailing-medals-asian-beach-games-2026', 'rsyc-optimist-gold-knockout-2026-recap');
