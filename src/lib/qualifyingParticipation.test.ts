import { describe, expect, it } from "vitest";
import { qualifyingParticipation } from "./qualifyingParticipation";

describe("qualifying participation", () => {
  it("uses the shared qualifying entry count for both Eastern Seaboard final fleets", () => {
    expect(qualifyingParticipation("eastern-seaboard-regatta-2026-optimist-gold")).toBe(135);
    expect(qualifyingParticipation("eastern-seaboard-regatta-2026-optimist-silver")).toBe(135);
  });

  it("does not combine independently entered fleets or unknown regattas", () => {
    expect(qualifyingParticipation("pesta-sukan-2026-silver")).toBeNull();
    expect(qualifyingParticipation(undefined)).toBeNull();
  });
});
