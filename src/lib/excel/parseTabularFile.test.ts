import { describe, expect, it } from "vitest";
import { parseCsv, tableRowsToRecords } from "./parseTabularFile";

describe("parseCsv", () => {
  it("parses quoted commas and escaped quotes", () => {
    expect(
      parseCsv(
        'Rank,Name,Club\r\n1,"Tan, Alex","The ""Fast"" Club"\r\n'
      )
    ).toEqual([
      ["Rank", "Name", "Club"],
      ["1", "Tan, Alex", 'The "Fast" Club'],
    ]);
  });

  it("keeps multiline quoted fields and blank rows", () => {
    expect(parseCsv('Name,Note\n"Lee","Line 1\nLine 2"\n\n')).toEqual([
      ["Name", "Note"],
      ["Lee", "Line 1\nLine 2"],
      [""],
    ]);
  });

  it("rejects an unterminated quoted field", () => {
    expect(() => parseCsv('Name\n"Lee')).toThrow(
      "Invalid CSV: unterminated quoted field."
    );
  });
});

describe("tableRowsToRecords", () => {
  it("skips blank headers and rows while converting header cells to records", () => {
    const records = tableRowsToRecords([
      ["", "  "],
      ["Rank", "", "Name", "Club"],
      ["1", "ignored", "Tan, Alex", "SAFYC"],
      ["", "", "", ""],
      ["2", "ignored", "Lee", ""],
    ]);

    expect(records).toEqual([
      { Rank: "1", Name: "Tan, Alex", Club: "SAFYC" },
      { Rank: "2", Name: "Lee", Club: "" },
    ]);
    expect(Object.getPrototypeOf(records[0])).toBeNull();
  });

  it("ignores duplicate and prototype-pollution headers", () => {
    const [record] = tableRowsToRecords([
      ["Name", "Name", "__proto__", "constructor", "prototype", "Rank"],
      ["Safe", "Duplicate", "polluted", "polluted", "polluted", "1"],
    ]);

    expect(record).toEqual({ Name: "Safe", Rank: "1" });
    expect(Object.keys(record)).toEqual(["Name", "Rank"]);
    expect(Object.getPrototypeOf(record)).toBeNull();
    expect(({} as Record<string, unknown>).polluted).toBeUndefined();
  });
});
