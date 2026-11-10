import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";
const { load } = vi.hoisted(() => ({ load: vi.fn() }));
vi.mock("@/lib/queries", () => ({ getCachedPublicRegattas: load }));
import X15ClassHub, { metadata } from "./page";

describe("X-15 class hub", () => {
  beforeEach(() => {
    load.mockReset();
    load.mockResolvedValue([]);
  });

  it("shows sourced championship showcases without removed results or governance copy", async () => {
    const html = renderToStaticMarkup(await X15ClassHub());
    expect(metadata.alternates).toEqual({ canonical: "/classes/x15" });

    // Header and core sections
    expect(html).toContain("Follow the X-15 class");
    expect(html).toContain("2026 championship");
    expect(html).not.toContain("2026 championship &amp; clinic guide");
    expect(html).toContain("Upcoming X-15 events (2026–2027)");
    expect(html).toContain("Official X-15 equipment &amp; division setup");
    expect(html).toContain("What is X-15?");

    // Worlds card
    expect(html).toContain("Port Nàutic Ibiza, Spain");
    expect(html).toContain("The inaugural World Championships, bringing together international riders to compete across senior, youth and junior divisions in Port Nàutic Ibiza, Spain.");
    expect(html).not.toContain("Registration opened on 4 November, with racing scheduled through 8 November for");
    expect(html).not.toContain("Masters and additional youth/junior divisions have separate championship awards.");
    expect(html).not.toContain("107-sailor fleet announcement (24 nations)");
    expect(html).not.toContain("Class entry guidance");

    // Asian Cup card
    expect(html).toContain("The premier Asian continental event on the X-15 circuit, featuring three days of championship racing preceded by training and the Emerging Nations Clinic at Amara Watersports Club.");
    expect(html).not.toContain("Japan WingFoil Association event notice");

    // Removed sections and copy
    expect(html).not.toContain("Official events, one-design equipment rules");
    expect(html).not.toContain("Race results");
    expect(html).not.toContain("Sources checked");
    expect(html).not.toContain("Class governance");

    // Hardware & calendar
    expect(html).toContain("82L Lite Tech");
    expect(html).toContain('/classes/x15/ibiza-worlds-2026.jpg');
    expect(html).toContain('fetchPriority="high"');
    expect(html).toContain('/classes/x15/equipment-board-82l.jpg');
    expect(html).toContain('/classes/x15/equipment-wing.jpg');
    expect(html).toContain('/classes/x15/equipment-foil-system.jpg');
    expect(html).toContain("snap-x snap-mandatory");
    expect(html).toContain('aria-label="Event overview for X-15 Asian Cup 2026"');
    expect(html).toContain("docs.google.com/forms/");
    expect(html).not.toContain("instagram.com");
    expect(html).not.toContain("<table");
  });
});
