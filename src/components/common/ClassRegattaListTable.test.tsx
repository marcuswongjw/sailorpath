/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it } from "vitest";
import { ClassRegattaListTable } from "./ClassRegattaListTable";
import type { PublicClassRegattaRow } from "@/lib/publicDataLoader";

const row = (name: string, year: string, kind: "normalized_result" | "special_scorecard"): PublicClassRegattaRow => ({
  id: name, eventSlug: name, fleetKey: "open", name, datesText: `1 Jan ${year}`, startDate: `${year}-01-01`, venue: "Singapore", timingStatus: "completed", resultStatus: "final", resultsSummary: "Final", competitorCount: 10, canonicalHref: `/regattas/${name}`, source: { kind, label: "Source" },
});

describe("class event list", () => {
  it("filters results while retaining distinct result and race scorecard links", async () => {
    const user = userEvent.setup();
    render(<ClassRegattaListTable classNameTitle="WingFoil" regattas={[row("Alpha", "2026", "normalized_result"), row("Bravo", "2025", "special_scorecard")]} />);
    expect(screen.getByRole("link", { name: /Alpha/ })).toHaveAttribute("href", "/regattas/Alpha");
    expect(screen.getByText("Event result")).toBeInTheDocument();
    expect(screen.getByText("Race scorecard")).toBeInTheDocument();
    await user.selectOptions(screen.getByLabelText("Year"), "2025");
    expect(screen.queryByRole("link", { name: /Alpha/ })).not.toBeInTheDocument();
    expect(screen.getByRole("link", { name: /Bravo/ })).toBeInTheDocument();
    await user.type(screen.getByRole("searchbox"), "missing");
    expect(screen.getByText("No events match your filters.")).toBeInTheDocument();
  });
});
