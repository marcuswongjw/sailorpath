import { and, desc, eq } from "drizzle-orm";
import { unstable_cache } from "next/cache";
import { db } from "@/db";
import { newsArticles } from "@/db/schema";
import {
  CACHE_TAG_NEWS_ARTICLES,
  PUBLIC_DATA_REVALIDATE_SECONDS,
} from "@/lib/cacheTags";

export type PublishedNewsArticle = {
  slug: string;
  title: string;
  summary: string;
  body: string;
  kind:
    | "result_report"
    | "correction"
    | "class_announcement"
    | "product_update"
    | "partner_update";
  authorDisplayName: string;
  publishedAt: string;
  updatedAt: string;
  relatedClass: string | null;
  relatedRegion: string | null;
  sourceUrl: string | null;
  sourceLabel: string | null;
  tags: string[];
  imageUrl?: string | null;
  imageAlt?: string | null;
  imageCaption?: string | null;
  imageCredit?: string | null;
  imageCreditUrl?: string | null;
};

const ARTICLE_MEDIA_BY_SLUG: Record<
  string,
  {
    imageUrl: string;
    imageAlt: string;
    imageCaption: string;
    imageCredit: string;
    imageCreditUrl: string | null;
  }
> = {
  "parent-workspace-gear-coach-notes": {
    imageUrl: "/news/public-sailing-record.png",
    imageAlt: "Illustration of connected sailing records and activity cards.",
    imageCaption: "Illustration of connected sailing records and activities; not a screenshot of the parent workspace.",
    imageCredit: "Illustration by SailorPath",
    imageCreditUrl: null,
  },
  "sailor-profiles-and-logbooks": {
    imageUrl: "/news/profile-sharing.png",
    imageAlt: "Illustration of a sailing profile and private information.",
    imageCaption: "Illustration of a sailor profile and private information.",
    imageCredit: "Illustration by SailorPath",
    imageCreditUrl: null,
  },
  "more-ways-to-join-sailorpath": {
    imageUrl: "/news/profile-sharing.png",
    imageAlt: "Illustration of a sailor profile beside a private panel.",
    imageCaption: "Illustration of a SailorPath profile and private information.",
    imageCredit: "Illustration by SailorPath",
    imageCreditUrl: null,
  },
  "connected-records-for-helm-and-crew": {
    imageUrl: "/news/public-sailing-record.png",
    imageAlt: "Illustrated sailing results and connected sailor records.",
    imageCaption: "Illustration of connected sailing results and sailor records.",
    imageCredit: "Illustration by SailorPath",
    imageCreditUrl: null,
  },
  "singapore-sailing-medals-asian-beach-games-2026": {
    imageUrl: "/news/asian-beach-games-sanya-2026.jpg",
    imageAlt: "China’s Cheng Wenyu sailing an Optimist at the 2026 Asian Beach Games in Sanya.",
    imageCaption: "Cheng Wenyu of China in the girls’ Optimist competition at Sanya 2026. The photograph shows the event, rather than Singapore’s medallists.",
    imageCredit: "Photo: Xinhua / Zhang Fan, via the Olympic Council of Asia",
    imageCreditUrl: "https://oca.asia/news/7248-china-sails-to-five-more-gold-medals-at-sanya-2026.html",
  },
  "rsyc-optimist-gold-knockout-2026-recap": {
    imageUrl: "/news/rsyc-optimist-gold-knockout-2026.jpg",
    imageAlt: "Optimist sailors racing beside the marina at the RSYC Gold Fleet Knockout Championship in October 2026.",
    imageCaption: "Racing on the opening day of the RSYC Optimist Gold Fleet Knockout Championship, 3 October 2026.",
    imageCredit: "Photo: RSYC official event album",
    imageCreditUrl: "https://photos.app.goo.gl/huykMdmuE9MvES9K9",
  },
  "2026-optimist-worlds-tangier-retrospective": {
    imageUrl: "/news/optimist-worlds-archive.jpg",
    imageAlt: "Optimist dinghies at the start of a World Championship race in Uruguay in 2007.",
    imageCaption: "Archive photograph: Optimist World Championship racing in Uruguay, 2007; not the 2026 event.",
    imageCredit: "Photo: Manlio Ferrari / Wikimedia Commons, public domain",
    imageCreditUrl: "https://commons.wikimedia.org/wiki/File:Optimist_race.jpg",
  },
  "mussanah-race-week-arab-womens-championship-2026": {
    imageUrl: "/news/optimist-regatta-archive.jpg",
    imageAlt: "Optimist dinghies preparing for a regatta on Lake Constance in 2016.",
    imageCaption: "Archive photograph: Optimist dinghies prepare for a regatta on Lake Constance, 2016; not Mussanah Race Week.",
    imageCredit: "Photo: PaterMcFly / Wikimedia Commons, CC BY 3.0 (cropped for display)",
    imageCreditUrl: "https://commons.wikimedia.org/wiki/File:Optimisten-Regatta.jpg",
  },
  "first-x15-world-championships-ibiza-2026": {
    imageUrl: "/news/x15-worlds-2026-ibiza.jpg",
    imageAlt: "Riders carrying X-15 boards and foils prepare at Port Nàutic Ibiza during the inaugural World Championships.",
    imageCaption: "Riders prepare at Port Nàutic Ibiza during the inaugural X-15 World Championships.",
    imageCredit: "Photo supplied from the championship media gallery",
    imageCreditUrl: "https://drive.google.com/file/d/1WVoXt-Z9Uu4JsYsJwvSftH4PNqE1wQ2w/view",
  },
  "more-racing-from-taiwan-and-japan": {
    imageUrl: "/news/asian-championship-coverage.png",
    imageAlt: "Illustrated sailing venues connected to published class scorecards across Asia.",
    imageCaption: "An illustration of SailorPath’s regional results coverage; not an event photograph or geographic map.",
    imageCredit: "Illustration by SailorPath",
    imageCreditUrl: null,
  },
  "easier-browsing-for-race-results-and-sailor-awards": {
    imageUrl: "/news/public-sailing-record.png",
    imageAlt: "Illustrated race result, award and sailor profile cards connected in one sailing history.",
    imageCaption: "A product illustration of connected competition records and awards; not a screenshot of the interface.",
    imageCredit: "Illustration by SailorPath",
    imageCreditUrl: null,
  },
  "asian-2026-multiclass-and-national-championships-published": {
    imageUrl: "/news/asian-championship-coverage.png",
    imageAlt: "An illustrated network of Asian sailing venues connected to published class scorecards.",
    imageCaption: "Illustration of SailorPath's regional championship coverage; not an event photograph or geographic map.",
    imageCredit: "Illustration by SailorPath",
    imageCreditUrl: null,
  },
  "privacy-first-profiles-guardian-consent-and-evidence-protections": {
    imageUrl: "/news/profile-sharing.png",
    imageAlt: "Public competition records beside a locked panel representing private notes and evidence.",
    imageCaption: "Profile sharing choices control optional personal information. Family notes and supporting evidence remain private.",
    imageCredit: "Illustration by SailorPath",
    imageCreditUrl: null,
  },
  "a-clearer-public-sailing-record": {
    imageUrl: "/news/public-sailing-record.png",
    imageAlt: "Illustrated result, award and sailor record cards connected in one sailing history.",
    imageCaption: "A product illustration of connected competition records, separate from private workspaces.",
    imageCredit: "Illustration by SailorPath",
    imageCreditUrl: null,
  },
  "x-15-pilot-opens-ahead-of-worlds": {
    imageUrl: "/news/x15-class-guide.png",
    imageAlt: "An illustrated wingfoil rider above the water beside X-15 class guide cards.",
    imageCaption: "X-15 one-design wingfoil racing, illustrated. Open the class hub for event information and reviewed scorecards.",
    imageCredit: "Illustration by SailorPath",
    imageCreditUrl: null,
  },
  "18th-eastern-seaboard-regatta-2026-results-published": {
    imageUrl: "/news/eastern-seaboard-pattaya.jpg",
    imageAlt:
      "Optimist dinghies racing off Pattaya at the 2026 18th Eastern Seaboard Regatta hosted by Royal Varuna Yacht Club.",
    imageCaption:
      "Optimist fleet racing off Pattaya at the 2026 18th Eastern Seaboard Regatta hosted by Royal Varuna Yacht Club.",
    imageCredit: "Photo © Chainarong Phrammanee / Royal Varuna Yacht Club (via Sail-World)",
    imageCreditUrl: "https://www.sail-world.com/news/301250/Eastern-Seaboard-Regatta-2026",
  },
  "australian-2026-ilca-optimist-and-zhik-youth-sail-results": {
    imageUrl: "/news/australia-youth-championships.jpg",
    imageAlt:
      "ILCA fleet racing on the River Derwent in Hobart at the 2026 ILCA Oceania & Australian Open & Youth Championships.",
    imageCaption:
      "ILCA fleet racing on the River Derwent in Hobart during the 2026 ILCA Oceania & Australian Open & Youth Championships at the Royal Yacht Club of Tasmania.",
    imageCredit: "Photo © Jane Austin / 2026 ILCA Oceania & Australian Championships (via Sail-World)",
    imageCreditUrl:
      "https://www.sail-world.com/news/292765/ILCA-Oceania-and-AUS-Open-and-Youth-Championship-day-3",
  },
  "2026-asian-games-and-youth-worlds-coverage": {
    imageUrl: "/news/asian-games-gamagori.jpg",
    imageAlt:
      "ILCA racing at Kaiyoh Yacht Harbor in Gamagori, Japan during the 20th Asian Games Aichi-Nagoya 2026.",
    imageCaption:
      "ILCA racing at Kaiyoh Yacht Harbor in Gamagori, Japan during the 20th Asian Games Aichi-Nagoya 2026.",
    imageCredit: "Photo © Junichi Hirai / World Sailing (via Sail-World)",
    imageCreditUrl: "https://www.sail-world.com/news/300410/First-Olympic-spots-for-LA28-decided",
  },
};

