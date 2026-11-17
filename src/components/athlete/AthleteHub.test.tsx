/** @vitest-environment jsdom */
import { render, screen, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { AthleteHub } from "./AthleteHub";

const toast = vi.hoisted(() => ({ success: vi.fn(), error: vi.fn() }));
vi.mock("next/navigation", () => ({
  useRouter: () => ({ push: vi.fn(), replace: vi.fn(), refresh: vi.fn() }),
}));
vi.mock("@/components/ui/FeedbackProvider", () => ({
  useFeedback: () => ({ toast, confirm: vi.fn().mockResolvedValue(true) }),
}));
vi.mock("@/components/equipment/EquipmentInventory", () => ({
  EquipmentInventory: () => <div data-testid="equipment-inventory" />,
}));

describe("AthleteHub logbook & reflections", () => {
  afterEach(() => vi.unstubAllGlobals());
  beforeEach(() => {
    vi.clearAllMocks();
    vi.stubGlobal(
      "fetch",
      vi.fn().mockImplementation(async (url: string, init?: RequestInit) => {
        if (url.startsWith("/api/account/results")) {
          return {
            ok: true,
            json: async () => ({
              results: [
                {
                  id: "res-1",
                  regattaId: "reg-esr",
                  regattaName: "18th Eastern Seaboard Regatta 2026 — Optimist Gold",
                  regattaSlug: "eastern-seaboard-regatta-2026-optimist-gold",
                  regattaDate: "2026-10-28",
                  regattaEndDate: "2026-11-01",
                  venue: "Royal Varuna Yacht Club, Pattaya, Thailand",
                  boatClass: "Optimist",
                  division: "Gold",
                  rank: 44,
                  totalFleetSize: 68,
                  nettScore: 152,
                  countsForRanking: false,
                  verificationStatus: "verified",
                  evidenceNotes:
                    "Official source name: MIKAELA WONG HUI TING; Source SHA256: f5859b58faa",
                },
              ],
            }),
          };
        }
        if (url.startsWith("/api/account/observations") && (!init?.method || init.method === "GET")) {
          return {
            ok: true,
            json: async () => ({ observations: [] }),
          };
        }
        if (url === "/api/account/observations" && init?.method === "POST") {
          const payload = JSON.parse(String(init.body || "{}"));
          return {
            ok: true,
            json: async () => ({
              ok: true,
              observation: {
                id: "obs-1",
                sailorId: payload.sailorId,
                regattaId: payload.regattaId,
                raceNumber: payload.raceNumber,
                position: payload.position,
                wind: payload.wind,
                note: payload.note,
                isPrivate: payload.isPrivate,
              },
            }),
          };
        }
        return { ok: true, json: async () => ({}) };
      })
    );
  });

  it("shows qualifying total (135), hides audit text, links to unified Edit profile, and saves reflections", async () => {
    const user = userEvent.setup();
    render(
      <AthleteHub
        athletes={[
          {
            id: "sailor-1",
            name: "Mikaela Hui Ting Wong",
            handle: "mikaela-wong",
            sailNumber: "3029",
            club: "SAF Yacht Club",
          },
        ]}
      />
    );

    expect(
      await screen.findByText("18th Eastern Seaboard Regatta 2026 — Optimist Gold")
    ).toBeInTheDocument();
    expect(screen.getByText(/\/ 135/)).toBeInTheDocument();
    expect(screen.queryByText(/Source SHA256/)).not.toBeInTheDocument();

    const tabs = screen.getByRole("tablist", { name: "Logbook sections" });
    expect(within(tabs).getByRole("tab", { name: /Logbook/ })).toBeInTheDocument();
    expect(within(tabs).getByRole("tab", { name: "Equipment" })).toBeInTheDocument();
    expect(within(tabs).getByRole("tab", { name: /Documents/ })).toBeInTheDocument();
    expect(within(tabs).queryByRole("tab", { name: "Profile" })).not.toBeInTheDocument();

    expect(screen.getByRole("link", { name: "Edit profile" })).toHaveAttribute(
      "href",
      "/sailors/mikaela-wong?edit=1"
    );

    await user.click(screen.getByRole("button", { name: "+ Add reflection" }));
    expect(screen.getByText("Regatta reflections", { selector: "h2" })).toBeInTheDocument();

    await user.type(
      screen.getByLabelText("Takeaways & notes"),
      "Strong starts on pin end in 12kt chop."
    );
    await user.click(screen.getByRole("button", { name: "Save reflection" }));

    expect(
      (await screen.findAllByText(/Strong starts on pin end in 12kt chop\./)).length
    ).toBeGreaterThan(0);
    expect(screen.getByRole("button", { name: "Reflections (1)" })).toBeInTheDocument();
  });

  it("consumes a new-regatta link after dismissal, including when switching sailors", async () => {
    window.history.replaceState(null, "", "/athlete?id=sailor-1&tab=results&action=new#logbook");
    const user = userEvent.setup();
    const athletes = [
      { id: "sailor-1", name: "First Sailor", handle: "first", sailNumber: "1", club: "Club" },
      { id: "sailor-2", name: "Second Sailor", handle: "second", sailNumber: "2", club: "Club" },
    ];
    const view = render(<AthleteHub athletes={athletes} initialAction="new" />);
    expect(screen.getByRole("button", { name: "Close regatta form" })).toBeInTheDocument();
    await user.click(screen.getByRole("button", { name: "Close regatta form" }));
    expect(new URL(window.location.href).searchParams.has("action")).toBe(false);
    expect(window.location.hash).toBe("#logbook");
    expect(new URL(window.location.href).searchParams.get("tab")).toBe("results");
    await user.click(screen.getByRole("button", { name: "Second Sailor" }));
    expect(screen.queryByRole("button", { name: "Close regatta form" })).not.toBeInTheDocument();
    view.unmount();
    render(<AthleteHub athletes={athletes} currentSailorId="sailor-2" />);
    expect(screen.queryByRole("button", { name: "Close regatta form" })).not.toBeInTheDocument();
    window.history.replaceState(null, "", "/");
  });
});
