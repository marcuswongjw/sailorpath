import {
  pgTable,
  uuid,
  text,
  timestamp,
  integer,
  boolean,
  date,
  real,
  unique,
} from "drizzle-orm/pg-core";

export const profiles = pgTable("profiles", {
  id: uuid("id").primaryKey().notNull(),
  email: text("email").notNull(),
  fullName: text("full_name").notNull(),
  role: text("role", {
    enum: ["parent", "sailor", "coach", "superadmin"],
  })
    .default("sailor")
    .notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const sailors = pgTable("sailors", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  name: text("name").notNull(),
  handle: text("handle").unique().notNull(),
  sailNumber: text("sail_number").notNull(),
  club: text("club").notNull(),
  school: text("school"),
  /** Country / nationality (e.g. Singapore, SGP) — optional */
  nationality: text("nationality"),
  /** Public profile photo URL (Supabase Storage or external) */
  avatarUrl: text("avatar_url"),
  bio: text("bio"),
  gender: text("gender"),
  nationalSquadStatus: text("national_squad_status"),
  /** Gold | Silver for the current ranking period (e.g. Jul–Dec 2026) */
  currentFleet: text("current_fleet"),
  /**
   * Y = left Optimist class without normal “ex-gold” drop path.
   * Excluded from active rankings; still listed on All Gold Fleet Sailors when relevant.
   */
  manuallyDropped: boolean("manually_dropped").default(false).notNull(),
  instagram: text("instagram"),
  /** Deprecated in UI — column retained for legacy data */
  facebook: text("facebook"),
  natSquadStatusJan25: text("nat_squad_status_jan_25"),
  natSquadStatusJul25: text("nat_squad_status_jul_25"),
  natSquadStatusJan26: text("nat_squad_status_jan_26"),
  natSquadStatusJul26: text("nat_squad_status_jul_26"),
  histRankingJun24: integer("hist_ranking_jun_24"),
  histRankingDec24: integer("hist_ranking_dec_24"),
  histRankingJun25: integer("hist_ranking_jun_25"),
  histRankingDec25: integer("hist_ranking_dec_25"),
  histRankingJun26: integer("hist_ranking_jun_26"),
  /**
   * Overseas representation years — text so multiple years are allowed
   * e.g. "2023, 2025". Migrated from single integer columns.
   */
  worlds: text("worlds_represented_year"),
  european: text("european_represented_year"),
  asian: text("asian_represented_year"),
  seaGames: text("sea_games_represented_year"),
  dob: date("dob"),
  weight: integer("weight"),
  goldEntryDate: date("gold_entry_date"),
  silverEntryDate: date("silver_entry_date"),
  dropDate: date("drop_date"),
  isPublicWeight: boolean("is_public_weight").default(false).notNull(),
  isPublicDob: boolean("is_public_dob").default(false).notNull(),
  isPublicEquipment: boolean("is_public_equipment").default(false).notNull(),
  /** Current equipment (owner-editable) */
  hullBrand: text("hull_brand"),
  sailMake: text("sail_make"),
  foilBrand: text("foil_brand"),
  mast: text("mast"),
  equipmentNotes: text("equipment_notes"),
  parentId: uuid("parent_id").references(() => profiles.id, {
    onDelete: "set null",
  }),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const regattas = pgTable("regattas", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  name: text("name").notNull(),
  slug: text("slug").unique().notNull(),
  date: date("date").notNull(),
  totalFleetSize: integer("total_fleet_size").notNull(),
  division: text("division").default("Gold").notNull(),
  /**
   * Number of individual races in this regatta (for sailor race-log observations).
   * Optional until set by admin.
   */
  raceCount: integer("race_count"),
  /** Country / region tag (e.g. SG, MY, TH) for multi-geo filtering */
  geography: text("geography").default("SG").notNull(),
  /** Boat class tag (e.g. Optimist, ILCA 6) */
  boatClass: text("boat_class").default("Optimist").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const regattaResults = pgTable(
  "regatta_results",
  {
    id: uuid("id").primaryKey().defaultRandom().notNull(),
    sailorId: uuid("sailor_id")
      .references(() => sailors.id, { onDelete: "cascade" })
      .notNull(),
    regattaId: uuid("regatta_id")
      .references(() => regattas.id, { onDelete: "cascade" })
      .notNull(),
    rank: integer("rank").notNull(),
    /**
     * Race nett points (optional). May be null when only ranking points apply
     * (e.g. overseas commitment / DNS with standing-based score).
     */
    nettScore: real("nett_score"),
    /** Gross / total points before discards (optional; from Excel "Total" / "Total Score") */
    totalScore: real("total_score"),
    /**
     * Did not start / did not compete — default score is usually fleet size + 1.
     * Stored so admins can edit the points later.
     */
    isDns: boolean("is_dns").default(false).notNull(),
    /**
     * Score adjusted for SSF-supported overseas commitment (missed ranking regatta).
     * Points are typically set to the sailor’s standing before the trip (editable).
     */
    isOverseasCommitment: boolean("is_overseas_commitment")
      .default(false)
      .notNull(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => ({
    unq: unique().on(table.sailorId, table.regattaId),
  })
);

export const sailorAliases = pgTable("sailor_aliases", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  sailorId: uuid("sailor_id")
    .references(() => sailors.id, { onDelete: "cascade" })
    .notNull(),
  aliasName: text("alias_name").unique().notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

/** Parent/sailor requests to claim a public athlete profile */
export const sailorClaims = pgTable("sailor_claims", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  sailorId: uuid("sailor_id")
    .references(() => sailors.id, { onDelete: "cascade" })
    .notNull(),
  requesterId: uuid("requester_id")
    .references(() => profiles.id, { onDelete: "cascade" })
    .notNull(),
  status: text("status", {
    enum: ["pending", "approved", "rejected"],
  })
    .default("pending")
    .notNull(),
  note: text("note"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

/**
 * Race-by-race observations (owner / parent).
 * Private by default — only visible when isPrivate=false or viewer is owner.
 */
export const raceObservations = pgTable(
  "race_observations",
  {
    id: uuid("id").primaryKey().defaultRandom().notNull(),
    sailorId: uuid("sailor_id")
      .references(() => sailors.id, { onDelete: "cascade" })
      .notNull(),
    regattaId: uuid("regatta_id")
      .references(() => regattas.id, { onDelete: "cascade" })
      .notNull(),
    raceNumber: integer("race_number").notNull(),
    position: integer("position"),
    wind: text("wind"),
    note: text("note"),
    isPrivate: boolean("is_private").default(true).notNull(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => ({
    unq: unique().on(table.sailorId, table.regattaId, table.raceNumber),
  })
);

/**
 * Equipment change log — optional dated snapshots (current gear also on sailors).
 */
export const equipmentLogs = pgTable("equipment_logs", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  sailorId: uuid("sailor_id")
    .references(() => sailors.id, { onDelete: "cascade" })
    .notNull(),
  effectiveDate: date("effective_date").notNull(),
  hullBrand: text("hull_brand"),
  sailMake: text("sail_make"),
  foilBrand: text("foil_brand"),
  mast: text("mast"),
  notes: text("notes"),
  regattaId: uuid("regatta_id").references(() => regattas.id, {
    onDelete: "set null",
  }),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

/** User-submitted support / help requests */
export const supportMessages = pgTable("support_messages", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  userId: uuid("user_id").references(() => profiles.id, {
    onDelete: "set null",
  }),
  email: text("email").notNull(),
  name: text("name"),
  topic: text("topic"),
  body: text("body").notNull(),
  pageUrl: text("page_url"),
  status: text("status", {
    enum: ["new", "read", "resolved"],
  })
    .default("new")
    .notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

/**
 * Privacy-light product usage events (page views, key actions).
 * No free-text PII — path + event type + optional role/session only.
 */
export const usageEvents = pgTable("usage_events", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  /** e.g. page_view, ranking_view, profile_view, import, claim, support */
  eventType: text("event_type").notNull(),
  /** Pathname only, e.g. /sg/optimist/gold — no query strings with tokens */
  path: text("path"),
  /** Optional coarse role if known: public | sailor | parent | coach | superadmin */
  role: text("role"),
  /** Anonymous browser session id (client-generated UUID) */
  sessionId: text("session_id"),
  /** Optional JSON string for small meta (fleet, period) — no emails/names */
  meta: text("meta"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});
