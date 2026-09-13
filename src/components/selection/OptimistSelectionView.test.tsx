/** @vitest-environment jsdom */
import { render, screen, fireEvent } from "@testing-library/react";
import { describe, it, expect, vi } from "vitest";
import { OptimistSelectionView } from "./OptimistSelectionView";
import type { OptimistSelectionPayload } from "@/lib/selectionQueries";

const mockUseAccount = vi.fn();
vi.mock("@/components/AccountProvider", () => ({
  useAccount: () => mockUseAccount(),
}));

const mockPayload: OptimistSelectionPayload = {
  matched: [
    {
      def: {
        id: "ssf-trials-2026",
        label: "SSF Selection Trials",
        dateFrom: "2026-08-22",
        dateTo: "2026-08-30",
        nameIncludes: ["ssf selection"],
      },
      regatta: {
        id: "reg-1",
        name: "SSF Selection Trials 2026",
        slug: "ssf-trials-2026",
        date: "2026-08-25",
        totalFleetSize: 45,
        division: "Gold",
        raceCount: 6,
        geography: "SG",
        boatClass: "Optimist",
        countsForRanking: true,
      },
      matched: true,
    },
    {
      def: {
        id: "snsc-2026",
        label: "Singapore National Sailing Championships",
        dateFrom: "2026-09-11",
        dateTo: "2026-09-13",
        nameIncludes: ["snsc"],
      },
      regatta: null,
      matched: false,
    },
  ],
  selectionStatus: {
    usableRaceCount: 6,
    discardCount: 1,
    complete: false,
    warnings: ["Singapore National Sailing Championships has not been matched yet."],
  },
  combinedScores: [
    {
      sailorId: "s1",
      name: "Lucas Wong",
      handle: "lucas-wong",
      gender: "M",
      birthYear: 2013,
      nationality: "SGP",
      eventScores: [],
      raceScores: [
        {
          regattaId: "reg-1",
          raceNumber: 1,
          score: 1,
          missing: false,
          discarded: false,
          nonDiscardable: false,
        },
        {
          regattaId: "reg-1",
          raceNumber: 2,
          score: 12,
          missing: false,
          discarded: true,
          nonDiscardable: false,
        },
      ],
      grossScore: 13,
      combinedScore: 1,
      discardCount: 1,
      eventsSailed: 1,
    },
    {
      sailorId: "s2",
      name: "Sarah Chen",
      handle: "sarah-chen",
      gender: "F",
      birthYear: 2014,
      nationality: "SGP",
      eventScores: [],
      raceScores: [],
      grossScore: 15,
      combinedScore: 5,
      discardCount: 1,
      eventsSailed: 1,
    },
  ],
  asianTeam: {
    selected: [
      {
        sailorId: "s1",
        name: "Lucas Wong",
        handle: "lucas-wong",
        gender: "M",
        birthYear: 2013,
        nationality: "SGP",
        eventScores: [],
        raceScores: [],
        grossScore: 13,
        combinedScore: 1,
        discardCount: 1,
        eventsSailed: 1,
        teamRank: 1,
      },
    ],
    reserves: [],
    reason: "Provisional top 10 by combined race score · 1M / 0F.",
  },
  perthCamp: {
    picks: [
      {
        sailorId: "s1",
        name: "Lucas Wong",
        handle: "lucas-wong",
        gender: "M",
        birthYear: 2013,
        nationality: "SGP",
        eventScores: [],
        raceScores: [],
        grossScore: 13,
        combinedScore: 1,
        discardCount: 1,
        eventsSailed: 1,
        bucket: "by2013",
        bucketLabel: "Born 2013 · top boy & top girl",
        slot: "Boy · born 2013",
      },
    ],
    notes: [],
  },
  campaigns: {
    asianOceania: {
      id: "asian-oceania-2026",
      title: "2026 Optimist Asian & Oceania Championship",
      subtitle: "Colombo, Sri Lanka · 12–19 December 2026",
      events: [],
      notes: "Top 10 sailors by lowest combined race score, min 3 per gender.",
      funding: "Key Event funding category.",
    },
    perthCamp: {
      id: "perth-camp-2026",
      title: "Optimist Perth Training Camp 2026",
      subtitle: "Perth, Australia · November 2026",
      events: [],
      notes: "Age buckets: 2013, 2014, 2015.",
      funding: "100% self-funded.",
    },
  },
};

describe("OptimistSelectionView", () => {
  it("renders selection trials header, progress status, and table", () => {
    mockUseAccount.mockReturnValue({
      email: null,
      owned: [],
      ready: true,
    });

    render(<OptimistSelectionView initialData={mockPayload} />);

    expect(screen.getByText("Optimist Selection Trials")).toBeInTheDocument();
    expect(screen.getByText("SSF Selection Trials")).toBeInTheDocument();
    expect(
      screen.getByText(/Detailed selection matrices & What-If calculator are for registered accounts/)
    ).toBeInTheDocument();
    expect(screen.getByText("Lucas Wong")).toBeInTheDocument();
  });

  it("switches tabs between Asian, Perth, and Combined", () => {
    mockUseAccount.mockReturnValue({
      email: "test@example.com",
      owned: [],
      ready: true,
    });

    render(<OptimistSelectionView initialData={mockPayload} />);

    // Click Perth Camp tab
    fireEvent.click(screen.getByText(/Perth Camp/));
    expect(screen.getByText("Boy · born 2013")).toBeInTheDocument();

    // Click Full Scoreboard tab
    fireEvent.click(screen.getByText(/Full Scoreboard/));
    expect(screen.getByText("Sarah Chen")).toBeInTheDocument();
  });

  it("displays claimed athlete spotlight when user owns a sailor", () => {
    mockUseAccount.mockReturnValue({
      email: "parent@example.com",
      owned: [{ id: "s1", name: "Lucas Wong", handle: "lucas-wong" }],
      ready: true,
    });

    render(<OptimistSelectionView initialData={mockPayload} />);

    expect(screen.getByText(/Your Claimed Sailor: Lucas Wong/)).toBeInTheDocument();
    expect(screen.getByText("Rank #1 of 2")).toBeInTheDocument();
  });
});
