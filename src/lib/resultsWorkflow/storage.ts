import { createHash } from "node:crypto";
import { desc, eq, sql } from "drizzle-orm";
import { db } from "@/db";
import { regattaEvents, regattas, resultImportMonitors, resultImportScans, resultMonitorRuns } from "@/db/schema";
import { todayYmdSg } from "@/lib/datesSg";
import { scanEventResults } from "./scan";
import type { ResultsScan } from "./types";

export async function resultsImportInventory() {
  const [events, monitors, sheets] = await Promise.all([
    db.select().from(regattaEvents), db.select({ eventId: resultImportMonitors.eventId, eventUrl: resultImportMonitors.eventUrl, enabled: resultImportMonitors.enabled, checkedAt: resultImportMonitors.checkedAt, lastStatus: sql<string | null>`${resultImportMonitors.report}->>'status'` }).from(resultImportMonitors),
    db.select({ id: regattas.id, eventId: regattas.eventId, name: regattas.name, date: regattas.date, boatClass: regattas.boatClass, division: regattas.division, geography: regattas.geography, countsForRanking: regattas.countsForRanking }).from(regattas),
  ]);
  const byEvent = new Map(monitors.map((m) => [m.eventId, m]));
  return events.map((event) => {
    const monitor = byEvent.get(event.id);
    return { ...event, eventUrl: monitor?.eventUrl || event.registrationUrl || event.norUrl || "", enabled: monitor?.enabled ?? true, checkedAt: monitor?.checkedAt ?? null, report: null as ResultsScan | null, lastStatus: monitor?.lastStatus ?? null, sheets: sheets.filter((s) => s.eventId === event.id) };
  }).sort((a, b) => b.startDate.localeCompare(a.startDate));
}

export async function resultsImportReport(eventId: string) {
  const [row] = await db.select({ report: resultImportMonitors.report }).from(resultImportMonitors).where(eq(resultImportMonitors.eventId, eventId));
  return row?.report ?? null;
}

async function scanResultsBatch(eventId?: string, dryRun = false) {
  const today = todayYmdSg();
  const oldest = new Date(`${today}T00:00:00Z`);
  oldest.setUTCDate(oldest.getUTCDate() - 45);
  const lower = oldest.toISOString().slice(0, 10);
  const inventory = await resultsImportInventory();
  // A bounded rotating batch, including already reviewed events to discover revisions.
  const targets = eventId ? inventory.filter((e) => e.id === eventId) : inventory
    .filter((e) => e.enabled && e.eventUrl && (e.endDate || e.startDate) < today && (e.endDate || e.startDate) >= lower && (!e.checkedAt || Date.now() - new Date(e.checkedAt).getTime() > 20 * 60 * 60 * 1000))
    .sort((a, b) => String(a.checkedAt || "").localeCompare(String(b.checkedAt || "")))
    .slice(0, 3);
  if (eventId && !targets.length) throw new Error("Regatta event not found.");
  const outcomes = [];
  for (const event of targets) {
    if (!event.eventUrl) throw new Error("Add an event or results URL first.");
    let report: ResultsScan;
    try {
      report = await scanEventResults(event.eventUrl);
    } catch {
      report = { checkedAt: new Date().toISOString(), status: "error", sources: [], searchedUrls: [event.eventUrl], errors: ["Source scan failed. Retry the event check."], pdfCorroboration: "not_found_in_checked_pages" };
    }
    if (!dryRun) {
      await db.transaction(async (tx) => {
        // Serialise overlapping cron/manual writes for this event.
        await tx.execute(sql`select id from regatta_events where id = ${event.id} for update`);
        const [current] = await tx.select().from(resultImportMonitors).where(eq(resultImportMonitors.eventId, event.id));
        if (current?.checkedAt && current.checkedAt > new Date(report.checkedAt)) return;
        if (current?.eventUrl && current.eventUrl !== event.eventUrl) return;
        const fingerprint = createHash("sha256").update(JSON.stringify({ ...report, checkedAt: undefined })).digest("hex");
        await tx.insert(resultImportScans).values({ eventId: event.id, fingerprint, report }).onConflictDoNothing();
        await tx.insert(resultImportMonitors).values({ eventId: event.id, checkedAt: new Date(report.checkedAt), report })
          .onConflictDoUpdate({ target: resultImportMonitors.eventId, set: { checkedAt: new Date(report.checkedAt), report } });
      });
    }
    outcomes.push({ eventId: event.id, name: event.name, report });
  }
  return { dryRun, outcomes };
}

export async function saveResultsMonitor(eventId: string, eventUrl: string, enabled: boolean) {
  const [event] = await db.select({ id: regattaEvents.id }).from(regattaEvents).where(eq(regattaEvents.id, eventId));
  if (!event) throw new Error("Regatta event not found.");
  await db.insert(resultImportMonitors).values({ eventId, eventUrl: eventUrl || null, enabled })
    .onConflictDoUpdate({ target: resultImportMonitors.eventId, set: { eventUrl: eventUrl || null, enabled, checkedAt: null, report: null } });
}

export async function runResultsScan(eventId?: string, dryRun = false) {
  if (dryRun) return scanResultsBatch(eventId, true);
  const [run] = await db.insert(resultMonitorRuns).values({ trigger: eventId ? "manual" : "scheduled", status: "running" }).returning({ id: resultMonitorRuns.id });
  try {
    const result = await scanResultsBatch(eventId);
    const failedCount = result.outcomes.filter((o) => o.report.status === "error").length;
    await db.update(resultMonitorRuns).set({ status: failedCount ? "failed" : "succeeded", finishedAt: new Date(), checkedCount: result.outcomes.length, failedCount }).where(eq(resultMonitorRuns.id, run.id));
    return result;
  } catch (error) {
    await db.update(resultMonitorRuns).set({ status: "failed", finishedAt: new Date() }).where(eq(resultMonitorRuns.id, run.id));
    throw error;
  }
}

export async function resultsMonitorHealth() {
  const recentRuns = await db.select().from(resultMonitorRuns).orderBy(desc(resultMonitorRuns.startedAt)).limit(10);
  const [lastSuccess] = await db.select().from(resultMonitorRuns).where(eq(resultMonitorRuns.status, "succeeded")).orderBy(desc(resultMonitorRuns.startedAt)).limit(1);
  const [lastFailure] = await db.select().from(resultMonitorRuns).where(eq(resultMonitorRuns.status, "failed")).orderBy(desc(resultMonitorRuns.startedAt)).limit(1);
  return {
    enabled: process.env.RESULTS_MONITOR_ENABLED === "true",
    schedulerConfigured: Boolean(process.env.CRON_SECRET),
    schedule: "Daily at 09:00 Singapore time",
    batchLimit: 3,
    lookbackDays: 45,
    publication: "admin_review" as const,
    recentRuns: recentRuns.map((run) => ({ ...run, status: run.status === "running" && Date.now() - run.startedAt.getTime() > 10 * 60 * 1000 ? "interrupted" : run.status })), lastSuccess: lastSuccess ?? null, lastFailure: lastFailure ?? null,
  };
}
