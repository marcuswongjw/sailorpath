/**
 * Static SAMPLE / DEMO data — not from the database.
 * Used on /sample to showcase Public · Sailor · Parent · Coach experiences.
 */

export type DemoRole = "public" | "sailor" | "parent" | "coach";

export const DEMO_ROLE_COPY: Record<
  DemoRole,
  { title: string; who: string; value: string }
> = {
  public: {
    title: "Public",
    who: "Anyone browsing SailorPath",
    value:
      "Fleet badge, age band, and regatta results — without private weight, notes, or gear unless shared.",
  },
  sailor: {
    title: "Sailor",
    who: "The athlete who owns this profile",
    value:
      "Full logbook, race notes, dual-class results, and privacy settings (via Settings).",
  },
  parent: {
    title: "Parent",
    who: "Guardian linked to this sailor",
    value:
      "Squad schedule, upcoming deadlines, equipment alerts, parent notes, and series context.",
  },
  coach: {
    title: "Coach",
    who: "Squad coach reviewing athletes",
    value:
      "Squad context, selection readiness, private coach notes, and comparison — never privacy controls.",
  },
};

/** Approx age for demo (full DOB when set). */
export function sampleAgeYears(
  dob: string | null | undefined,
  asOf: Date = new Date()
): number | null {
  const ymd = String(dob || "").slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(ymd)) return null;
  const [y, m, d] = ymd.split("-").map(Number);
  let age = asOf.getFullYear() - y!;
  const month = asOf.getMonth() + 1;
  const day = asOf.getDate();
  if (month < m! || (month === m && day < d!)) age -= 1;
  return age >= 0 ? age : null;
}

export const SAMPLE_SAILOR = {
  id: "sample-kimberly",
  name: "Kimberly Tan",
  handle: "kimberly-t",
  sailNumber: "SGP 115",
  sailNumberIlca4: "SGP 2115",
  club: "Changi Sailing Club",
  nationality: "SGP",
  goldEntryDate: "2025-06-15",
  silverEntryDate: "2024-01-10",
  dropDate: null as string | null,
  currentFleet: "Series",
  school: "Raffles Institution",

  dob: "2013-08-14",
  weight: 42,
  bio: "Dual-class Optimist Gold & ILCA 4 racer focused on light-wind speed and clean starts. Training toward Asian championships.",
  gender: "F",
  nationalSquadStatus: "Nat A",
  instagram: "@kimberly.t_sails",
  facebook: null as string | null,
  /** Demo headshot (static asset) */
  avatarUrl: "/demo-kimberly-tan.jpg" as string | null,
  isPublicWeight: false,
  isPublicDob: false,
  /** Public view respects this — gear stays private until shared */
  isPublicEquipment: false,
  natSquadStatusJan25: "DS",
  natSquadStatusJul25: "Nat B",
  natSquadStatusJan26: "Nat A",
  natSquadStatusJul26: "Nat A",
  histRankingJun24: 15,
  histRankingDec24: 11,
  histRankingJun25: 6,
  histRankingDec25: 4,
  histRankingJun26: 3,
  worlds: "2025",
  european: null as string | null,
  asian: "2024, 2025",
  seaGames: null as string | null,
  sailingJourney: JSON.stringify([
    {
      id: "demo-j1",
      when: "Jun 2026",
      title: "First National Championship win",
      detail:
        "Won Singapore Nationals in Gold fleet — a memory that still fuels training.",
    },
    {
      id: "demo-j2",
      when: "2025",
      title: "Represented Singapore at Asian Championships",
      detail: "Proud to race for SGP among the best Optimist sailors in Asia.",
    },
    {
      id: "demo-j3",
      when: "Jan 2025",
      title: "Selected for Nat A squad",
      detail: "Moved up from Nat B after a strong Jul–Dec 2024 series.",
    },
    {
      id: "demo-j4",
      when: "Mar 2026",
      title: "First ILCA 4 regatta",
      detail: "Started dual-class path while remaining Optimist Gold eligible.",
    },
  ]),
};

