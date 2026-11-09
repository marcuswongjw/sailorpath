import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";
const { load } = vi.hoisted(() => ({ load: vi.fn() }));
vi.mock("@/lib/queries", () => ({ getCachedPublicRegattas: load }));
import X15ClassHub, { metadata } from "./page";

describe("X-15 class hub", () => {
  beforeEach(() => { load.mockReset(); load.mockResolvedValue([]); });
  it("shows sourced championship guidance and an honest empty results state", async () => {
    const html = renderToStaticMarkup(await X15ClassHub());
    expect(metadata.alternates).toEqual({ canonical: "/classes/x15" });
    expect(html).toContain("15–17 December training");
    expect(html).toContain("Port Nàutic Ibiza, Spain");
    expect(html).toContain("107 riders from 24 nations");
    expect(html).toContain("X-15 Emerging Nations Clinic");
    expect(html).toContain("46th Singapore Open Windsurfing and Foiling Championships 2027");
    expect(html).toContain("X-15 Youth World Championships");
    expect(html).toContain("82L Lite Tech");
    expect(html).toContain('/classes/x15/ibiza-worlds-2026.jpg');
    expect(html).toContain('fetchPriority="high"');
    expect(html).toContain('/classes/x15/equipment-board-82l.jpg');
    expect(html).toContain('/classes/x15/equipment-wing.jpg');
    expect(html).toContain('/classes/x15/equipment-foil-system.jpg');
    expect(html).toContain("snap-x snap-mandatory");
    expect(html).toContain('aria-label="Event overview for X-15 Asian Cup 2026"');
    expect(html).toContain("No reviewed X-15 scorecards");
    expect(html).toContain("docs.google.com/forms/");
    expect(html).not.toContain("instagram.com");
    expect(html).not.toContain("<table");
  });
  it("distinguishes failed loading from no published results", async () => {
    load.mockImplementation(() => { throw new Error("offline"); });
    const html = renderToStaticMarkup(await X15ClassHub());
    expect(html).toContain("Results are temporarily unavailable");
    expect(html).not.toContain("No reviewed X-15 scorecards");
  });
  it("links actual published divisions without including other disciplines", async () => {
    load.mockResolvedValue([
      { id: "x", slug: "fixture-x15", name: "Fixture event", boatClass: "X-15", division: "Senior male", date: "2026-11-08", totalFleetSize: 12, importedEntryCount: 12, eventId: "e", eventSlug: "fixture", eventName: "Fixture event" },
      { id: "w", slug: "other-wingfoil", name: "Unrelated Wingfoil", boatClass: "WingFoil", date: "2026-11-08", totalFleetSize: 10 },
    ]);
    const html = renderToStaticMarkup(await X15ClassHub());
    expect(html).toContain('/regattas/fixture?fleet=x15-senior-male');
    expect(html).not.toContain("Unrelated Wingfoil");
    expect(html).not.toContain("No reviewed X-15 scorecards");
  });
});
