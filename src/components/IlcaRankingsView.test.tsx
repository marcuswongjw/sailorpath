/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { getIlcaIntakeOptions, IlcaRankingsView } from "./IlcaRankingsView";
import type { IlcaRankedSailor } from "@/lib/ilcaRanking";

vi.mock("next/link", () => ({
  default: ({
    children,
    href,
    ...rest
  }: {
    children: React.ReactNode;
    href: string;
    [key: string]: unknown;
  }) => (
    <a href={href} {...rest}>
      {children}
    </a>
  ),
}));

const mockSailors: IlcaRankedSailor[] = [
  {
    rank: 1,
    sailorId: "s1",
    name: "Alex Tan",
    handle: "alextan",
    gender: "M",
    birthYear: 2011,
    ageInIntakeYear: 15,
    nationality: "SGP",
    bestThreePoints: [30, 29, 28],
    totalPoints: 87,
    eventScores: [
      {
        regattaId: "reg1",
        regattaName: "Event One",
        date: "2026-02-01",
        place: 1,
        fleetSize: 30,
        points: 30,
        isDns: false,
      },
      {
        regattaId: "reg2",
        regattaName: "Event Two",
        date: "2026-03-01",
        place: 2,
        fleetSize: 30,
        points: 29,
        isDns: false,
      },
      {
        regattaId: "reg3",
        regattaName: "Event Three",
        date: "2026-04-01",
        place: 3,
        fleetSize: 30,
        points: 28,
        isDns: false,
      },
      {
        regattaId: "reg4",
        regattaName: "Event Four",
        date: "2026-05-01",
        place: 4,
        fleetSize: 30,
        points: 27,
        isDns: false,
      },
    ],
  },
];

describe("getIlcaIntakeOptions", () => {
  it("offers the current half and earlier halves, not future periods", () => {
    const october = getIlcaIntakeOptions(new Date("2026-10-17T04:00:00Z"));
    expect(october.map((option) => option.label)).toEqual([
      "Jul – Dec 2026",
      "Jan – Jun 2026",
      "Jul – Dec 2025",
      "Jan – Jun 2025",
      "Jul – Dec 2024",
      "Jan – Jun 2024",
    ]);
    expect(october[0]).toMatchObject({ kind: "january", year: 2027 });
    expect(october.some((option) => option.label.includes("2027"))).toBe(false);

    const march = getIlcaIntakeOptions(new Date("2026-03-15T00:00:00Z"));
    expect(march[0]).toMatchObject({ kind: "july", year: 2026, label: "Jan – Jun 2026" });
    expect(march.some((option) => option.label === "Jul – Dec 2026")).toBe(false);
  });
});

describe("IlcaRankingsView", () => {
  it("renders ILCA 4 standings, exclusion checkboxes, and selection links", () => {
    render(
      <IlcaRankingsView
        initialRanked={mockSailors}
        initialIntakeKind="july"
        initialIntakeYear={2026}
        initialLabel="July 2026"
        initialAsOf="2026-06-30"
      />
    );

    expect(screen.getByText("National standings")).toBeInTheDocument();
    expect(screen.getByText(/Projected National Squad & 2026 Selection Trials/i)).toBeInTheDocument();
    expect(screen.getByRole("link", { name: /Selection Trials/i })).toBeInTheDocument();
    expect(screen.getByText("Uncheck a regatta to exclude it from Best 3 of 5")).toBeInTheDocument();
    expect(screen.getAllByText("Feb 26").length).toBeGreaterThan(0);
    expect(screen.getAllByText("May 26").length).toBeGreaterThan(0);
    expect(screen.getAllByText("Alex Tan").length).toBeGreaterThanOrEqual(1);
  });

  it("handles regatta exclusion toggle and updates what-if view", () => {
    render(
      <IlcaRankingsView
        initialRanked={mockSailors}
        initialIntakeKind="july"
        initialIntakeYear={2026}
        initialLabel="July 2026"
        initialAsOf="2026-06-30"
      />
    );

    // Desktop checkboxes
    const checkboxes = screen.getAllByRole("checkbox");
    expect(checkboxes.length).toBeGreaterThanOrEqual(1);

    // Uncheck Event One
    fireEvent.click(checkboxes[0]);

    // What-if banner should be visible
    expect(screen.getByText(/What-if scenario · 1 event excluded/i)).toBeInTheDocument();

    // Reset button should appear
    expect(screen.getAllByText("84").length).toBeGreaterThan(0);
    const resetButtons = screen.getAllByRole("button", { name: "Return to current standings" });
    expect(resetButtons.length).toBeGreaterThanOrEqual(1);

    // Click reset
    fireEvent.click(resetButtons[0]);
    expect(screen.queryByText(/What-if scenario/i)).toBeNull();
    expect(screen.getAllByText("87").length).toBeGreaterThan(0);
  });

  it("hides Born when the birth year is unknown", () => {
    render(
      <IlcaRankingsView
        initialRanked={[
          { ...mockSailors[0], birthYear: 2011 },
          {
            ...mockSailors[0],
            sailorId: "s2",
            name: "No Year",
            handle: "no-year",
            birthYear: null,
          },
        ]}
        initialIntakeKind="july"
        initialIntakeYear={2026}
        initialLabel="July 2026"
        initialAsOf="2026-06-30"
      />
    );

    expect(screen.getAllByText(/Born 2011/).length).toBeGreaterThan(0);
    expect(screen.queryByText(/Born —/)).toBeNull();
    expect(screen.queryByText(/Born –/)).toBeNull();
  });
});
