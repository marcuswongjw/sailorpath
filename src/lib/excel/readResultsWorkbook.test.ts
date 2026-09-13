import { describe, expect, it } from "vitest";
import { readResultsWorkbook } from "./readResultsWorkbook";

describe("results workbook detection", () => {
  it("finds a table below a title after a cover worksheet", () => {
    const [parsed] = readResultsWorkbook([
      { sheet: "Cover", data: [["Instructions"]] },
      { sheet: "Gold", data: [["Harbour Cup"], [], ["Rank", "Name", "R1", "Nett"], [1, "Alice", 2, 2]] },
    ]);
    expect(parsed.sheetName).toBe("Gold");
    expect(parsed.rows[0]).toMatchObject({ name: "Alice", rank: 1, nett: 2 });
  });
  it("retains every results sheet for explicit selection", () => {
    expect(readResultsWorkbook(["Gold", "Silver"].map((sheet) => ({ sheet, data: [["Name", "Rank"], [sheet, 1]] })))).toHaveLength(2);
  });
  it("preserves typed dates and comma-separated CSV scores", () => {
    const [parsed] = readResultsWorkbook([{ sheet: "Results", data: [["Name", "Rank", "DOB", "Net"], ["Alice", "1,234", new Date("2013-03-02T00:00:00Z"), "1,345.5"]] }]);
    expect(parsed.rows[0]).toMatchObject({ rank: 1234, dob: "2013-03-02", nett: 1345.5 });
  });
  it("counts actual race columns when race numbers have gaps", () => {
    const [parsed] = readResultsWorkbook([{ sheet: "Results", data: [["Name", "Rank", "R1", "R3"], ["Alice", 1, 2, 3]] }]);
    expect(parsed.raceCount).toBe(2);
  });
  it("reports code-only penalties rather than silently deleting them", () => {
    expect(() => readResultsWorkbook([{ sheet: "Results", data: [["Name", "Rank", "R1"], ["Alice", 1, "DNS"]] }])).toThrow("without points");
  });
  it("rejects files without a results header", () => {
    expect(() => readResultsWorkbook([{ sheet: "Cover", data: [["Instructions"]] }])).toThrow("No results table found");
  });
});
