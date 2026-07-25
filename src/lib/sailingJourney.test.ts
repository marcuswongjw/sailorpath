import { describe, expect, it } from "vitest";
import {
  parseSailingJourney,
  serializeSailingJourney,
} from "./sailingJourney";

describe("sailingJourney", () => {
  it("round-trips highlights", () => {
    const raw = serializeSailingJourney([
      {
        id: "1",
        when: "2026",
        title: "Nationals win",
        detail: "First big title",
      },
    ]);
    const parsed = parseSailingJourney(raw);
    expect(parsed).toHaveLength(1);
    expect(parsed[0].title).toBe("Nationals win");
  });

  it("drops empty titles", () => {
    expect(
      parseSailingJourney([{ id: "x", when: "1", title: "  ", detail: "no" }])
    ).toHaveLength(0);
  });
});
