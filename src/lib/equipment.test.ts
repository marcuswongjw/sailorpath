import { describe, expect, it } from "vitest";
import {
  evaluateEquipmentAttention,
  parseTags,
  serializeTags,
  displayName,
} from "./equipment";

describe("equipment helpers", () => {
  it("parses and serializes tags", () => {
    expect(parseTags("racing,training")).toEqual(["racing", "training"]);
    expect(serializeTags(["racing", "nope" as never])).toBe("racing");
  });

  it("displayName prefers label", () => {
    expect(displayName({ label: "Race", brand: "North", category: "sail" })).toBe(
      "Race"
    );
    expect(displayName({ brand: "North", model: "3DL", category: "sail" })).toBe(
      "North 3DL"
    );
  });

  it("flags worn sails and high use", () => {
    expect(
      evaluateEquipmentAttention({
        category: "sail",
        status: "active",
        condition: "worn",
        useCount: 2,
      }).needsAttention
    ).toBe(true);

    expect(
      evaluateEquipmentAttention({
        category: "sail",
        status: "active",
        condition: "good",
        useCount: 15,
      }).needsAttention
    ).toBe(true);

    expect(
      evaluateEquipmentAttention({
        category: "sail",
        status: "active",
        condition: "good",
        useCount: 3,
        acquiredOn: "2026-07-01",
      }).needsAttention
    ).toBe(false);
  });
});
