import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({ rows: [] as Record<string, unknown>[], update: vi.fn() }));
vi.mock("@/db", () => ({ db: {
  insert: () => ({ values: (event: { slug: string }) => ({
    onConflictDoUpdate: () => ({ returning: async () => [{ id: `event-${event.slug}`, slug: event.slug }] }),
  }) }),
  select: () => ({ from: async () => mocks.rows }),
  update: () => ({ set: (patch: unknown) => ({ where: async () => { mocks.update(patch); } }) }),
} }));

import { linkRegattaEvents } from "./linkRegattaEvents";

describe("calendar linking after a class move", () => {
  beforeEach(() => {
    mocks.update.mockReset();
    mocks.rows = [{ id: "sheet", name: "Pesta Sukan Gold", slug: "pesta-sukan-gold-aug-26-2026-08-01", date: "2026-08-01", boatClass: "Optimist", division: "Gold" }];
  });

  it("preserves the destination chosen by the admin", async () => {
    mocks.rows[0].eventId = "different-weekend";
    expect((await linkRegattaEvents()).linked).toBe(0);
    expect(mocks.update).not.toHaveBeenCalled();
  });

  it("still fills a missing event link", async () => {
    expect((await linkRegattaEvents()).linked).toBe(1);
    expect(mocks.update).toHaveBeenCalledOnce();
  });
});
