import { describe, expect, it } from "vitest";
import { renderToStaticMarkup } from "react-dom/server";
import { AdminSignInGate } from "./AdminSignInGate";

describe("AdminSignInGate", () => {
  it("keeps host-only admin authentication on admin.sailorpath.com", () => {
    const html = renderToStaticMarkup(
      <AdminSignInGate
        nextUrl="https://admin.sailorpath.com/"
        siteOrigin="https://admin.sailorpath.com"
      />
    );

    expect(html).toContain(
      'href="https://admin.sailorpath.com/login?next=https%3A%2F%2Fadmin.sailorpath.com%2F"'
    );
    expect(html).not.toContain("vercel.app/login");
  });
});