function withArticleMedia(article: PublishedNewsArticle): PublishedNewsArticle {
  const media = ARTICLE_MEDIA_BY_SLUG[article.slug];
  if (!media) return article;
  return {
    ...article,
    imageUrl: article.imageUrl ?? media.imageUrl,
    imageAlt: article.imageAlt ?? media.imageAlt,
    imageCaption: article.imageCaption ?? media.imageCaption,
    imageCredit: article.imageCredit ?? media.imageCredit,
    imageCreditUrl: article.imageCreditUrl ?? media.imageCreditUrl,
  };
}

/**
 * Keeps the release-updates surface useful before the editorial migration has
 * been applied, or during a temporary database outage. The migration seeds the
 * same records; a successful database read always takes precedence.
 */
const FALLBACK_ARTICLES: PublishedNewsArticle[] = [
  {
    slug: "first-x15-world-championships-ibiza-2026",
    title: "History made in Ibiza at the first X-15 World Championships",
    summary: "Five inaugural world champions were crowned as 107 riders from 24 nations gathered in Ibiza for the first-ever X-15 World Championships.",
    body: `The first-ever X-15 World Championships brought 107 riders from 24 nations to Ibiza, Spain, from 4–8 November 2026, with five inaugural world titles on the line.

Hosted by Club Mare Nostrum at Port Nàutic Ibiza, the championship united experienced international sailors and emerging young wingfoilers on one-design equipment.

## The first X-15 world champions

• Senior Men: Kamil Manowiecki — Poland
• Senior Women: Jette Koep — Germany
• U19 Men: Holland Vierling — USA
• U19 Women: Yana Li — China
• U15: Benjamin Almeida — Brazil

Light winds limited racing during the week, leaving the senior titles decided by the opening-day results. A late breeze on Sunday gave the youth and junior fleets another opportunity to race and settle their championships.

Beyond the results, Ibiza marked the beginning of a new world championship community, bringing riders of different ages and backgrounds together to compete and share their experience.

Explore all five fleet standings and individual race scores on SailorPath.`,
    kind: "result_report",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-11-09T16:10:59.000+08:00",
    updatedAt: "2026-11-09T16:10:59.000+08:00",
    relatedClass: "X-15",
    relatedRegion: "Europe",
    sourceUrl: "https://sailorpath.com/regattas/x15-world-championships-2026",
    sourceLabel: "View the X-15 World Championships results",
    tags: ["x15", "world-championships", "ibiza", "spain", "wingfoiling", "results"],
  },
  {
    slug: "more-racing-from-taiwan-and-japan",
    title: "More racing from Taiwan and Japan",
    summary: "Explore newly added results from the Kaohsiung Lotus Pond Optimist Regatta, the 22nd Botchan Cup and Japan’s Youth Worlds selection regatta.",
    body: `SailorPath’s results archive now includes the Kaohsiung Lotus Pond Optimist Regatta, the 22nd Botchan Cup and Japan’s Youth Worlds selection regatta.

Explore fleet standings and individual race scores, with links to the official source documents. Double-handed entries connect both sailors to their shared boat result.

Lotus Pond’s available fleet results remain provisional. Its team-racing bracket is linked separately and is not presented as a complete final classification.

These overseas results contribute to sailors’ competition histories and do not count toward Singapore national rankings.`,
    kind: "result_report",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-11-08T22:44:06.000+08:00",
    updatedAt: "2026-11-08T22:44:06.000+08:00",
    relatedClass: null,
    relatedRegion: "Asia",
    sourceUrl: "https://sailorpath.com/results",
    sourceLabel: "Browse the results",
    tags: ["taiwan", "japan", "optimist", "ilca-4", "ilca-6", "420", "29er", "iqfoil", "results"],
  },
  {
    slug: "easier-browsing-for-race-results-and-sailor-awards",
    title: "Easier browsing for race results and sailor awards",
    summary: "Browse race-by-race results in a scrolling mobile table, and explore sailor awards with newest-first sorting and filters for dates, location, class and honours.",
    body: `Regatta results on mobile now use the same table format as desktop. Scroll across individual race scores, totals and net scores while keeping sailor names in view.

On sailor profiles, awards appear newest first. Search and filter by year, location, boat class, medal or a custom date range, or change the order to explore earlier achievements and best placings.

Together, these changes make it easier to follow a regatta and explore a sailor’s competition history.`,
    kind: "product_update",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-11-08T22:44:05.000+08:00",
    updatedAt: "2026-11-08T22:44:06.000+08:00",
    relatedClass: null,
    relatedRegion: "International",
    sourceUrl: "https://sailorpath.com/sailors",
    sourceLabel: "Explore sailor profiles",
    tags: ["product", "mobile", "results", "awards", "profiles"],
  },
  {
    slug: "asian-2026-multiclass-and-national-championships-published",
    title:
      "Asian championship coverage: regional opens and national results",
    summary:
      "Explore published 2026 championship scorecards from Langkawi Perdana, Hong Kong Race Week, Indonesia, the Philippines and the All Japan 420 Championship, with class and fleet details on each event page.",
    body: `SailorPath has published a new wave of 2026 Asian multi-class and national championship scorecards, expanding cross-border benchmarking across Southeast and East Asia for single-handed dinghies, double-handed skiffs, and windsurfing fleets.

## 22nd Langkawi International Regatta Perdana 2026 (Malaysia)

Published Langkawi scorecards cover dinghy, skiff and board classes. Open the event's class list to see the available fleets and source references:

• 29er and International 420
• ILCA 4, ILCA 6 and ILCA 7
• iQFOiL, Optimist and Techno 293

## Hong Kong Race Week 2026 & 29er Asian Championship

Alongside existing Optimist and ILCA 4 sheets from Hong Kong Race Week 2026, SailorPath has added the visually PDF-verified scorecards for:

• 29er (2026 29er Asian Championship — 21 entries, 13 races, 2 discards, with full helm and crew links)
• ILCA 6 (21 entries, 11 races, 1 discard)

## Indonesia, Philippines & All Japan National Championships

We have also completed imports for three national championship series across the region:

• 38th All Japan 420 Class Championship 2026 (Tottori, Japan — 26 entries across Qualifying & Final series, visually verified against the official JSAF/J420 final PDF)
• INA Regatta II — Indonesia National Sailing Championship 2026 (Jakarta — 420, ILCA 4, ILCA 6, ILCA 7, iQFOiL, Optimist and Techno 293)
• Philippine National Sailing Championship 2026 (Manila Bay — 420, ILCA 4, ILCA 6, ILCA 7 and Optimist Class A & Class B)

## Taiwan and historical Indian results

The archive also includes the 2026 Taiwan President's Cup and the 2023 YAI Junior National Sailing Championship in India. The Indian results retain their original 2023 event date.

Source note: These imports retain organiser or federation result references, including official PDF evidence for Indonesia and the Philippines. Individual scorecards show the available race scores and fleet details. Entry totals, dates and divisions should be read from the linked scorecards and official documents rather than inferred across separate fleets.`,
    kind: "result_report",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-11-03T10:00:00.000+08:00",
    updatedAt: "2026-11-03T14:25:00.000+08:00",
    relatedClass: "Optimist",
    relatedRegion: "Asia",
    sourceUrl: "https://sailorpath.com/results",
    sourceLabel: "Browse published Asian championship scorecards",
    tags: [
      "asia",
      "malaysia",
      "hong-kong",
      "indonesia",
      "philippines",
      "japan",
      "optimist",
      "ilca-4",
      "ilca-6",
      "ilca-7",
      "29er",
      "420",
      "techno-293",
      "iqfoil",
      "results",
    ],
  },
  {
    slug: "18th-eastern-seaboard-regatta-2026-results-published",
    title: "Eastern Seaboard 2026: final results confirmed",
    summary: "Final results are now available for ILCA 4, ILCA 6, Optimist Gold and Optimist Silver, covering 209 competitors and 1,672 individual race scores.",
    body: `Final results are now available for ILCA 4, ILCA 6, Optimist Gold and Optimist Silver at the 18th Eastern Seaboard Regatta.

The four fleets cover 209 competitors and 1,672 individual race scores. Placings, scores, penalties and discards remain unchanged.

SailorPath now displays Final status in line with the organiser’s official notice-board labels. The retained source PDFs still contain provisional headers; this difference remains documented in the source evidence.`,
    kind: "result_report",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-11-02T09:00:00.000+08:00",
    updatedAt: "2026-11-08T22:44:06.000+08:00",
    relatedClass: "Optimist",
    relatedRegion: "Asia",
    sourceUrl: "https://sailorpath.com/regattas/eastern-seaboard-regatta-2026",
    sourceLabel: "Explore the results",
    tags: ["thailand", "eastern-seaboard", "optimist", "ilca-4", "ilca-6", "results", "pdf-verified"],
  },
  {
    slug: "australian-2026-ilca-optimist-and-zhik-youth-sail-results",
    title:
      "Australian 2026 Championship Coverage: ILCA Oceania & Australian Championships, Optimist States, 29er & 420 Nationals, and Zhik Youth Sail",
    summary:
      "SailorPath publishes 52 verified Australian championship fleet sheets across the 2026 ILCA Oceania & Australian Championships in Hobart, Musto Australian and State Optimist Championships, Australian 29er and 420 National Championships, and the nationwide Zhik Youth Sail series.",
    body: `To support cross-border benchmarking across Asia and Oceania, SailorPath has completed a major expansion of 2026 Australian youth and open championship records across 52 fleet sheets and 7,780 individual race scores.

## 2026 ILCA Oceania & Australian Championships (Hobart, Tasmania)

All five championship fleets raced on the River Derwent in Hobart are now published with full race-by-race scores and discards:

• ILCA 4 Gold and Silver fleets (12 races, 2 discards)
• ILCA 6 Gold and Silver fleets
• ILCA 7 Open fleet

Source and verification note: All five ILCA Oceania & Australian Championship sheets have been visually verified and reconciled against both the official SailingResults.net portal and the 8-page organiser-hosted final results PDF.

## 2026 Australian National & State Optimist Championships

Nine completed Open and Intermediate fleet scorecards (260 entries, 1,470 race scores) are now live from the 2026 Australian domestic calendar:

• 2026 Musto Australian Optimist Championship (Intermediate Fleet, Royal Yacht Club of Tasmania)
• 2026 VIODA International Optimist Victorian & Open Championship (Open and Intermediate fleets)
• 2026 NSW, ACT, and Tasmanian Optimist State Championships (Open and Intermediate fleets)

## 2026 Australian 29er & International 420 National Championships

Two national double-handed youth championship scorecards are also published with full helm and crew attribution:

• 2026 Australian 29er Championship (Sandy Bay Sailing Club, Hobart — 21 entries, 14 races)
• 2026 International 420 Class Australian Championship (Albury Wodonga Sailing Club, Lake Hume — 17 entries, 10 races)

## 2026 Zhik Youth Sail State Championships (36 Fleet Sheets)

We have also imported 36 completed class sheets (478 entries, 3,554 race scores) across seven 2026 Zhik Youth Sail state championships—Tasmania, Northern Territory, Queensland, South Australia, Western Australia, New South Wales, and the ACT:

• Optimist (Open and Intermediate fleets across TAS, QLD, SA, WA, and NSW; 213 entries)
• ILCA 4, ILCA 6, and ILCA 7
• 29er and 420 double-handed youth fleets
• iQFOiL and Techno 293 windsurfing fleets

Source and verification note: Where official organiser PDFs were not published for the Australian Optimist state championships, 29er/420 Nationals, and Zhik Youth Sail portals, scorecards were verified directly against the official digital scoring systems (SailingResults.net, Sailwave, TopYacht, Sportspage, and SailSys) and are transparently marked as digital-source verified rather than PDF-verified. Zhik Youth Sail Victoria 2026 is recorded as un-sailed (0 races completed due to severe weather).`,
    kind: "result_report",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-10-30T11:00:00.000+08:00",
    updatedAt: "2026-11-03T14:25:00.000+08:00",
    relatedClass: "Optimist",
    relatedRegion: "Oceania",
    sourceUrl: "https://sailorpath.com/results",
    sourceLabel: "Explore published Australian regatta scorecards",
    tags: [
      "australia",
      "oceania",
      "optimist",
      "ilca-4",
      "ilca-6",
      "ilca-7",
      "29er",
      "420",
      "results",
    ],
  },
  {
    slug: "privacy-first-profiles-guardian-consent-and-evidence-protections",
    title:
      "Strengthening Youth Sailor Privacy: Consent-Gated Photos, Private Evidence, and Claim Protections",
    summary:
      "How public competition records, optional profile sharing, approved profile claims and private workspaces fit together for youth sailors and their families.",
    body: `Because youth sailing records involve minor athletes, SailorPath is built around a strict separation between the public competition record and private athlete or family data. Over the past week, we shipped a series of security and privacy upgrades across public profiles, file storage, and claim workflows.

## Verified Results by Default, Optional Sharing by Choice

Public sailor profiles bring together published competition history—regatta finishes, event sail numbers, class standings and recorded awards. Public records may also include nationality, gender, club and birth year.

• Profile photos and avatars are stored in private buckets and are never publicly served unless an authorised profile owner or verified parent/guardian has explicitly enabled public sharing.
• Full dates of birth and weight are private unless an authorised profile manager chooses to share them. Birth year may appear as part of the public competition record.
• Personal race notes, equipment locker items, and coach debriefs live exclusively inside authenticated Sailor, Parent, and Coach workspaces.

## Hardened Evidence Storage and Claim Quotas

When sailors or parents submit supporting documentation or result evidence, those uploads are now governed by stricter storage policies:

• Supporting evidence files are restricted to accounts with an approved sailor or guardian claim and are served only through short-lived, authorised access checks.
• Per-user upload quotas and file validation checks protect the platform against automated abuse while keeping legitimate result verification fast.

## International Championship Awards on Public Profiles

Official category awards and recorded podium finishes appear together on sailor profiles. Event and source links let visitors check the relevant scorecard or published award evidence. Profiles can include separate girls' awards, U16/U12 prizes and double-handed helm and crew honours.

Awards now appear newest first. Visitors can change the sort order and combine year, date range, location, boat class, medal and text filters. The medal totals reflect the filtered list.`,
    kind: "product_update",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-10-27T10:00:00.000+08:00",
    updatedAt: "2026-11-03T14:25:00.000+08:00",
    relatedClass: null,
    relatedRegion: "International",
    sourceUrl: "https://sailorpath.com/privacy",
    sourceLabel: "SailorPath Privacy Policy",
    tags: ["privacy", "profiles", "guardian-consent", "security", "product"],
  },
  {
    slug: "2026-asian-games-and-youth-worlds-coverage",
    title:
      "20th Asian Games 2026 Sailing Standings and Youth World Championship Results Added",
    summary:
      "SailorPath adds verified overall standings from the 20th Asian Games in Gamagori across five classes, alongside race-by-race scorecards from the 2026 ILCA 4 Youth World Championships and regional Asian Cup regattas.",
    body: `SailorPath has expanded its international championship archive with official standings from the 20th Asian Games 2026 in Gamagori, Japan, alongside full race-by-race scorecards from recent youth world and regional championships.

## 20th Asian Games 2026 (Kaiyoh Yacht Harbor, Japan)

Overall standings, final ranks, net scores, and medal outcomes from racing at Kaiyoh Yacht Harbor (26 September – 3 October 2026) are now live across five classes:

• ILCA 4 (Men's and Women's divisions)
• ILCA 6
• ILCA 7
• 29er (including full helm and crew participant attribution)
• iQFOiL

Source and verification note: Overall standings, final ranks, and net totals have been corroborated across official Asian Games Organising Committee (AINAGOC), Asian Sailing Federation (ASAF), World Sailing, and national federation releases. Individual race-by-race scores for the Asian Games sheets remain deferred pending release of the consolidated official final race-by-race PDF and are not marked as PDF-verified.

## 2026 ILCA 4 Youth Worlds and Regional ILCA Coverage

Alongside the Asian Games standings, we have published complete race-by-race scorecards and updated demographic records across key international and regional youth fleets:

• 2026 ILCA 4 Youth World Championships
• 2026 ILCA Asian Cup (Penghu)
• East and West Japan Optimist Championships and JODA National Team Final Selection Trials

Each imported scorecard links directly to its source attribution and updates the career histories and international prize records of participating sailors.`,
    kind: "result_report",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-10-22T09:00:00.000+08:00",
    updatedAt: "2026-10-22T09:00:00.000+08:00",
    relatedClass: "ILCA 4",
    relatedRegion: "Asia",
    sourceUrl: "https://sailorpath.com/results",
    sourceLabel: "Browse published championship scorecards",
    tags: [
      "asian-games",
      "ilca-4",
      "ilca-6",
      "ilca-7",
      "29er",
      "iqfoil",
      "results",
    ],
  },
  {
    slug: "a-clearer-public-sailing-record",
    title: "A clearer public sailing record",
    summary:
      "SailorPath now separates public results discovery from private account, parent and coach workspaces.",
    body:
      "Browse published sailing results, class standings and sailor profiles without an account. Approved profile claims connect sailors and families to their private workspaces. Optional personal information is controlled through profile sharing choices; private notes, equipment records and supporting evidence are separate from the public competition record.",
    kind: "product_update",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-10-15T00:00:00.000+08:00",
    updatedAt: "2026-11-03T14:25:00.000+08:00",
    relatedClass: null,
    relatedRegion: "Singapore",
    sourceUrl: null,
    sourceLabel: null,
    tags: ["product", "public-records", "privacy"],
  },
  {
    slug: "x-15-pilot-opens-ahead-of-worlds",
    title: "X-15 class guide: Worlds, Asian Championships and reviewed results",
    summary:
      "Find official X-15 championship information, class history and links to reviewed scorecards in the one-design wingfoil class hub.",
    body:
      "The X-15 class hub brings together the 2026 World Championships in Ibiza and Asian Championships in Thailand, class history and official event links. Reviewed scorecards appear as they are published on SailorPath. X-15 event results are separate from generic WingFoil results, and SailorPath does not publish an X-15 national ranking. Open the class hub for current event and result availability.",
    kind: "class_announcement",
    authorDisplayName: "SailorPath",
    publishedAt: "2026-10-15T00:00:00.000+08:00",
    updatedAt: "2026-11-03T14:25:00.000+08:00",
    relatedClass: "X-15",
    relatedRegion: "International",
    sourceUrl: null,
    sourceLabel: null,
    tags: ["x-15", "class-hub", "methodology"],
  },
];