/** ILCA 4 national ranking snapshot (demo dual-class) */
export const SAMPLE_ILCA_STANDING = {
  periodLabel: "ILCA 4 · 2026 national series",
  fleet: "Open" as const,
  overallRank: 8,
  fleetSize: 42,
  best3of5: 78,
  rScores: [
    {
      regattaId: "sample-ilca1",
      regattaName: "CSC ILCA Open",
      score: 25,
      finishPlace: 4,
      isDNS: false,
      isOverseasCommitment: false,
    },
    {
      regattaId: "sample-ilca2",
      regattaName: "SAFYC ILCA",
      score: 27,
      finishPlace: 6,
      isDNS: false,
      isOverseasCommitment: false,
    },
    {
      regattaId: "sample-ilca3",
      regattaName: "NSC ILCA Cup",
      score: 16,
      finishPlace: 9,
      isDNS: false,
      isOverseasCommitment: false,
    },
    {
      regattaId: "sample-ilca4",
      regattaName: "Changi series",
      score: 14,
      finishPlace: 5,
      isDNS: false,
      isOverseasCommitment: false,
    },
    {
      regattaId: "sr-ilca5",
      regattaName: "Missed event",
      score: 0,
      finishPlace: null,
      isDNS: true,
      isOverseasCommitment: false,
    },
  ],
  trendNote: "Best 3 of 5 high points · #8 nationally",
  boatClass: "ILCA 4" as const,
};

/** Best 3 of 5 snapshot for Jul–Dec 2026 demo (matches SailorProfileView shape) */
export const SAMPLE_SERIES_STANDING = {
  periodLabel: "Jul – Dec 2026 (Current)",
  fleet: "Gold" as const,
  overallRank: 3,
  fleetSize: 100,
  best3of5: 14,
  rScores: [
    {
      regattaId: "sr1",
      regattaName: "NRS 3 · Jul",
      score: 5,
      isDNS: false,
      isOverseasCommitment: false,
    },
    {
      regattaId: "sr2",
      regattaName: "CSC Gold · Aug",
      score: 4,
      isDNS: false,
      isOverseasCommitment: false,
    },
    {
      regattaId: "sr3",
      regattaName: "SAFYC Gold · Sep",
      score: 5,
      isDNS: false,
      isOverseasCommitment: false,
    },
    {
      regattaId: "sr4",
      regattaName: "NSC Cup · Oct",
      score: 12,
      isDNS: true,
      isOverseasCommitment: false,
    },
    {
      regattaId: "sr5",
      regattaName: "Nationals · Nov",
      score: 3,
      isDNS: false,
      isOverseasCommitment: false,
    },
  ],
  trendNote: "↑ 1 place vs Jun 2026 · Best 3 of 5 = 5+4+5",
};

