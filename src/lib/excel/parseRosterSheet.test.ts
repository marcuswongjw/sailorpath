import { describe, expect, it } from "vitest";
import { parseRosterRows } from "./parseRosterSheet";

describe("roster birth date parsing", () => {
  it("does not turn a numeric birth year into a 1905 Excel date", () => {
    const rows = parseRosterRows([
      { Name: "Year only", Born: 2010 },
      { Name: "Text year", Born: "2013" },
      { Name: "Full date", DOB: "23/03/2010" },
      { Name: "Serial date", DOB: 40260 },
    ]);
    expect(rows.map((row) => row.dob)).toEqual(["2010-01-01", "2013-01-01", "2010-03-23", "2010-03-23"]);
  });
});
