/** @vitest-environment jsdom */
import { fireEvent, render, screen } from "@testing-library/react";
import { beforeEach, describe, expect, it, vi } from "vitest";
const { push } = vi.hoisted(() => ({ push: vi.fn() }));
vi.mock("next/navigation", () => ({ useRouter: () => ({ push }) }));
import { RegattasBackLink } from "./RegattasBackLink";
describe("regatta return navigation", () => {
  beforeEach(() => { sessionStorage.clear(); push.mockClear(); });
  it("returns to the past tab with every filter retained", () => {
    const address = "/calendar?view=past&class=optimist&region=Singapore&year=2025&q=RSYC";
    sessionStorage.setItem("regatta-return-url", address);
    render(<RegattasBackLink>Regattas</RegattasBackLink>);
    fireEvent.click(screen.getByRole("link", { name: "Regattas" }));
    expect(push).toHaveBeenCalledWith(address);
  });
  it("does not use an external return address", () => {
    sessionStorage.setItem("regatta-return-url", "https://example.com");
    render(<RegattasBackLink>Regattas</RegattasBackLink>);
    expect(screen.getByRole("link", { name: "Regattas" })).toHaveAttribute("href", "/calendar");
  });
});
