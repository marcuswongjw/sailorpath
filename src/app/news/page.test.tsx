import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it } from "vitest";
import NewsPage from "./page";

describe("news index", () => {
  it("renders a real release-updates page", () => {
    const html = renderToStaticMarkup(<NewsPage />);
    expect(html).toContain("What&#x27;s new");
    expect(html).toContain("X-15 pilot opens");
  });
});
