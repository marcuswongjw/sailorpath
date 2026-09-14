/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { SquadPulseCards } from "./SquadPulseCards";
import type { CoachSquadMember } from "@/lib/coachDashboard";

const mockMembers: CoachSquadMember[] = [
  {
    id: "m1",
    sailorId: "s1",
    name: "Sailor One",
    handle: "s1",
    sailNumber: "SGP 1",
    club: "CSC",
    avatarUrl: null,
    fleet: "Gold",
    ranking: 2,
    bestThreeOfFive: 6,
    squadStatus: "Nat Squad",
    recentMovement: 3,
    scoringEvents: [],
    recentResults: [],
    coachNote: "",
    coachNoteVisibility: "coach_only",
    developmentRecords: [],
    selectionReadiness: { tone: "ready", label: "Ready", detail: "Met" },
    latestResult: null,
  },
  {
    id: "m2",
    sailorId: "s2",
    name: "Sailor Two",
    handle: "s2",
    sailNumber: "SGP 2",
    club: "SAFYC",
    avatarUrl: null,
    fleet: "Silver",
    ranking: 5,
    bestThreeOfFive: 18,
    squadStatus: null,
    recentMovement: -1,
    scoringEvents: [],
    recentResults: [],
    coachNote: "",
    coachNoteVisibility: "coach_only",
    developmentRecords: [],
    selectionReadiness: { tone: "watch", label: "Building", detail: "Building" },
    latestResult: null,
  },
];

describe("SquadPulseCards", () => {
  it("renders squad size, fleet split, and rank movement indicators", () => {
    render(
      <SquadPulseCards
        members={mockMembers}
        actionsCount={2}
        rankingPeriod="Jul-Dec 2026"
        averageBest="12.0"
      />
    );

    expect(screen.getAllByText("2")).toHaveLength(2); // total sailors and alerts count
    expect(screen.getByText("Gold 1")).toBeInTheDocument();
    expect(screen.getByText("Silver 1")).toBeInTheDocument();
    expect(screen.getByText("12.0")).toBeInTheDocument(); // average best 3
    expect(screen.getByText("▲ 1")).toBeInTheDocument(); // climbed
    expect(screen.getByText("▼ 1")).toBeInTheDocument(); // dropped
    expect(screen.getByText("(+2 net)")).toBeInTheDocument();
    expect(screen.getByText("ready")).toBeInTheDocument();
    expect(screen.getByText("1 developing / on bubble")).toBeInTheDocument();
    expect(screen.getByText("Items need coach attention")).toBeInTheDocument();
  });
});
