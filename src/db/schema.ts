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
  index,
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
  /** Admin product changelog unread watermark (not used for public users yet). */
  lastSeenProductChangelogAt: timestamp("last_seen_product_changelog_at", {
    withTimezone: true,
  }),
});

/** A coach may request access, but only a superadmin may grant the coach role. */
export const coachAccessRequests = pgTable(
  "coach_access_requests",
  {
    id: uuid("id").primaryKey().defaultRandom().notNull(),
    requesterId: uuid("requester_id")
      .references(() => profiles.id, { onDelete: "cascade" })
      .notNull(),
    status: text("status", {
      enum: ["pending", "approved", "rejected"],
    })
      .default("pending")
      .notNull(),
    requestedAt: timestamp("requested_at", { withTimezone: true })
      .defaultNow()
      .notNull(),
    reviewedAt: timestamp("reviewed_at", { withTimezone: true }),
    reviewedBy: uuid("reviewed_by").references(() => profiles.id, {
      onDelete: "set null",
    }),
    updatedAt: timestamp("updated_at", { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    requesterUnq: unique("coach_access_requests_requester_unq").on(
      table.requesterId
    ),
    reviewedByIdx: index("coach_access_requests_reviewed_by_idx").on(
      table.reviewedBy
    ),
    statusRequestedIdx: index("coach_access_requests_status_requested_idx").on(
      table.status,
      table.requestedAt
    ),
  })
);

export const sailors = pgTable("sailors", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  name: text("name").notNull(),
  handle: text("handle").unique().notNull(),
  /** Primary / Optimist sail number */
  sailNumber: text("sail_number").notNull(),
  /**
   * ILCA 4 sail number (optional). Sailors under 15 may hold both
   * Optimist and ILCA 4 numbers; each class tracks latest by regatta date.
   */
  sailNumberIlca4: text("sail_number_ilca4"),
  /**
   * On the official ILCA 4 national ranking list (admin-managed).
   * Public standings only include sailors with this flag.
   */
  ilca4NationalList: boolean("ilca4_national_list").default(false).notNull(),
  club: text("club").notNull(),
  school: text("school"),
  /** Country / nationality (e.g. Singapore, SGP) — optional */
  nationality: text("nationality"),
  /**
   * True when nationality was auto-derived from sail number prefix
   * (e.g. SGP 115 → SGP), not from import column or manual admin edit.
   */
  nationalityFromSail: boolean("nationality_from_sail")
    .default(false)
    .notNull(),
  /** Public profile photo URL (Supabase Storage or external) */
  avatarUrl: text("avatar_url"),
  bio: text("bio"),
  gender: text("gender"),
  nationalSquadStatus: text("national_squad_status"),
  /**
   * SG Series Fleet membership: "Guest" | "Series" (In SG Fleet).
   * Legacy values "Gold"/"Silver" are treated as Series.
   * Ranking Gold vs Silver is derived from goldEntryDate / dropDate only.
   */
  currentFleet: text("current_fleet"),
  instagram: text("instagram"),
  /** Deprecated in UI — column retained for legacy data */
  facebook: text("facebook"),
  natSquadStatusJan25: text("nat_squad_status_jan_25"),
  natSquadStatusJul25: text("nat_squad_status_jul_25"),
  natSquadStatusJan26: text("nat_squad_status_jan_26"),
  natSquadStatusJul26: text("nat_squad_status_jul_26"),
  natSquadStatusJan27: text("nat_squad_status_jan_27"),
  natSquadStatusJul27: text("nat_squad_status_jul_27"),
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
  /** Current Optimist (or primary) equipment — owner-editable */
  hullBrand: text("hull_brand"),
  sailMake: text("sail_make"),
  foilBrand: text("foil_brand"),
  mast: text("mast"),
  equipmentNotes: text("equipment_notes"),
  /** ILCA 4 class equipment (dual-class sailors) */
  hullBrandIlca4: text("hull_brand_ilca4"),
  sailMakeIlca4: text("sail_make_ilca4"),
  foilBrandIlca4: text("foil_brand_ilca4"),
  mastIlca4: text("mast_ilca4"),
  equipmentNotesIlca4: text("equipment_notes_ilca4"),
  /**
   * Owner-edited sailing journey highlights (JSON array).
   * [{ id, when, title, detail }] — key memories, not full results log.
   */
  sailingJourney: text("sailing_journey"),
  parentId: uuid("parent_id").references(() => profiles.id, {
    onDelete: "set null",
  }),
  /**
   * How the linked account relates to this sailor (set on claim approve).
   * parent | sailor | other — drives parent dashboard vs self-profile copy.
   */
  ownerRelation: text("owner_relation", {
    enum: ["parent", "sailor", "other"],
  }),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
},
  (table) => ({
    parentIdIdx: index("sailors_parent_id_idx").on(table.parentId),
  })
);

