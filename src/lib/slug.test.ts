import { describe, it, expect } from "vitest";
import { slugify, slugifyWithDate } from "./slug";

describe("slugify", () => {
  it("formats Cincapura 2026 (ILCA 4) as cincapura-2026-ilca4", () => {
    expect(slugify("Cincapura 2026 (ILCA 4)")).toBe("cincapura-2026-ilca4");
  });

  it("formats other ILCA classes correctly", () => {
    expect(slugify("Cincapura 2026 (ILCA 6)")).toBe("cincapura-2026-ilca6");
    expect(slugify("Cincapura 2026 (ILCA 7)")).toBe("cincapura-2026-ilca7");
    expect(slugify("ILCA 4 National Ranking")).toBe("ilca4-national-ranking");
  });

  it("formats windsurfing and skiff classes correctly", () => {
    expect(slugify("Cincapura 2026 (Techno 293)")).toBe("cincapura-2026-techno293");
    expect(slugify("Cincapura 2026 (Techno 293+)")).toBe("cincapura-2026-techno293");
    expect(slugify("Cincapura 2026 (29er)")).toBe("cincapura-2026-29er");
    expect(slugify("Cincapura 2026 (iQFOiL)")).toBe("cincapura-2026-iqfoil");
  });

  it("formats optimist fleets correctly", () => {
    expect(slugify("Cincapura 2026 (Optimist Gold)")).toBe("cincapura-2026-optimist-gold");
    expect(slugify("Cincapura 2026 (Optimist Silver)")).toBe("cincapura-2026-optimist-silver");
  });

  it("handles standard text and names without mangling", () => {
    expect(slugify("Singapore National Sailing Championships 2026")).toBe(
      "singapore-national-sailing-championships-2026"
    );
    expect(slugify("John Doe")).toBe("john-doe");
    expect(slugify("")).toBe("");
  });
});

describe("slugifyWithDate", () => {
  it("appends date when provided", () => {
    expect(slugifyWithDate("Event Name", "2026-05-01")).toBe("event-name-2026-05-01");
  });

  it("returns base slug when date is omitted", () => {
    expect(slugifyWithDate("Event Name")).toBe("event-name");
  });
});
