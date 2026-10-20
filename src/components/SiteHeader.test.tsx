import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it, vi } from "vitest";

vi.mock("next/navigation", () => ({ usePathname: () => "/" }));

vi.mock("@/components/AccountProvider", () => ({
  useAccount: () => ({
    email: null,
    owned: [],
    ready: true,
    signOut: () => undefined,
  }),
}));

import { SiteHeader } from "./SiteHeader";

describe("SiteHeader", () => {
  it("keeps X-15 out of the public menu bar", () => {
    const html = renderToStaticMarkup(<SiteHeader />);

    expect(html).toContain('href="/results"');
    expect(html).toContain('href="/rankings"');
    expect(html).toContain('href="/sailors"');
    expect(html).toContain('href="/calendar"');
    expect(html).not.toContain('href="/classes"');
    expect(html).not.toContain("/classes/x15");
    expect(html).not.toContain("X-15");
  });
});
