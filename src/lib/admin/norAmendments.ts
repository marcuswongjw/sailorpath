/**
 * Amendment 1 details from the official Notices of Race.
 * Shown in the admin regatta editor only. The public site is unchanged.
 */

export type NorPrizeLine = { fleet: string; prizes: string };

export type NorAmendment = {
  id: string;
  title: string;
  amendedOn: string;
  website: string;
  noticeUrl: string;
  venue: string;
  classes: string;
  fees: string;
  deadlines: string;
  schedule: string[];
  races: string[];
  prizes: NorPrizeLine[];
  notes: string[];
};

export const NOR_AMENDMENTS: NorAmendment[] = [
  {
    id: "safyc-optimist-2026",
    title: "2nd SAFYC Optimist Championships 2026 — Notice of Race",
    amendedOn: "Notice of Race",
    website: "https://www.safyc.org.sg",
    noticeUrl: "https://www.racingrulesofsailing.org/documents/14691/event",
    venue: "NSRCC Seasports Centre, 11 Changi Coast Walk, Singapore 499740",
    classes: "Optimist Gold, Optimist Silver",
    fees:
      "Early bird on or before 25 June 2026: SAFYC members $70.85, non-members $92.65. After 25 June: members $92.65, non-members $114.45.",
    deadlines: "Entry closes 25 June 2026. Late entries may be accepted at the organising authority’s discretion.",
    schedule: [
      "4 July 2026, 1100h: first warning for Optimist Gold and Silver.",
      "5 July 2026, 1100h: first warning. Prize presentation 1800h at NSRCC Seasports Centre.",
      "No warning signal after 1600h on the last day.",
    ],
    races: [
      "7 races scheduled, maximum 4 per day, for both Gold and Silver.",
      "Official results, final 6 July 2026. Gold sailed 7 races with 1 discard, 91 entries. Silver sailed 5 races with 1 discard, 58 entries.",
      "One race constitutes the event. Fewer than 4 races: no discard. Four or more: one discard.",
    ],
    prizes: [
      { fleet: "Optimist Gold", prizes: "Open 1st–10th, Female 1st–5th, 12 & under 1st–5th, 10 & under 1st–5th. Open winner Alyssa Wong Li Lin, sail 150, nett 18.8." },
      { fleet: "Optimist Silver", prizes: "Open 1st–10th, Female 1st–5th, 10 & under (born 2016) 1st–5th, 9 years (born 2017) 1st–5th, 8 & under (born 2018 or later) 1st–5th. Open winner Lee Thian Tsek Bryan, sail 3508, nett 11.0." },
    ],
    notes: [
      "The organising authority is SAF Yacht Club. Questions: seasports@safyc.org.sg, 6758 3359.",
      "Sailing instructions are posted on the notice board after 1 July 2026.",
    ],
  },
  {
    id: "pesta-sukan-2026",
    title: "Pesta Sukan 2026 — NoR Amendment 1",
    amendedOn: "27 April 2026",
    website: "https://www.sailing.org.sg/events/351968",
    noticeUrl:
      "https://www.racingrulesofsailing.org/documents/14397/event?name=pesta-sukan-2026",
    venue: "National Sailing Centre, 1500 East Coast Parkway, Singapore 468963",
    classes:
      "Optimist Gold, Optimist Silver, ILCA 4, ILCA 6, ILCA 7, 29er, Techno 293/293+, iQFOiL, WingFoil",
    fees:
      "By 6 July 2026, 2359h: single-handed $78 (amended from $101), double-handed $156 (amended from $202), GST included. Late fee $54.50 if payment is not received by 6 July 2026, 2359h.",
    deadlines: "Entry form and fee due 13 July 2026, 2359h.",
    schedule: [
      "25–26 July: Optimist Silver and boards, plus the Open Water Festival Passage Race. Prize presentation 1830h, NSC Boat Hangar.",
      "1–2 August: ILCA, Optimist Gold, and 29er. First warning for those classes. Prize presentation 1830h, NSC Boat Hangar.",
      "Passage Race is a standalone event. Its results count as races for Optimist Silver and the board classes. They do not count for Optimist Gold, ILCA, or 29er.",
    ],
    races: [
      "Optimist Gold / ILCA / 29er: 6 races, maximum 4 per day.",
      "Optimist Silver: 5 races, maximum 3 per day.",
      "Techno 293 / iQFOiL / WingFoil: 7 races, maximum 5 per day.",
      "One race constitutes a series. Four or more races: one discard.",
      "No warning signal after 1600h on the last day.",
    ],
    prizes: [
      { fleet: "Optimist Gold", prizes: "Open 1st–10th, Female 1st–3rd, 11–12 (born 2014–2015) 1st–5th, 9–10 (born 2016–2017) 1st–5th, Primary School 1st, Secondary School 1st" },
      { fleet: "Optimist Silver", prizes: "Open 1st–10th, Female 1st–3rd, 9–10 (born 2016–2017) 1st–3rd, 8 & under (born 2018 or later) 1st–3rd, Novice 1st–10th, Primary School 1st" },
      { fleet: "ILCA 4", prizes: "Open 1st–3rd, Female 1st–3rd, Novice 1st–3rd, 13 & under (born 2013 or later) 1st–3rd, Secondary School 1st" },
      { fleet: "ILCA 6", prizes: "Open 1st–3rd, Female 1st–3rd, Novice 1st–3rd, 15 & under (born 2011 or later) 1st–3rd, Secondary School 1st, Junior College 1st, Polytechnic/ITE 1st" },
      { fleet: "ILCA 7", prizes: "Open 1st–3rd, 20 & under (born 2006 or later) 1st" },
      { fleet: "29er", prizes: "Open 1st–3rd" },
      { fleet: "Techno 293 / 293+", prizes: "Open 1st–3rd, Female 1st" },
      { fleet: "iQFOiL", prizes: "18 & under (born 2008 or later) 1st–3rd, Female 1st" },
      { fleet: "WingFoil", prizes: "18 & under (born 2008 or later) 1st–3rd, Female 1st" },
      { fleet: "Passage Race", prizes: "Open 1st–3rd for Optimist Gold and Silver, ILCA 4/6/7, 29er, Techno 293, iQFOiL, and WingFoil" },
    ],
    notes: [
      "Official final results. Optimist Gold: 6 races, 1 discard, 77 entries, final 3 Aug 2026 at 17:07. Open winner Alyssa Li Lin Wong (sail 150, nett 15).",
      "Optimist Silver: 4 races, 1 discard, 54 entries, final 28 Jul 2026 at 09:57. Open winner Bryan Thian Tsek Lee (sail 3508, nett 4).",
      "ILCA 4: 5 races, 1 discard, 43 entries, final 3 Aug 2026 at 17:04. Open winner Caleb Peck (sail 225221, nett 6), then Lucas Zhihong Cao and Yuk Jun Lim.",
      "A class may be cancelled if fewer than 6 boats enter. Fees for a cancelled class are refunded.",
      "Novice and school prizes are not awarded to overseas or visiting competitors.",
      "If a category has fewer than 6 entries, only 1st is awarded.",
      "29er: two-turns penalty is changed to a one-turn penalty.",
    ],
  },
  {
    id: "cincapura-2026",
    title: "Cincapura Regatta 2026 — NoR Amendment 1",
    amendedOn: "10 July 2026",
    website: "https://www.sailing.org.sg/events/323693",
    noticeUrl: "https://www.racingrulesofsailing.org/documents/14587/event",
    venue: "National Sailing Centre, 1500 East Coast Parkway, Singapore 468963",
    classes:
      "Optimist Gold, Optimist Silver, ILCA 4, ILCA 6, ILCA 7, 29er, Techno 293/293+, iQFOiL, WingFoil",
    fees:
      "Entry fee by 29 June 2026, 2359h: single-handed $78, double-handed $156, GST included. Late fee $54.50 if full payment is not received by 28 June 2026, 2359h.",
    deadlines: "Entry form and fee due 6 July 2026, 2359h, at the event website.",
    schedule: [
      "18 July: team leaders and coaches briefing 0930h, Level 2 Conference Room. First warning 1100h–1200h.",
      "19 July: team leaders and coaches briefing 1000h. First warning 1100h. Prize presentation 1830h, NSC Boat Hangar.",
      "The amendment schedule is 18–19 July. It does not list a 20 July race day.",
    ],
    races: [
      "Optimist Gold / ILCA / 29er: 6 races, maximum 4 per day.",
      "Optimist Silver: 5 races, maximum 3 per day.",
      "Techno 293 / iQFOiL / WingFoil: the race table prints 7 and 8 in the total column and 5 as the daily maximum. Treat 8 races, maximum 5 per day, as the amended figure.",
      "One race constitutes a series. Four or more races: one discard.",
      "No warning signal after 1600h on the last day.",
    ],
    prizes: [
      { fleet: "Optimist Gold", prizes: "Open 1st–10th, Female 1st–3rd, 11–12 (born 2014–2015) 1st–5th, 9–10 (born 2016–2017) 1st–5th, Primary School 1st, Secondary School 1st" },
      { fleet: "Optimist Silver", prizes: "Open 1st–10th, Female 1st–3rd, 9–10 (born 2016–2017) 1st–3rd, 8 & under (born 2018 or later) 1st–3rd, Novice 1st–10th, Primary School 1st" },
      { fleet: "ILCA 4", prizes: "Open 1st–3rd, Female 1st–3rd, Novice 1st–3rd, 13 & under (born 2013 or later) 1st–3rd, Secondary School 1st" },
      { fleet: "ILCA 6", prizes: "Open 1st–3rd, Female 1st–3rd, Novice 1st–3rd, 15 & under (born 2011 or later) 1st–3rd, Secondary School 1st, Junior College 1st, Polytechnic/ITE 1st" },
      { fleet: "ILCA 7", prizes: "Open 1st–3rd, 20 & under (born 2006 or later) 1st" },
      { fleet: "29er", prizes: "Open 1st–3rd" },
      { fleet: "Techno 293 / 293+", prizes: "Open 1st–3rd, Female 1st" },
      { fleet: "iQFOiL", prizes: "18 & under (born 2008 or later) 1st–3rd, Female 1st" },
      { fleet: "WingFoil", prizes: "18 & under (born 2008 or later) 1st–3rd, Female 1st" },
    ],
    notes: [
      "Official final results. Optimist Gold: 3 races, no discard, 86 entries, final 20 Jul 2026 at 13:18. Open winner Kyle Jeremy Zhi Jun Soh (sail 3183, nett 21).",
      "Optimist Silver: 4 races, 1 discard, 55 entries, final 21 Jul 2026 at 10:00. Open winner Adele Ziyi Chiang (sail 3120, nett 11).",
      "ILCA 4: 2 races, no discard, 42 entries, final 20 Jul 2026 at 13:34. Open winner Mika Tew (sail 227461, nett 7).",
      "ILCA 6: 3 races, no discard, 16 entries, final 21 Jul 2026 at 09:56. Open winner Sarah Rui-En Yong (sail 221689, nett 6).",
      "29er: 2 races, no discard, 3 entries. Techno 293: 8 races, 1 discard, 7 entries. Both final 21 Jul 2026 at 10:13. 29er winners Cheryl Ho / Gemma Chen. Techno 293 winner Addy Armand Anuar. First Techno female Kate Teo.",
      "Event website in Amendment 1 is https://www.sailing.org.sg/events/323693.",
      "Optimist sailors must sail the fleet that matches their national ranking. The wrong fleet scores no ranking points.",
      "International Optimist entrants who do not live in Singapore are assigned a fleet by the organising authority.",
      "A class may be cancelled if fewer than 6 boats enter.",
      "Novice and school prizes are not awarded to overseas or visiting competitors.",
      "If a category has fewer than 6 entries, only 1st is awarded.",
    ],
  },
];

export function norAmendmentForRegatta(
  name: string | null | undefined,
  slug: string | null | undefined
): NorAmendment | null {
  const hay = `${name || ""} ${slug || ""}`.toLowerCase();
  const byId = (id: string) => NOR_AMENDMENTS.find((notice) => notice.id === id) ?? null;
  if (hay.includes("pesta") && hay.includes("sukan")) return byId("pesta-sukan-2026");
  if (hay.includes("cincapura")) return byId("cincapura-2026");
  if (
    (hay.includes("safyc") || hay.includes("saf yacht")) &&
    hay.includes("optimist")
  ) {
    return byId("safyc-optimist-2026");
  }
  return null;
}
