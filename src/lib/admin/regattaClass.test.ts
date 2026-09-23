import { describe, expect, it } from "vitest";
import {
  ilcaFleetOf,
  regattaClassFamily,
  regattaMatchesAdminClass,
} from "./regattaClass";

describe("admin regatta classes", () => {
  it("keeps ILCA 4, 6, and 7 inside ILCA", () => {
    expect(regattaClassFamily("ILCA 4")).toBe("ilca");
    expect(regattaClassFamily("ILCA 6")).toBe("ilca");
    expect(regattaClassFamily("Laser Radial")).toBe("ilca");
    expect(regattaClassFamily("ILCA 7")).toBe("ilca");
    expect(ilcaFleetOf("ILCA 4")).toBe("ILCA 4");
    expect(ilcaFleetOf("ilca-6")).toBe("ILCA 6");
    expect(ilcaFleetOf("ILCA 7")).toBe("ILCA 7");
    expect(ilcaFleetOf("ILCA")).toBe("ILCA 4");
  });

  it("keeps Optimist Gold and Silver as fleets, and 29er separate", () => {
    expect(regattaClassFamily("Optimist")).toBe("optimist");
    expect(regattaClassFamily("29er")).toBe("29er");
    expect(
      regattaMatchesAdminClass({
        boatClass: "Optimist",
        division: "Silver",
        family: "optimist",
        fleet: "Silver",
      })
    ).toBe(true);
    expect(
      regattaMatchesAdminClass({
        boatClass: "ILCA 6",
        division: "Open",
        family: "ilca",
        fleet: "ILCA 6",
      })
    ).toBe(true);
    expect(
      regattaMatchesAdminClass({
        boatClass: "ILCA 4",
        division: "Open",
        family: "ilca",
        fleet: "ILCA 7",
      })
    ).toBe(false);
  });
});
