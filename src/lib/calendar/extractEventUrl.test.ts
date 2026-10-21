import { describe, expect, it } from "vitest";
import { extractEventUrl } from "./extractEventUrl";

const page = (event: object) => `<script type="application/ld+json">${JSON.stringify(event)}</script><main><a href="/nor.pdf">Notice of Race</a><a href="/enter">Register now</a></main>`;
describe("calendar event URL extraction", () => {
  it("extracts structured event facts, dates, classes and relative links", () => {
    const { draft } = extractEventUrl(page({ "@type": "SportsEvent", name: "Optimist Harbour Cup 2026", startDate: "2026-10-23T09:00:00+08:00", endDate: "2026-10-25", location: { name: "Harbour Sailing Club" }, organizer: { name: "Sailing Association" }, description: "Racing for Optimist and ILCA 4." }), "https://club.example/event");
    expect(draft).toMatchObject({ name: "Optimist Harbour Cup 2026", startDate: "2026-10-23", endDate: "2026-10-25", venue: "Harbour Sailing Club", organizer: "Sailing Association", classes: "Optimist, ILCA 4", norUrl: "https://club.example/nor.pdf", registrationUrl: "https://club.example/enter", sourceUrl: "https://club.example/event" });
  });
  it("reads ordinary event pages without inventing missing fields", () => {
    const { draft, warnings } = extractEventUrl('<title>Club</title><main><h1>Optimist Cup</h1><p>23–25 October 2026</p><p>Venue: Harbour</p><p>Organiser: CSC</p><p>Classes: Optimist, ILCA 6</p></main>', "https://club.example/event");
    expect(draft).toMatchObject({ startDate: "2026-10-23", endDate: "2026-10-25", venue: "Harbour", organizer: "CSC", classes: "Optimist, ILCA 6", registrationUrl: "" });
    expect(warnings).toEqual([]);
  });
  it("supports month-first date ranges", () => {
    expect(extractEventUrl('<h1>Harbour Cup</h1><p>October 23–25, 2026</p>', "https://club.example").draft.startDate).toBe("2026-10-23");
  });
  it("reads explicit and cross-month event ranges without choosing document publication dates", () => {
    expect(extractEventUrl('<h1>Cup</h1><p>From 18 Oct 2019 To 21 Oct 2019</p><p>NOR published 25 Jul 2019</p>', "https://club.example").draft).toMatchObject({ startDate: "2019-10-18", endDate: "2019-10-21" });
    expect(extractEventUrl('<h1>Cup</h1><p>29 October–1 November 2026</p>', "https://club.example").draft).toMatchObject({ startDate: "2026-10-29", endDate: "2026-11-01" });
  });
  it("leaves conflicting dates and missing classes for review", () => {
    const { draft, warnings } = extractEventUrl('<h1>Harbour Cup</h1><p>Entries close 1 October 2026. Racing 23–25 October 2026.</p><nav>Optimist ILCA 4</nav>', "https://club.example");
    expect(draft.startDate).toBe(""); expect(draft.classes).toBe(""); expect(warnings).toHaveLength(2);
  });
  it("does not choose an arbitrary event from a multi-event page", () => {
    const { draft } = extractEventUrl(page({ "@graph": [{ "@type": "Event", name: "Old Cup", startDate: "2025-10-01" }, { "@type": "Event", name: "New Cup", startDate: "2026-10-01" }] }), "https://club.example");
    expect(draft.startDate).toBe("");
  });
  it("rejects impossible dates, reversed ranges and unsafe links", () => {
    const { draft } = extractEventUrl(page({ "@type": "Event", name: "Cup", startDate: "2026-02-31", endDate: "2026-01-01" }) + '<main><a href="javascript:alert(1)">Register now</a></main>', "https://club.example");
    expect(draft.startDate).toBe(""); expect(draft.registrationUrl).toBe("https://club.example/enter");
  });
});
