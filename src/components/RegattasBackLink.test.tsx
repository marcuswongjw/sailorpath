/** @vitest-environment jsdom */
import { fireEvent, render, screen } from "@testing-library/react";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { RegattaDirectoryLink } from "./regattas/RegattaDirectoryLink";
const { push } = vi.hoisted(() => ({ push: vi.fn() }));
vi.mock("next/navigation", () => ({ useRouter: () => ({ push }) }));
import { RegattasBackLink } from "./RegattasBackLink";
describe("regatta return navigation", () => {
  beforeEach(() => { sessionStorage.clear(); push.mockClear(); });
  afterEach(() => { vi.restoreAllMocks(); window.history.replaceState({}, "", "/"); });
  it("remembers directory filters and restores them through the breadcrumb", () => {
    const address = "/regattas?class=ILCA+4&year=2026&results=published&q=Harbour";
    window.history.replaceState({}, "", address);
    render(<><RegattaDirectoryLink href="/regattas/harbour" onClick={(event) => event.preventDefault()}>Harbour</RegattaDirectoryLink><RegattasBackLink>Regattas</RegattasBackLink></>);
    fireEvent.click(screen.getByRole("link", { name: "Harbour" }));
    expect(sessionStorage.getItem("regatta-return-url")).toBe(address);
    fireEvent.click(screen.getByRole("link", { name: "Regattas" }));
    expect(push).toHaveBeenCalledWith(address);
  });
  it("keeps normal navigation available when browser storage is blocked", () => {
    vi.spyOn(Storage.prototype, "getItem").mockImplementation(() => { throw new Error("Blocked"); });
    render(<RegattasBackLink>Regattas</RegattasBackLink>);
    fireEvent.click(screen.getByRole("link", { name: "Regattas" }));
    expect(push).not.toHaveBeenCalled();
  });
  it("leaves modified clicks to the browser", () => {
    sessionStorage.setItem("regatta-return-url", "/regattas?results=published");
    render(<RegattasBackLink>Regattas</RegattasBackLink>);
    fireEvent.click(screen.getByRole("link", { name: "Regattas" }), { ctrlKey: true });
    expect(push).not.toHaveBeenCalled();
  });
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