function isSafeNewsSlug(value: string): boolean {
  return /^[a-z0-9]+(?:-[a-z0-9]+)*$/.test(value);
}

const PUBLIC_NEWS_COLUMNS = {
  slug: newsArticles.slug,
  title: newsArticles.title,
  summary: newsArticles.summary,
  body: newsArticles.body,
  kind: newsArticles.kind,
  authorDisplayName: newsArticles.authorDisplayName,
  publishedAt: newsArticles.publishedAt,
  updatedAt: newsArticles.updatedAt,
  relatedClass: newsArticles.relatedClass,
  relatedRegion: newsArticles.relatedRegion,
  sourceUrl: newsArticles.sourceUrl,
  sourceLabel: newsArticles.sourceLabel,
  tags: newsArticles.tags,
} as const;

type PublicNewsRow = Pick<
  typeof newsArticles.$inferSelect,
  keyof typeof PUBLIC_NEWS_COLUMNS
>;

function toPublishedArticle(row: PublicNewsRow): PublishedNewsArticle {
  if (!row.publishedAt) {
    throw new Error(`Published news article ${row.slug} is missing published_at`);
  }

  return withArticleMedia({
    slug: row.slug,
    title: row.title,
    summary: row.summary,
    body: row.body,
    kind: row.kind,
    authorDisplayName: row.authorDisplayName,
    publishedAt: row.publishedAt.toISOString(),
    updatedAt: row.updatedAt.toISOString(),
    relatedClass: row.relatedClass,
    relatedRegion: row.relatedRegion,
    sourceUrl: row.sourceUrl,
    sourceLabel: row.sourceLabel,
    tags: Array.isArray(row.tags) ? row.tags.filter((tag): tag is string => typeof tag === "string") : [],
  });
}

