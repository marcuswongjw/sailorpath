export type IlcaInternationalCampaign = {
  id: string;
  name: string;
  venue: string;
  regattaDates: string;
  travelPeriod: string;
  quota: string;
  eligibility: string;
  scoringRule: string;
  selectionEvents: Array<{
    name: string;
    dates: string;
    description?: string;
  }>;
  notes: string[];
};

export type IlcaNjtsQuotaRule = {
  category: string;
  quotaM: number;
  quotaF: number;
  total: number;
  description: string;
};

export const ILCA4_INTERNATIONAL_CAMPAIGNS: IlcaInternationalCampaign[] = [
  {
    id: "eastern-seaboard",
    name: "Eastern Seaboard Regatta 2026 & ILCA District Championships 2026",
    venue: "Pattaya, Thailand",
    regattaDates: "28 Oct – 1 Nov 2026 & 6 – 8 Nov 2026",
    travelPeriod: "27 Oct – 9 Nov 2026",
    quota: "Top 3 boys & Top 3 girls",
    eligibility: "Singapore Citizens born in 2012 or later",
    scoringRule: "Lowest combined race scores across selection events",
    selectionEvents: [
      {
        name: "Pesta Sukan Regatta 2026",
        dates: "1 – 2 August 2026",
        description: "Official selection event 1",
      },
      {
        name: "Singapore National Sailing Championships 2026",
        dates: "11 – 13 September 2026",
        description: "Official selection event 2",
      },
    ],
    notes: [
      "This document shall be read together with the guidelines in the Standard Selection Policy.",
      "The intended travel period will be 27th October to 9th November 2026.",
      "Selection decisions by the Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including fitness, attendance, attitude, and the coach’s input.",
    ],
  },
  {
    id: "asian-open",
    name: "ILCA Asian Open Championships 2026",
    venue: "Pattaya, Thailand",
    regattaDates: "14 – 20 December 2026",
    travelPeriod: "10 – 21 December 2026",
    quota: "Top 4 boys & Top 4 girls",
    eligibility: "Singapore Citizens born in 2010 or later",
    scoringRule: "Lowest combined race scores across selection events",
    selectionEvents: [
      {
        name: "Singapore National Sailing Championships 2026",
        dates: "11 – 13 September 2026",
        description: "Official selection event 1",
      },
      {
        name: "Selection Trials",
        dates: "10, 11, 17, 18 October 2026",
        description: "Official selection event 2 (4 days)",
      },
    ],
    notes: [
      "This document shall be read together with the guidelines in the Standard Selection Policy.",
      "The intended travel period will be 10th to 21st December 2026.",
      "Selection decisions by the Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including fitness, attendance, attitude, and the coach’s input.",
    ],
  },
];

export const ILCA4_NJTS_POLICY = {
  title: "National Junior Training Squad (NJTS)",
  authority: "Singapore Sailing Federation",
  basis: "Singapore ILCA 4 Ranking System",
  schedule: "Twice a year (January & July intakes)",
  maxSquadSize: 16,
  rankingThreshold: "Top 25 overall in the ranking list",
  eligibility: [
    "Singapore Citizen",
    "Age ≤ 17 in intake year (as of 31 December)",
    "Ranked in top 25 of the Singapore ILCA 4 Ranking System",
    "Good standing with Singapore Sailing Federation",
  ],
  quotaRules: [
    {
      category: "Top Overall",
      quotaM: 2,
      quotaF: 2,
      total: 4,
      description: "Top 2 male and top 2 female overall on the ranking list.",
    },
    {
      category: "Age 16 Bucket",
      quotaM: 2,
      quotaF: 2,
      total: 4,
      description: "Top 2 male and top 2 female aged 16 in the intake year.",
    },
    {
      category: "Age ≤ 15 Bucket",
      quotaM: 4,
      quotaF: 4,
      total: 8,
      description: "Top 4 male and top 4 female aged 15 or under in the intake year.",
    },
  ],
  unfilledSlotsRule:
    "Any unfilled slots in age categories will be filled by the next highest ranked sailor of the same gender (still required to be within top 25).",
  rankingCutoffs: {
    july: "Ranking as of 30 June (July intake)",
    january: "Ranking as of 20 December of preceding year (January intake)",
  },
};

export type IlcaTrialEvent = {
  id: string;
  name: string;
  shortName: string;
  dateStr: string;
  venue: string;
  fleetSize: number;
  completed: boolean;
};

