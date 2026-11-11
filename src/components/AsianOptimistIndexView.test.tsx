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
        "An independent index of verified Optimist results for sailors representing Asian and Oceanian national authorities."
      )
    ).toBeInTheDocument();
    expect(screen.queryByText(/Optimist · V1 \(Beta\) methodology/i)).not.toBeInTheDocument();
    expect(screen.queryByText(/Fixed cohort/i)).not.toBeInTheDocument();
    expect(screen.queryByText(/Standings · V1 \(Beta\)/i)).not.toBeInTheDocument();
    expect(screen.getByRole("heading", { name: "Standings" })).toBeInTheDocument();
    expect(container.querySelector("table")).not.toBeNull();
    expect(container.querySelector("summary h1, summary h2, summary h3")).toBeNull();
  });
});