async function readPublishedNews(): Promise<PublishedNewsArticle[]> {
  const rows = await db
    .select(PUBLIC_NEWS_COLUMNS)
    .from(newsArticles)
    .where(eq(newsArticles.status, "published"))
    .orderBy(desc(newsArticles.publishedAt));

  const publishedRows = rows.map(toPublishedArticle);
  const existingSlugs = new Set(publishedRows.map((row) => row.slug));
  const missingFallbacks = FALLBACK_ARTICLES.filter(
    (article) => !existingSlugs.has(article.slug)
  ).map(withArticleMedia);

  return [...publishedRows, ...missingFallbacks].sort((a, b) =>
    b.publishedAt.localeCompare(a.publishedAt)
  );
}

async function readPublishedNewsArticle(
  slug: string
): Promise<PublishedNewsArticle | null> {
  const [row] = await db
    .select(PUBLIC_NEWS_COLUMNS)
    .from(newsArticles)
    .where(
      and(
        eq(newsArticles.slug, slug),
        eq(newsArticles.status, "published")
      )
    )
    .limit(1);

  if (row) return toPublishedArticle(row);
  const fallback = FALLBACK_ARTICLES.find((article) => article.slug === slug);
  return fallback ? withArticleMedia(fallback) : null;
}

const getCachedPublishedNews = unstable_cache(
  readPublishedNews,
  ["published-news-v8-x15-worlds"],
  {
    revalidate: PUBLIC_DATA_REVALIDATE_SECONDS,
    tags: [CACHE_TAG_NEWS_ARTICLES],
  }
);

