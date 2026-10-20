import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it, vi } from "vitest";
vi.mock("next/navigation", () => ({ usePathname: () => "/" }));

vi.mock("@/components/AccountProvider", () => ({
  useAccount: () => ({ owned: [], ready: true }),
}));

vi.mock("@/lib/adminHost", () => ({
  shouldShowDemoNavigation: () => false,
}));

import { SiteFooter } from "./SiteFooter";

describe("SiteFooter", () => {
  it("links to the class index without naming X-15", () => {
    const html = renderToStaticMarkup(<SiteFooter />);

    expect(html).toContain('href="/classes"');
    expect(html).toContain("Classes");
    expect(html).not.toContain('href="/classes/x15"');
    expect(html).not.toContain('href="/classes/x-15"');
    expect(html).not.toContain("X-15");
    expect(html).toContain('href="/results"');
  });
});
