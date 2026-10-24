/** Events requested for planning whose exact dates are not yet verified. */
export type PendingRegatta = {
  slug: string;
  name: string;
  year: string;
  boatClass: string;
  region: string;
  venue: string;
  organizer: string;
  officialUrl: string;
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
];

// Checked 2026-10-24: the organiser's calendar has no dated 45th edition.
// USODA's international-team listing names it with dates TBD.
// https://fragliavelariva.it/calendario?tipo=regata
// https://usoda.org/international-team
