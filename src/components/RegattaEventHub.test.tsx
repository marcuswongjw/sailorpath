// @vitest-environment jsdom
import { cleanup, render, screen } from "@testing-library/react";
import { afterEach, expect, it, vi } from "vitest";
afterEach(cleanup);
vi.mock("@/lib/queries", () => ({ getCachedPublicRegattas: async () => [], getResultsForRegatta: async () => [] }));
vi.mock("@/lib/search", () => ({ searchSailorsEnhanced: async () => [] }));
vi.mock("@/db", () => ({ DbUnavailableError: class extends Error {} }));
vi.mock("@/components/RegattasBackLink", () => ({ RegattasBackLink: ({ children, href }: { children: React.ReactNode; href: string }) => <a href={href}>{children}</a> }));
import { RegattaEventHub } from "./RegattaEventHub";
import { SNSC_2026_EVENT, type RegattaEventDef } from "@/lib/regattaEvents";

it("alphabetises imported fleet tabs while retaining the requested active fleet and links", async () => {
  const event: RegattaEventDef = { ...SNSC_2026_EVENT, slug: "alphabetical-fixture", slices: [
    { key: "optimist-silver", label: "Optimist Silver", series: "optimist" },
    { key: "ilca-6", label: "ILCA 6 Open", series: "ilca6" },
    { key: "optimist-gold", label: "Optimist Gold", series: "optimist" },
    { key: "ilca-4", label: "ILCA 4 Open", series: "ilca4" },
  ] };
  render(await RegattaEventHub({ event, activeFleet: "ilca-6" }));
  const tabs = screen.getAllByRole("tab");
  expect(tabs.map((tab) => tab.getAttribute("href"))).toEqual(["ilca-4", "ilca-6", "optimist-gold", "optimist-silver"].map((key) => `/regattas/alphabetical-fixture/results/${key}`));
  expect(tabs[1].getAttribute("aria-selected")).toBe("true");
  expect(event.slices[0].key).toBe("optimist-silver");
});
