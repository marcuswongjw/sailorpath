import { describe, expect, it } from "vitest";
import {
  isOnIlca6NationalListByName,
  isSailorOnIlca6NationalList,
  isSingaporeNationality,
  ILCA6_NATIONAL_RANKING_NAMES,
} from "./ilca6NationalList";

describe("isOnIlca6NationalListByName", () => {
  it("matches list size", () => {
    expect(ILCA6_NATIONAL_RANKING_NAMES.length).toBe(29);
  });

  it("matches Last, First and reordered names", () => {
    expect(isOnIlca6NationalListByName("Tan, Kenan Kee Zen")).toBe(true);
    expect(isOnIlca6NationalListByName("Kenan Kee Zen Tan")).toBe(true);
    expect(isOnIlca6NationalListByName("Carlyle, Keira")).toBe(true);
    expect(isOnIlca6NationalListByName("Keira Carlyle")).toBe(true);
    expect(isOnIlca6NationalListByName("van Riel, Lucien Franciscus Henricus")).toBe(true);
    expect(isOnIlca6NationalListByName("Lucien Franciscus Henricus van Riel")).toBe(true);
  });

  it("rejects unknown sailors", () => {
    expect(isOnIlca6NationalListByName("Not On List")).toBe(false);
  });
});

describe("isSailorOnIlca6NationalList", () => {
  it("prefers explicit DB flag", () => {
    expect(
      isSailorOnIlca6NationalList({
        name: "Not On List",
        ilca6NationalList: true,
      })
    ).toBe(true);
    expect(
      isSailorOnIlca6NationalList({
        name: "Tan, Kenan Kee Zen",
        ilca6NationalList: false,
      })
    ).toBe(false);
  });

  it("falls back to seed name when flag unset", () => {
    expect(
      isSailorOnIlca6NationalList({
        name: "Tan, Kenan Kee Zen",
        ilca6NationalList: null,
      })
    ).toBe(true);
  });
});

describe("isSingaporeNationality", () => {
  it("accepts SGP variants", () => {
    expect(isSingaporeNationality("SGP")).toBe(true);
    expect(isSingaporeNationality("Singapore")).toBe(true);
    expect(isSingaporeNationality("SG")).toBe(true);
  });

  it("rejects others", () => {
    expect(isSingaporeNationality("THA")).toBe(false);
    expect(isSingaporeNationality(null)).toBe(false);
  });
});
