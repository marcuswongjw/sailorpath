import { describe, expect, it } from "vitest";
import { getRegattaEvent } from "@/lib/regattaEvents";
import { SAMPLE_RESULTS, SAMPLE_SAILOR } from "@/lib/sampleProfile";
import {
  eventDatesFromText,
  eventHubTitle,
  HUB_SITEMAP_PATHS,
  isIndexablePublicSailor,
  organizationWebsiteJsonLd,
  profilePageJsonLd,
  publicResultSheetPaths,
  resultSheetFromEventSlice,
  resultSheetTitle,
  sailorShareModel,
  sailorSitemapEntries,
  serializeJsonLd,
  sportsEventJsonLd,
  topFinishers,
} from "@/lib/publicSeo";

const PRIVATE_KEYS = [
  "dob",
  "school",
  "weight",
  "email",
  "telephone",
  "gender",
  "image",
  "parentId",
];

function keysDeep(value: unknown, found = new Set<string>()): Set<string> {
  if (Array.isArray(value)) {
    for (const item of value) keysDeep(item, found);
    return found;
  }
  if (value && typeof value === "object") {
    for (const [key, child] of Object.entries(value)) {
      found.add(key);
      keysDeep(child, found);
    }
  }
  return found;
}

describe("public share metadata", () => {
  it("builds a sailor title and a one-line results summary", () => {
    const share = sailorShareModel({
      name: SAMPLE_SAILOR.name,
      handle: SAMPLE_SAILOR.handle,
      nationality: SAMPLE_SAILOR.nationality,
      club: SAMPLE_SAILOR.club,
      results: SAMPLE_RESULTS,
      path: "/sample",
    });
    expect(share.title).toBe("Kimberly Tan – Optimist, Singapore | SailorPath");
    expect(share.country).toBe("Singapore");
    expect(share).not.toHaveProperty("birthYear");
    expect(share.boatClass).toBe("Optimist");
    expect(share.bestResult).toBe("1st in Optimist at Singapore National Championship 2026");
    expect(share.summary).toBe(
      `${share.bestResult}. ${share.regattaCount} regattas on record.`
    );
    expect(share.summary).not.toContain("2013");
    expect(share.summary).not.toContain("Born");
    expect(share.summary).not.toContain("August");
    expect(share.summary).not.toContain("Raffles");
    expect(share.summary).not.toContain("Dual-class");

    const jsonLd = profilePageJsonLd(share);
    expect(jsonLd["@type"]).toBe("ProfilePage");
    expect(jsonLd.mainEntity["@type"]).toBe("Person");
    expect(jsonLd.mainEntity).not.toHaveProperty("birthDate");
    const serialized = JSON.stringify(jsonLd);
    expect(serialized).not.toContain("2013");
    expect(serialized).not.toContain("birthDate");
    expect(serialized).not.toContain("Raffles");
    for (const key of [...PRIVATE_KEYS, "birthDate", "birthYear"]) {
      expect(keysDeep(jsonLd).has(key)).toBe(false);
    }
  });

  it("keeps a known birth year out of the description and JSON-LD", () => {
    const share = sailorShareModel({
      name: "Ada Lim",
      handle: "ada-lim",
      nationality: "SGP",
      club: "Changi Sailing Club",
      results: [
        {
          regattaName: "Harbour Regatta",
          regattaDate: "2014-02-02",
          boatClass: "Optimist",
          rank: 2,
          isDns: false,
        },
      ],
    });
    expect(share.summary).toBe("2nd in Optimist at Harbour Regatta. 1 regatta on record.");
    expect(share.summary).not.toContain("2014");
    expect(share.summary).not.toMatch(/born/i);
    const jsonLd = profilePageJsonLd(share);
    const serialized = JSON.stringify(jsonLd);
    expect(serialized).not.toContain("birthDate");
    expect(serialized).not.toContain("2014");
    expect(keysDeep(jsonLd).has("birthDate")).toBe(false);
    expect(keysDeep(jsonLd).has("birthYear")).toBe(false);
  });

  it("keeps a tied class when that class was sailed most recently", () => {
    const share = sailorShareModel({
      name: "Ada Lim",
      handle: "ada-lim",
      nationality: "MAS",
      results: [
        { regattaName: "Cup", regattaDate: "2024-01-01", boatClass: "Optimist", rank: 4, isDns: false },
        { regattaName: "Open", regattaDate: "2025-06-01", boatClass: "ILCA 4", rank: 2, isDns: false },
      ],
    });
    expect(share.boatClass).toBe("ILCA 4");
    expect(share.country).toBe("Malaysia");
    expect(share.title).toBe("Ada Lim – ILCA 4, Malaysia | SailorPath");
  });

  it("ignores DNS when choosing the best finish", () => {
    const share = sailorShareModel({
      name: "Ada Lim",
      handle: "ada-lim",
      results: [
        { regattaName: "Cup", boatClass: "Optimist", rank: 1, isDns: true },
        { regattaName: "Open", boatClass: "Optimist", rank: 3, isDns: false },
      ],
    });
    expect(share.bestResult).toBe("3rd in Optimist at Open");
  });

  it("names an SNSC fleet sheet without repeating the year", () => {
    const event = getRegattaEvent("snsc-2025");
    expect(event).toBeTruthy();
    const slice = event!.slices.find((item) => item.key === "optimist-gold");
    expect(slice).toBeTruthy();
    const sheet = resultSheetFromEventSlice(event!, slice!);
    expect(sheet.title).toBe(
      "Singapore National Sailing Championships 2025 – Optimist Gold results | SailorPath"
    );
    expect(sheet.description).toBe(
      "Published Optimist Gold results for Singapore National Sailing Championships 2025, 6–9 September 2025."
    );
    expect(sheet.canonicalPath).toBe("/regattas/snsc-2025/results/optimist-gold");
    expect(sheet.startDate).toBe("2025-09-06");
    expect(sheet.endDate).toBe("2025-09-09");
    const jsonLd = sportsEventJsonLd(sheet);
    expect(jsonLd["@type"]).toBe("SportsEvent");
    expect(jsonLd.sport).toBe("Sailing");
    expect(jsonLd.startDate).toBe("2025-09-06");
    for (const key of [...PRIVATE_KEYS, "birthDate", "birthYear"]) {
      expect(keysDeep(jsonLd).has(key)).toBe(false);
    }
  });

  it("adds the year when the regatta name does not already contain it", () => {
    expect(resultSheetTitle("NSC Cup", 2025, "ILCA 4")).toBe(
      "NSC Cup 2025 – ILCA 4 results | SailorPath"
    );
    expect(resultSheetTitle("NSC Cup 2025", 2025, "ILCA 4")).toBe(
      "NSC Cup 2025 – ILCA 4 results | SailorPath"
    );
    expect(eventHubTitle("Harbour Regatta", 2026)).toBe("Harbour Regatta 2026 – results | SailorPath");
  });

  it("omits JSON-LD dates when the prose is not a clean range", () => {
    expect(eventDatesFromText("early September")).toEqual({});
    const event = getRegattaEvent("snsc-2025")!;
    const slice = event.slices.find((item) => item.key === "optimist-gold")!;
    const sheet = resultSheetFromEventSlice({ ...event, datesText: "early September" }, slice);
    expect(sheet.startDate).toBeUndefined();
    expect(sheet.endDate).toBeUndefined();
    expect(sheet.description).toContain("early September");
    expect(sportsEventJsonLd(sheet).startDate).toBeUndefined();
  });

  it("puts only names and profile URLs on the podium", () => {
    const rows: Array<{
      rank: number;
      sailorName: string;
      handle: string;
      isDns: boolean;
      birthYear: number;
      school: string;
      dob: string;
    }> = [
      {
        rank: 1,
        sailorName: "DNS Sailor",
        handle: "dns-sailor",
        isDns: true,
        birthYear: 2012,
        school: "Hidden School",
        dob: "2012-01-01",
      },
      {
        rank: 2,
        sailorName: "Ada Lim",
        handle: "ada-lim",
        isDns: false,
        birthYear: 2013,
        school: "Raffles",
        dob: "2013-01-01",
      },
    ];
    const top3 = topFinishers(rows);
    expect(top3).toEqual([{ rank: 2, name: "Ada Lim", handle: "ada-lim" }]);
    const event = getRegattaEvent("snsc-2025")!;
    const slice = event.slices.find((item) => item.key === "optimist-gold")!;
    const jsonLd = sportsEventJsonLd(resultSheetFromEventSlice(event, slice, top3));
    const serialized = JSON.stringify(jsonLd);
    expect(serialized).toContain("Ada Lim");
    expect(serialized).toContain("https://sailorpath.com/sailors/ada-lim");
    expect(serialized).not.toContain("2013");
    expect(serialized).not.toContain("2012-01-01");
    expect(serialized).not.toContain("Raffles");
    expect(serialized).not.toContain("DNS Sailor");
    for (const key of [...PRIVATE_KEYS, "birthDate", "birthYear"]) {
      expect(keysDeep(jsonLd).has(key)).toBe(false);
    }
  });

  it("describes the site and its search box without personal data", () => {
    const jsonLd = organizationWebsiteJsonLd();
    expect(jsonLd["@graph"].map((node) => node["@type"])).toEqual(["Organization", "WebSite"]);
    expect(JSON.stringify(jsonLd)).toContain(
      "https://sailorpath.com/search?q={search_term_string}"
    );
    for (const key of PRIVATE_KEYS) expect(keysDeep(jsonLd).has(key)).toBe(false);
  });

  it("escapes angle brackets in JSON-LD", () => {
    expect(serializeJsonLd({ name: "</script><script>" })).toBe(
      '{"name":"\\u003c/script>\\u003cscript>"}'
    );
  });
});

