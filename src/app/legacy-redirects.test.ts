import { beforeEach, describe, expect, it, vi } from "vitest";

const redirect = vi.hoisted(() => vi.fn());
vi.mock("next/navigation", () => ({ permanentRedirect: redirect }));

import LegacyCoachAliasPage from "./coach/page";
import LegacyCoachPage from "./coach-tools/page";
import LegacyParentPage from "./parent/page";

function redirectTo(path: string): never {
  throw new Error(`REDIRECT:${path}`);
}

describe("legacy canonical redirects", () => {
  beforeEach(() => {
    redirect.mockReset();
    redirect.mockImplementation(redirectTo);
  });

  it("moves the parent workspace to its canonical private route", () => {
    expect(() => LegacyParentPage()).toThrow("REDIRECT:/account/parent");
    expect(redirect).toHaveBeenCalledWith("/account/parent");
  });

  it("moves the coach workspace aliases to the canonical private route", () => {
    expect(() => LegacyCoachPage()).toThrow("REDIRECT:/account/coach");
    expect(redirect).toHaveBeenCalledWith("/account/coach");

    redirect.mockClear();
    expect(() => LegacyCoachAliasPage()).toThrow("REDIRECT:/account/coach");
    expect(redirect).toHaveBeenCalledWith("/account/coach");
  });
});
