import { pgTable, uuid, text, timestamp, integer, boolean, date, unique, primaryKey } from "drizzle-orm/pg-core";
import { relations } from "drizzle-orm";

// 1. PROFILES Table (Extends auth.users from Supabase)
export const profiles = pgTable("profiles", {
  id: uuid("id").primaryKey().notNull(), // Links to auth.users.id
  email: text("email").notNull(),
  fullName: text("full_name").notNull(),
  role: text("role", { enum: ["parent", "sailor", "coach", "superadmin"] }).default("sailor").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const profilesRelations = relations(profiles, ({ many }) => ({
  sailorsAsParent: many(sailors, { relationName: "parentOfSailors" }),
  coachingRelationships: many(coachingRelationships, { relationName: "coachRelationships" }),
}));

// 2. SAILORS Table (Core Identity)
export const sailors = pgTable("sailors", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  firstName: text("first_name").notNull(),
  lastName: text("last_name").notNull(),
  handle: text("handle").unique().notNull(), // URL friendly e.g. "ashlyn-t"
  sailNumber: text("sail_number").notNull(), // e.g. "SGP 115"
  club: text("club").notNull(), // e.g. "CSC", "SAFYC", "NSC"
  bio: text("bio"), // Short biography
  gender: text("gender"), // M or F
  nationalSquadStatus: text("national_squad_status"), // Nat A, Nat B, DS, or null
  instagram: text("instagram"), // Instagram handle
  facebook: text("facebook"), // Facebook URL
  natSquadStatusJan25: text("nat_squad_status_jan_25"),
  natSquadStatusJul25: text("nat_squad_status_jul_25"),
  natSquadStatusJan26: text("nat_squad_status_jan_26"),
  natSquadStatusJul26: text("nat_squad_status_jul_26"), // current
  histRankingJun24: integer("hist_ranking_jun_24"),
  histRankingDec24: integer("hist_ranking_dec_24"),
  histRankingJun25: integer("hist_ranking_jun_25"),
  histRankingDec25: integer("hist_ranking_dec_25"),
  histRankingJun26: integer("hist_ranking_jun_26"),
  worlds: integer("worlds_represented_year"),
  european: integer("european_represented_year"),
  asian: integer("asian_represented_year"),
  seaGames: integer("sea_games_represented_year"),
  dob: date("dob"), // Private field
  weight: integer("weight"), // Private field (in kg)
  
  // Fleet dates for half-year resolution
  goldEntryDate: date("gold_entry_date"),
  silverEntryDate: date("silver_entry_date"),
  dropDate: date("drop_date"),
  
  // Privacy settings
  isPublicWeight: boolean("is_public_weight").default(false).notNull(),
  isPublicDob: boolean("is_public_dob").default(false).notNull(),
  isPublicEquipment: boolean("is_public_equipment").default(false).notNull(),
  
  // Parent linking for sailors under 13
  parentId: uuid("parent_id").references(() => profiles.id, { onDelete: "set null" }),
  
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const sailorsRelations = relations(sailors, ({ one, many }) => ({
  parent: one(profiles, {
    fields: [sailors.parentId],
    references: [profiles.id],
    relationName: "parentOfSailors",
  }),
  boatClasses: many(sailorBoatClass),
  aliases: many(sailorAliases),
  regattaResults: many(regattaResults),
  coachingRelationships: many(coachingRelationships, { relationName: "sailorRelationships" }),
  equipmentLogs: many(equipmentLogs),
}));

// 3. BOAT CLASSES Table (Static: Optimist, ILCA4, 29er)
export const boatClasses = pgTable("boat_classes", {
  id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
  name: text("name").unique().notNull(), // e.g. "Optimist", "ILCA4", "29er"
});

export const boatClassesRelations = relations(boatClasses, ({ many }) => ({
  sailors: many(sailorBoatClass),
}));

// 4. SAILOR BOAT CLASS (Join Table)
export const sailorBoatClass = pgTable("sailor_boat_class", {
  sailorId: uuid("sailor_id").references(() => sailors.id, { onDelete: "cascade" }).notNull(),
  boatClassId: integer("boat_class_id").references(() => boatClasses.id, { onDelete: "cascade" }).notNull(),
  startDate: date("start_date").notNull(),
  endDate: date("end_date"),
  crewRole: text("crew_role"), // e.g., Skipper, Crew for double-handed like 29er
}, (table) => ({
  pk: primaryKey({ columns: [table.sailorId, table.boatClassId, table.startDate] }),
}));

export const sailorBoatClassRelations = relations(sailorBoatClass, ({ one }) => ({
  sailor: one(sailors, {
    fields: [sailorBoatClass.sailorId],
    references: [sailors.id],
  }),
  boatClass: one(boatClasses, {
    fields: [sailorBoatClass.boatClassId],
    references: [boatClasses.id],
  }),
}));

// 5. REGATTAS Table (Stores event metadata)
export const regattas = pgTable("regattas", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  name: text("name").notNull(),
  slug: text("slug").unique().notNull(), // URL slug e.g. "national-championship-2026"
  date: date("date").notNull(),
  totalFleetSize: integer("total_fleet_size").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const regattasRelations = relations(regattas, ({ many }) => ({
  results: many(regattaResults),
}));

// 6. REGATTA RESULTS Table (Links sailor to regatta)
export const regattaResults = pgTable("regatta_results", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  sailorId: uuid("sailor_id").references(() => sailors.id, { onDelete: "cascade" }).notNull(),
  regattaId: uuid("regatta_id").references(() => regattas.id, { onDelete: "cascade" }).notNull(),
  rank: integer("rank").notNull(),
  nettScore: integer("nett_score").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
}, (table) => ({
  unq: unique().on(table.sailorId, table.regattaId),
}));

export const regattaResultsRelations = relations(regattaResults, ({ one }) => ({
  sailor: one(sailors, {
    fields: [regattaResults.sailorId],
    references: [sailors.id],
  }),
  regatta: one(regattas, {
    fields: [regattaResults.regattaId],
    references: [regattas.id],
  }),
}));

// 7. SAILOR ALIASES Table (Stores name variations for reconciliation)
export const sailorAliases = pgTable("sailor_aliases", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  sailorId: uuid("sailor_id").references(() => sailors.id, { onDelete: "cascade" }).notNull(),
  aliasName: text("alias_name").unique().notNull(), // e.g. "Ashlyn T."
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export const sailorAliasesRelations = relations(sailorAliases, ({ one }) => ({
  sailor: one(sailors, {
    fields: [sailorAliases.sailorId],
    references: [sailors.id],
  }),
}));

// 8. COACHING RELATIONSHIPS Table (Links coaches to sailors with confirmations)
export const coachingRelationships = pgTable("coaching_relationships", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  coachId: uuid("coach_id").references(() => profiles.id, { onDelete: "cascade" }).notNull(),
  sailorId: uuid("sailor_id").references(() => sailors.id, { onDelete: "cascade" }).notNull(),
  status: text("status", { enum: ["pending", "confirmed", "rejected"] }).default("pending").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
}, (table) => ({
  unq: unique().on(table.coachId, table.sailorId),
}));

export const coachingRelationshipsRelations = relations(coachingRelationships, ({ one }) => ({
  coach: one(profiles, {
    fields: [coachingRelationships.coachId],
    references: [profiles.id],
    relationName: "coachRelationships",
  }),
  sailor: one(sailors, {
    fields: [coachingRelationships.sailorId],
    references: [sailors.id],
    relationName: "sailorRelationships",
  }),
}));

// 9. EQUIPMENT LOGS Table (Private by default, can be toggled public via sailor table setting)
export const equipmentLogs = pgTable("equipment_logs", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  sailorId: uuid("sailor_id").references(() => sailors.id, { onDelete: "cascade" }).notNull(),
  hullBrand: text("hull_brand").notNull(), // e.g., Winner, Carter
  sailMake: text("sail_make").notNull(), // e.g., J-Sails, Olimpic
  foilBrand: text("foil_brand").notNull(), // e.g., DSK, N1 Foils
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const equipmentLogsRelations = relations(equipmentLogs, ({ one }) => ({
  sailor: one(sailors, {
    fields: [equipmentLogs.sailorId],
    references: [sailors.id],
  }),
}));
