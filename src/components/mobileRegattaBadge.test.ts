import { describe, expect, it } from "vitest";
import { mobileRegattaBadge } from "./FleetRankingsView";

describe("mobileRegattaBadge", () => {
  it("formats well-known Singapore clubs and regattas cleanly", () => {
    expect(mobileRegattaBadge("Changi Sailing Club Regatta", 0)).toBe("CSC");
    expect(mobileRegattaBadge("CSC Optimist Championship", 0)).toBe("CSC");
    expect(mobileRegattaBadge("SAF Yacht Club Dinghy Open", 1)).toBe("SAFYC");
    expect(mobileRegattaBadge("SAFYC Regatta 2025", 1)).toBe("SAFYC");
    expect(mobileRegattaBadge("Pesta Sukan 2025", 2)).toBe("Pesta");
    expect(mobileRegattaBadge("Singapore National Sailing Championships", 3)).toBe("SNSC");
    expect(mobileRegattaBadge("SNSC 2025", 3)).toBe("SNSC");
    expect(mobileRegattaBadge("Singapore Youth Sailing Championship", 4)).toBe("SYSC");
    expect(mobileRegattaBadge("Raffles Marina Optimist", 0)).toBe("RM");
  });

  it("handles fallbacks and empty names", () => {
    expect(mobileRegattaBadge("", 2)).toBe("R3");
    expect(mobileRegattaBadge(null, 4)).toBe("R5");
    expect(mobileRegattaBadge("Eastern Regatta", 0)).toBe("Eastern");
  });
});
