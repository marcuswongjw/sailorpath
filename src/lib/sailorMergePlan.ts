import { getSeparateSailorPairs } from "./sailorDuplicateDecisionStore";
import { createHash } from "node:crypto";
import { inArray } from "drizzle-orm";
import { db } from "@/db";
import { regattaRaceResults, regattaResultParticipants, regattaResults, regattas, sailors } from "@/db/schema";
import { sailorIdentityConflicts } from "@/lib/sailorMergeIdentity";

type Transaction = Parameters<Parameters<typeof db.transaction>[0]>[0];

/** Called again inside the mutation transaction, before the first write. */
export async function buildSailorMergePlan(tx: Transaction, keepId: string, mergeId: string) {
  const profiles = await tx.select().from(sailors)
    .where(inArray(sailors.id, [keepId, mergeId])).orderBy(sailors.id).for("update");
  const keep = profiles.find(s => s.id === keepId);
  const source = profiles.find(s => s.id === mergeId);
  if (!keep || !source) throw Object.assign(new Error("Both sailor profiles must still exist."), { status: 404 });
  const results = await tx.select().from(regattaResults)
    .where(inArray(regattaResults.sailorId, [keepId, mergeId])).orderBy(regattaResults.id).for("update");
  const memberships = await tx.select().from(regattaResultParticipants)
    .where(inArray(regattaResultParticipants.sailorId, [keepId, mergeId])).orderBy(regattaResultParticipants.id).for("update");
  const entryIds = [...new Set([...results.map(r => r.id), ...memberships.map(p => p.regattaResultId)])];
  const entries = entryIds.length ? await tx.select({ id: regattaResults.id, regattaId: regattaResults.regattaId, entryType: regattaResults.entryType })
    .from(regattaResults).where(inArray(regattaResults.id, entryIds)).orderBy(regattaResults.id) : [];
  const races = entryIds.length ? await tx.select().from(regattaRaceResults)
    .where(inArray(regattaRaceResults.regattaResultId, entryIds)).orderBy(regattaRaceResults.id).for("update") : [];
  const entryById = new Map(entries.map(r => [r.id, r]));
  const keepSheets = new Set(results.filter(r => r.sailorId === keepId).map(r => r.regattaId));
  for (const p of memberships.filter(p => p.sailorId === keepId)) {
    const entry = entryById.get(p.regattaResultId);
    if (entry) keepSheets.add(entry.regattaId);
  }
  const sourceSheets = new Set(results.filter(r => r.sailorId === mergeId).map(r => r.regattaId));
  for (const p of memberships.filter(p => p.sailorId === mergeId)) {
    const entry = entryById.get(p.regattaResultId);
    if (entry) sourceSheets.add(entry.regattaId);
  }
  const sharedSheetIds = [...sourceSheets].filter(id => keepSheets.has(id));
  const sharedSheets = sharedSheetIds.length ? await tx.select({ id: regattas.id, name: regattas.name })
    .from(regattas).where(inArray(regattas.id, sharedSheetIds)) : [];
  const separatePairs = (await getSeparateSailorPairs(tx)).filter(d =>
    [d.aId, d.bId].includes(mergeId) || [d.aId, d.bId].includes(keepId));
  const conflicts = sailorIdentityConflicts(keep, source);
  for (const decision of separatePairs) {
    // Do not transfer a reviewed identity relationship implicitly through a merge.
    conflicts.push(`A confirmed-different decision involves ${decision.aName} / ${decision.bName}. Reopen that review before merging.`);
  }
  if (keepId === mergeId) conflicts.push("Choose two different profiles.");
  // Conservative: even identical/DNS rows require a source-backed result repair first.
  for (const sheet of sharedSheets) conflicts.push(`Both profiles have entries in ${sheet.name}. Resolve the official entries before merging.`);
  const sameEntry = memberships.some(a => a.sailorId === keepId && memberships.some(b => b.sailorId === mergeId && a.regattaResultId === b.regattaResultId));
  if (sameEntry) conflicts.push("Both profiles are linked to the same crew entry; resolve participant identities first.");
  const token = createHash("sha256").update(JSON.stringify({ keepId, mergeId, profiles, results, memberships, races, separatePairs })).digest("hex");
  const profile = (s: typeof keep) => ({ id: s.id, name: s.name, handle: s.handle, sailNumber: s.sailNumber, sailNumberIlca4: s.sailNumberIlca4, boardNumber: s.boardNumber, nationality: s.nationality, gender: s.gender, claimed: Boolean(s.parentId) });
  const sourceResultIds = new Set(results.filter(r => r.sailorId === mergeId).map(r => r.id));
  return {
    keep: profile(keep), source: profile(source),
    resultsToMove: sourceResultIds.size,
    raceScoresPreserved: races.filter(r => sourceResultIds.has(r.regattaResultId)).length,
    participantLinksToMove: memberships.filter(p => p.sailorId === mergeId).length,
    evidenceLinksPreserved: results.filter(r => r.sailorId === mergeId && (r.officialUrl || r.evidenceUrl)).length,
    conflicts, canMerge: conflicts.length === 0, reviewToken: token,
    requiredReview: "Confirm identity using official source names and sail/board numbers. All existing scored entries and evidence will be preserved; conflicting entries require correction first.",
  };
}

export function getSailorMergePlan(keepId: string, mergeId: string) {
  return db.transaction(tx => buildSailorMergePlan(tx, keepId, mergeId));
}

export type SailorMergePlan = Awaited<ReturnType<typeof getSailorMergePlan>>;
