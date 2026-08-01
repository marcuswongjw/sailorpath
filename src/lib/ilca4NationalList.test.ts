import { describe, expect, it } from "vitest";
import {
  isOnIlca4NationalList,
  isSingaporeNationality,
  ILCA4_NATIONAL_RANKING_NAMES,
} from "./ilca4NationalList";

describe("isOnIlca4NationalList", () => {
  it("matches list size", () => {
    expect(ILCA4_NATIONAL_RANKING_NAMES.length).toBeGreaterThan(50);
  });

  it("matches Last, First and reordered names", () => {
    expect(isOnIlca4NationalList("Goh, Ian")).toBe(true);
    expect(isOnIlca4NationalList("Ian Goh")).toBe(true);
    expect(isOnIlca4NationalList("Lee, Desiree Yuet Chi")).toBe(true);
    expect(isOnIlca4NationalList("Desiree Yuet Chi Lee")).toBe(true);
  });

  it("rejects unknown sailors", () => {
    expect(isOnIlca4NationalList("Not On List")).toBe(false);
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