function cachedArticleLookup(slug: string) {
  return unstable_cache(
    () => readPublishedNewsArticle(slug),
    ["published-news-article-v8-x15-worlds", slug],
    {
      revalidate: PUBLIC_DATA_REVALIDATE_SECONDS,
      tags: [CACHE_TAG_NEWS_ARTICLES],
    }
  );
}

/** Published rows only; editorial drafts and review metadata never cross this boundary. */
export async function listPublishedNews(): Promise<PublishedNewsArticle[]> {
  try {
    return await getCachedPublishedNews();
  } catch (error) {
    console.warn("[news] published article query failed; serving release-update fallback", error);
    return FALLBACK_ARTICLES.map(withArticleMedia);
  }
}

/** A missing or non-published article is intentionally indistinguishable from a missing route. */
export async function getPublishedNewsArticle(
  slug: string
): Promise<PublishedNewsArticle | null> {
  const normalized = slug.trim().toLowerCase();
  if (!isSafeNewsSlug(normalized)) return null;

  try {
    return await cachedArticleLookup(normalized)();
  } catch (error) {
    console.warn("[news] article query failed; serving release-update fallback", error);
    const fallback = FALLBACK_ARTICLES.find((article) => article.slug === normalized);
    return fallback ? withArticleMedia(fallback) : null;
  }
}

export function formatNewsDate(isoTimestamp: string): string {
  return new Intl.DateTimeFormat("en-GB", {
    day: "numeric",
    month: "long",
    year: "numeric",
    timeZone: "Asia/Singapore",
  }).format(new Date(isoTimestamp));
}
