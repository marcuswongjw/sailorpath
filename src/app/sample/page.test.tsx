import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it, vi } from "vitest";

vi.mock("next/navigation", () => ({
  redirect: (url: string) => {
    throw new Error(`REDIRECT:${url}`);
  },
}));
vi.mock("@/components/SailorProfileView", () => ({
  SailorProfileView: ({ initialSailor }: { initialSailor: { name: string } }) => <article>{initialSailor.name} results</article>,
}));
vi.mock("@/components/demo/DemoNavHeader", () => ({
  DemoNavHeader: () => <nav>Demo navigation</nav>,
}));

import SamplePage, { generateMetadata } from "./page";

describe("sample profile page", () => {
  it("renders the public profile on the server", async () => {
    const page = await SamplePage({ searchParams: Promise.resolve({}) });
    const html = renderToStaticMarkup(page);
    expect(html).toContain("Kimberly Tan · SGP 115 · SailorPath Profile");
    expect(html).toContain("Kimberly Tan results");
    expect(html).toContain('href="/sample?view=public"');
    expect(html).toContain('href="/sample?view=sailor"');
    expect(html).not.toContain("Loading page");
    expect(html).not.toContain("Loading demo");
  });

  it("uses a sailor-view title", async () => {
    const metadata = await generateMetadata({ searchParams: Promise.resolve({ view: "sailor" }) });
    expect(metadata.title).toBe("Kimberly Tan · SGP 115 · Sailor view | SailorPath");
  });

  it("sends the parent demo to its own page", async () => {
    await expect(SamplePage({ searchParams: Promise.resolve({ view: "parent" }) })).rejects.toThrow("REDIRECT:/demo/parent");
  });
});
