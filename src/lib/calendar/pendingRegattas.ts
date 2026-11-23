import { X15_PENDING_EVENTS } from "@/lib/x15Calendar";

/** Events requested for planning whose exact dates are not yet verified. */
export type PendingRegatta = {
  slug: string;
  name: string;
  year: string;
  period?: string;
  boatClass: string;
  classes?: string[];
  region: string;
  venue: string;
  organizer: string;
  officialUrl?: string;
  isSelectionTrial?: boolean;
  notice?: string;
};

export const PENDING_REGATTAS: readonly PendingRegatta[] = [
  {
    slug: "45th-lake-garda-meeting-optimist-2027",
    name: "45th Lake Garda Meeting Optimist",
    year: "2027",
    boatClass: "Optimist",
    region: "Europe",
    venue: "Riva del Garda, Lake Garda, Italy",
    organizer: "Fraglia Vela Riva",
    officialUrl: "https://fragliavelariva.it/",
  },
  {
    slug: "optimist-asian-oceanian-championship-2027",
    name: "2027 Optimist Asian & Oceanian Championship",
    year: "2027",
    boatClass: "Optimist",
    region: "Asia",
    venue: "Host Venue TBD",
    organizer: "International Optimist Dinghy Association (IODA)",
    officialUrl: "https://optiworld.org",
  },
  {
    slug: "15th-bodrum-international-optimist-regatta-2027",
    name: "15th Bodrum International Optimist Regatta (Europe Training Camp)",
    year: "2027",
    period: "April/May 2027 (TBC)",
    boatClass: "Optimist",
    classes: ["Optimist"],
    region: "Europe",
    venue: "Bodrum, Turkey",
    organizer: "Bodrum International Optimist Regatta / Singapore Sailing Federation",
    isSelectionTrial: true,
    notice:
      "SSF 2027 Optimist Europe Training Camp target (top 5 males and top 5 females selected from CSC Optimist Championships and 23rd SAFYC Regatta) and Part B selection event for the 2027 IODA Optimist World Championship (top 3 ranked sailors).",
  },
  {
    slug: "roc-kosmos-2027",
    name: "ROC Kosmos 2027",
    year: "2027",
    period: "July 2027 (TBC)",
    boatClass: "Optimist",
    classes: ["Optimist"],
    region: "Europe",
    venue: "Athens, Greece",
    organizer: "The R.O.C.",
    officialUrl: "https://www.regattaofchampions.com/",
    notice:
      "SSF 2027 Optimist Gold Fleet self-funded campaign (top 3 males and top 3 females open, plus top 2 males and top 2 females born in 2014 or later, selected via CSC Optimist Championships, Pulau Ujong Regatta, and SYSC 2027).",
  },
  {
    slug: "pesta-sukan-regatta-2027",
    name: "Pesta Sukan Regatta 2027",
    year: "2027",
    period: "August 2027",
    boatClass: "ILCA 4",
    classes: ["ILCA 4", "ILCA 6"],
    region: "Singapore",
    venue: "National Sailing Centre, Singapore",
    organizer: "Singapore Sailing Federation",
    officialUrl: "https://www.sailing.org.sg",
    isSelectionTrial: true,
    notice:
      "Official 2027 SSF selection event 1 for ILCA 4 and ILCA 6 Eastern Seaboard Regatta 2027 (sailors born in 2011 or later).",
  },
  {
    slug: "snsc-2027",
    name: "Singapore National Sailing Championships 2027",
    year: "2027",
    period: "September 2027",
    boatClass: "ILCA 4",
    classes: ["ILCA 4", "ILCA 6"],
    region: "Singapore",
    venue: "National Sailing Centre, Singapore",
    organizer: "Singapore Sailing Federation",
    officialUrl: "https://www.sailing.org.sg",
    isSelectionTrial: true,
    notice:
      "Official 2027 SSF selection event 2 for ILCA 4 and ILCA 6 Eastern Seaboard Regatta 2027 (sailors born in 2011 or later).",
  },
  {
    slug: "eastern-seaboard-regatta-2027",
    name: "Eastern Seaboard Regatta 2027",
    year: "2027",
    period: "2027 (TBC)",
    boatClass: "ILCA 4",
    classes: ["ILCA 4", "ILCA 6"],
    region: "Asia",
    venue: "Pattaya, Thailand",
    organizer: "Royal Varuna Yacht Club",
    officialUrl: "https://varuna.org",
    notice:
      "Target international regatta for Singapore ILCA 4 and ILCA 6 squads (top 3 males and top 3 females per class, born in 2011 or later, selected via Pesta Sukan Regatta 2027 and Singapore National Sailing Championships 2027).",
  },
  ...X15_PENDING_EVENTS,
];

// Checked 2026-10-24: the organiser's calendar has no dated 45th edition.
// USODA's international-team listing names it with dates TBD.
// https://fragliavelariva.it/calendario?tipo=regata
// https://usoda.org/international-team
