import { describe, expect, it } from "vitest";
import {
  isOnIlca4NationalListByName,
  isSailorOnIlca4NationalList,
  isSingaporeNationality,
  ILCA4_NATIONAL_RANKING_NAMES,
} from "./ilca4NationalList";

describe("isOnIlca4NationalListByName", () => {
  it("matches list size", () => {
    expect(ILCA4_NATIONAL_RANKING_NAMES.length).toBeGreaterThan(50);
  });

  it("matches Last, First and reordered names", () => {
    expect(isOnIlca4NationalListByName("Goh, Ian")).toBe(true);
    expect(isOnIlca4NationalListByName("Ian Goh")).toBe(true);
    expect(isOnIlca4NationalListByName("Lee, Desiree Yuet Chi")).toBe(true);
    expect(isOnIlca4NationalListByName("Desiree Yuet Chi Lee")).toBe(true);
  });

  it("rejects unknown sailors", () => {
    expect(isOnIlca4NationalListByName("Not On List")).toBe(false);
  });
});

describe("isSailorOnIlca4NationalList", () => {
  it("prefers explicit DB flag", () => {
    expect(
      isSailorOnIlca4NationalList({
        name: "Not On List",
        ilca4NationalList: true,
      })
    ).toBe(true);
    expect(
      isSailorOnIlca4NationalList({
        name: "Goh, Ian",
        ilca4NationalList: false,
      })
    ).toBe(false);
  });

  it("falls back to seed name when flag unset", () => {
    expect(
      isSailorOnIlca4NationalList({
        name: "Goh, Ian",
        ilca4NationalList: null,
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
    expect(isSingaporeNationality("")).toBe(false);
  });
});
