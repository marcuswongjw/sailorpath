import { describe, expect, it, vi } from "vitest";
import { singleFlight } from "./singleFlight";
describe("concurrent read refreshes", () => {
 it("shares in-flight work for one key and keeps different keys independent", async () => {
  const loader = vi.fn(async () => 42);
  const [a,b,c] = await Promise.all([singleFlight("a",loader), singleFlight("a",loader), singleFlight("b",loader)]);
  expect([a,b,c]).toEqual([42,42,42]); expect(loader).toHaveBeenCalledTimes(2);
  await singleFlight("a",loader); expect(loader).toHaveBeenCalledTimes(3);
 });
 it("allows retry after rejection instead of caching a failed refresh", async () => {
  await expect(singleFlight("failure", async () => { throw new Error("offline"); })).rejects.toThrow("offline");
  await expect(singleFlight("failure", async () => "ok")).resolves.toBe("ok");
 });
});
