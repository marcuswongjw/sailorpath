import { describe, expect, it } from "vitest";
import {
  OPTIMIST_SAILOR_SAIL_NUMBERS,
  getOptimistSailNumber,
  getOptimistNationality,
  cleanOptimistSailorName,
} from "./optimistSailNumberMap";

describe("optimistSailNumberMap", () => {
  it("contains all 134 extracted Optimist sailors", () => {
    expect(OPTIMIST_SAILOR_SAIL_NUMBERS).toHaveLength(134);
  });

  it("retrieves sail number and nationality accurately", () => {
    expect(getOptimistSailNumber("Muhammad Rehan Bin Mohamed Salim")).toBe("2059");
    expect(getOptimistNationality("Muhammad Rehan Bin Mohamed Salim")).toBe("SGP");

    expect(getOptimistSailNumber("Moyan Han")).toBe("2042");
    expect(getOptimistSailNumber("Bryan Thian Tsek Lee")).toBe("3508");
    expect(getOptimistSailNumber("Axel Lin")).toBe("720");
    expect(getOptimistSailNumber("Nadia Zahedi")).toBe("4724");
    expect(getOptimistSailNumber("Xiang Yu Du")).toBe("3761");
    expect(getOptimistNationality("Xiang Yu Du")).toBe("CHN");

    expect(getOptimistSailNumber("Dylan Yue Teng Goh")).toBe("3800");
    expect(getOptimistSailNumber("Charlene Heng Ning Yong")).toBe("766");
  });

  it("handles case insensitivity, extra whitespace, and trailing periods", () => {
    expect(getOptimistSailNumber("neel paul behl.")).toBe("88");
    expect(getOptimistSailNumber("Neel Paul Behl")).toBe("88");
    expect(getOptimistSailNumber("  MOYAN   HAN  ")).toBe("2042");
  });
});
