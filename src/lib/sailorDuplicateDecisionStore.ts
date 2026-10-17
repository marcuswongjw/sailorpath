import { desc, inArray, sql } from "drizzle-orm";
import { db } from "@/db";
import { adminChangeLog, sailors } from "@/db/schema";
import { duplicatePairKey, type SailorDuplicateDecision } from "./sailorDuplicateDecisions";

type Reader = Pick<typeof db, "select">;
const actions = ["sailors.duplicates.keep_separate", "sailors.duplicates.reopen"];

/** The existing private audit ledger is append-only decision history. */
export async function getSeparateSailorPairs(reader: Reader = db): Promise<SailorDuplicateDecision[]> {
  const history = await reader.select({ action: adminChangeLog.action, details: adminChangeLog.details })
    .from(adminChangeLog).where(inArray(adminChangeLog.action, actions))
    .orderBy(desc(adminChangeLog.createdAt), desc(adminChangeLog.id));
  const seen = new Set<string>();
  const active: SailorDuplicateDecision[] = [];
  for (const row of history) {
    const d = row.details as SailorDuplicateDecision | null;
    if (!d || typeof d.aId !== "string" || typeof d.bId !== "string") continue;
    const key = duplicatePairKey(d.aId, d.bId);
    if (seen.has(key)) continue;
    seen.add(key);
    if (row.action === actions[0]) active.push({ ...d, pairKey: key });
  }
  if (!active.length) return [];
  const ids = [...new Set(active.flatMap(d => [d.aId, d.bId]))];
  const existing = new Set((await reader.select({ id: sailors.id }).from(sailors)
    .where(inArray(sailors.id, ids))).map(s => s.id));
  // Deleted profiles no longer form an actionable pair. Their decision remains
  // in the audit ledger and must not block an unrelated future merge.
  return active.filter(d => existing.has(d.aId) && existing.has(d.bId));
}

/** Include reopened reviews in merge-token freshness, even after suppression ends. */
export async function sailorDuplicateReviewRevision(reader: Reader, ids: string[]) {
  const history = await reader.select({ id: adminChangeLog.id, details: adminChangeLog.details })
    .from(adminChangeLog).where(inArray(adminChangeLog.action, actions)).orderBy(adminChangeLog.id);
  return history.filter(row => {
    const d = row.details as SailorDuplicateDecision | null;
    return d && (ids.includes(d.aId) || ids.includes(d.bId));
  }).map(row => row.id);
}

export async function saveSailorDuplicateDecision(input: {
  aId: string; bId: string; reason: string; separate: boolean;
  actor: { userId: string; email: string | null };
}) {
  return db.transaction(async tx => {
    // Same locks/order as merge preflight: a decision cannot race a merge.
    const rows = await tx.select({ id: sailors.id, name: sailors.name }).from(sailors)
      .where(inArray(sailors.id, [input.aId, input.bId])).orderBy(sailors.id).for("update");
    if (rows.length !== 2) throw new Error("Both sailor profiles must still exist.");
    const [a, b] = rows;
    const decision = { pairKey: duplicatePairKey(a.id, b.id), aId: a.id, bId: b.id,
      aName: a.name, bName: b.name, reason: input.reason };
    // clock_timestamp reflects lock acquisition order, including waiting requests.
    await tx.insert(adminChangeLog).values({
      action: input.separate ? actions[0] : actions[1], entityType: "sailor", entityId: a.id,
      entityLabel: `${a.name} / ${b.name}`, actorUserId: input.actor.userId,
      actorEmail: input.actor.email, createdAt: sql`clock_timestamp()`,
      summary: input.separate ? "Confirmed these are different sailors." : "Reopened sailor identity review.",
      details: decision, source: "admin-duplicate-review",
    });
    return decision;
  });
}
