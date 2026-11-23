/** @vitest-environment jsdom */
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { fireEvent, render, screen, within } from "@testing-library/react";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { AdminGoldFormPanel } from "./AdminGoldFormPanel";
import type { AdminGoldFormResponse } from "@/app/api/admin/gold-form/route";
import { buildGoldFormIndex } from "@/lib/admin/goldFormIndex";

const requests = vi.hoisted(() => ({
  fetchGoldForm: vi.fn(),
}));

vi.mock("./adminFetch", async (importOriginal) => ({
  ...(await importOriginal<typeof import("./adminFetch")>()),
  fetchAdminGoldForm: requests.fetchGoldForm,
}));

function buildMockPayload(): AdminGoldFormResponse {
  const sailors = [
    {
      id: "s-leader",
      name: "Alyssa Wong",
      sailNumber: "SGP 101",
      club: "NSC",
      gender: "F",
      dob: "2013-02-01",
      goldEntryDate: "2023-01-01",
      currentFleet: "Series",
      nationalSquadStatus: "Nat A",
    },
    {
      id: "s-riser",
      name: "Timothy Ng",
      sailNumber: "SGP 202",
      club: "CSC",
      gender: "M",
      dob: "2015-04-10",
      goldEntryDate: "2026-01-01",
      currentFleet: "Series",
      nationalSquadStatus: "Nat B",
    },
  ];
  const regattas = [
    { id: "g1", name: "CSC Gold", date: "2026-01-24", division: "Gold", boatClass: "Optimist", geography: "SGP", countsForRanking: true, status: "published", totalFleetSize: 80 },
    { id: "g2", name: "SYSC Gold", date: "2026-03-14", division: "Gold", boatClass: "Optimist", geography: "SGP", countsForRanking: true, status: "published", totalFleetSize: 80 },
    { id: "g3", name: "Cincapura Gold", date: "2026-07-20", division: "Gold", boatClass: "Optimist", geography: "SGP", countsForRanking: true, status: "published", totalFleetSize: 80 },
    { id: "g4", name: "SNSC Gold", date: "2026-09-11", division: "Gold", boatClass: "Optimist", geography: "SGP", countsForRanking: true, status: "published", totalFleetSize: 80 },
    { id: "g5", name: "RSYC Gold", date: "2026-10-03", division: "Gold", boatClass: "Optimist", geography: "SGP", countsForRanking: true, status: "published", totalFleetSize: 80 },
    { id: "os1", name: "Eastern Seaboard Gold", date: "2026-10-28", division: "Gold", boatClass: "Optimist", geography: "THA", countsForRanking: false, status: "published", totalFleetSize: 60 },
  ];
  const results = [
    { sailorId: "s-leader", regattaId: "g1", rank: 5 },
    { sailorId: "s-leader", regattaId: "g2", rank: 4 },
    { sailorId: "s-leader", regattaId: "g3", rank: 2 },
    { sailorId: "s-leader", regattaId: "g4", rank: 1 },
    { sailorId: "s-leader", regattaId: "g5", rank: 3 },
    { sailorId: "s-riser", regattaId: "g1", rank: 60 },
    { sailorId: "s-riser", regattaId: "g2", rank: 45 },
    { sailorId: "s-riser", regattaId: "g3", rank: 18 },
    { sailorId: "s-riser", regattaId: "g4", rank: 12 },
    { sailorId: "s-riser", regattaId: "g5", rank: 6 },
    { sailorId: "s-riser", regattaId: "os1", rank: 4 },
  ];
  return {
    sgRanking: buildGoldFormIndex({
      sailors,
      regattas,
      results,
      scope: "sg_ranking",
      asOfYmd: "2026-11-23",
    }),
    allGold: buildGoldFormIndex({
      sailors,
      regattas,
      results,
      scope: "all_gold",
      asOfYmd: "2026-11-23",
    }),
    generatedAt: "2026-11-23T12:00:00.000Z",
  };
}

function renderPanel(onOpenSailor = vi.fn(), isSuperadmin = true) {
  const client = new QueryClient({
    defaultOptions: { queries: { retry: false } },
  });
  return render(
    <QueryClientProvider client={client}>
      <AdminGoldFormPanel isSuperadmin={isSuperadmin} onOpenSailor={onOpenSailor} />
    </QueryClientProvider>,
  );
}

beforeEach(() => {
  requests.fetchGoldForm.mockReset().mockResolvedValue(buildMockPayload());
});

describe("AdminGoldFormPanel", () => {
  it("gates analytics behind superadmin permission", () => {
    renderPanel(vi.fn(), false);
    expect(screen.getByText("Superadmin access is required.")).toBeInTheDocument();
    expect(requests.fetchGoldForm).not.toHaveBeenCalled();
  });

  it("renders KPI leaders, accessible SVG charts, sortable table headers, and supports inspection & sorting", async () => {
    const onOpenSailor = vi.fn();
    renderPanel(onOpenSailor, true);

    expect(
      await screen.findByRole("heading", { name: /Optimist Gold Form & Up-and-Coming Index/i }),
    ).toBeInTheDocument();

    // Quadrant and Trajectory SVG charts
    expect(
      screen.getByRole("img", { name: /Scatter chart plotting Form Index horizontally/i }),
    ).toBeInTheDocument();
    expect(
      screen.getByRole("img", { name: /Historical Gold finish percentile progression/i }),
    ).toBeInTheDocument();

    // Sortable table starts sorted by Form descending
    const table = screen.getByRole("table");
    const formHeader = within(table).getByRole("columnheader", { name: /Form/i });
    expect(formHeader).toHaveAttribute("aria-sort", "descending");

    // Click Up & Coming preset switches sort cleanly to Watchlist
    fireEvent.click(screen.getByRole("button", { name: "Up & Coming to Watch" }));
    const watchHeader = within(table).getByRole("columnheader", { name: /Watchlist/i });
    expect(watchHeader).toHaveAttribute("aria-sort", "descending");

    // Switch scope to All Gold includes overseas starts
    fireEvent.click(screen.getByRole("button", { name: "All Gold (incl. Overseas)" }));
    expect(screen.getByText("+1 OS")).toBeInTheDocument();

    // Select a sailor row and open directory callback
    fireEvent.click(within(table).getByRole("button", { name: /Timothy Ng/i }));
    fireEvent.click(screen.getByRole("button", { name: /Sailor record/i }));
    expect(onOpenSailor).toHaveBeenCalledWith("s-riser", "Timothy Ng");
  });
});
