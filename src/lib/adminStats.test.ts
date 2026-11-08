import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { PGlite } from "@electric-sql/pglite";

const mocks = vi.hoisted(() => ({ query: vi.fn() }));
vi.mock("@/db", () => ({ pgSql: mocks.query }));
import { formatRosterClaimedPct, getPlatformDemographics, getAdminStats, StatsTimeoutError, withStatsQueryTimeout } from "./adminStats";

let database: PGlite;
beforeEach(async () => {
  database = new PGlite();
  await database.exec(`
    create table sailors (parent_id text, current_fleet text, silver_entry_date date,
      gold_entry_date date, drop_date date, dob date, sail_number text, nationality text);
    create table sailor_claims (status text);
    create table support_messages (status text);
    create table regattas (id text, counts_for_ranking boolean, boat_class text);
    create table regatta_results (id text, regatta_id text, sailor_id text);
    create table usage_events (created_at timestamptz, session_id text, event_type text);
    create table profiles (id text, full_name text, role text);
    create schema auth;
    create table auth.users (id text, email text, created_at timestamptz, confirmed_at timestamptz,
      last_sign_in_at timestamptz, deleted_at timestamptz, is_anonymous boolean);
    create table auth.sessions (user_id text, not_after timestamptz, refreshed_at timestamptz);
  `);
  mocks.query.mockImplementation((strings: TemplateStringsArray, ...params: unknown[]) =>
    Object.assign(database.query(strings.reduce((query, part, index) => query + (index ? `$${index}` : "") + part, ""), params).then((r) => r.rows), { cancel: vi.fn() })
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

  it("groups class aliases before counting unique sailors and preserves board disciplines", async () => {
    await database.exec(`insert into regattas values
      ('a', false, 'Wingfoil'), ('b', false, 'WingFoil'), ('c', false, 'Windfoil'),
      ('d', false, 'WindFoil'), ('e', false, 'Windsurfing'), ('f', false, 'Windsurfing LT'),
      ('g', false, 'iQFOiL');
      insert into regatta_results values ('1','a','same-sailor'), ('2','b','same-sailor'),
        ('3','c','s2'), ('4','d','s2'), ('5','e','s3'), ('6','f','s4'), ('7','g','s5'),
        ('8','g','same-sailor');`);
    const stats = await getPlatformDemographics();
    expect(stats.classesCount).toBe(5);
    expect(stats.resultsTotal).toBe(8);
    expect(stats.multiClassSailors).toBe(1);
    expect(stats.boatClasses.find((row) => row.className === "WingFoil")).toMatchObject({regattaCount: 2, resultCount: 2, sailorCount: 1});
    expect(stats.boatClasses.find((row) => row.className === "Windfoil")).toMatchObject({regattaCount: 2, resultCount: 2, sailorCount: 1});
  });

  it("computes extended demographics, traffic breakdown, and feature adoption when full schema is present", async () => {
    await database.exec(`
      alter table sailors add column gender text;
      alter table sailors add column club text;
      alter table sailors add column owner_relation text;
      alter table sailors add column show_profile_photo_on_public_profile boolean default false;
      alter table sailors add column show_equipment_on_public_profile boolean default false;
      alter table sailors add column is_public_equipment boolean default false;
      alter table sailors add column show_school_on_public_profile boolean default false;
      alter table sailors add column show_sailing_milestones_on_public_profile boolean default false;
      alter table sailors add column show_social_links_on_public_profile boolean default false;
      alter table usage_events add column path text;
      alter table usage_events add column meta text;
      create table followed_sailors (sailor_id text, follower_profile_id text);
      create table coach_followed_sailors (sailor_id text, coach_id text);
      create table coach_squads (id text, coach_id text);
      create table coach_squad_members (squad_id text, sailor_id text);
      create table coach_development_records (id text, visibility text);
      create table coach_sailor_notes (id text);
      create table race_observations (id text, sailor_id text);
      create table parent_notes (id text);
      create table equipment_items (id text, sailor_id text);
      create table equipment_usages (id text, created_at timestamptz);

      insert into sailors (parent_id, current_fleet, silver_entry_date, gold_entry_date, drop_date, dob, sail_number, nationality, gender, club, owner_relation, show_profile_photo_on_public_profile, show_equipment_on_public_profile)
      values
        ('p1', 'Series', '2024-01-01', '2025-01-01', null, '2013-05-10', 'SGP 123', 'SGP', 'M', 'NSC', 'parent', true, true),
        ('p2', 'Series', '2025-01-01', null, null, '2016-02-15', 'SGP 456', 'SGP', 'F', 'CSC', 'sailor', false, false);

      insert into sailor_claims values ('approved'), ('approved'), ('rejected'), ('pending');
      insert into profiles values ('c1', 'Coach One', 'coach');
      insert into followed_sailors values ('s1', 'u1'), ('s2', 'u1');
      insert into coach_followed_sailors values ('s3', 'c1');
      insert into coach_squads values ('sq1', 'c1');
      insert into coach_squad_members values ('sq1', 's1'), ('sq1', 's2');
      insert into coach_development_records values ('d1', 'shared'), ('d2', 'coach_only');
      insert into coach_sailor_notes values ('n1');
      insert into race_observations values ('ro1', 's1'), ('ro2', 's1');
      insert into parent_notes values ('pn1');
      insert into equipment_items values ('eq1', 's1');
      insert into equipment_usages values ('eu1', now());

      insert into usage_events (created_at, session_id, event_type, path, meta) values
        (now() - interval '2 days', 'sess-1', 'ranking_view', '/sg/optimist/gold', '{"vid":"v1","source":"whatsapp","device":"mobile"}'),
        (now(), 'sess-1', 'profile_view', '/sailors/alex', '{"vid":"v1","source":"whatsapp","device":"mobile","own":"true"}'),
        (now(), 'sess-2', 'sample_view', '/sample', '{"vid":"v2","source":"google","device":"desktop"}'),
        (now(), 'sess-2', 'claim_submit', '/sailors/ben', '{"vid":"v2","source":"google","device":"desktop"}');
    `);

    const stats = await getAdminStats();
    expect(stats.demographics.genderBreakdown).toEqual({ male: 1, female: 1, unspecified: 0 });
    expect(stats.demographics.activeSeriesGold).toBe(1);
    expect(stats.demographics.activeSeriesSilver).toBe(1);
    expect(stats.demographics.topClubs).toEqual([
      { club: "CSC", count: 1 },
      { club: "NSC", count: 1 },
    ]);
    expect(stats.trafficBreakdown).toMatchObject({
      sessions30d: 2,
      uniqueVisitors7d: 2,
      returningVisitors7d: 1,
      ownProfileViews7d: 1,
      otherProfileViews7d: 0,
      rankingToProfileSessions30d: 1,
      rankingSessions30d: 1,
      demoToClaimSessions30d: 1,
      demoSessions30d: 1,
      devices7d: { mobile: 1, desktop: 1, unknown: 0 },
    });
    expect(stats.featureAdoption).toMatchObject({
      claims: {
        approved: 2,
        rejected: 1,
        pending: 1,
        approvalRatePct: 66.7,
        byRelation: { parent: 1, sailor: 1, other: 0 },
      },
      publicProfileOptIns: {
        photo: 1,
        equipment: 1,
        school: 0,
        milestones: 0,
        social: 0,
      },
      community: {
        followedSailorLinks: 2,
        uniqueSailorsFollowed: 3,
        activeFollowers: 1,
      },
      coaching: {
        coachAccounts: 1,
        coachSquads: 1,
        squadSailors: 2,
        watchlistEntries: 1,
        developmentRecords: 2,
        sharedRecords: 1,
        coachNotes: 1,
      },
      logbookAndGear: {
        raceObservations: 2,
        sailorsWithRaceNotes: 1,
        parentNotes: 1,
        equipmentItems: 1,
        sailorsWithEquipment: 1,
        equipmentSessionsTotal: 1,
        equipmentSessions30d: 1,
      },
    });
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