/** Coach-owned groups. Athlete membership is private and never exposed publicly. */
export const coachSquads = pgTable(
  "coach_squads",
  {
    id: uuid("id").primaryKey().defaultRandom().notNull(),
    coachId: uuid("coach_id")
      .references(() => profiles.id, { onDelete: "cascade" })
      .notNull(),
    name: text("name").default("My squad").notNull(),
    createdAt: timestamp("created_at", { withTimezone: true }).defaultNow().notNull(),
    updatedAt: timestamp("updated_at", { withTimezone: true }).defaultNow().notNull(),
  },
  (table) => ({
    coachIdIdx: index("coach_squads_coach_id_idx").on(table.coachId),
    coachNameUnq: unique("coach_squads_coach_name_unq").on(
      table.coachId,
      table.name
    ),
  })
);

export const coachSquadMembers = pgTable(
  "coach_squad_members",
  {
    id: uuid("id").primaryKey().defaultRandom().notNull(),
    squadId: uuid("squad_id")
      .references(() => coachSquads.id, { onDelete: "cascade" })
      .notNull(),
    sailorId: uuid("sailor_id")
      .references(() => sailors.id, { onDelete: "cascade" })
      .notNull(),
    createdAt: timestamp("created_at", { withTimezone: true }).defaultNow().notNull(),
  },
  (table) => ({
    squadIdIdx: index("coach_squad_members_squad_id_idx").on(table.squadId),
    sailorIdIdx: index("coach_squad_members_sailor_id_idx").on(table.sailorId),
    squadSailorUnq: unique("coach_squad_members_squad_sailor_unq").on(
      table.squadId,
      table.sailorId
    ),
  })
);

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
  /** Geography NOC-style code (e.g. SGP, MAS, THA) for multi-geo filtering */
  geography: text("geography").default("SGP").notNull(),
  /** Boat class tag (e.g. Optimist, ILCA 6) */
  boatClass: text("boat_class").default("Optimist").notNull(),
  /**
   * When false, event is logbook-only (e.g. overseas / training) and is
   * excluded from Best 3 of 5 series rankings.
   */
  countsForRanking: boolean("counts_for_ranking").default(true).notNull(),
  /**
   * When set, admin has dismissed or promoted a non-ranking (owner) suggestion.
   * NULL + countsForRanking=false → still in admin Suggestions queue.
   */
  reviewedAt: timestamp("reviewed_at", { withTimezone: true }),
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
    /**
     * Denormalized from sailor at import/sync time for result-level filters
     * (M / F). Source of truth remains sailors.gender.
     */
    gender: text("gender"),
    /**
     * Birth year denormalized from sailor DOB for result-level age buckets.
     * Source of truth remains sailors.dob.
     */
    birthYear: integer("birth_year"),
    /**
     * Denormalized NOC nationality from sailor profile (e.g. SGP).
     * Source of truth remains sailors.nationality.
     */
    nationality: text("nationality"),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => ({
    unq: unique().on(table.sailorId, table.regattaId),
    regattaIdIdx: index("regatta_results_regatta_id_idx").on(table.regattaId),
  })
);

