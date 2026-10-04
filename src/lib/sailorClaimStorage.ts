import { pgTable, text, timestamp, uuid } from "drizzle-orm/pg-core";

/** Query shape for databases where the optional referral column is not migrated. */
export const sailorClaimsWithoutReferral = pgTable("sailor_claims", {
  id: uuid("id").primaryKey().defaultRandom().notNull(),
  sailorId: uuid("sailor_id").notNull(),
  requesterId: uuid("requester_id").notNull(),
  status: text("status", { enum: ["pending", "approved", "rejected"] })
    .default("pending").notNull(),
  relation: text("relation", { enum: ["parent", "sailor", "other"] }),
  source: text("source", { enum: ["user", "admin"] }).default("user").notNull(),
  note: text("note"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

/** Drizzle wraps PostgreSQL errors in cause; don't mistake other DB errors for this one. */
export function isMissingReferralColumn(error: unknown): boolean {
  let current = error;
  for (let depth = 0; current && typeof current === "object" && depth < 6; depth++) {
    const value = current as { message?: unknown; cause?: unknown };
    if (typeof value.message === "string" &&
      /column [^\n]*heard_about[^\n]*does not exist/i.test(value.message)) return true;
    current = value.cause;
  }
  return false;
}
