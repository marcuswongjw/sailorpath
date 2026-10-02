import type {
  Athlete,
  UpcomingRegatta,
  PendingClaim,
} from "@/components/parent-dashboard/types";

export type FamilyDashboardInitialData = {
  athletes: Athlete[];
  upcomingRegattas?: UpcomingRegatta[];
  pendingClaims?: PendingClaim[];
  isParentStyle?: boolean;
};

export const SAMPLE_FAMILY_DASHBOARD: FamilyDashboardInitialData = {
  isParentStyle: true,
  athletes: [
    {
      id: "sample-kimberly",
      name: "Kimberly Tan",
      handle: "kimberly-t",
      sailNumber: "SGP 115",
      sailNumberIlca4: "SGP 2115",
      club: "Changi Sailing Club",
      school: "Raffles Girls' School",
      gender: "F",
      nationality: "SGP",
      dob: "2012-05-14",
      currentFleet: "Gold",
      ownerRelation: "parent",
      nationalSquadStatus: "National Squad (AOC 2026)",
      avatarUrl: "/demo-kimberly-tan.jpg",
      standing: {
        periodLabel: "2026 Season · Current SG Half",
        fleet: "Gold",
        overallRank: 3,
        fleetSize: 68,
        best3of5: 14,
        trendNote: "Rank #3 · Top 5% nationally",
      },
      selectionTrials: {
        rank: 3,
        nettScore: 18.0,
        eventsSailed: 2,
        isQualifiedAsian: true,
        isQualifiedPerth: true,
        asianTeamRank: 2,
        gapToCutoff: 14.0,
      },
      recentResults: [
        {
          regattaName: "Singapore Youth Sailing Championships 2026",
          regattaDate: "2026-06-21",
          rank: 3,
          boatClass: "Optimist Gold",
        },
        {
          regattaName: "Singapore National Sailing Championships 2026",
          regattaDate: "2026-07-12",
          rank: 4,
          boatClass: "Optimist Gold",
        },
        {
          regattaName: "5th CSC ILCA & 29er Open 2025",
          regattaDate: "2025-11-23",
          rank: 2,
          boatClass: "ILCA 4",
        },
      ],
      primaryGear: [
        {
          id: "gear-k1",
          category: "hull",
          brand: "Winner",
          model: "Den 2024 Team Edition",
          label: "Primary Race Hull",
          condition: "race_ready",
          status: "active",
          isPrimary: true,
        },
        {
          id: "gear-k2",
          category: "sail",
          brand: "J-Sails",
          model: "Blue 2025",
          label: "Championship Race Sail",
          condition: "practice_only",
          status: "needs_inspection",
          isPrimary: true,
        },
        {
          id: "gear-k3",
          category: "spars",
          brand: "SuperSpar",
          model: "Black M2 (2° rake)",
          label: "Rig & Spars",
          condition: "race_ready",
          status: "active",
          isPrimary: true,
        },
        {
          id: "gear-k4",
          category: "foils",
          brand: "DSK",
          model: "Flebi & Exas Set",
          label: "Race Foils",
          condition: "race_ready",
          status: "active",
          isPrimary: true,
        },
      ],
      equipmentAlertCount: 1,
      equipmentAlerts: [
        {
          label: "J-Sails Blue 2025",
          reason:
            "Acquired Feb 2025 (~18 months). Consider measuring a backup sail before Asian Youth trials.",
        },
      ],
      coachFeedback: [
        {
          id: "cf-k1",
          type: "debrief",
          category: "Starts",
          title: "Mid-line acceleration on 10s gun",
          detail:
            "Accelerated cleanly without losing height. Focus on downwind wave pumping rhythm for Asian Championship.",
          recordDate: "2026-06-20",
          status: "active",
        },
        {
          id: "cf-k2",
          type: "debrief",
          category: "Tactics",
          title: "Changi outgoing current layline",
          detail:
            "Earlier mode change into flat water paid off. Good sprit tension adjustments under 8 knots.",
          recordDate: "2026-06-18",
          status: "active",
        },
      ],
      notes: [
        {
          id: "note-k1",
          body: "[Training] Focused on hiking endurance and core stability sessions Tue/Thu.",
          createdAt: "2026-06-22T08:30:00Z",
        },
        {
          id: "note-k2",
          body: "[Equipment] Measured new backup sail with official class measurer at NSC.",
          createdAt: "2026-06-15T10:15:00Z",
        },
      ],
    },
    {
      id: "sample-alex",
      name: "Alex Tan",
      handle: "alex-t",
      sailNumber: "SGP 3108",
      sailNumberIlca4: null,
      club: "Changi Sailing Club",
      school: "Anglo-Chinese School (Junior)",
      gender: "M",
      nationality: "SGP",
      dob: "2014-08-20",
      currentFleet: "Silver",
      ownerRelation: "parent",
      nationalSquadStatus: "National Development Squad",
      avatarUrl: null,
      standing: {
        periodLabel: "2026 Season · Current SG Half",
        fleet: "Silver",
        overallRank: 8,
        fleetSize: 84,
        best3of5: 28,
        trendNote: "Rank #8 · Up 4 places this half",
      },
      selectionTrials: null,
      recentResults: [
        {
          regattaName: "21st SAFYC Regatta 2025",
          regattaDate: "2025-08-17",
          rank: 6,
          boatClass: "Optimist Silver",
        },
        {
          regattaName: "Raffles Marina Optimist Regatta 2025",
          regattaDate: "2025-09-07",
          rank: 8,
          boatClass: "Optimist Silver",
        },
      ],
      primaryGear: [
        {
          id: "gear-a1",
          category: "hull",
          brand: "Far East",
          model: "Optimist Standard",
          label: "Training & Fleet Hull",
          condition: "good",
          status: "active",
          isPrimary: true,
        },
        {
          id: "gear-a2",
          category: "sail",
          brand: "North Sails",
          model: "V-Series Medium",
          label: "Race Sail",
          condition: "race_ready",
          status: "active",
          isPrimary: true,
        },
        {
          id: "gear-a3",
          category: "spars",
          brand: "Optiparts",
          model: "Blackline MK3",
          label: "Spars",
          condition: "race_ready",
          status: "active",
          isPrimary: true,
        },
      ],
      equipmentAlertCount: 0,
      equipmentAlerts: [],
      coachFeedback: [
        {
          id: "cf-a1",
          type: "debrief",
          category: "Boat Handling",
          title: "Roll tacking coordination in light breeze",
          detail:
            "Clean roll tacking on shift signals. Keep head out of boat on approach to top mark.",
          recordDate: "2026-06-19",
          status: "active",
        },
      ],
      notes: [
        {
          id: "note-a1",
          body: "[Regatta] Great confidence in 12–15 knot breeze at SAFYC. Finished top 10 in all races.",
          createdAt: "2026-06-20T14:00:00Z",
        },
      ],
    },
  ],
  upcomingRegattas: [
    {
      id: "up-1",
      name: "Singapore Youth Sailing Championships 2026",
      date: "2026-06-20",
      boatClass: "Optimist",
      division: "Gold & Silver",
      slug: "singapore-youth-sailing-championships-2026",
    },
    {
      id: "up-2",
      name: "Singapore National Sailing Championships 2026",
      date: "2026-07-10",
      boatClass: "Optimist",
      division: "Gold & Silver",
      slug: "singapore-national-sailing-championships-2026",
    },
    {
      id: "up-3",
      name: "SSF Selection Trials 2026",
      date: "2026-08-22",
      boatClass: "Optimist",
      division: "Selection Trial",
      slug: "ssf-selection-trials-2026",
    },
  ],
  pendingClaims: [],
};
