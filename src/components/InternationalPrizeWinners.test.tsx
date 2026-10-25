// @vitest-environment jsdom
import { cleanup, render, screen } from "@testing-library/react";
import { afterEach, expect, it } from "vitest";
import { RegattaPrizeWinners } from "./RegattaPrizeWinners";
import { getRegattaPrizeSchedule } from "@/lib/regattaPrizes";

afterEach(cleanup);
it("renders sourced Worlds girls' awards with links to the exact existing profiles", () => {
  const schedule = getRegattaPrizeSchedule("2026-optimist-world-championship-overall")!;
  render(<RegattaPrizeWinners schedule={schedule} />);
  expect(screen.getByRole("link", { name: "Margaux Nguyen-Minh" }).getAttribute("href")).toBe("/sailors/margaux-nguyen-minh-fcs112q");
  expect(screen.getByTitle("1st Girl / Helen Mary Wilkes Trophy")).toBeTruthy();
  expect(screen.getByRole("link", { name: /Official source/ }).getAttribute("href")).toBe(schedule.noticeOfRaceUrl);
});