describe("public sitemap paths", () => {
  it("lists public handles and skips hidden, reserved, and private logs", () => {
    expect(isIndexablePublicSailor({ handle: "ada-lim" })).toBe(true);
    expect(isIndexablePublicSailor({ handle: "ada-lim", hiddenFromSearch: true })).toBe(false);
    expect(isIndexablePublicSailor({ handle: "sample" })).toBe(false);
    expect(isIndexablePublicSailor({ handle: "admin" })).toBe(false);
    const entries = sailorSitemapEntries([
      { handle: "ada-lim" },
      { handle: "hidden-sailor", hiddenFromSearch: true },
      { handle: "sample" },
    ]);
    expect(entries.map((entry) => entry.url)).toEqual(["https://sailorpath.com/sailors/ada-lim"]);
  });

  it("lists event sheets and class sheets, and leaves personal logs and class hubs out", () => {
    const paths = publicResultSheetPaths([
      { slug: "log-kim", boatClass: "Optimist" },
      { slug: "harbour-ilca-open", boatClass: "ILCA 6" },
      { slug: "board-only", boatClass: "iQFOiL" },
      { slug: "snsc-gold-sep-25", boatClass: "Optimist" },
    ]);
    expect(paths).toContain("/regattas/snsc-2025/results/optimist-gold");
    expect(paths).toContain("/sg/ilca/regattas/harbour-ilca-open");
    expect(paths.some((path) => path.includes("log-"))).toBe(false);
    expect(paths).not.toContain("/sg/iqfoil");
    expect(paths).not.toContain("/sg/optimist/regattas/snsc-gold-sep-25");
    expect(paths).not.toContain("/classes/x-15");
    expect(paths).toContain(
      "/regattas/youth-thailand-national-sailing-championship-2026/results/optimist"
    );
  });

  it("lists the Asian and Oceania Optimist Index and skips the old redirect", () => {
    expect(HUB_SITEMAP_PATHS).toContain("/optimist/asian-index");
    expect(HUB_SITEMAP_PATHS).toContain("/optimist/asian-index/methodology");
    expect(HUB_SITEMAP_PATHS).not.toContain("/sg/optimist/asian-index");
  });
});
