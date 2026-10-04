import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { PGlite } from "@electric-sql/pglite";

const mocks = vi.hoisted(() => ({ query: vi.fn() }));
vi.mock("@/db", () => ({ pgSql: mocks.query }));
import { formatRosterClaimedPct, getAdminStats, StatsTimeoutError, withStatsQueryTimeout } from "./adminStats";

let database: PGlite;
beforeEach(async () => {
  database = new PGlite();
  await database.exec(`
    create table sailors (parent_id text, current_fleet text, silver_entry_date date,
      gold_entry_date date, drop_date date, dob date, sail_number text);
    create table sailor_claims (status text);
    create table support_messages (status text);
    create table regattas (counts_for_ranking boolean);
    create table usage_events (created_at timestamptz, session_id text, event_type text);
    create table profiles (id text, full_name text, role text);
    create schema auth;
    create table auth.users (id text, email text, created_at timestamptz, confirmed_at timestamptz,
      last_sign_in_at timestamptz, deleted_at timestamptz, is_anonymous boolean);
    create table auth.sessions (user_id text, not_after timestamptz, refreshed_at timestamptz);
  `);
  mocks.query.mockImplementation((strings: TemplateStringsArray) =>
    Object.assign(database.query(strings.join("")).then((r) => r.rows), { cancel: vi.fn() })
  );
});
afterEach(async () => {
  vi.useRealTimers();
  vi.restoreAllMocks();
  await database.close();
});

describe("admin Stats", () => {
  it("uses only the active series roster for the claim percentage and excludes Guests", async () => {
    await database.exec(`insert into sailors values
      ('owner', 'Series', '2025-01-01', null, null, null, '123'),
      (null, 'Silver', '2025-01-01', null, null, null, '000'),
      ('owner', 'Guest', '2025-01-01', null, null, null, 'SGP 000'),
      ('owner', 'Series', '2025-01-01', null, '2025-07-01', null, '123');`);
    const stats = await getAdminStats();
    expect(stats.northStars).toMatchObject({ claimedSailors: 3, claimedSeriesSailors: 1,
      seriesSailors: 2, rosterClaimedPct: 50 });
    expect(stats.dataTrust.missingOrPlaceholderSail).toBe(2);
    expect(stats.authAccountsOk).toBe(true);
  });

  it("still returns inventory and traffic when account activity cannot be read", async () => {
    await database.exec(`drop table auth.sessions;
      insert into usage_events values (now(), 'session-1', 'ranking_view');`);
    vi.spyOn(console, "warn").mockImplementation(() => {});
    const stats = await getAdminStats();
    expect(stats.authAccountsOk).toBe(false);
    expect(stats.usageEventsOk).toBe(true);
    expect(stats.traffic7d.rankingViews).toBe(1);
    expect(stats.northStars.weeklyActiveSessions).toBe(1);
  });

  it("returns partial stats when an optional query stalls", async () => {
    vi.useFakeTimers();
    const cancel = vi.fn();
    mocks.query.mockImplementation((strings: TemplateStringsArray) => {
      if (strings.join("").includes("auth.sessions")) {
        return Object.assign(new Promise<never>(() => {}), { cancel });
      }
      return Object.assign(Promise.resolve([]), { cancel: vi.fn() });
    });
    vi.spyOn(console, "warn").mockImplementation(() => {});
    const response = getAdminStats();
    await vi.advanceTimersByTimeAsync(4_000);
    const stats = await response;
    expect(stats.authAccountsOk).toBe(false);
    expect(stats.usageEventsOk).toBe(true);
    expect(cancel).toHaveBeenCalledOnce();
  });

  it("cancels a stalled query at the deadline", async () => {
    vi.useFakeTimers();
    const cancel = vi.fn();
    const stalled = Object.assign(new Promise<never>(() => {}), { cancel });
    const result = withStatsQueryTimeout(stalled, 50);
    const assertion = expect(result).rejects.toBeInstanceOf(StatsTimeoutError);
    await vi.advanceTimersByTimeAsync(50);
    await assertion;
    expect(cancel).toHaveBeenCalledOnce();
  });

  it("clears its timer when a query succeeds", async () => {
    vi.useFakeTimers();
    const cancel = vi.fn();
    expect(await withStatsQueryTimeout(Object.assign(Promise.resolve(3), { cancel }), 50)).toBe(3);
    await vi.advanceTimersByTimeAsync(50);
    expect(cancel).not.toHaveBeenCalled();
  });
});

describe("formatRosterClaimedPct", () => {
  it("returns null when the roster is empty", () => {
    expect(formatRosterClaimedPct(0, 0)).toBeNull();
  });
  it("rounds to one decimal percent", () => {
    expect(formatRosterClaimedPct(1, 3)).toBe(33.3);
  });
});
