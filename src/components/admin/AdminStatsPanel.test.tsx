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
  demographics: {
    sailorsTotal: 100,
    sailorsWithResults: 90,
    nationalitiesCount: 12,
    resultsTotal: 450,
    classesCount: 3,
    topNationalities: [{ country: "SGP", count: 80 }],
    boatClasses: [{ className: "Optimist", regattaCount: 5, resultCount: 400, sailorCount: 85 }],
  },
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

  it("renders traffic & engagement breakdown, extended demographics, and feature adoption insights", async () => {
    const richStats: AdminStatsPayload = {
      ...stats,
      usageEventsOk: true,
      northStars: {
        ...stats.northStars,
        weeklyActiveSessions: 140,
      },
      traffic7d: {
        profileViews: 85,
        rankingViews: 120,
        searches: 30,
        sampleViews: 15,
        adminOpens: 5,
      },
      trafficBreakdown: {
        sessions30d: 480,
        pageViews7d: 310,
        pageViews30d: 1120,
        rankingViews30d: 410,
        profileViews30d: 290,
        searches30d: 95,
        sampleViews30d: 45,
        uniqueVisitors7d: 110,
        returningVisitors7d: 44,
        ownProfileViews7d: 25,
        otherProfileViews7d: 60,
        rankingToProfileSessions30d: 90,
        rankingSessions30d: 180,
        demoToClaimSessions30d: 6,
        demoSessions30d: 30,
        devices7d: { mobile: 98, desktop: 42, unknown: 0 },
        topSources7d: [{ source: "whatsapp", sessions: 65, events: 180 }],
        topPaths7d: [{ path: "/sg/optimist/gold", views: 120, sessions: 80 }],
      },
      demographics: {
        ...stats.demographics,
        multiClassSailors: 14,
        activeSeriesGold: 22,
        activeSeriesSilver: 18,
        genderBreakdown: { male: 55, female: 40, unspecified: 5 },
        birthYearCohorts: [{ cohort: "2011–2014 (U16 Youth)", count: 60 }],
        topClubs: [{ club: "NSC", count: 45 }],
      },
      featureAdoption: {
        claims: {
          approved: 15,
          rejected: 3,
          pending: 1,
          approvalRatePct: 83.3,
          byRelation: { parent: 11, sailor: 4, other: 0 },
        },
        publicProfileOptIns: {
          photo: 8,
          equipment: 6,
          school: 5,
          milestones: 7,
          social: 3,
        },
        community: {
          followedSailorLinks: 32,
          uniqueSailorsFollowed: 19,
          activeFollowers: 14,
        },
        coaching: {
          coachAccounts: 4,
          coachSquads: 6,
          squadSailors: 28,
          watchlistEntries: 12,
          developmentRecords: 35,
          sharedRecords: 20,
          coachNotes: 9,
        },
        logbookAndGear: {
          raceObservations: 48,
          sailorsWithRaceNotes: 10,
          parentNotes: 16,
          equipmentItems: 24,
          sailorsWithEquipment: 9,
          equipmentSessionsTotal: 52,
          equipmentSessions30d: 18,
        },
      },
    };
    vi.stubGlobal("fetch", vi.fn(async () => Response.json(richStats)));
    mount();

    expect(
      await screen.findByRole("region", {
        name: "Traffic & engagement breakdown",
      }),
    ).toBeInTheDocument();
    expect(screen.getByText("44 / 110")).toBeInTheDocument();
    expect(screen.getByText("/sg/optimist/gold")).toBeInTheDocument();
    expect(screen.getByText("2011–2014 (U16 Youth)")).toBeInTheDocument();
    expect(screen.getByText("NSC:")).toBeInTheDocument();
    expect(screen.getByText("83.3%")).toBeInTheDocument();
    expect(
      screen.getByRole("region", { name: "Feature & community adoption" }),
    ).toBeInTheDocument();
    expect(screen.getByText("4 coaches · 6 squads")).toBeInTheDocument();
  });
});
