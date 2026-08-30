import { describe, expect, it } from "vitest";
import { tesseractTsvToPdfPage } from "./ocrRegattaPdf";

describe("tesseractTsvToPdfPage", () => {
  it("keeps words on one OCR line at the same parser coordinate", () => {
    const tsv = [
      "level\tpage_num\tblock_num\tpar_num\tline_num\tword_num\tleft\ttop\twidth\theight\tconf\ttext",
      "5\t1\t1\t1\t1\t1\t10\t20\t30\t10\t95\tRank",
      "5\t1\t1\t1\t1\t2\t60\t21\t40\t12\t92\tName",
      "5\t1\t1\t1\t2\t1\t10\t50\t10\t10\t99\t1",
    ].join("\n");

    const page = tesseractTsvToPdfPage(tsv, 2, 100);

    expect(page.pageNumber).toBe(2);
    expect(page.items).toEqual([
      { str: "Rank", x: 10, y: 75 },
      { str: "Name", x: 60, y: 75 },
      { str: "1", x: 10, y: 45 },
    ]);
  });

  it("drops blank and very low confidence words", () => {
    const tsv = [
      "level\tpage_num\tblock_num\tpar_num\tline_num\tword_num\tleft\ttop\twidth\theight\tconf\ttext",
      "5\t1\t1\t1\t1\t1\t10\t20\t30\t10\t-1\tNoise",
      "5\t1\t1\t1\t1\t2\t60\t20\t40\t10\t92\tNett",
    ].join("\n");

    expect(tesseractTsvToPdfPage(tsv, 1, 100).items).toEqual([
      { str: "Nett", x: 60, y: 75 },
    ]);
  });

  it("splits race scores that OCR merged across adjacent cells", () => {
    const tsv = [
      "level\tpage_num\tblock_num\tpar_num\tline_num\tword_num\tleft\ttop\twidth\theight\tconf\ttext",
      "5\t1\t1\t1\t1\t1\t100\t20\t80\t10\t80\t(19.0)/12.0",
      "5\t1\t1\t1\t1\t2\t200\t20\t80\t10\t80\t500.0450.0",
    ].join("\n");

    const page = tesseractTsvToPdfPage(tsv, 1, 100);
    expect(page.items.map((item) => item.str)).toEqual([
      "(19.0)",
      "12.0",
      "500.0",
      "450.0",
    ]);
    expect(page.items[1].x).toBeGreaterThan(page.items[0].x);
    expect(page.items[3].x).toBeGreaterThan(page.items[2].x);
  });
});
