export type SelectionPolicyClassId = "optimist" | "ilca4" | "ilca6";

export type SelectionFundingCategory =
  | "Key Competition"
  | "Non-Key Competition"
  | "Training Camp"
  | "Self-Funded";

export type SelectionPolicyQuotaBucket = {
  label: string;
  ageRule?: string;
  birthYearLabel?: string;
};

export type SelectionPolicyTrialEvent = {
  selectionEventId?: string;
  name: string;
  dates: string;
  calendarSlug?: string;
};

export type SelectionPolicyPathway = {
  id: string;
  title: string;
  fleetOrClassNote: string;
  quotas: SelectionPolicyQuotaBucket[];
  scoringRule: string;
  rankingRequirement?: string;
  events: SelectionPolicyTrialEvent[];
  restrictionNote?: string;
};

export type SelectionPolicyCampaign2027 = {
  id: string;
  code: string;
  name: string;
  venue: string;
  dates: string;
  datesConfirmed: boolean;
  travelPeriod: string;
  calendarSlug?: string;
  isTrainingCamp?: boolean;
  fundingCategory: SelectionFundingCategory;
  fundingText: string;
  pathways: SelectionPolicyPathway[];
  notes: string[];
};

export type SelectionTrialScheduleItem2027 = {
  selectionEventId?: string;
  name: string;
  dates: string;
  venue: string;
  datesConfirmed: boolean;
  calendarSlug?: string;
  feedsCampaigns: string[];
};

export type ClassSelectionPolicy2027 = {
  classId: SelectionPolicyClassId;
  classLabel: string;
  authority: string;
  issuedDate: string;
  policyHref: string;
  summary: string;
  keyTrialSchedule: SelectionTrialScheduleItem2027[];
  campaigns: SelectionPolicyCampaign2027[];
};

