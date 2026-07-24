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
      "See fleet badge, honors, and regatta results — without private weight or full training notes.",
  },
  sailor: {
    title: "Sailor",
    who: "The athlete who owns this profile",
    value:
      "Full logbook, privacy controls, equipment, series standing, and race-by-race observations.",
  },
  parent: {
    title: "Parent",
    who: "Guardian linked to this sailor",
    value:
      "Track progress, upcoming events, claim status, and support decisions with clear ranking context.",
  },
  coach: {
    title: "Coach",
    who: "Squad coach reviewing athletes",
    value:
      "Squad overview, technical notes, pathway checklist, and performance trends for training plans.",
  },
};

export const SAMPLE_SAILOR = {
  id: "sample-ashlyn",
  name: "Ashlyn Tan",
  handle: "ashlyn-t",
  sailNumber: "SGP 115",
  club: "Changi Sailing Club",
  nationality: "SGP",
  goldEntryDate: "2025-06-15",
  silverEntryDate: "2024-01-10",
  dropDate: null as string | null,
  currentFleet: "Series",
  school: "Raffles Institution",

  dob: "2013-08-14",
  weight: 42,
  bio: "Optimist Gold fleet racer focused on light-wind speed and clean starts. Training toward Asian championships.",
  gender: "F",
  nationalSquadStatus: "Nat A",
  instagram: "@ashlyn.t_sails",
  facebook: null as string | null,
  avatarUrl: null as string | null,
  isPublicWeight: false,
  isPublicDob: false,
  isPublicEquipment: true,
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
};

/** Best 3 of 5 snapshot for Jul–Dec 2026 demo */
export const SAMPLE_SERIES_STANDING = {
  periodLabel: "Jul – Dec 2026 (Current)",
  fleet: "Gold" as const,
  overallRank: 3,
  best3of5: 14,
  rScores: [
    { label: "R1", regatta: "NRS 3 · Jul", score: 5, isDNS: false, isOverseas: false },
    { label: "R2", regatta: "CSC Gold · Aug", score: 4, isDNS: false, isOverseas: false },
    { label: "R3", regatta: "SAFYC Gold · Sep", score: 5, isDNS: false, isOverseas: false },
    { label: "R4", regatta: "NSC Cup · Oct", score: 12, isDNS: true, isOverseas: false },
    { label: "R5", regatta: "Nationals · Nov", score: 3, isDNS: false, isOverseas: false },
  ],
  trendNote: "↑ 1 place vs Jun 2026 · Best 3 of 5 = 5+4+5",
};

export const SAMPLE_RESULTS = [
  {
    id: "sample-r1",
    regattaId: "sample-r1",
    regattaName: "Singapore National Championship 2026",
    regattaSlug: "sample-nationals-2026",
    regattaDate: "2026-06-15",
    division: "Gold",
    totalFleetSize: 85,
    fleetSize: 85,
    rank: 3,
    totalScore: 38,
    nettScore: 24,
    isDns: false,
    isOverseasCommitment: false,
    raceCount: 8,
  },
  {
    id: "sample-r2",
    regattaId: "sample-r2",
    regattaName: "CSC Optimist Championships 2026",
    regattaSlug: "sample-csc-2026",
    regattaDate: "2026-05-04",
    division: "Gold",
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
    id: "sample-r3",
    regattaId: "sample-r3",
    regattaName: "SAFYC Regatta 2026",
    regattaSlug: "sample-safyc-2026",
    regattaDate: "2026-04-12",
    division: "Gold",
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
    id: "sample-r4",
    regattaId: "sample-r4",
    regattaName: "National Ranking Series 1 2026",
    regattaSlug: "sample-nrs1-2026",
    regattaDate: "2026-02-28",
    division: "Gold",
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
    id: "sample-r5",
    regattaId: "sample-r5",
    regattaName: "NSC Cup 2026",
    regattaSlug: "sample-nsc-2026",
    regattaDate: "2026-01-18",
    division: "Gold",
    totalFleetSize: 55,
    fleetSize: 55,
    rank: 56,
    totalScore: null,
    nettScore: null,
    isDns: true,
    isOverseasCommitment: false,
    raceCount: 5,
  },
];

export const SAMPLE_EQUIPMENT = {
  hullBrand: "Winner",
  sailMake: "J-Sails",
  foilBrand: "DSK",
  mast: "SuperSpar",
  notes: "Medium rig · 2° more rake for medium breeze",
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
      note: "Protected from right. Overall 3rd — target top-2 next event.",
    },
  ] as RaceObservation[],
};

export const SAMPLE_PARENT_PANEL = {
  claimStatus: "Approved · linked as parent",
  nextEvents: [
    { name: "Gold Ranking Series · R3", date: "2026-08-16", venue: "SAFYC" },
    { name: "CSC Gold Fleet Open", date: "2026-09-05", venue: "Changi SC" },
    { name: "Asian Optimist Championships", date: "2026-10-12", venue: "Overseas" },
  ],
  highlights: [
    "Standing: #3 Gold (Best 3 of 5 = 14)",
    "Overseas commitment score applied for NRS 1 (standing-based 2 pts)",
    "School exams week of 22 Sep — lighter mid-week training",
  ],
  coachContact: "Coach Lim (CSC Optimist Gold)",
};

export const SAMPLE_COACH_PANEL = {
  squadName: "CSC Optimist Gold (demo)",
  pathway: [
    { item: "National Ranking Series commitment", done: true },
    { item: "Light-air speed block (Jun–Jul)", done: true },
    { item: "Start-line video review", done: false },
    { item: "Asian champs boat prep", done: false },
  ],
  coachNotes: [
    {
      date: "2026-06-16",
      text: "Nationals: strong mental reset after race 6. Keep mid-line starts in big fleets.",
    },
    {
      date: "2026-05-10",
      text: "CSC: downwind mode excellent. Focus next block on light-air height.",
    },
  ],
  squadTeaser: [
    { name: "Ashlyn Tan", handle: "sample", rank: 3, highlight: "This profile" },
    { name: "Ethan Koh", handle: "#", rank: 7, highlight: "Consistent top-10" },
    { name: "Mia Wong", handle: "#", rank: 11, highlight: "Strong silver→gold path" },
  ],
};
