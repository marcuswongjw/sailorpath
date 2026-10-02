/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { PersonalSeasonCard } from "@/components/PersonalSeasonCard";
import { decorateSeasonSlots, explainSeasonPlace } from "@/lib/personalSeason";
import type { PersonalSeasonView } from "@/lib/personalSeason";

describe("PersonalSeasonCard", () => {
  it("shows the half, Best 3 marks, and why this place", () => {
    const slots = decorateSeasonSlots([
      { regattaId: "a", regattaName: "NSC", score: 8, isCarryForward: true },
      { regattaId: "b", regattaName: "SAFYC", score: 4 },
      { regattaId: "c", regattaName: "Pesta", score: 12, isDNS: true },
      { regattaId: "d", regattaName: "CSC", score: 6 },
      { regattaId: "e", regattaName: "RM", score: 20, isOverseasCommitment: true },
    ]);
    const season: PersonalSeasonView = {
      sailorId: "ava",
      sailorName: "Ava Tan",
      handle: "ava-tan",
      periodLabel: "Jul – Dec 2026",
      fleet: "Gold",
      ilcaClass: null,
      rank: 4,
      fleetSize: 42,
      best3: 18,
      higherIsBetter: false,
      slots,
      nextCountingEvent: {
        name: "SYC Gold",
        date: "2026-10-18",
        href: "/regattas/syc-gold",
        boatClass: "Optimist",
      },
      why: explainSeasonPlace({
        sailorName: "Ava Tan",
        periodLabel: "Jul – Dec 2026",
        fleet: "Gold",
        ilcaClass: null,
        rank: 4,
        fleetSize: 42,
        best3: 18,
        higherIsBetter: false,
        slots,
        nextCountingEvent: { name: "SYC Gold", date: "2026-10-18" },
        tiedWith: 1,
      }),
      resultsHref: "/ava-tan#results",
      lastResultDate: "2026-09-01",
      tiedWith: 1,
    };

    render(<PersonalSeasonCard season={season} />);

    expect(screen.getByText("Ava Tan")).toBeInTheDocument();
    expect(screen.getByText(/#4 of 42/)).toBeInTheDocument();
    expect(screen.getAllByText("Counting").length).toBeGreaterThan(0);
    expect(screen.getAllByText("Dropped").length).toBeGreaterThan(0);
    expect(screen.getByText("DNS")).toBeInTheDocument();
    expect(screen.getByText("Overseas")).toBeInTheDocument();
    expect(screen.getByText("Carry-forward")).toBeInTheDocument();
    expect(screen.getByText(/Best 3 of 5 of 18/)).toBeInTheDocument();
    expect(screen.getByRole("link", { name: "SYC Gold" })).toHaveAttribute(
      "href",
      "/regattas/syc-gold"
    );
    expect(screen.getByRole("link", { name: "Full results →" })).toHaveAttribute(
      "href",
      "/ava-tan#results"
    );
  });
});
