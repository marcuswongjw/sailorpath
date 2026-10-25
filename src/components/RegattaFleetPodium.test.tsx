// @vitest-environment jsdom
import { render, screen, cleanup } from "@testing-library/react";
import { afterEach, expect, it } from "vitest";
import { RegattaFleetPodium } from "./RegattaFleetPodium";
import type { PublicRegattaResult } from "@/lib/queries";
afterEach(cleanup);
it("shows recorded podiums with actual profile links while keeping unverified awards explicit", () => {
  render(<RegattaFleetPodium results={[
    { resultId: "a", sailorName: "Winner One", handle: "winner-one", rank: 1 },
    { resultId: "b", sailorName: "DNS Sailor", handle: "dns", rank: 2, isDns: true },
  ] as PublicRegattaResult[]} />);
  expect(screen.getByRole("link", { name: "Winner One" }).getAttribute("href")).toBe("/sailors/winner-one");
  expect(screen.queryByText("DNS Sailor")).toBeNull();
  expect(screen.getByText(/Official prize categories have not been verified/)).toBeTruthy();
});
