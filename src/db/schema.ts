import {
  pgTable,
  uuid,
  text,
  timestamp,
  integer,
  boolean,
  date,
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
  bio: text("bio"),
  gender: text("gender"),
  nationalSquadStatus: text("national_squad_status"),
  instagram: text("instagram"),
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
  worlds: integer("worlds_represented_year"),
  european: integer("european_represented_year"),
  asian: integer("asian_represented_year"),
  seaGames: integer("sea_games_represented_year"),
  dob: date("dob"),
  weight: integer("weight"),
  goldEntryDate: date("gold_entry_date"),
  silverEntryDate: date("silver_entry_date"),
  dropDate: date("drop_date"),
  isPublicWeight: boolean("is_public_weight").default(false).notNull(),
  isPublicDob: boolean("is_public_dob").default(false).notNull(),
  isPublicEquipment: boolean("is_public_equipment").default(false).notNull(),
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
    nettScore: integer("nett_score").notNull(),
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
