-- Four editorial drafts; do not overwrite existing editorial work.
INSERT INTO public.news_articles
  (slug, status, kind, title, summary, body, author_display_name, related_event_id, related_class, related_region, source_url, source_label, tags)
VALUES
  ('colombo-2026-asian-oceanian-optimist-preview', 'draft', 'class_announcement',
   'Colombo prepares for Asian and Oceanian Optimist Championship',
   'Young Optimist sailors head to Sri Lanka for the 12–19 December championship.',
   E'The 2026 Optimist Asian & Oceanian Championship is scheduled for 12–19 December at Colombo Port City, Sri Lanka. The event brings young sailors together for individual and team racing.\n\nThe championship is a chance to follow Optimist competition across Asia and Oceania as the year draws to a close. Singapore Sailing has also listed the event on its calendar.\n\nSailorPath’s event listing: https://sailorpath.com/regattas/2026-optimist-asian-oceania-championship\n\nResults are not yet available; racing has not started. Event information: https://www.asiansailing.org/events/ioda-asian-oceanian-optimist-sailing-championship-2026-sri-lanka/',
   'SailorPath', 'e2af43c1-f231-431d-8b6c-b4b2f8d05cea', 'Optimist', 'Asia & Oceania',
   'https://www.asiansailing.org/events/ioda-asian-oceanian-optimist-sailing-championship-2026-sri-lanka/', 'Asian Sailing Federation', '["Optimist", "Sri Lanka", "Preview"]'::jsonb),
  ('2026-optimist-worlds-tangier-retrospective', 'draft', 'result_report',
   'Bragança wins Optimist Worlds in Tangier',
   'Brazil’s Manuel Bragança led a 284-sailor fleet at the 2026 Optimist World Championship.',
   E'Manuel Bragança of Brazil won the 2026 Optimist World Championship in Tangier, Morocco, finishing ahead of Switzerland’s Elliot Novara and Malta’s Andrei Zhakov.\n\nThe championship ran from 18–28 June at the Royal Yacht Club de Tanger. SailorPath’s published results cover the full 284-sailor fleet and all 12 races, retaining the official overall positions across the final fleets.\n\nInes Mendez Larminaux of Puerto Rico finished sixth overall and led the girls’ results, ahead of Hong Kong’s Margaux Nguyen-Minh and Spain’s Mara Peñalver.\n\nExplore the race-by-race results: https://sailorpath.com/regattas/2026-optimist-world-championship/results/optimist',
   'SailorPath', '1e1b625c-c10a-564a-b919-c3bf0bb713cc', 'Optimist', 'International',
   'https://scoring.sailti.com/public/download/overall-datetime-pdf/10651/1/20260628140956', 'Official championship results', '["Optimist", "World Championship", "Results"]'::jsonb),
  ('singapore-sailing-medals-asian-beach-games-2026', 'draft', 'result_report',
   'Singapore sailors win three medals at Asian Beach Games',
   'Ian Goh, Anya Alessia Zahedi and Nia Mehry Zahedi reached the podium in Sanya.',
   E'Singapore’s sailors won gold, silver and bronze as the sailing competition at the sixth Asian Beach Games concluded in Sanya, China, on 28 April 2026.\n\nIan Goh won the boys’ ILCA 4 event, delivering Singapore’s first gold medal of the Games. Anya Alessia Zahedi took silver in girls’ Optimist, while Nia Mehry Zahedi earned bronze in girls’ ILCA 4.\n\nThe Olympic Council of Asia reported that China won five of the eight sailing titles, while Thailand won two and Singapore one.\n\nOfficial medal report: https://oca.asia/news/7248-china-sails-to-five-more-gold-medals-at-sanya-2026.html\n\nEditorial note: Full race-by-race results are not yet available on SailorPath; verify and link them before publication.',
   'SailorPath', NULL, NULL, 'Asia', 'https://oca.asia/news/7248-china-sails-to-five-more-gold-medals-at-sanya-2026.html', 'Olympic Council of Asia', '["Asian Beach Games", "Singapore", "Results"]'::jsonb),
  ('mussanah-race-week-arab-womens-championship-2026', 'draft', 'result_report',
   'Mussanah Race Week celebrates regional sailing',
   'Oman hosted youth and women sailors for racing across multiple classes in October.',
   E'Mussanah Race Week and the Arab Women’s Sailing Championship concluded in Oman in October 2026, bringing together sailors from across the region. Oman Sail reported more than 100 sailors across the two events.

Khaled Yahya Al Sarihi led the Optimist standings, with Oman’s Mohammed Ziyad al Gasim second and the UAE’s Theyab Almehairi third in the host’s published overall table. In ILCA 4, Egypt’s Karma Waleed took first place overall, while Tunisia’s Ines Gmati won ILCA 6.

The championships provided a stage for youth and women sailors alongside para-inclusive competition. Racing took place from 18–21 October at Mussanah.

Explore race-by-race results on SailorPath: https://sailorpath.com/regattas/mussanah-race-week-2026
Official event results: https://www.omansail.om/events/mussanah-race-week-2026

Editorial note: Race-by-race results for Optimist, ILCA 4, ILCA 6 and ILCA 7 are published on SailorPath. Standing tables reflect the official mixed-fleet results published by the host.',
   'SailorPath', NULL, NULL, 'Middle East', 'https://www.omansail.om/events/mussanah-race-week-2026', 'Oman Sail', '["Mussanah", "Optimist", "Results"]'::jsonb)
ON CONFLICT (slug) DO NOTHING;
