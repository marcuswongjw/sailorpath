import { describe, expect, it } from "vitest";
import {
  currentHalfStartYmd,
  fleetTagSaveValues,
  ilca6TagChecked,
  isSgOptimistTagged,
  optimistDivisionOf,
  setOptimistDivision,
  setSgOptimistTag,
} from "./fleetTags";

const TODAY = "2026-10-01";

describe("fleet tags", () => {
  it("treats legacy Gold and Silver fleet strings as SG Optimist", () => {
    expect(isSgOptimistTagged("Series")).toBe(true);
    expect(isSgOptimistTagged("Gold")).toBe(true);
    expect(isSgOptimistTagged("silver")).toBe(true);
    expect(isSgOptimistTagged("Guest")).toBe(false);
    expect(isSgOptimistTagged("")).toBe(false);
  });

  it("uses the half start that contains today", () => {
    expect(currentHalfStartYmd("2026-10-01")).toBe("2026-07-01");
    expect(currentHalfStartYmd("2026-03-15")).toBe("2026-01-01");
  });

  it("tags SG Optimist as Silver and stamps silver entry when dates are empty", () => {
    const next = setSgOptimistTag(
      { currentFleet: "Guest", goldEntryDate: "", silverEntryDate: "" },
      true,
      TODAY
    );
    expect(next.currentFleet).toBe("Series");
    expect(next.silverEntryDate).toBe(TODAY);
    expect(next.goldEntryDate).toBe("");
    expect(optimistDivisionOf(next)).toBe("silver");
  });

  it("keeps entry dates when SG Optimist is unchecked", () => {
    const next = setSgOptimistTag(
      {
        currentFleet: "Series",
        goldEntryDate: "2024-01-01",
        silverEntryDate: "2023-06-01",
      },
      false,
      TODAY
    );
    expect(next.currentFleet).toBe("Guest");
    expect(next.goldEntryDate).toBe("2024-01-01");
    expect(next.silverEntryDate).toBe("2023-06-01");
  });

  it("sets Gold on the current half boundary and keeps silver history", () => {
    const next = setOptimistDivision(
      { currentFleet: "Series", goldEntryDate: "", silverEntryDate: "2024-02-01" },
      "gold",
      TODAY
    );
    expect(next.currentFleet).toBe("Series");
    expect(next.goldEntryDate).toBe("2026-07-01");
    expect(next.silverEntryDate).toBe("2024-02-01");
    expect(optimistDivisionOf(next)).toBe("gold");
  });

  it("fills silver history when promoting to Gold with no dates", () => {
    const next = setOptimistDivision(
      { currentFleet: "Guest", goldEntryDate: "", silverEntryDate: "" },
      "gold",
      TODAY
    );
    expect(next.goldEntryDate).toBe("2026-07-01");
    expect(next.silverEntryDate).toBe("2026-07-01");
  });

  it("clears gold entry when switching to Silver", () => {
    const next = setOptimistDivision(
      {
        currentFleet: "Series",
        goldEntryDate: "2024-01-01",
        silverEntryDate: "2023-01-01",
      },
      "silver",
      TODAY
    );
    expect(next.goldEntryDate).toBe("");
    expect(next.silverEntryDate).toBe("2023-01-01");
    expect(optimistDivisionOf(next)).toBe("silver");
  });

  it("shows ILCA 6 from the name seed only while the flag is unset", () => {
    expect(ilca6TagChecked(null, "Tan, Kenan Kee Zen")).toBe(true);
    expect(ilca6TagChecked(undefined, "Kenan Kee Zen Tan")).toBe(true);
    expect(ilca6TagChecked(null, "Ian Goh")).toBe(false);
    expect(ilca6TagChecked(false, "Tan, Kenan Kee Zen")).toBe(false);
    expect(ilca6TagChecked(true, "Ian Goh")).toBe(true);
  });

  it("saves an explicit ILCA 6 boolean and Optimist membership", () => {
    expect(
      fleetTagSaveValues({
        name: "Tan, Kenan Kee Zen",
        currentFleet: "Gold",
        ilca4NationalList: true,
        ilca6NationalList: null,
      })
    ).toEqual({
      currentFleet: "Series",
      ilca4NationalList: true,
      ilca6NationalList: true,
    });
    expect(
      fleetTagSaveValues({
        name: "Ian Goh",
        currentFleet: "Guest",
        ilca6NationalList: false,
      })
    ).toEqual({
      currentFleet: "Guest",
      ilca4NationalList: false,
      ilca6NationalList: false,
    });
  });
});
