/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { AsianOptimistIndexView } from "@/components/AsianOptimistIndexView";
import { createAsianOptimistIndexProvisionalEntries } from "@/lib/asianOptimistIndexScoring";
import { ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS } from "@/lib/asianOptimistIndexQualifiers";

describe("AsianOptimistIndexView", () => {
  it("renders the streamlined header copy, removes V1 Beta clutter, and renders responsive standings", () => {
    const entries = createAsianOptimistIndexProvisionalEntries().slice(0, 5);
    const { container } = render(
      <AsianOptimistIndexView
        entries={entries}
        qualifiers={[...ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS]}
      />
    );

    expect(
      screen.getByText(
        "An independent beta index of Optimist results for sailors representing Asian and Oceanian national authorities. Event and sailor details remain under review."
      )
    ).toBeInTheDocument();
    expect(screen.queryByText(/Optimist · V1 \(Beta\) methodology/i)).not.toBeInTheDocument();
    expect(screen.queryByText(/Fixed cohort/i)).not.toBeInTheDocument();
    expect(screen.queryByText(/Standings · V1 \(Beta\)/i)).not.toBeInTheDocument();
    expect(screen.getByRole("heading", { name: "Standings" })).toBeInTheDocument();
    expect(container.querySelector("table")).not.toBeNull();
    expect(container.querySelector("summary h1, summary h2, summary h3")).toBeNull();
  });

  it("shows the score calculation, selection status and the sailor's actual split-fleet scorecard", () => {
    const entry = createAsianOptimistIndexProvisionalEntries()[0];
    const result = entry.qualifierResults[0];
    const source = ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS.find((item) => item.id === result.qualifier.id);
    const sailor = { ...entry, qualifierResults: [{ ...result, regattaSlug: "test-silver-scorecard" }] };
    render(<AsianOptimistIndexView entries={[sailor]} qualifiers={source ? [source] : []} />);
    expect(screen.getAllByText(/Score breakdown/).length).toBeGreaterThan(0);
    expect(screen.getAllByText(/Points = grade/).length).toBeGreaterThan(0);
    expect(screen.getAllByText(/Season Points:/).length).toBeGreaterThan(0);
    expect(screen.getAllByRole("link", { name: "SailorPath results", hidden: true }).some(
      (link) => link.getAttribute("href") === "/sg/optimist/regattas/test-silver-scorecard"
    )).toBe(true);
  });
});