/** Optimist + ILCA 4 results (dual-class demo). boatClass drives class tabs. */
export const SAMPLE_RESULTS = [
  {
    id: "sample-r1",
    regattaId: "sample-r1",
    regattaName: "Singapore National Championship 2026",
    regattaSlug: "sample-nationals-2026",
    regattaDate: "2026-06-15",
    geography: "SG",
    division: "Gold",
    boatClass: "Optimist",
    totalFleetSize: 85,
    fleetSize: 85,
    rank: 1,
    totalScore: 38,
    nettScore: 24,
    isDns: false,
    isOverseasCommitment: false,
    raceCount: 8,
  },
  {
    id: "sample-r2",
    regattaId: "sample-r2",
    regattaName: "Baltic Optimist Cup 2026",
    regattaSlug: "sample-baltic-2026",
    regattaDate: "2026-05-10",
    geography: "EE",
    division: "Gold",
    boatClass: "Optimist",
    totalFleetSize: 120,
    fleetSize: 120,
    rank: 2,
    totalScore: 48,
    nettScore: 36,
    isDns: false,
    isOverseasCommitment: false,
    raceCount: 9,
    countsForRanking: false,
  },
  {
    id: "sample-r3",
    regattaId: "sample-r3",
    regattaName: "CSC Optimist Championships 2026",
    regattaSlug: "sample-csc-2026",
    regattaDate: "2026-05-04",
    geography: "SG",
    division: "Gold",
    boatClass: "Optimist",
    totalFleetSize: 60,
    fleetSize: 60,
    rank: 8,
    totalScore: 82,
    nettScore: 68,
    isDns: false,
    isOverseasCommitment: false,
    raceCount: 6,
  },
  {
    id: "sample-r4",
    regattaId: "sample-r4",
    regattaName: "Kiel Week Optimist 2026",
    regattaSlug: "sample-kiel-2026",
    regattaDate: "2026-04-20",
    geography: "DE",
    division: "Gold",
    boatClass: "Optimist",
    totalFleetSize: 200,
    fleetSize: 200,
    rank: 3,
    totalScore: 55,
    nettScore: 42,
    isDns: false,
    isOverseasCommitment: false,
    raceCount: 10,
    countsForRanking: false,
  },
  {
    id: "sample-r5",
    regattaId: "sample-r5",
    regattaName: "SAFYC Regatta 2026",
    regattaSlug: "sample-safyc-2026",
    regattaDate: "2026-04-12",
    geography: "SG",
    division: "Gold",
    boatClass: "Optimist",
    totalFleetSize: 72,
    fleetSize: 72,
    rank: 2,
    totalScore: 29,
    nettScore: 18,
    isDns: false,
    isOverseasCommitment: false,
    raceCount: 7,
  },
  {
    id: "sample-r6",
    regattaId: "sample-r6",
    regattaName: "Trofeo Optimist Italia 2026",
    regattaSlug: "sample-italia-2026",
    regattaDate: "2026-03-15",
    geography: "IT",
    division: "Gold",
    boatClass: "Optimist",
    totalFleetSize: 180,
    fleetSize: 180,
    rank: 7,
    totalScore: 91,
    nettScore: 74,
    isDns: false,
    isOverseasCommitment: false,
    raceCount: 8,
    countsForRanking: false,
  },
  {
    id: "sample-r7",
    regattaId: "sample-r7",
    regattaName: "National Ranking Series 1 2026",
    regattaSlug: "sample-nrs1-2026",
    regattaDate: "2026-02-28",
    geography: "SG",
    division: "Gold",
    boatClass: "Optimist",
    totalFleetSize: 90,
    fleetSize: 90,
    rank: 2,
    totalScore: null,
    nettScore: null,
    isDns: false,
    isOverseasCommitment: true,
    raceCount: 6,
  },
  {
    id: "sample-r8",
    regattaId: "sample-r8",
    regattaName: "NSC Cup 2026",
    regattaSlug: "sample-nsc-2026",
    regattaDate: "2026-01-18",
    geography: "SG",
    division: "Gold",
    boatClass: "Optimist",
    totalFleetSize: 55,
    fleetSize: 55,
    rank: 56,
    totalScore: null,
    nettScore: null,
    isDns: true,
    isOverseasCommitment: false,
    raceCount: 5,
  },
  // ILCA 4 dual-class results (Open fleet)
  {
    id: "sample-ilca1",
    regattaId: "sample-ilca1",
    regattaName: "CSC ILCA Open 2026",
    regattaSlug: "sample-csc-ilca-2026",
    regattaDate: "2026-07-05",
    geography: "SG",
    division: "Open",
    boatClass: "ILCA 4",
    totalFleetSize: 28,
    fleetSize: 28,
    rank: 4,
    totalScore: 42,
    nettScore: 34,
    isDns: false,
    isOverseasCommitment: false,
    raceCount: 6,
  },
  {
    id: "sample-ilca2",
    regattaId: "sample-ilca2",
    regattaName: "SAFYC ILCA Regatta 2026",
    regattaSlug: "sample-safyc-ilca-2026",
    regattaDate: "2026-05-24",
    geography: "SG",
    division: "Open",
    boatClass: "ILCA 4",
    totalFleetSize: 32,
    fleetSize: 32,
    rank: 6,
    totalScore: 58,
    nettScore: 46,
    isDns: false,
    isOverseasCommitment: false,
    raceCount: 7,
  },
  {
    id: "sample-ilca3",
    regattaId: "sample-ilca3",
    regattaName: "NSC ILCA Cup 2026",
    regattaSlug: "sample-nsc-ilca-2026",
    regattaDate: "2026-04-05",
    geography: "SG",
    division: "Open",
    boatClass: "ILCA 4",
    totalFleetSize: 24,
    fleetSize: 24,
    rank: 9,
    totalScore: 71,
    nettScore: 59,
    isDns: false,
    isOverseasCommitment: false,
    raceCount: 5,
  },
  {
    id: "sample-ilca4",
    regattaId: "sample-ilca4",
    regattaName: "Changi ILCA Training Series 2026",
    regattaSlug: "sample-changi-ilca-2026",
    regattaDate: "2026-03-08",
    geography: "SG",
    division: "Open",
    boatClass: "ILCA 4",
    totalFleetSize: 18,
    fleetSize: 18,
    rank: 5,
    totalScore: 38,
    nettScore: 30,
    isDns: false,
    isOverseasCommitment: false,
    raceCount: 6,
    countsForRanking: false,
  },
];

