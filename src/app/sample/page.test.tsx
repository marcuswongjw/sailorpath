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

  it("uses the public share title and omits personal details from JSON-LD", async () => {
    const metadata = await generateMetadata();
    expect(metadata.title).toBe("Kimberly Tan – Optimist, Singapore | SailorPath");
    expect(metadata.description).toContain("Born 2013.");
    expect(metadata.description).toContain("1st in Optimist at Singapore National Championship 2026");
    expect(metadata.description).not.toContain("2013-08-14");
    expect(metadata.description).not.toContain("Raffles");
    expect(metadata.alternates?.canonical).toBe("https://sailorpath.com/sample");
    expect(metadata.openGraph?.title).toBe(metadata.title);

    const page = await SamplePage({ searchParams: Promise.resolve({ view: "sailor" }) });
    const html = renderToStaticMarkup(page);
    const match = html.match(/<script type="application\/ld\+json">([\s\S]*?)<\/script>/);
    expect(match).toBeTruthy();
    const jsonLd = JSON.parse(match![1].replace(/\\u003c/g, "<"));
    expect(jsonLd["@type"]).toBe("ProfilePage");
    expect(jsonLd.mainEntity.name).toBe("Kimberly Tan");
    expect(jsonLd.mainEntity.birthDate).toBe("2013");
    const serialized = JSON.stringify(jsonLd);
    expect(serialized).not.toContain("2013-08-14");
    expect(serialized).not.toContain("Raffles");
    expect(html).toContain("b. 2013");
  });

  it("sends the parent demo to its own page", async () => {
    await expect(SamplePage({ searchParams: Promise.resolve({ view: "parent" }) })).rejects.toThrow("REDIRECT:/demo/parent");
  });
});
