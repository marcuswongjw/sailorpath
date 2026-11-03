// @vitest-environment jsdom
import { cleanup, fireEvent, render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
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

it("defaults to newest first and lets visitors combine and clear filters", async () => {
  const user = userEvent.setup();
  const base = getSailorPrizes({ name: "Margaux Nguyen-Minh", handle: "margaux-nguyen-minh-fcs112q" })[0];
  const awards: SailorPrizeAward[] = [
    { ...base, id: "old", regattaName: "Old Cup", year: 2025, regattaDate: "2025-01-01", regattaEndDate: undefined, venue: "Singapore", boatClass: "ILCA 4", medal: "gold", rank: 1 },
    { ...base, id: "new", regattaName: "Eastern Seaboard", year: 2026, regattaDate: "2026-10-28", regattaEndDate: "2026-11-01", venue: "Pattaya", boatClass: "Optimist", medal: "bronze", rank: 3 },
  ];
  render(<ProfileAwardsCabinet awards={awards} sailorName="Test Sailor" />);
  const order = () => screen.getAllByRole("article").map((card) => card.textContent);
  expect(order()[0]).toContain("Eastern Seaboard");
  await user.selectOptions(screen.getByLabelText("Sort awards"), "oldest");
  expect(order()[0]).toContain("Old Cup");
  await user.selectOptions(screen.getByLabelText("Year"), "2026");
  await user.selectOptions(screen.getByLabelText("Location", { exact: true }), "Pattaya");
  await user.selectOptions(screen.getByLabelText("Boat class"), "Optimist");
  await user.selectOptions(screen.getByLabelText("Medal or honour"), "bronze");
  await user.type(screen.getByLabelText("Search awards"), "eastern");
  expect(screen.getByRole("status").textContent).toContain("Showing 1 of 2");
  expect(screen.getByText(/Total Podiums/).parentElement!.textContent).toMatch(/Total Podiums1$/);
  await user.click(screen.getByText("Custom date range"));
  fireEvent.change(screen.getByLabelText("From date"), { target: { value: "2026-11-01" } });
  fireEvent.change(screen.getByLabelText("To date"), { target: { value: "2026-11-01" } });
  expect(order()).toHaveLength(1);
  fireEvent.change(screen.getByLabelText("To date"), { target: { value: "2026-10-31" } });
  expect(screen.getByRole("alert").textContent).toContain("on or after");
  expect(screen.getByText("No awards match these filters.")).toBeTruthy();
  await user.click(screen.getByRole("button", { name: "Clear filters" }));
  expect(order()).toHaveLength(2);
  expect(screen.getByRole("status").textContent).toContain("Showing 2 of 2");
});
