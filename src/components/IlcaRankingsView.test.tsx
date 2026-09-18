/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { IlcaRankingsView } from "./IlcaRankingsView";
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
    expect(screen.getByText("Selection trials & NJTS policy")).toBeInTheDocument();
    expect(screen.getByText("Uncheck a regatta to exclude it from Best 3 of 5")).toBeInTheDocument();
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
    expect(screen.getByText(/Viewing what-if ranking: 1 regatta excluded/i)).toBeInTheDocument();

    // Reset button should appear
    const resetButtons = screen.getAllByRole("button", { name: /Reset/i });
    expect(resetButtons.length).toBeGreaterThanOrEqual(1);

    // Click reset
    fireEvent.click(resetButtons[0]);
    expect(screen.queryByText(/Viewing what-if ranking/i)).toBeNull();
  });
});
