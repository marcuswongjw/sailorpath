import { describe, expect, it } from "vitest";
import { sailorDbErrorHint } from "@/lib/seriesMembership";
import { SailorPatchSchema, sailorPatchTextValue } from "./sailor";

describe("sailor profile save", () => {
  it("keeps a blank club as an empty string", () => {
    expect(sailorPatchTextValue("club", "")).toBe("");
    expect(sailorPatchTextValue("club", "   ")).toBe("");
    expect(sailorPatchTextValue("club", null)).toBe("");
    expect(sailorPatchTextValue("club", "Constant Wind")).toBe("Constant Wind");
  });

  it("keeps required text columns when they are blank and clears optional ones", () => {
    expect(sailorPatchTextValue("name", "Mason Qifeng Lau")).toBe(
      "Mason Qifeng Lau"
    );
    expect(sailorPatchTextValue("handle", "mason-qifeng-lau-04b538")).toBe(
      "mason-qifeng-lau-04b538"
    );
    expect(sailorPatchTextValue("sailNumber", "")).toBe("");
    expect(sailorPatchTextValue("school", "")).toBeNull();
    expect(sailorPatchTextValue("gender", "")).toBeNull();
    expect(sailorPatchTextValue("bio", "")).toBeNull();
  });

  it("parses a profile with a name, a board number, and blank optional fields", () => {
    const parsed = SailorPatchSchema.parse({
      id: "mason",
      name: "Mason Qifeng Lau",
      handle: "mason-qifeng-lau-04b538",
      sailNumber: "",
      sailNumberIlca4: null,
      boardNumber: "8",
      club: "",
      school: null,
      nationality: null,
      gender: "M",
      weight: null,
      dob: null,
      histRankingJun24: null,
      histRankingDec24: null,
      histRankingJun25: null,
      histRankingDec25: null,
      histRankingJun26: null,
      natSquadStatusJan25: null,
      natSquadStatusJul25: null,
      natSquadStatusJan26: null,
      natSquadStatusJul26: null,
      natSquadStatusJan27: null,
      natSquadStatusJul27: null,
    });

    expect(parsed.club).toBe("");
    expect(sailorPatchTextValue("club", parsed.club)).toBe("");
    expect(parsed.sailNumber).toBe("");
    expect(parsed.boardNumber).toBe("8");
    expect(parsed.weight).toBeNull();
    expect(parsed.histRankingJun24).toBeNull();
    expect(parsed.histRankingJun26).toBeNull();
    expect(parsed.school).toBeNull();
    expect(parsed.nationality).toBeNull();
  });

  it("keeps a typed weight and leaves an omitted weight unset", () => {
    expect(SailorPatchSchema.parse({ id: "a", weight: "" }).weight).toBeNull();
    expect(SailorPatchSchema.parse({ id: "a", weight: "54" }).weight).toBe(54);
    expect(SailorPatchSchema.parse({ id: "a", weight: 54 }).weight).toBe(54);
    const omitted = SailorPatchSchema.parse({ id: "a", name: "A" });
    expect(omitted.weight).toBeUndefined();
    expect(omitted.histRankingJun24).toBeUndefined();
    expect(omitted.club).toBe("N/A");
  });

  it("names the column when Postgres rejects a null", () => {
    const err = new Error(
      'Failed query: update "sailors" set "school" = $1, "nationality_from_sail" = $2'
    );
    (err as Error & { cause?: unknown }).cause = new Error(
      'null value in column "club" of relation "sailors" violates not-null constraint'
    );
    expect(sailorDbErrorHint(err)).toBe(
      "Could not save: club cannot be empty."
    );
  });

  it("shows the database reason when the query text is too long to read", () => {
    const err = new Error(
      'Failed query: update "sailors" set "name" = $1, "handle" = $2'
    );
    (err as Error & { cause?: unknown }).cause = new Error(
      'new row for relation "sailors" violates check constraint "sailors_sail_number_check"'
    );
    expect(sailorDbErrorHint(err)).toBe(
      'new row for relation "sailors" violates check constraint "sailors_sail_number_check"'
    );
  });
});
