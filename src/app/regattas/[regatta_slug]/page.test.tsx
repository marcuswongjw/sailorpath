import { beforeEach, describe, expect, it, vi } from "vitest";

const permanentRedirect = vi.hoisted(() => vi.fn());

vi.mock("next/navigation", () => ({
  permanentRedirect,
  redirect: vi.fn(),
}));

vi.mock("@/db", () => ({
  db: {
    select: vi.fn(),
  },
}));

vi.mock("@/components/RegattaEventHub", () => ({
  RegattaEventHub: vi.fn(() => null),
}));

import RegattaRedirectPage from "./page";

function redirectTo(path: string): never {
  throw new Error(`REDIRECT:${path}`);
}

describe("canonical RSYC event routes", () => {
  beforeEach(() => {
    permanentRedirect.mockReset();
    permanentRedirect.mockImplementation(redirectTo);
  });

  it("moves the short RSYC Gold import slug to its canonical event hub", async () => {
    await expect(
      RegattaRedirectPage({
        params: Promise.resolve({ regatta_slug: "rsyc-2026-gold" }),
        searchParams: Promise.resolve({}),
      })
    ).rejects.toThrow(
      "REDIRECT:/regattas/rsyc-optimist-gold-fleet-knockout-championship-2026"
    );
    expect(permanentRedirect).toHaveBeenCalledWith(
      "/regattas/rsyc-optimist-gold-fleet-knockout-championship-2026"
    );
  });
});
