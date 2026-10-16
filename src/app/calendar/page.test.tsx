import { renderToStaticMarkup } from "react-dom/server";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { regattaEventDeletions } from "@/db/schema";
import type { CalendarEventOverride } from "@/lib/calendar/applyEventOverrides";

const state = vi.hoisted(() => ({
  events: [] as CalendarEventOverride[],
  deletions: [] as { slug: string }[],
  deletionReadFails: false,
}));
vi.mock("@/lib/queries", () => ({ getCachedPublicRegattas: async () => [] }));
vi.mock("next/cache", () => ({ unstable_cache: (fn: unknown) => fn }));
vi.mock("@/db", () => ({
  withDatabaseRetry: (fn: () => unknown) => fn(),
  db: { select: () => ({ from: async (table: unknown) => {
    if (table !== regattaEventDeletions) return state.events;
    if (state.deletionReadFails) throw new Error("database unavailable");
    return state.deletions;
  } }) },
}));
vi.mock("@/components/calendar/RegattaCalendarClient", () => ({
  RegattaCalendarClient: ({ regattas }: { regattas: { slug: string; name: string }[] }) => (
    <div>{regattas.map((row) => <p key={row.slug}>{row.name}</p>)}</div>
  ),
}));
import CalendarPage from "./page";

beforeEach(() => {
  state.events = [];
  state.deletions = [{ slug: "xix-euromarina-optimist-trophy-2027" }];
  state.deletionReadFails = false;
});

describe("public calendar deletion state", () => {
  it("does not restore a deleted built-in entry when its database row is absent", async () => {
    const html = renderToStaticMarkup(await CalendarPage({}));
    expect(html).not.toContain("Euromarina");
    expect(html).toContain("Palamós");
  });

  it("shows an event explicitly recreated in admin", async () => {
    state.events = [{ slug: "xix-euromarina-optimist-trophy-2027", name: "Recreated trophy", startDate: "2027-01-20" }];
    const html = renderToStaticMarkup(await CalendarPage({}));
    expect(html).toContain("Recreated trophy");
  });

  it("shows an unavailable state rather than resurrecting events when deletion records cannot load", async () => {
    state.deletionReadFails = true;
    const html = renderToStaticMarkup(await CalendarPage({}));
    expect(html).toContain("Calendar is temporarily unavailable");
    expect(html).not.toContain("Euromarina");
  });
});
