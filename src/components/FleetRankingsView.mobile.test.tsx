/** @vitest-environment jsdom */
import { describe, expect, it, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { FleetRankingsView } from "./FleetRankingsView";
import type { RankedSailor } from "@/lib/ranking";

vi.mock("next/link", () => ({
  default: ({
    children,
    href,
  }: {
    children: React.ReactNode;
    href: string;
  }) => <a href={href}>{children}</a>,
}));

vi.mock("@/components/AccountProvider", () => ({
  useAccount: () => ({ email: "sailor@example.com", ready: true }),
}));

const period = { year: 2026, half: "Jul-Dec" as const };

const alyssa: RankedSailor = {
  id: "alyssa",
  name: "Alyssa Wong Li Lin",
  handle: "alyssa",
  sailNumber: "SGP 1",
  club: "CSC",
  goldEntryDate: "2024-01-01",
  silverEntryDate: null,
  dropDate: null,
  gender: "F",
  dob: "2013-03-01",
  fleet: "Gold",
  periodSquadStatus: "Nat A",
  nextPeriodSquadStatus: null,
  overallScore: 3,
  bestThreeScores: [1, 1, 1],
  regattaScores: [
    {
      regattaId: "temasek",
      regattaName: "Temasek Regatta 2026",
      score: 9,
      isDNS: false,
      isCarryForward: true,
    },
    {
      regattaId: "safyc",
      regattaName: "SAFYC Optimist 2026",
      score: 1,
      isDNS: false,
    },
    {
      regattaId: "cincap",
      regattaName: "Cincapura Regatta 2026",
      score: 2,
      isDNS: false,
    },
    {
      regattaId: "pesta",
      regattaName: "Pesta Sukan 2026",
      score: 1,
      isDNS: false,
    },
    {
      regattaId: "snsc",
      regattaName: "Singapore National Sailing Championships 2026",
      score: 1,
      isDNS: false,
    },
  ],
};

describe("FleetRankingsView mobile board", () => {
  it("keeps event names on the rail and shows squad chips", async () => {
    const user = userEvent.setup();
    render(
      <FleetRankingsView
        fleet="Gold"
        initialPeriod={period}
        initialRanked={[alyssa]}
      />
    );

    expect(screen.getAllByText("Temasek")).toHaveLength(1);
    expect(screen.getAllByText("SNSC")).toHaveLength(1);
    expect(screen.getAllByText("prev").length).toBeGreaterThan(0);
    expect(screen.getByText("Nat A", { selector: ".leading-none" })).toHaveClass(
      "bg-amber-100"
    );
    expect(screen.getByText("→ Nat A", { selector: ".leading-none" })).toHaveClass(
      "border-amber-500"
    );
    expect(screen.getAllByText("Counts toward Best 3:", { exact: false })).toHaveLength(3);
    expect(screen.queryByText("★ Count")).not.toBeInTheDocument();
    expect(screen.queryByText(/^Drop$/)).not.toBeInTheDocument();
    expect(screen.queryByText("Tap event to include/exclude")).not.toBeInTheDocument();

    const snsc = screen.getByRole("button", { name: /SNSC/ });
    expect(snsc).toHaveAttribute("aria-pressed", "true");
    await user.click(snsc);
    expect(snsc).toHaveAttribute("aria-pressed", "false");
    expect(screen.getByText(/1 event off/)).toBeInTheDocument();
    expect(screen.getAllByText("Excluded:", { exact: false })).toHaveLength(1);
    await user.click(screen.getByRole("button", { name: /^Reset$/ }));
    expect(snsc).toHaveAttribute("aria-pressed", "true");
    expect(screen.queryByRole("button", { name: /^Reset$/ })).not.toBeInTheDocument();
  });
});
