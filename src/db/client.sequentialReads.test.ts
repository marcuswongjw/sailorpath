import { describe, expect, it, vi } from "vitest";
import { withSequentialDatabaseReads } from "./client";

describe("withSequentialDatabaseReads", () => {
  it("runs each read only after the previous one finishes", async () => {
    const order: string[] = [];
    const first = vi.fn(async () => {
      order.push("first-start");
      await new Promise((resolve) => setTimeout(resolve, 20));
      order.push("first-end");
      return "one";
    });
    const second = vi.fn(async () => {
      order.push("second-start");
      return "two";
    });

    await expect(withSequentialDatabaseReads([first, second], { label: "admin.overview" })).resolves.toEqual([
      "one",
      "two",
    ]);
    expect(order).toEqual(["first-start", "first-end", "second-start"]);
  });
});