export const SAMPLE_EQUIPMENT = {
  hullBrand: "Winner",
  sailMake: "J-Sails",
  foilBrand: "DSK",
  mast: "SuperSpar",
  notes: "Medium rig · 2° more rake for medium breeze · sail acquired Feb 2025",
  /** Demo metadata for parent equipment alerts */
  sailAcquired: "2025-02-01",
  mastLastChanged: "2026-06-20",
};

export type RaceObservation = {
  raceNumber: number;
  position: number | null;
  wind: string;
  note: string;
};

/** Race-by-race log for the most recent sample regatta (Nationals) */
export const SAMPLE_RACE_LOG = {
  regattaName: "Singapore National Championship 2026",
  raceCount: 8,
  observations: [
    {
      raceNumber: 1,
      position: 4,
      wind: "6–8 kn E",
      note: "Clean start mid-line. Lost two boats on first beat — need earlier tack on shifts.",
    },
    {
      raceNumber: 2,
      position: 2,
      wind: "8–10 kn E",
      note: "Pin end start worked. Strong downwind VMG. Keep this gearing.",
    },
    {
      raceNumber: 3,
      position: 5,
      wind: "5 kn SE",
      note: "Light air — sat too low. Next time: more height, earlier mode change.",
    },
    {
      raceNumber: 4,
      position: 3,
      wind: "10–12 kn",
      note: "Solid boat speed. Mark rounding tight — practice exits.",
    },
    {
      raceNumber: 5,
      position: 1,
      wind: "9 kn E",
      note: "Best race. Led from first mark. Confidence high.",
    },
    {
      raceNumber: 6,
      position: 6,
      wind: "7 kn oscillating",
      note: "OCS risk — conservative. Still recovered to 6th.",
    },
    {
      raceNumber: 7,
      position: 3,
      wind: "11 kn",
      note: "Good height to weather mark. Keep same setup.",
    },
    {
      raceNumber: 8,
      position: 2,
      wind: "8 kn dying",
      note: "Protected from right. Overall 1st — keep this focus.",
    },
  ] as RaceObservation[],
};

/** Pre-seeded observations for demo sailor logbook */
export const SAMPLE_OBSERVATIONS = SAMPLE_RACE_LOG.observations.map((o, i) => ({
  id: `sample-obs-${i + 1}`,
  regattaId: "sample-r1",
  raceNumber: o.raceNumber,
  position: o.position,
  wind: o.wind,
  note: o.note,
  isPrivate: true,
}));

