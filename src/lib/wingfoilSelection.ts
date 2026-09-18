export type WingfoilFundingPolicy = {
  title: string;
  covers: string;
  policyDate: string;
  amendedDate: string;
  authority: string;
  context: string;
  eligibility: string[];
  qualifier: {
    event: string;
    dates: string;
    equipment: string;
    surveyDeadline: string;
    surveyUrl: string;
  };
  categories: Array<{
    name: string;
    code: string;
    quota: number;
    description: string;
  }>;
  costSplit: {
    ssfCovers: string[];
    athleteCovers: string[];
    cap: string;
  };
  equipmentDeposits: Array<{
    type: string;
    amount: string;
    terms: string;
  }>;
  appeals: {
    deadline: string;
    addressTo: string;
    bond: string;
    conditions: string;
  };
};

export const WINGFOIL_FUNDING_POLICY: WingfoilFundingPolicy = {
  title: "Wingfoil Funding Policy",
  covers:
    "The Thailand X-15 Wingfoil Series / Asian Championships (event name TBC) in Dec 2026, and any future wingfoil events identified by SSF.",
  policyDate: "4 September 2026",
  amendedDate: "16 September 2026",
  authority: "Singapore Sailing Federation",
  context:
    "SSF runs a wingfoil programme, but our fleet in Singapore is still too small to support a full national training squad (the same position taken with Techno 293 and iQFOiL). This policy governs event-specific funding and support rather than squad selection.",
  eligibility: [
    "Singapore citizen (permanent residents do not qualify)",
    "Current member of an SSF-affiliated club or association",
    "In good financial standing with SSF (no outstanding fees or dues)",
    "Must participate in the qualifying regatta",
  ],
  qualifier: {
    event: "Southwest Monsoon Grand Prix Series 3",
    dates: "24 – 25 October 2026",
    equipment:
      "Athletes will race on SSF's X-15 equipment, made available to Advanced wingers in the lead-up to the event.",
    surveyDeadline: "20 September 2026",
    surveyUrl: "https://www.sailing.org.sg/surveys/11216",
  },
  categories: [
    {
      name: "Top Youth U17",
      code: "U17",
      quota: 1,
      description: "Highest placed eligible youth athlete under 17 years of age.",
    },
    {
      name: "Top Junior U15",
      code: "U15",
      quota: 1,
      description: "Highest placed eligible junior athlete under 15 years of age.",
    },
    {
      name: "Top Senior Female",
      code: "Senior F",
      quota: 1,
      description: "Highest placed eligible senior female competitor.",
    },
  ],
  costSplit: {
    ssfCovers: [
      "Coach's and Team Manager's travel and coaching costs",
      "Athlete flights",
      "Local transportation",
    ],
    athleteCovers: [
      "Board / wing / equipment charter",
      "Accommodation",
      "Event entry fee",
    ],
    cap: "$2,800 per event",
  },
  equipmentDeposits: [
    {
      type: "SSF Chartered Equipment",
      amount: "$500 SGD",
      terms: "Refundable damage deposit, returned once equipment is checked and confirmed undamaged.",
    },
    {
      type: "Event Organiser Charter (Thailand X-15)",
      amount: "2,000 THB cash",
      terms: "Required at on-site registration, returned in full once equipment is inspected undamaged at event conclusion.",
    },
    {
      type: "Personal Gear Required",
      amount: "Mandatory Safety Gear",
      terms: "Athletes must bring own harness, harness lines, impact vest, helmet, and personal equipment.",
    },
  ],
  appeals: {
    deadline: "Within 48 hours of decision announcement",
    addressTo:
      "Chief Executive Officer, Singapore Sailing Federation, 1500 East Coast Parkway, National Sailing Centre, Singapore 468963",
    bond: "$500 bond (forfeited if appeal is deemed unreasonable or without merit)",
    conditions:
      "Only on grounds that the qualifying regatta was not run according to its Notice of Race, or that this policy was not properly followed.",
  },
};