export const ILCA4_2027_SELECTION_POLICY: ClassSelectionPolicy2027 = {
  classId: "ilca4",
  classLabel: "ILCA 4",
  authority: "Singapore Sailing Federation",
  issuedDate: "12 November 2026",
  policyHref: "/sg/ilca4/selection",
  summary:
    "Four 2027 international and training camp campaigns covering 23rd Langkawi International Regatta, China Training Camp, ILCA 4 Youth World Championships, and Eastern Seaboard Regatta.",
  keyTrialSchedule: [
    {
      selectionEventId: "ilca4-safyc-2027",
      name: "23rd SAFYC Regatta 2027",
      dates: "30–31 January 2027",
      venue: "NSRCC Seasports Centre, Singapore",
      datesConfirmed: true,
      calendarSlug: "23rd-safyc-regatta-2027",
      feedsCampaigns: ["23rd Langkawi International Regatta 2027"],
    },
    {
      selectionEventId: "ilca4-csc-2027",
      name: "7th CSC ILCA Open 2027",
      dates: "13–14 February 2027",
      venue: "Changi Sailing Club, Singapore",
      datesConfirmed: true,
      calendarSlug: "7th-csc-ilca-open-2027",
      feedsCampaigns: [
        "23rd Langkawi International Regatta 2027",
        "ILCA 4 China Training Camp 2027",
        "ILCA 4 Youth World Championships 2027 (Part A)",
      ],
    },
    {
      selectionEventId: "ilca4-pulau-ujong-2027",
      name: "Pulau Ujong Regatta 2027",
      dates: "20–21 February 2027",
      venue: "National Sailing Centre, Singapore",
      datesConfirmed: true,
      calendarSlug: "pulau-ujong-regatta-2027",
      feedsCampaigns: [
        "ILCA 4 China Training Camp 2027",
        "ILCA 4 Youth World Championships 2027 (Part A)",
      ],
    },
    {
      selectionEventId: "ilca4-sysc-2027",
      name: "Singapore Youth Sailing Championships 2027",
      dates: "13–15 March 2027",
      venue: "National Sailing Centre, Singapore",
      datesConfirmed: true,
      calendarSlug: "sysc-2027",
      feedsCampaigns: [
        "ILCA 4 China Training Camp 2027",
        "ILCA 4 Youth World Championships 2027 (Part A)",
      ],
    },
    {
      selectionEventId: "ilca4-langkawi-2027",
      name: "23rd Langkawi International Regatta 2027",
      dates: "18–21 March 2027",
      venue: "Langkawi, Malaysia",
      datesConfirmed: true,
      calendarSlug: "23rd-langkawi-international-regatta-2027",
      feedsCampaigns: ["ILCA 4 Youth World Championships 2027 (Part B)"],
    },
    {
      selectionEventId: "ilca4-pesta-2027",
      name: "Pesta Sukan Regatta 2027",
      dates: "August 2027 (TBC)",
      venue: "National Sailing Centre, Singapore",
      datesConfirmed: false,
      calendarSlug: "pesta-sukan-regatta-2027",
      feedsCampaigns: ["Eastern Seaboard Regatta 2027"],
    },
    {
      selectionEventId: "ilca4-snsc-2027",
      name: "Singapore National Sailing Championships 2027",
      dates: "September 2027 (TBC)",
      venue: "National Sailing Centre, Singapore",
      datesConfirmed: false,
      calendarSlug: "snsc-2027",
      feedsCampaigns: ["Eastern Seaboard Regatta 2027"],
    },
  ],
  campaigns: [
    {
      id: "ilca4-langkawi-2027-campaign",
      code: "a",
      name: "23rd Langkawi International Regatta 2027",
      venue: "Langkawi, Malaysia",
      dates: "18 to 21 March 2027",
      datesConfirmed: true,
      travelPeriod: "16 to 22 March 2027",
      calendarSlug: "23rd-langkawi-international-regatta-2027",
      fundingCategory: "Non-Key Competition",
      fundingText:
        "Non-Key Competition. SSF pays the sailors' flights and transport, and the coach's and team manager's costs. The sailor pays equipment charter, accommodation and entry fee (sailor's contribution capped at SGD 2,800 per event).",
      pathways: [
        {
          id: "ilca4-langkawi-main",
          title: "Selection events",
          fleetOrClassNote: "Sailed in ILCA 4",
          quotas: [
            {
              label: "Top 3 males and top 3 females",
              ageRule: "Born in 2010 or later",
            },
            {
              label: "Top male and top female",
              ageRule: "Born in 2011 or later",
            },
          ],
          scoringRule: "Lowest combined race scores",
          events: [
            {
              selectionEventId: "ilca4-safyc-2027",
              name: "23rd SAFYC Regatta",
              dates: "30 to 31 January 2027",
              calendarSlug: "23rd-safyc-regatta-2027",
            },
            {
              selectionEventId: "ilca4-csc-2027",
              name: "7th CSC ILCA Open",
              dates: "13 to 14 February 2027",
              calendarSlug: "7th-csc-ilca-open-2027",
            },
          ],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is 16 to 22 March 2027.",
        "If any places for either gender are unfilled, the next highest open-ranked sailor may be invited.",
        "Selection decisions by the Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including fitness, attendance, attitude and the coach's input.",
      ],
    },
    {
      id: "ilca4-china-camp-2027-campaign",
      code: "b",
      name: "ILCA 4 China Training Camp 2027",
      venue: "Qinhuangdao, China",
      dates: "24 May to 2 June 2027",
      datesConfirmed: true,
      travelPeriod: "24 May to 2 June 2027 (includes travel days)",
      isTrainingCamp: true,
      fundingCategory: "Training Camp",
      fundingText:
        "Training Camp. SSF pays the sailors' flights and transport, and the coach's and team manager's costs. The sailor pays equipment charter, accommodation and any entry fee (sailor's contribution capped at SGD 2,800 per event).",
      pathways: [
        {
          id: "ilca4-china-camp-main",
          title: "Selection events",
          fleetOrClassNote: "Sailed in ILCA 4",
          quotas: [
            {
              label: "Top 4 males and top 4 females",
              ageRule: "Born in 2010 or later",
            },
            {
              label: "Top male and top female",
              ageRule: "Born in 2011 or later",
            },
          ],
          scoringRule: "Lowest combined race scores",
          events: [
            {
              selectionEventId: "ilca4-csc-2027",
              name: "7th CSC ILCA Open",
              dates: "13 to 14 February 2027",
              calendarSlug: "7th-csc-ilca-open-2027",
            },
            {
              selectionEventId: "ilca4-pulau-ujong-2027",
              name: "Pulau Ujong Regatta",
              dates: "20 to 21 February 2027",
              calendarSlug: "pulau-ujong-regatta-2027",
            },
            {
              selectionEventId: "ilca4-sysc-2027",
              name: "Singapore Youth Sailing Championships",
              dates: "13 to 15 March 2027",
              calendarSlug: "sysc-2027",
            },
          ],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is 24 May to 2 June 2027, which includes travel days.",
        "If any places for either gender are unfilled, the next highest open-ranked sailor may be invited.",
        "Selection decisions by the Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including fitness, attendance, attitude and the coach's input.",
      ],
    },
    {
      id: "ilca4-youth-worlds-2027-campaign",
      code: "c",
      name: "ILCA 4 Youth World Championships 2027",
      venue: "Qinhuangdao, China",
      dates: "22 to 30 June 2027",
      datesConfirmed: true,
      travelPeriod: "16 to 30 June 2027",
      calendarSlug: "2027-ilca4-youth-world-championship-qinhuangdao",
      fundingCategory: "Key Competition",
      fundingText:
        "Key Competition. SSF pays the sailors' flights, equipment charter and transport, and the coach's and team manager's costs. The sailor pays accommodation and entry fee (sailor's contribution capped at SGD 2,800 per event).",
      pathways: [
        {
          id: "ilca4-youth-worlds-part-a",
          title: "Part A selection events",
          fleetOrClassNote: "Sailed in ILCA 4",
          quotas: [
            {
              label: "Top 2 males and top 2 females",
              ageRule: "Born in 2010 or later",
            },
          ],
          scoringRule: "Lowest combined race scores",
          rankingRequirement:
            "To be selected, a sailor must be ranked in the top 15 in the overall selection outcome.",
          events: [
            {
              selectionEventId: "ilca4-csc-2027",
              name: "7th CSC ILCA Open",
              dates: "13 to 14 February 2027",
              calendarSlug: "7th-csc-ilca-open-2027",
            },
            {
              selectionEventId: "ilca4-pulau-ujong-2027",
              name: "Pulau Ujong Regatta",
              dates: "20 to 21 February 2027",
              calendarSlug: "pulau-ujong-regatta-2027",
            },
            {
              selectionEventId: "ilca4-sysc-2027",
              name: "Singapore Youth Sailing Championships",
              dates: "13 to 15 March 2027",
              calendarSlug: "sysc-2027",
            },
          ],
        },
        {
          id: "ilca4-youth-worlds-part-b",
          title: "Part B selection event",
          fleetOrClassNote: "Sailed in ILCA 4",
          quotas: [
            {
              label: "Top male and top female",
              ageRule: "Born in 2010 or later",
            },
          ],
          scoringRule: "Lowest combined race scores",
          rankingRequirement:
            "To be selected, a sailor must be ranked in the top 15 in the overall selection outcome.",
          events: [
            {
              selectionEventId: "ilca4-langkawi-2027",
              name: "23rd Langkawi International Regatta 2027",
              dates: "18 to 21 March 2027",
              calendarSlug: "23rd-langkawi-international-regatta-2027",
            },
          ],
          restrictionNote:
            "Sailors will be selected under Part A first. Part B is open only to sailors not selected under Part A. If 23rd Langkawi International Regatta 2027 does not take place, Part B selection will be made from the National ILCA 4 Ranking as of 30 March 2027.",
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is 16 to 30 June 2027.",
        "To be selected, a sailor must be ranked in the top 15 in the overall selection outcome.",
        "If any places for either gender are unfilled, the next highest open-ranked sailor may be invited.",
        "Selection decisions by the Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including fitness, attendance, attitude and the coach's input.",
        "If the 23rd Langkawi International Regatta 2027 does not take place, Part B selection will be made from the National ILCA 4 Ranking as of 30 March 2027.",
        "Sailors will be selected under Part A first. Part B is open only to sailors not selected under Part A.",
      ],
    },
    {
      id: "ilca4-eastern-seaboard-2027-campaign",
      code: "d",
      name: "Eastern Seaboard Regatta 2027",
      venue: "Pattaya, Thailand",
      dates: "Dates TBC",
      datesConfirmed: false,
      travelPeriod: "TBC",
      calendarSlug: "eastern-seaboard-regatta-2027",
      fundingCategory: "Non-Key Competition",
      fundingText:
        "Non-Key Competition. SSF pays the sailors' flights and transport, and the coach's and team manager's costs. The sailor pays equipment charter, accommodation and entry fee (sailor's contribution capped at SGD 2,800 per event).",
      pathways: [
        {
          id: "ilca4-eastern-seaboard-main",
          title: "Selection events",
          fleetOrClassNote: "Sailed in ILCA 4",
          quotas: [
            {
              label: "Top 3 males and top 3 females",
              ageRule: "Born in 2011 or later",
            },
          ],
          scoringRule: "Lowest combined race scores",
          rankingRequirement:
            "Must be ranked 12th or higher in the selection outcome and meet the fitness testing requirements.",
          events: [
            {
              selectionEventId: "ilca4-pesta-2027",
              name: "Pesta Sukan Regatta 2027",
              dates: "August 2027",
              calendarSlug: "pesta-sukan-regatta-2027",
            },
            {
              selectionEventId: "ilca4-snsc-2027",
              name: "Singapore National Sailing Championships 2027",
              dates: "September 2027",
              calendarSlug: "snsc-2027",
            },
          ],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is TBC.",
        "To be selected, a sailor must be ranked 12th or higher in the selection outcome and meet the fitness testing requirements.",
        "If any places for either gender are unfilled, the next highest open-ranked sailor may be invited.",
        "Selection decisions by the Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including fitness, attendance, attitude and the coach's input.",
      ],
    },
  ],
};

export const ILCA6_2027_SELECTION_POLICY: ClassSelectionPolicy2027 = {
  classId: "ilca6",
  classLabel: "ILCA 6",
  authority: "Singapore Sailing Federation",
  issuedDate: "12 November 2026",
  policyHref: "/sg/ilca6/selection",
  summary:
    "Five 2027 international and training camp campaigns covering 23rd Langkawi International Regatta, China Training Camp, Kieler Woche, ILCA 6 Youth World Championships, and Eastern Seaboard Regatta.",
  keyTrialSchedule: [
    {
      selectionEventId: "ilca6-safyc-2027",
      name: "23rd SAFYC Regatta 2027",
      dates: "30–31 January 2027",
      venue: "NSRCC Seasports Centre, Singapore",
      datesConfirmed: true,
      calendarSlug: "23rd-safyc-regatta-2027",
      feedsCampaigns: ["23rd Langkawi International Regatta 2027"],
    },
    {
      selectionEventId: "ilca6-csc-2027",
      name: "7th CSC ILCA Open 2027",
      dates: "13–14 February 2027",
      venue: "Changi Sailing Club, Singapore",
      datesConfirmed: true,
      calendarSlug: "7th-csc-ilca-open-2027",
      feedsCampaigns: [
        "23rd Langkawi International Regatta 2027",
        "Kieler Woche 2027",
      ],
    },
    {
      selectionEventId: "ilca6-pulau-ujong-2027",
      name: "Pulau Ujong Regatta 2027",
      dates: "20–21 February 2027",
      venue: "National Sailing Centre, Singapore",
      datesConfirmed: true,
      calendarSlug: "pulau-ujong-regatta-2027",
      feedsCampaigns: ["Kieler Woche 2027"],
    },
    {
      selectionEventId: "ilca6-sysc-2027",
      name: "Singapore Youth Sailing Championships 2027",
      dates: "13–15 March 2027",
      venue: "National Sailing Centre, Singapore",
      datesConfirmed: true,
      calendarSlug: "sysc-2027",
      feedsCampaigns: ["Kieler Woche 2027"],
    },
    {
      selectionEventId: "ilca6-kieler-woche-2027",
      name: "Kieler Woche 2027",
      dates: "19–23 June 2027",
      venue: "Kiel, Germany",
      datesConfirmed: true,
      calendarSlug: "kieler-woche-2027",
      feedsCampaigns: ["ILCA 6 Youth World Championships 2027"],
    },
    {
      selectionEventId: "ilca6-pesta-2027",
      name: "Pesta Sukan Regatta 2027",
      dates: "August 2027 (TBC)",
      venue: "National Sailing Centre, Singapore",
      datesConfirmed: false,
      calendarSlug: "pesta-sukan-regatta-2027",
      feedsCampaigns: ["Eastern Seaboard Regatta 2027"],
    },
    {
      selectionEventId: "ilca6-snsc-2027",
      name: "Singapore National Sailing Championships 2027",
      dates: "September 2027 (TBC)",
      venue: "National Sailing Centre, Singapore",
      datesConfirmed: false,
      calendarSlug: "snsc-2027",
      feedsCampaigns: ["Eastern Seaboard Regatta 2027"],
    },
  ],
  campaigns: [
    {
      id: "ilca6-langkawi-2027-campaign",
      code: "a",
      name: "23rd Langkawi International Regatta 2027",
      venue: "Langkawi, Malaysia",
      dates: "18 to 21 March 2027",
      datesConfirmed: true,
      travelPeriod: "16 to 22 March 2027",
      calendarSlug: "23rd-langkawi-international-regatta-2027",
      fundingCategory: "Non-Key Competition",
      fundingText:
        "Non-Key Competition. SSF pays the sailors' flights and transport, and the coach's and team manager's costs. The sailor pays equipment charter, accommodation and entry fee (sailor's contribution capped at SGD 2,800 per event).",
      pathways: [
        {
          id: "ilca6-langkawi-main",
          title: "Selection events",
          fleetOrClassNote: "Sailed in ILCA 6",
          quotas: [
            {
              label: "Top 4 males and top 4 females",
              ageRule: "Born in 2009 or later",
            },
          ],
          scoringRule: "Lowest combined race scores",
          rankingRequirement:
            "Ranked 12th or higher in the selection outcome and meet the fitness testing requirements. Places go in order of the selection ranking; a sailor meeting the gender place below 12th overall is not selected (treated as unfilled).",
          events: [
            {
              selectionEventId: "ilca6-safyc-2027",
              name: "23rd SAFYC Regatta",
              dates: "30 to 31 January 2027",
              calendarSlug: "23rd-safyc-regatta-2027",
            },
            {
              selectionEventId: "ilca6-csc-2027",
              name: "7th CSC ILCA Open",
              dates: "13 to 14 February 2027",
              calendarSlug: "7th-csc-ilca-open-2027",
            },
          ],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is 16 to 22 March 2027.",
        "To be selected, a sailor must be ranked 12th or higher in the selection outcome and meet the fitness testing requirements. Places go in order of the selection ranking. A sailor who meets the gender place but is ranked below 12th overall is not selected, and the place is treated as unfilled (see note 4).",
        "If any places for either gender are unfilled, the next highest open-ranked sailor may be invited.",
        "Selection decisions by the Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including fitness, attendance, attitude and the coach's input.",
      ],
    },
    {
      id: "ilca6-china-camp-2027-campaign",
      code: "b",
      name: "ILCA 6 China Training Camp 2027",
      venue: "Qinhuangdao, China",
      dates: "24 May to 2 June 2027",
      datesConfirmed: true,
      travelPeriod: "24 May to 2 June 2027 (includes travel days)",
      isTrainingCamp: true,
      fundingCategory: "Training Camp",
      fundingText:
        "Training Camp. SSF pays the sailors' flights and transport, and the coach's and team manager's costs. The sailor pays equipment charter, accommodation and any entry fee (sailor's contribution capped at SGD 2,800 per event).",
      pathways: [
        {
          id: "ilca6-china-camp-main",
          title: "Selection basis",
          fleetOrClassNote: "Selection events: None",
          quotas: [
            {
              label: "ILCA 6 National Training Squad members",
              ageRule: "All NTS members meeting fitness requirements",
            },
          ],
          scoringRule:
            "All ILCA 6 National Training Squad members who meet the fitness testing requirements will be invited.",
          events: [],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is 24 May to 2 June 2027, which includes travel days.",
        "All ILCA 6 National Training Squad members who meet the fitness testing requirements will be invited. Invitations may also take into account attendance, attitude and the coach's input.",
      ],
    },
    {
      id: "ilca6-kieler-woche-2027-campaign",
      code: "c",
      name: "Kieler Woche 2027",
      venue: "Kiel, Germany",
      dates: "19 to 23 June 2027",
      datesConfirmed: true,
      travelPeriod: "12 to 24 June 2027",
      calendarSlug: "kieler-woche-2027",
      fundingCategory: "Non-Key Competition",
      fundingText:
        "Non-Key Competition. SSF pays the sailors' flights and transport, and the coach's and team manager's costs. The sailor pays equipment charter, accommodation and entry fee (sailor's contribution capped at SGD 2,800 per event).",
      pathways: [
        {
          id: "ilca6-kieler-woche-main",
          title: "Selection events",
          fleetOrClassNote: "Sailed in ILCA 6",
          quotas: [
            {
              label: "Top 3 males and top 3 females",
              ageRule: "Born in 2009 or later",
            },
          ],
          scoringRule: "Lowest combined race scores",
          rankingRequirement:
            "Ranked 10th or higher in the selection outcome and meet the fitness testing requirements. Places go in order of the selection ranking; a sailor meeting the gender place below 10th overall is not selected (treated as unfilled).",
          events: [
            {
              selectionEventId: "ilca6-csc-2027",
              name: "7th CSC ILCA Open",
              dates: "13 to 14 February 2027",
              calendarSlug: "7th-csc-ilca-open-2027",
            },
            {
              selectionEventId: "ilca6-pulau-ujong-2027",
              name: "Pulau Ujong Regatta",
              dates: "20 to 21 February 2027",
              calendarSlug: "pulau-ujong-regatta-2027",
            },
            {
              selectionEventId: "ilca6-sysc-2027",
              name: "Singapore Youth Sailing Championships",
              dates: "13 to 15 March 2027",
              calendarSlug: "sysc-2027",
            },
          ],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is 12 to 24 June 2027.",
        "To be selected, a sailor must be ranked 10th or higher in the selection outcome and meet the fitness testing requirements. Places go in order of the selection ranking. A sailor who meets the gender place but is ranked below 10th overall is not selected, and the place is treated as unfilled (see note 4).",
        "If any places for either gender are unfilled, the next highest open-ranked sailor may be invited.",
        "Selection decisions by the Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including fitness, attendance, attitude and the coach's input.",
      ],
    },
    {
      id: "ilca6-youth-worlds-2027-campaign",
      code: "d",
      name: "ILCA 6 Youth World Championships 2027",
      venue: "Volos, Greece",
      dates: "21 to 29 August 2027",
      datesConfirmed: true,
      travelPeriod: "16 to 30 August 2027",
      calendarSlug: "2027-ilca6-youth-world-championship-volos",
      fundingCategory: "Key Competition",
      fundingText:
        "Key Competition. SSF pays the sailors' flights, equipment charter and transport, and the coach's and team manager's costs. The sailor pays accommodation and entry fee (sailor's contribution capped at SGD 2,800 per event).",
      pathways: [
        {
          id: "ilca6-youth-worlds-main",
          title: "Selection event",
          fleetOrClassNote: "Sailed in ILCA 6",
          quotas: [
            {
              label: "Top 2 males and top 2 females",
              ageRule: "Born in 2009 or later",
            },
          ],
          scoringRule: "Ranked by final overall position at Kieler Woche 2027",
          rankingRequirement: "Must meet the fitness testing requirements.",
          events: [
            {
              selectionEventId: "ilca6-kieler-woche-2027",
              name: "Kieler Woche 2027",
              dates: "19 to 23 June 2027",
              calendarSlug: "kieler-woche-2027",
            },
          ],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is 16 to 30 August 2027.",
        "To be selected, a sailor must meet the fitness testing requirements.",
        "Selection decisions by the Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including fitness, attendance, attitude and the coach's input.",
      ],
    },
    {
      id: "ilca6-eastern-seaboard-2027-campaign",
      code: "e",
      name: "Eastern Seaboard Regatta 2027",
      venue: "Pattaya, Thailand",
      dates: "Dates TBC",
      datesConfirmed: false,
      travelPeriod: "TBC",
      calendarSlug: "eastern-seaboard-regatta-2027",
      fundingCategory: "Non-Key Competition",
      fundingText:
        "Non-Key Competition. SSF pays the sailors' flights and transport, and the coach's and team manager's costs. The sailor pays equipment charter, accommodation and entry fee (sailor's contribution capped at SGD 2,800 per event).",
      pathways: [
        {
          id: "ilca6-eastern-seaboard-main",
          title: "Selection events",
          fleetOrClassNote: "Sailed in ILCA 6",
          quotas: [
            {
              label: "Top 3 males and top 3 females",
              ageRule: "Born in 2011 or later",
            },
          ],
          scoringRule: "Lowest combined race scores",
          rankingRequirement:
            "Ranked 12th or higher in the selection outcome and meet the fitness testing requirements. Places go in order of the selection ranking; a sailor meeting the gender place below 12th overall is not selected (treated as unfilled).",
          events: [
            {
              selectionEventId: "ilca6-pesta-2027",
              name: "Pesta Sukan Regatta 2027",
              dates: "August 2027",
              calendarSlug: "pesta-sukan-regatta-2027",
            },
            {
              selectionEventId: "ilca6-snsc-2027",
              name: "Singapore National Sailing Championships 2027",
              dates: "September 2027",
              calendarSlug: "snsc-2027",
            },
          ],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is TBC.",
        "To be selected, a sailor must be ranked 12th or higher in the selection outcome and meet the fitness testing requirements. Places go in order of the selection ranking. A sailor who meets the gender place but is ranked below 12th overall is not selected, and the place is treated as unfilled (see note 4).",
        "If any places for either gender are unfilled, the next highest open-ranked sailor may be invited.",
        "Selection decisions by the Athlete Selection Committee are not based solely on trial outcomes and may also take into consideration additional factors, including fitness, attendance, attitude and the coach's input.",
      ],
    },
  ],
};

export const OPTIMIST_2027_SELECTION_POLICY: ClassSelectionPolicy2027 = {
  classId: "optimist",
  classLabel: "Optimist",
  authority: "Singapore Sailing Federation",
  issuedDate: "13 November 2026",
  policyHref: "/sg/optimist/selection",
  summary:
    "Six 2027 international and training camp campaigns covering 23rd Langkawi International Regatta, 15th Bodrum International Optimist Regatta (Europe Training Camp), IODA Optimist World Championship, IODA Optimist European Championship, ROC Kosmos, and Perth Training Camp.",
  keyTrialSchedule: [
    {
      selectionEventId: "opti-csc-2027",
      name: "CSC Optimist Championships 2027 (Gold Fleet)",
      dates: "23–24 January 2027",
      venue: "Changi Sailing Club, Singapore",
      datesConfirmed: true,
      calendarSlug: "csc-optimist-championship-2027-gold",
      feedsCampaigns: [
        "15th Bodrum International Optimist Regatta (Europe Training Camp)",
        "IODA Optimist World Championship 2027 (Part A)",
        "IODA Optimist European Championship 2027",
        "ROC Kosmos 2027",
      ],
    },
    {
      selectionEventId: "opti-safyc-2027",
      name: "23rd SAFYC Regatta 2027 (Optimist Gold Fleet)",
      dates: "13–14 February 2027",
      venue: "NSRCC Seasports Centre, Singapore",
      datesConfirmed: true,
      calendarSlug: "23rd-safyc-regatta-2027",
      feedsCampaigns: [
        "15th Bodrum International Optimist Regatta (Europe Training Camp)",
      ],
    },
    {
      selectionEventId: "opti-pulau-ujong-2027",
      name: "Pulau Ujong Regatta 2027",
      dates: "20–21 February 2027",
      venue: "National Sailing Centre, Singapore",
      datesConfirmed: true,
      calendarSlug: "pulau-ujong-regatta-2027",
      feedsCampaigns: [
        "IODA Optimist World Championship 2027 (Part A)",
        "IODA Optimist European Championship 2027",
        "ROC Kosmos 2027",
      ],
    },
    {
      selectionEventId: "opti-sysc-2027",
      name: "Singapore Youth Sailing Championships 2027",
      dates: "13–15 March 2027",
      venue: "National Sailing Centre, Singapore",
      datesConfirmed: true,
      calendarSlug: "sysc-2027",
      feedsCampaigns: [
        "IODA Optimist World Championship 2027 (Part A)",
        "IODA Optimist European Championship 2027",
        "ROC Kosmos 2027",
      ],
    },
    {
      selectionEventId: "opti-bodrum-2027",
      name: "15th Bodrum International Optimist Regatta 2027",
      dates: "April/May 2027 (TBC)",
      venue: "Bodrum, Turkey",
      datesConfirmed: false,
      calendarSlug: "15th-bodrum-international-optimist-regatta-2027",
      feedsCampaigns: ["IODA Optimist World Championship 2027 (Part B)"],
    },
  ],
  campaigns: [
    {
      id: "opti-langkawi-2027-campaign",
      code: "a",
      name: "23rd Langkawi International Regatta 2027",
      venue: "Langkawi, Malaysia",
      dates: "18 to 21 March 2027",
      datesConfirmed: true,
      travelPeriod: "16 to 22 March 2027",
      calendarSlug: "23rd-langkawi-international-regatta-2027",
      fundingCategory: "Self-Funded",
      fundingText:
        "This trip is self-funded. SSF will cover the costs associated with the coach and team manager only.",
      pathways: [
        {
          id: "opti-langkawi-pool",
          title: "Selection pool",
          fleetOrClassNote: "Optimist Gold Fleet",
          quotas: [
            {
              label: "Top 8 males and top 8 females",
            },
          ],
          scoringRule: "Sailors in the NTS A January 2027 intake",
          events: [],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is 16 to 22 March 2027.",
      ],
    },
    {
      id: "opti-bodrum-2027-campaign",
      code: "b",
      name: "15th Bodrum International Optimist Regatta (Europe Training Camp)",
      venue: "Bodrum, Turkey",
      dates: "April/May 2027 (TBC)",
      datesConfirmed: false,
      travelPeriod: "TBC",
      calendarSlug: "15th-bodrum-international-optimist-regatta-2027",
      fundingCategory: "Self-Funded",
      fundingText:
        "This trip is self-funded. SSF will cover the costs associated with the coach and team manager only.",
      pathways: [
        {
          id: "opti-bodrum-main",
          title: "Selection events",
          fleetOrClassNote: "Sailed in the Optimist Gold Fleet",
          quotas: [
            {
              label: "Top 5 males and top 5 females",
            },
          ],
          scoringRule: "Lowest combined race scores",
          events: [
            {
              selectionEventId: "opti-csc-2027",
              name: "CSC Optimist Championships",
              dates: "23 to 24 January 2027",
              calendarSlug: "csc-optimist-championship-2027-gold",
            },
            {
              selectionEventId: "opti-safyc-2027",
              name: "23rd SAFYC Regatta",
              dates: "13 to 14 February 2027",
              calendarSlug: "23rd-safyc-regatta-2027",
            },
          ],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is TBC.",
      ],
    },
    {
      id: "opti-worlds-2027-campaign",
      code: "c",
      name: "IODA Optimist World Championship 2027",
      venue: "Lanzarote, Spain",
      dates: "24 June to 4 July 2027",
      datesConfirmed: true,
      travelPeriod: "19 June to 5 July 2027",
      calendarSlug: "2027-optimist-world-championship",
      fundingCategory: "Key Competition",
      fundingText:
        "Key Competition, as set out in Appendix A of the Standard Selection Policy.",
      pathways: [
        {
          id: "opti-worlds-part-a",
          title: "Part A selection events",
          fleetOrClassNote: "Sailed in the Optimist Gold Fleet",
          quotas: [
            {
              label: "Top male and top female",
            },
          ],
          scoringRule: "Lowest combined race scores",
          events: [
            {
              selectionEventId: "opti-csc-2027",
              name: "CSC Optimist Championships",
              dates: "23 to 24 January 2027",
              calendarSlug: "csc-optimist-championship-2027-gold",
            },
            {
              selectionEventId: "opti-pulau-ujong-2027",
              name: "Pulau Ujong Regatta",
              dates: "20 to 21 February 2027",
              calendarSlug: "pulau-ujong-regatta-2027",
            },
            {
              selectionEventId: "opti-sysc-2027",
              name: "Singapore Youth Sailing Championships",
              dates: "13 to 15 March 2027",
              calendarSlug: "sysc-2027",
            },
          ],
        },
        {
          id: "opti-worlds-part-b",
          title: "Part B selection event",
          fleetOrClassNote: "Sailed in the Optimist Gold Fleet",
          quotas: [
            {
              label: "Top 3 ranked sailors",
            },
          ],
          scoringRule: "Lowest combined race scores",
          events: [
            {
              selectionEventId: "opti-bodrum-2027",
              name: "Bodrum International Optimist Regatta 2027",
              dates: "April/May 2027, TBC",
              calendarSlug: "15th-bodrum-international-optimist-regatta-2027",
            },
          ],
          restrictionNote:
            "Sailors selected in Part A will not be considered in the selection process for Part B. If Bodrum International Optimist Regatta 2027 does not take place, Part B selection will be based on the National Optimist Gold Ranking as of 30 March 2027.",
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is 19 June to 5 July 2027.",
        "Sailors selected in Part A will not be considered in the selection process for Part B.",
        "If the Bodrum International Optimist Regatta 2027 does not take place, Part B selection will be based on the National Optimist Gold Ranking as of 30 March 2027.",
      ],
    },
    {
      id: "opti-europeans-2027-campaign",
      code: "d",
      name: "IODA Optimist European Championship 2027",
      venue: "Weymouth, UK",
      dates: "21 to 28 August 2027",
      datesConfirmed: true,
      travelPeriod: "18 to 29 August 2027",
      calendarSlug: "2027-optimist-european-championship",
      fundingCategory: "Self-Funded",
      fundingText:
        "This trip is self-funded. Sailors are responsible for the costs associated with the coach and team manager.",
      pathways: [
        {
          id: "opti-europeans-main",
          title: "Selection events",
          fleetOrClassNote: "Sailed in the Optimist Gold Fleet",
          quotas: [
            {
              label: "Top male and top female",
            },
            {
              label: "Top male and top female",
              ageRule: "Born in 2014 or later",
            },
          ],
          scoringRule: "Lowest combined race scores",
          events: [
            {
              selectionEventId: "opti-csc-2027",
              name: "CSC Optimist Championships",
              dates: "23 to 24 January 2027",
              calendarSlug: "csc-optimist-championship-2027-gold",
            },
            {
              selectionEventId: "opti-pulau-ujong-2027",
              name: "Pulau Ujong Regatta",
              dates: "20 to 21 February 2027",
              calendarSlug: "pulau-ujong-regatta-2027",
            },
            {
              selectionEventId: "opti-sysc-2027",
              name: "Singapore Youth Sailing Championships",
              dates: "13 to 15 March 2027",
              calendarSlug: "sysc-2027",
            },
          ],
          restrictionNote:
            "If the Organising Authority allocates fewer than four entries, selection will be based on the top open rankings relative to the number of entries allocated. Sailors selected for the IODA Optimist European Championship will not be eligible for the IODA Optimist World Championship.",
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is 18 to 29 August 2027.",
        "If the Organising Authority allocates fewer than four entries, selection will be based on the top open rankings relative to the number of entries allocated.",
        "Sailors selected for the IODA Optimist European Championship will not be eligible for the IODA Optimist World Championship.",
      ],
    },
    {
      id: "opti-roc-kosmos-2027-campaign",
      code: "e",
      name: "ROC Kosmos 2027",
      venue: "Athens, Greece",
      dates: "July 2027 (TBC)",
      datesConfirmed: false,
      travelPeriod: "TBC",
      calendarSlug: "roc-kosmos-2027",
      fundingCategory: "Self-Funded",
      fundingText:
        "This trip is self-funded. Sailors are responsible for the costs associated with the coach and team manager.",
      pathways: [
        {
          id: "opti-roc-kosmos-main",
          title: "Selection events",
          fleetOrClassNote: "Sailed in the Optimist Gold Fleet",
          quotas: [
            {
              label: "Top 3 males and top 3 females",
            },
            {
              label: "Top 2 males and top 2 females",
              ageRule: "Born in 2014 or later",
            },
          ],
          scoringRule: "Lowest combined race scores",
          events: [
            {
              selectionEventId: "opti-csc-2027",
              name: "CSC Optimist Championships",
              dates: "23 to 24 January 2027",
              calendarSlug: "csc-optimist-championship-2027-gold",
            },
            {
              selectionEventId: "opti-pulau-ujong-2027",
              name: "Pulau Ujong Regatta",
              dates: "20 to 21 February 2027",
              calendarSlug: "pulau-ujong-regatta-2027",
            },
            {
              selectionEventId: "opti-sysc-2027",
              name: "Singapore Youth Sailing Championships",
              dates: "13 to 15 March 2027",
              calendarSlug: "sysc-2027",
            },
          ],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is TBC.",
      ],
    },
    {
      id: "opti-perth-camp-2027-campaign",
      code: "f",
      name: "Perth Training Camp 2027",
      venue: "Perth, Australia",
      dates: "November 2027",
      datesConfirmed: false,
      travelPeriod: "TBC",
      isTrainingCamp: true,
      fundingCategory: "Self-Funded",
      fundingText:
        "This trip is self-funded. Sailors are responsible for the costs associated with the coach and team manager.",
      pathways: [
        {
          id: "opti-perth-camp-ranking",
          title: "Selection criteria",
          fleetOrClassNote: "Optimist Gold Fleet",
          quotas: [
            {
              label: "Top male and top female",
              ageRule: "Born in 2014",
              birthYearLabel: "2014",
            },
            {
              label: "Top 3 males and top 3 females",
              ageRule: "Born in 2015",
              birthYearLabel: "2015",
            },
            {
              label: "Top 2 males and top 2 females",
              ageRule: "Born in 2016",
              birthYearLabel: "2016",
            },
          ],
          scoringRule: "Optimist Gold National Ranking as of 20 September 2027",
          events: [],
        },
      ],
      notes: [
        "This document shall be read together with the guidelines in the Standard Selection Policy.",
        "The intended travel period is TBC.",
      ],
    },
  ],
};

export const SELECTION_POLICIES_2027: Record<
  SelectionPolicyClassId,
  ClassSelectionPolicy2027
> = {
  optimist: OPTIMIST_2027_SELECTION_POLICY,
  ilca4: ILCA4_2027_SELECTION_POLICY,
  ilca6: ILCA6_2027_SELECTION_POLICY,
};