/** Official race scores published by the event organiser. */
export const regattaRaceResults = pgTable(
  "regatta_race_results",
  {
    id: uuid("id").primaryKey().defaultRandom().notNull(),
    regattaResultId: uuid("regatta_result_id")
      .references(() => regattaResults.id, { onDelete: "cascade" })
      .notNull(),
    raceNumber: integer("race_number").notNull(),
    score: real("score").notNull(),
    scoringCode: text("scoring_code"),
    discarded: boolean("discarded").default(false).notNull(),
    rawValue: text("raw_value").notNull(),
    createdAt: timestamp("created_at", { withTimezone: true }).defaultNow().notNull(),
    updatedAt: timestamp("updated_at", { withTimezone: true }).defaultNow().notNull(),
  },
  (table) => ({
    unq: unique().on(table.regattaResultId, table.raceNumber),
    resultIdIdx: index("regatta_race_results_result_id_idx").on(table.regattaResultId),
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
  /** Structured relation from claim form: parent | sailor | other */
  relation: text("relation", {
    enum: ["parent", "sailor", "other"],
  }),
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
 * Equipment change log — optional dated snapshots (legacy; prefer equipment_items).
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

/**
 * Multi-item equipment inventory (Optimist / ILCA 4).
 */
export const equipmentItems = pgTable("equipment_items", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  sailorId: uuid("sailor_id")
    .references(() => sailors.id, { onDelete: "cascade" })
    .notNull(),
  boatClass: text("boat_class", {
    enum: ["optimist", "ilca4", "other"],
  })
    .default("optimist")
    .notNull(),
  category: text("category", {
    enum: [
      "hull",
      "sail",
      "mast",
      "boom",
      "sprit",
      "daggerboard",
      "rudder",
      "other",
    ],
  }).notNull(),
  brand: text("brand"),
  model: text("model"),
  label: text("label"),
  status: text("status", {
    enum: ["active", "backup", "retired"],
  })
    .default("active")
    .notNull(),
  condition: text("condition", {
    enum: ["new", "good", "fair", "worn", "replace_soon"],
  })
    .default("good")
    .notNull(),
  isPrimary: boolean("is_primary").default(false).notNull(),
  /** Comma-separated tags: racing,training,spare,overseas */
  tags: text("tags"),
  /** Sail primary wind band: light | medium | heavy */
  windRange: text("wind_range"),
  acquiredOn: date("acquired_on"),
  retiredOn: date("retired_on"),
  useCount: integer("use_count").default(0).notNull(),
  lastUsedOn: date("last_used_on"),
  notes: text("notes"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

/**
 * Private parent notes on a linked sailor (owner only).
 */
export const parentNotes = pgTable("parent_notes", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  sailorId: uuid("sailor_id")
    .references(() => sailors.id, { onDelete: "cascade" })
    .notNull(),
  authorUserId: uuid("author_user_id")
    .references(() => profiles.id, { onDelete: "cascade" })
    .notNull(),
  body: text("body").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

/** Individual session/use events for equipment items */
export const equipmentUsages = pgTable("equipment_usages", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  equipmentItemId: uuid("equipment_item_id")
    .references(() => equipmentItems.id, { onDelete: "cascade" })
    .notNull(),
  sailorId: uuid("sailor_id")
    .references(() => sailors.id, { onDelete: "cascade" })
    .notNull(),
  usedOn: date("used_on").notNull(),
  regattaId: uuid("regatta_id").references(() => regattas.id, {
    onDelete: "set null",
  }),
  /** regatta | training | manual | import */
  source: text("source", {
    enum: ["manual", "regatta", "import", "training"],
  })
    .default("manual")
    .notNull(),
  /** Session wind: light | medium | heavy */
  wind: text("wind"),
  note: text("note"),
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
export const usageEvents = pgTable(
  "usage_events",
  {
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
  },
  (table) => ({
    createdTypeIdx: index("usage_events_created_type_idx").on(
      table.createdAt,
      table.eventType
    ),
  })
);

/**
 * Admin/data audit trail — may include sailor names (superadmin UI only).
 * Distinct from privacy-light usage_events.
 */
export const adminChangeLog = pgTable("admin_change_log", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  createdAt: timestamp("created_at", { withTimezone: true }).defaultNow().notNull(),
  actorUserId: uuid("actor_user_id").references(() => profiles.id, {
    onDelete: "set null",
  }),
  actorEmail: text("actor_email"),
  action: text("action").notNull(),
  entityType: text("entity_type").notNull(),
  entityId: uuid("entity_id"),
  entityLabel: text("entity_label"),
  summary: text("summary").notNull(),
  details: text("details"), // JSON string for portability
  source: text("source"),
});
