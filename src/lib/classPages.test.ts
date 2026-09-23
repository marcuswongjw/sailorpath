import { describe, expect, it } from "vitest";
import {
  dinghyClassForBoatClass,
  regattaResultsHref,
} from "./classPages";

describe("dinghyClassForBoatClass", () => {
  it("recognises ILCA 6, ILCA 7, and 29er labels", () => {
    expect(dinghyClassForBoatClass("ILCA 6")?.key).toBe("ilca6");
    expect(dinghyClassForBoatClass("ilca-6")?.key).toBe("ilca6");
    expect(dinghyClassForBoatClass("Laser Radial")?.key).toBe("ilca6");
    expect(dinghyClassForBoatClass("ILCA 7")?.key).toBe("ilca7");
    expect(dinghyClassForBoatClass("Laser Standard")?.key).toBe("ilca7");
    expect(dinghyClassForBoatClass("29er")?.key).toBe("29er");
  });

  it("leaves Optimist, ILCA 4, and other classes alone", () => {
    expect(dinghyClassForBoatClass("ILCA 4")).toBeNull();
    expect(dinghyClassForBoatClass("Optimist")).toBeNull();
    expect(dinghyClassForBoatClass("49er")).toBeNull();
    expect(dinghyClassForBoatClass("")).toBeNull();
  });
});

describe("regattaResultsHref", () => {
  it("points each class at its own results page", () => {
    expect(regattaResultsHref("ILCA 6", "snsc-ilca-6-sep-26")).toBe(
      "/sg/ilca6/regattas/snsc-ilca-6-sep-26"
    );
    expect(regattaResultsHref("ILCA 7", "snsc-ilca-7-sep-26")).toBe(
      "/sg/ilca7/regattas/snsc-ilca-7-sep-26"
    );
    expect(regattaResultsHref("29er", "snsc-29er-sep-26")).toBe(
      "/sg/29er/regattas/snsc-29er-sep-26"
    );
    expect(regattaResultsHref("ILCA 4", "snsc-ilca-4-sep-26")).toBe(
      "/sg/ilca4/regattas/snsc-ilca-4-sep-26"
    );
    expect(regattaResultsHref("Optimist", "snsc-gold-sep-26")).toBe(
      "/sg/optimist/regattas/snsc-gold-sep-26"
    );
  });
});