export const SAMPLE_PARENT_PANEL = {
  claimStatus: "Approved · linked as parent",
  childName: "Kimberly",
  coachName: "Coach Lim",
  coachContact: "Coach Lim (CSC Optimist Gold)",
  club: "Changi Sailing Club",
  trainingSchedule: [
    { day: "Tue", time: "4:30–6:30pm", focus: "Starts & boat speed" },
    { day: "Thu", time: "4:30–6:30pm", focus: "Tactics / video" },
    { day: "Sat", time: "9:00am–1:00pm", focus: "Fleet racing" },
  ],
  squadMates: [
    { name: "Ethan Koh", sail: "SGP 88", note: "Same weight band" },
    { name: "Mia Wong", sail: "SGP 42", note: "Travel partner (AOC)" },
    { name: "Jayden Lee", sail: "SGP 201", note: "School teammate" },
  ],
  nextEvents: [
    {
      name: "Gold Ranking Series · R3",
      date: "2026-08-16",
      venue: "SAFYC",
      deadline: "Register by 9 Aug",
    },
    {
      name: "CSC Gold Fleet Open",
      date: "2026-09-05",
      venue: "Changi SC",
      deadline: "Entries open",
    },
    {
      name: "Asian Optimist Championships",
      date: "2026-10-12",
      venue: "Overseas",
      deadline: "Selection window closes 20 Sep",
    },
  ],
  equipmentAlerts: [
    {
      level: "warn" as const,
      text: "Sail is ~18 months old — consider replacement before AOC",
    },
    {
      level: "info" as const,
      text: "Mast rig setting changed 20 Jun — confirm with coach",
    },
  ],
  parentNotes: [
    {
      date: "2026-06-18",
      text: "Spoke to coach about starts — agreed extra mid-line practice Tue.",
    },
    {
      date: "2026-05-12",
      text: "School exams week of 22 Sep — lighter mid-week training.",
    },
  ],
  highlights: [
    "Standing: #3 Gold (Best 3 of 5 = 14)",
    "Overseas commitment score applied for NRS 1 (standing-based 2 pts)",
    "Dual-class: 4 ILCA 4 events logged this year",
  ],
};

export const SAMPLE_COACH_PANEL = {
  squadName: "CSC Optimist Gold (demo)",
  squadSize: 12,
  squadAvgFinish: 5.2,
  sailorAvgFinish: 3.6,
  nationalRank: 3,
  nationalFleet: 100,
  squadRank: 1,
  selectionReadiness: {
    score: 82,
    label: "On track",
    detail: "NRS commitment met · light-air block done · AOC boat prep pending",
  },
  attendance: [
    { session: "Sat 2 Aug", status: "attended" as const },
    { session: "Thu 31 Jul", status: "attended" as const },
    { session: "Tue 29 Jul", status: "missed" as const },
    { session: "Sat 26 Jul", status: "attended" as const },
  ],
  pathway: [
    { item: "National Ranking Series commitment", done: true },
    { item: "Light-air speed block (Jun–Jul)", done: true },
    { item: "Start-line video review", done: false },
    { item: "Asian champs boat prep", done: false },
  ],
  coachNotes: [
    {
      date: "2026-06-16",
      text: "Nationals: strong mental reset after race 6. Keep mid-line starts in big fleets. (Coach-only — not visible to sailor/parent)",
    },
    {
      date: "2026-05-10",
      text: "CSC: downwind mode excellent. Focus next block on light-air height.",
    },
  ],
  compareOptions: [
    { name: "Ethan Koh", rank: 7 },
    { name: "Mia Wong", rank: 11 },
    { name: "Jayden Lee", rank: 14 },
  ],
  squadTeaser: [
    { name: "Kimberly Tan", handle: "sample", rank: 3, highlight: "This profile" },
    { name: "Ethan Koh", handle: "#", rank: 7, highlight: "Consistent top-10" },
    { name: "Mia Wong", handle: "#", rank: 11, highlight: "Strong silver→gold path" },
  ],
};
