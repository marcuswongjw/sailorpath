// @vitest-environment jsdom
import { cleanup, render, screen } from "@testing-library/react";
import { afterEach, expect, it } from "vitest";
import { ProfileAwardsCabinet } from "./ProfileAwardsCabinet";
import { getSailorPrizes, type SailorPrizeAward } from "@/lib/sailorPrizes";
afterEach(cleanup);
it("lists 14th-place honours while counting only the actual podium", () => {
  const silver = getSailorPrizes({ name: "Margaux Nguyen-Minh", handle: "margaux-nguyen-minh-fcs112q" }).find((a) => a.regattaSlug.includes("world-championship"))!;
  const other: SailorPrizeAward = { ...silver, id: "overall-14", rank: 14, medal: "other", prizeTitle: "14th", categoryName: "Open" };
  render(<ProfileAwardsCabinet awards={[silver, other]} sailorName="Margaux Nguyen-Minh" />);
  expect(screen.getByText("2 Recorded Honours")).toBeTruthy();
  expect(screen.getByText(/Total Podiums/).parentElement!.textContent).toMatch(/Total Podiums1$/);
  expect(screen.getByRole("img", { name: "14th Award" })).toBeTruthy();
  expect(screen.queryByRole("img", { name: "14th Medal" })).toBeNull();
});
