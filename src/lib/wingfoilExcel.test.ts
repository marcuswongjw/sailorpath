import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  readExcelInWorker: vi.fn(),
}));

vi.mock("./excel/readExcelInWorker", () => ({
  readExcelInWorker: mocks.readExcelInWorker,
}));

import { readWingfoilExcel } from "./wingfoilExcel";

describe("readWingfoilExcel", () => {
  beforeEach(() => {
    mocks.readExcelInWorker.mockReset();
  });

  it("parses Sailwave CSV exports without SheetJS", async () => {
    const file = new File(
      [
        "Wingfoil Test,2026-09-10,Sailed: 2,Discards: 0\n" +
          "Pos,HelmName,SailNo,Club,Division,R1,R2,Total,Nett\n" +
          "1,Alice Example,SGP 7,Test Club,Open,1,2,3,3\n",
      ],
      "wingfoil-results.csv",
      { type: "text/csv" }
    );

    const result = await readWingfoilExcel(file);

    expect(result.regattaName).toBe("Wingfoil Test");
    expect(result.startDate).toBe("2026-09-10");
    expect(result.results).toHaveLength(1);
    expect(result.results[0]).toMatchObject({
      name: "Alice Example",
      sailNumber: "SGP 7",
      grossScore: 3,
      nettScore: 3,
    });
  });

  it("routes XLSX parsing through the isolated safe reader", async () => {
    mocks.readExcelInWorker.mockResolvedValueOnce([
      {
        sheet: "Results",
        data: [
          ["Wingfoil Worker Test", "2026-09-11", "Sailed: 2", "Discards: 0"],
          ["Pos", "HelmName", "SailNo", "R1", "R2", "Total", "Nett"],
          [1, "Bob Example", "8", 2, 1, 3, 3],
        ],
      },
    ]);
    const file = new File([new Uint8Array([0x50, 0x4b])], "results.xlsx");

    const result = await readWingfoilExcel(file);

    expect(mocks.readExcelInWorker).toHaveBeenCalledOnce();
    expect(result.regattaName).toBe("Wingfoil Worker Test");
    expect(result.results[0]).toMatchObject({
      name: "Bob Example",
      grossScore: 3,
      nettScore: 3,
    });
  });

  it("rejects legacy binary XLS files with migration guidance", async () => {
    const file = new File([new Uint8Array([0xd0, 0xcf, 0x11, 0xe0])], "legacy.xls");

    await expect(readWingfoilExcel(file)).rejects.toThrow(
      "Save the workbook as .xlsx or export it as CSV"
    );
  });

  it("preserves fractional redress scores", async () => {
    const file = new File(
      [
        "Wingfoil Redress,2026-09-12,Sailed: 2,Discards: 0\n" +
          "Pos,HelmName,SailNo,R1,R2,Total,Nett\n" +
          "1,Alice Example,7,1.5,2 RDG,3.5,3.5\n",
      ],
      "redress.csv"
    );

    const result = await readWingfoilExcel(file);

    expect(result.results[0].races).toEqual([
      expect.objectContaining({ score: 1.5 }),
      expect.objectContaining({ score: 2, code: "RDG" }),
    ]);
    expect(result.results[0].grossScore).toBe(3.5);
  });

  it("requires an event date instead of silently using today", async () => {
    const file = new File(
      [
        "Wingfoil Undated,Sailed: 1,Discards: 0\n" +
          "Pos,HelmName,SailNo,R1,Total,Nett\n" +
          "1,Alice Example,7,1,1,1\n",
      ],
      "undated.csv"
    );

    await expect(readWingfoilExcel(file)).rejects.toThrow(
      "Could not determine the event date"
    );
  });
});
