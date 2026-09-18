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
