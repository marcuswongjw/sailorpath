import { describe, expect, it } from "vitest";
import {
  coachListFromCache,
  coachRequestsFromCache,
} from "./coachAccessCache";

describe("coach access cache", () => {
  it("reads requests from the panel payload", () => {
    expect(
      coachRequestsFromCache({
        requests: [{ status: "pending" }, { status: "approved" }],
        coaches: [{ id: "c1" }],
      }).filter((row) => row.status === "pending")
    ).toEqual([{ status: "pending" }]);
  });

  it("reads an older array cache without throwing", () => {
    expect(coachRequestsFromCache([{ status: "pending" }])).toEqual([
      { status: "pending" },
    ]);
    expect(coachListFromCache([{ status: "pending" }])).toEqual([]);
  });
});
