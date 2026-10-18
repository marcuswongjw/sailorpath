// @vitest-environment jsdom
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { render, screen, within } from "@testing-library/react";
import { afterEach, describe, expect, it, vi } from "vitest";
import { AdminStatsPanel } from "./AdminStatsPanel";
import type { AdminStatsPayload } from "@/lib/adminStats";

const stats: AdminStatsPayload = {
  generatedAt: "2026-10-18T09:00:00Z", cacheSeconds: 60,
  usageEventsOk: false, authAccountsOk: false,
  northStars: {claimedSeriesSailors: 12, seriesSailors: 40, rosterClaimedPct: 30, claimedSailors: 15, weeklyActiveSessions: 0, claimsPending: 1},
  traffic7d: {profileViews: 0, rankingViews: 0, searches: 0, sampleViews: 0, adminOpens: 0},
  ops: {supportNew: 0, daysSinceLastImport: 60, lastImportAt: null, rankingRegattas: 10},
  dataTrust: {sailorsTotal: 100, missingDob: 80, missingOrPlaceholderSail: 20},
  accounts: {registered: 0, confirmed: 0, signedInLast7d: 0, authSessions: 0, recent: []},
};
function mount() {
  return render(<QueryClientProvider client={new QueryClient({defaultOptions: {queries: {retry: false}}})}><AdminStatsPanel isSuperadmin /></QueryClientProvider>);
}
afterEach(() => vi.unstubAllGlobals());
describe("Admin insights", () => {
  it("does not turn a failed insights request into zero activity", async () => {
    vi.stubGlobal("fetch", vi.fn(async () => Response.json({error: "Unavailable"}, {status: 503})));
    mount();
    expect(await screen.findByRole("alert")).toHaveTextContent("does not mean activity is zero");
    expect(screen.queryByRole("heading", {name: "Recorded sessions"})).not.toBeInTheDocument();
  });
  it("shows unavailable usage as dashes, with adoption denominators and actionable links", async () => {
    vi.stubGlobal("fetch", vi.fn(async () => Response.json(stats)));
    mount();
    expect(await screen.findByText("12 / 40")).toBeInTheDocument();
    const usage = screen.getByRole("region", {name: "Recorded usage · last 7 days"});
    expect(within(usage).getAllByText("—")).toHaveLength(4);
    expect(screen.getByText(/not a complete import ledger/)).toBeInTheDocument();
    expect(screen.getByRole("link", {name: /Results coverage/})).toHaveAttribute("href", "/admin?area=events&view=missing-results");
    expect(screen.getByText("Diagnostics & account activity").closest("details")).not.toHaveAttribute("open");
    expect(screen.queryByText("60 days")).not.toBeInTheDocument();
  });
});
