import { describe, expect, it } from "vitest";
import { pickCol } from "./pickCol";

describe("pickCol", () => {
  it("does not match 'Sailor' when looking for sail number aliases containing 'sail'", () => {
    const row = {
      Sailor: "John Tan",
      Club: "Changi Sailing Club",
    };
    const sailAliases = [
      "sailnumber",
      "sail number",
      "sail",
      "sail#",
      "sail no",
      "sail no.",
    ];
    expect(pickCol(row, sailAliases)).toBeNull();
  });

  it("does not match 'Weight' when looking for instagram alias 'ig'", () => {
    const row = {
      Sailor: "Jane Doe",
      Weight: 45,
    };
    const igAliases = ["instagram", "ig"];
    expect(pickCol(row, igAliases)).toBeNull();
  });

  it("matches 'Sail No.' and 'Sail Number' correctly", () => {
    const row1 = { "Sail No.": "SGP 1234" };
    const row2 = { "Sail Number": "SGP 5678" };
    const row3 = { "Official Sail #": "SGP 9999" };
    const sailAliases = [
      "sailnumber",
      "sail number",
      "sail",
      "sail#",
      "sail no",
      "sail no.",
    ];
    expect(pickCol(row1, sailAliases)).toBe("SGP 1234");
    expect(pickCol(row2, sailAliases)).toBe("SGP 5678");
    expect(pickCol(row3, sailAliases)).toBe("SGP 9999");
  });

  it("matches 'IG Handle' and 'Instagram' correctly", () => {
    const row1 = { "IG Handle": "@sailor_sg" };
    const row2 = { Instagram: "@sailor_champ" };
    const igAliases = ["instagram", "ig"];
    expect(pickCol(row1, igAliases)).toBe("@sailor_sg");
    expect(pickCol(row2, igAliases)).toBe("@sailor_champ");
  });

  it("does not match 'Semester' when looking for gender alias 'sex'", () => {
    const row = { Semester: "Fall 2026" };
    expect(pickCol(row, ["gender", "sex"])).toBeNull();
  });
});
