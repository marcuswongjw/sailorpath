// @vitest-environment jsdom
import { fireEvent, render, screen, waitFor } from "@testing-library/react";
import { afterEach, describe, expect, it, vi } from "vitest";
vi.mock("next/dynamic", () => ({ default: () => (props: { initialExtraction: unknown; remotePdfUrl?: string }) => <div data-testid="prepared-import">{JSON.stringify(props)}</div> }));
import { ResultsImportInbox } from "./ResultsImportInbox";

const event = {
  id: "event-a", slug: "harbour-cup", name: "Harbour Cup", startDate: "2026-10-01", endDate: "2026-10-02", eventUrl: "https://club.example/", enabled: true, checkedAt: null,
  sheets: [{ id: "sheet-a", name: "Harbour Gold", date: "2026-10-01", boatClass: "Optimist", division: "Gold", geography: "SGP", countsForRanking: true }],
  report: { checkedAt: "2026-10-03", status: "needs_review", pdfCorroboration: "not_found_in_checked_pages", searchedUrls: ["https://club.example/"], errors: [], sources: [{ kind: "html", url: "https://club.example/final", title: "Final results", sha256: "hash", finalLabelSeen: true, tables: [{ title: "Gold", raceCount: 1, issues: [], rows: [{ rank: 1, name: "Alice Example", sailNumber: "123", total: 1, nett: 1, races: [{ rawValue: "1", discarded: false }] }] }] }] },
};
afterEach(() => { vi.unstubAllGlobals(); });
describe("results import pilot", () => {
  it("shows global disabled status independently of enabled event checkboxes", async () => {
    vi.stubGlobal("fetch", vi.fn(async () => Response.json({ events: [event], health: {
      enabled: false, schedulerConfigured: true, schedule: "Daily at 09:00 Singapore time", batchLimit: 3, lookbackDays: 45,
      lastSuccess: null, lastFailure: { startedAt: "2026-10-22T01:00:00Z", finishedAt: "2026-10-22T01:01:00Z" }, recentRuns: [],
    } })));
    render(<ResultsImportInbox />);
    expect(await screen.findByRole("heading", { name: "Scheduled source checks: Disabled" })).toBeInTheDocument();
    expect(screen.getByText(/Global monitoring is switched off/)).toBeInTheDocument();
    expect(screen.getByText(/Last successful check: None recorded/)).toBeInTheDocument();
  });
  it("requires a destination and source review before handing scores to the draft importer", async () => {
    vi.stubGlobal("fetch", vi.fn(async () => Response.json({ events: [event] })));
    render(<ResultsImportInbox />);
    await screen.findByRole("option", { name: /Harbour Cup/ });
    fireEvent.change(screen.getByLabelText("Regatta"), { target: { value: "event-a" } });
    expect(screen.getByRole("button", { name: "Prepare reviewed import" })).toBeDisabled();
    fireEvent.change(screen.getByLabelText("Destination class sheet"), { target: { value: "sheet-a" } });
    expect(screen.getByRole("button", { name: "Prepare reviewed import" })).toBeDisabled();
    fireEvent.click(screen.getByLabelText(/I verified the event/));
    fireEvent.click(screen.getByRole("button", { name: "Prepare reviewed import" }));
    const prepared = await screen.findByTestId("prepared-import");
    expect(prepared.textContent).toContain('"publicationStatus":"draft"');
    expect(prepared.textContent).toContain('"targetSheetId":"sheet-a"');
    expect(prepared.textContent).toContain('"officialResultsUrl":"https://club.example/final"');
  });
  it("makes dry run explicit and sends it without saving settings", async () => {
    const fetcher = vi.fn(async (_url: string, options?: RequestInit) => options?.method === "POST" ? Response.json({ outcomes: [{ report: event.report }] }) : Response.json({ events: [event] }));
    vi.stubGlobal("fetch", fetcher);
    render(<ResultsImportInbox />);
    await screen.findByRole("option", { name: /Harbour Cup/ });
    fireEvent.change(screen.getByLabelText("Regatta"), { target: { value: "event-a" } });
    fireEvent.click(screen.getByRole("button", { name: "Dry run" }));
    await waitFor(() => expect(screen.getByRole("status")).toHaveTextContent("Nothing was saved or imported"));
    const request = fetcher.mock.calls.find((call) => call[1]?.method === "POST");
    expect(JSON.parse(String(request?.[1]?.body))).toMatchObject({ action: "scan", dryRun: true, eventId: "event-a" });
  });
});
