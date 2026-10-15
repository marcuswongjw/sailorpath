import { describe, expect, it } from "vitest";
import {
  calendarPastResultsHref,
  legacySearchHref,
  PRIVATE_WORKSPACE_REDIRECTS,
} from "./publicRouteRedirects";

describe("public route redirects", () => {
  it("preserves supported calendar history filters when moving to Results", () => {
    expect(calendarPastResultsHref({ view: "past", class: "optimist", region: "Singapore", year: "2025", q: "Pesta" })).toBe("/results?class=optimist&region=Singapore&year=2025&q=Pesta");
  });

  it("does not carry private or unsupported legacy calendar filters", () => {
    expect(calendarPastResultsHref({ view: "past", school: "private", squad: "Nat A" })).toBe("/results");
  });

  it("preserves supported search intent on the Sailors directory", () => {
    expect(legacySearchHref({ query: "SGP 4652", fleet: "gold", school: "private" })).toBe("/sailors?fleet=gold&q=SGP+4652");
  });

  it("maps private workspaces to their explicit canonical destinations", () => {
    expect(PRIVATE_WORKSPACE_REDIRECTS["/parent"]).toBe("/account/parent");
    expect(PRIVATE_WORKSPACE_REDIRECTS["/coach-tools"]).toBe("/account/coach");
  });
});