export type IlcaTrialSailor = {
  sailorId: string;
  name: string;
  gender: "M" | "F";
  birthYear: number | null;
  handle: string | null;
  nationalRank: number;
  cscPoints: number;
  syscPoints: number;
  temasekPoints: number;
  pestaPoints: number;
  pestaPlace: number | null;
  snscPoints: number;
  snscPlace: number | null;
  trialPts: number;
  finishPos: number;
  bestThreePoints: number;
  isU14: boolean;
  isU17: boolean;
  easternStatus:
    | "Qualified (Slot 1)"
    | "Qualified (Slot 2)"
    | "Qualified (Slot 3)"
    | "1st Reserve"
    | "2nd Reserve"
    | "3rd Reserve"
    | "Eligible (U14)"
    | "Ineligible (Over U14 Age)";
  easternRankGender: number | null;
  asianProvisionalStatus:
    | "Provisional Leader (Slot 1)"
    | "Provisional Leader (Slot 2)"
    | "Provisional Leader (Slot 3)"
    | "Provisional Leader (Slot 4)"
    | "Provisional Reserve"
    | "Eligible (U17)"
    | "Ineligible (Over U17 Age)";
  asianRankGender: number | null;
  njtsStatus:
    | "Top 2 Overall"
    | "Age 16 Bucket"
    | "Age ≤ 15 Bucket"
    | "Top 25 Contender"
    | "Ranked Contender";
};

export const ILCA4_SELECTION_EVENTS: IlcaTrialEvent[] = [
  {
    id: "pesta-sukan-2026",
    name: "Pesta Sukan Regatta 2026",
    shortName: "Pesta Sukan",
    dateStr: "1 – 2 August 2026",
    venue: "National Sailing Centre, Singapore",
    fleetSize: 41,
    completed: true,
  },
  {
    id: "snsc-2026",
    name: "Singapore National Sailing Championships 2026",
    shortName: "SNSC 2026",
    dateStr: "11 – 13 September 2026",
    venue: "National Sailing Centre, Singapore",
    fleetSize: 45,
    completed: true,
  },
  {
    id: "selection-trials-2026",
    name: "Asian Open Selection Trials 2026",
    shortName: "Trials Event 2",
    dateStr: "10, 11, 17, 18 October 2026",
    venue: "National Sailing Centre, Singapore",
    fleetSize: 0,
    completed: false,
  },
];

export function getEasternQualifiedTeam(sailors: IlcaTrialSailor[] = []) {
  const qualifiedBoys = sailors
    .filter((s) => s.easternStatus.startsWith("Qualified") && s.gender === "M")
    .sort((a, b) => (a.easternRankGender ?? 99) - (b.easternRankGender ?? 99));

  const reserveBoys = sailors
    .filter((s) => s.easternStatus.includes("Reserve") && s.gender === "M")
    .sort((a, b) => (a.easternRankGender ?? 99) - (b.easternRankGender ?? 99));

  const qualifiedGirls = sailors
    .filter((s) => s.easternStatus.startsWith("Qualified") && s.gender === "F")
    .sort((a, b) => (a.easternRankGender ?? 99) - (b.easternRankGender ?? 99));

  const reserveGirls = sailors
    .filter((s) => s.easternStatus.includes("Reserve") && s.gender === "F")
    .sort((a, b) => (a.easternRankGender ?? 99) - (b.easternRankGender ?? 99));

  return {
    qualifiedBoys,
    reserveBoys,
    qualifiedGirls,
    reserveGirls,
  };
}

export function getAsianProvisionalLeaders(sailors: IlcaTrialSailor[] = []) {
  const leaderBoys = sailors
    .filter((s) => s.asianProvisionalStatus.startsWith("Provisional Leader") && s.gender === "M")
    .sort((a, b) => (a.asianRankGender ?? 99) - (b.asianRankGender ?? 99));

  const leaderGirls = sailors
    .filter((s) => s.asianProvisionalStatus.startsWith("Provisional Leader") && s.gender === "F")
    .sort((a, b) => (a.asianRankGender ?? 99) - (b.asianRankGender ?? 99));

  return {
    leaderBoys,
    leaderGirls,
  };
}

export function getNjtsProjectedSquad(sailors: IlcaTrialSailor[] = []) {
  return sailors
    .filter((s) => ["Top 2 Overall", "Age 16 Bucket", "Age ≤ 15 Bucket"].includes(s.njtsStatus))
    .sort((a, b) => a.nationalRank - b.nationalRank);
}

