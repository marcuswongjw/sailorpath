import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it, vi } from "vitest";

vi.mock("@/components/AccountProvider", () => ({
  useAccount: () => ({ owned: [], ready: true }),
}));

vi.mock("@/lib/adminHost", () => ({
  shouldShowDemoNavigation: () => false,
}));

import { SiteFooter } from "./SiteFooter";

describe("SiteFooter", () => {
  it("does not expose the X-15 review route in public navigation", () => {
    const html = renderToStaticMarkup(<SiteFooter />);

    expect(html).not.toContain('href="/classes/x-15"');
    expect(html).toContain('href="/results"');
  });
});
