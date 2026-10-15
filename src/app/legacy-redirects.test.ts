import { beforeEach, describe, expect, it, vi } from "vitest";

const redirect = vi.hoisted(() => vi.fn());
vi.mock("next/navigation", () => ({ permanentRedirect: redirect }));

import LegacyCoachPage from "./coach-tools/page";
import LegacyParentPage from "./parent/page";
import LegacySearchPage from "./search/page";

function redirectTo(path: string): never {
  throw new Error(`REDIRECT:${path}`);
}

describe("legacy canonical redirects", () => {
  beforeEach(() => {
    redirect.mockReset();
    redirect.mockImplementation(redirectTo);
  });

  it("moves legacy search to Sailors and retains only public query context", async () => {
    await expect(
      LegacySearchPage({
        searchParams: Promise.resolve({
          query: "SGP 4652",
          fleet: "gold",
          club: "CSC",
          nationality: "SGP",
          school: "private",
          squad: "Nat A",
        }),
      })
    ).rejects.toThrow("REDIRECT:/sailors?fleet=gold&club=CSC&nationality=SGP&q=SGP+4652");
  });

  it("moves the parent workspace to its canonical private route", () => {
    expect(() => LegacyParentPage()).toThrow("REDIRECT:/account/parent");
    expect(redirect).toHaveBeenCalledWith("/account/parent");
  });

  it("moves the coach workspace to its canonical private route", () => {
    expect(() => LegacyCoachPage()).toThrow("REDIRECT:/account/coach");
    expect(redirect).toHaveBeenCalledWith("/account/coach");
  });
});
