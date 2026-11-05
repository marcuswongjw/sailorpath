import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import { ProfileStandingCard } from "./ProfileStandingCard";

describe("Optimist standing copy", () => {
  it("labels the Singapore Gold ranking and scoring rule", () => {
    const html = renderToStaticMarkup(<ProfileStandingCard standing={{ boatClass: "Optimist", fleet: "Gold", overallRank: 2, fleetSize: 68, best3of5: 10, rScores: [], periodLabel: "2026", trendNote: "" }} standingIsIlca={false} seriesDnsCount={0} cardClass="" />);
    expect(html).toContain("Singapore Optimist Gold Fleet Ranking");
    expect(html).toContain("Best 3 out of 5 ranking regattas");
    expect(html).not.toContain("Lower total scores are better");
  });
});
