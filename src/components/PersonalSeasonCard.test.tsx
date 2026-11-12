/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { PersonalSeasonCard } from "@/components/PersonalSeasonCard";
import { FollowingHome } from "@/components/FollowingHome";
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

  it("renders updated copy and omits Why this place on the Following page", () => {
    const slots = decorateSeasonSlots([
      { regattaId: "a", regattaName: "NSC", score: 4 },
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
      nextCountingEvent: null,
      why: ["Leading mark in Gold fleet."],
      resultsHref: "/sailors/ava-tan#results",
      lastResultDate: "2026-09-01",
      tiedWith: 0,
    };

    render(
      <FollowingHome
        sailors={[
          {
            sailorId: "ava",
            name: "Ava Tan",
            handle: "ava-tan",
            club: "CSC",
            fleet: "Gold",
            periodLabel: "Jul – Dec 2026",
            periodRank: 4,
            fleetSize: 42,
            lastResultDate: "2026-09-01",
            season,
          },
        ]}
      />
    );

    expect(
      screen.getByText(
        "Follow their performance over the last 6 months. You will also get an email when their results publish."
      )
    ).toBeInTheDocument();
    expect(screen.queryByText("This half")).not.toBeInTheDocument();
    expect(screen.getByText(/SG Gold/)).toBeInTheDocument();
    expect(screen.queryByText("Why this place")).not.toBeInTheDocument();
  });

  it("displays SG Silver for Silver fleet sailors", () => {
    const season: PersonalSeasonView = {
      sailorId: "ben",
      sailorName: "Ben Lim",
      handle: "ben-lim",
      periodLabel: "Jul – Dec 2026",
      fleet: "Silver",
      ilcaClass: null,
      rank: 8,
      fleetSize: 60,
      best3: 24,
      higherIsBetter: false,
      slots: decorateSeasonSlots([]),
      nextCountingEvent: null,
      why: [],
      resultsHref: "/sailors/ben-lim#results",
      lastResultDate: null,
      tiedWith: 0,
    };

    render(<PersonalSeasonCard season={season} showExplanation={false} />);
    expect(screen.queryByText("This half")).not.toBeInTheDocument();
    expect(screen.getByText(/SG Silver/)).toBeInTheDocument();
  });

  it("omits Guest and Not on this board for sailors outside SG rankings", () => {
    const season: PersonalSeasonView = {
      sailorId: "sorawit",
      sailorName: "Sorawit Naksuk",
      handle: "sorawit-naksuk",
      periodLabel: "Jul – Dec 2026",
      fleet: "Guest",
      ilcaClass: null,
      rank: null,
      fleetSize: null,
      best3: null,
      higherIsBetter: false,
      slots: decorateSeasonSlots([]),
      nextCountingEvent: null,
      why: [],
      resultsHref: "/sailors/sorawit-naksuk#results",
      lastResultDate: null,
      tiedWith: 0,
    };

    render(<PersonalSeasonCard season={season} showExplanation={false} />);
    expect(screen.getByText("Jul – Dec 2026")).toBeInTheDocument();
    expect(screen.queryByText(/Guest/)).not.toBeInTheDocument();
    expect(screen.queryByText(/Not on this board/)).not.toBeInTheDocument();
  });
});
