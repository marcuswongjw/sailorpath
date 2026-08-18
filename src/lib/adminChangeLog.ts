/**
 * Fail-soft admin audit trail (may include names — superadmin only).
 * Also emits a structured console line via `adminLog` for log drains.
 */

import { db } from "@/db";
import { adminChangeLog } from "@/db/schema";
import { desc } from "drizzle-orm";
import { adminLog } from "@/lib/adminLog";

export type AdminChangeInput = {
  actorUserId?: string | null;
  actorEmail?: string | null;
  action: string;
  entityType: string;
  entityId?: string | null;
  entityLabel?: string | null;
  summary: string;
  details?: unknown;
  source?: string | null;
  /** Optional correlation id from the HTTP handler */
  requestId?: string | null;
};

export async function logAdminChange(
  input: AdminChangeInput
): Promise<{ ok: boolean; skipped?: string }> {
  try {
    let details: string | null = null;
    if (input.details !== undefined) {
      try {
        details = JSON.stringify(input.details).slice(0, 8000);
      } catch {
        details = null;
      }
    }
    await db.insert(adminChangeLog).values({
      actorUserId: input.actorUserId || null,
      actorEmail: input.actorEmail?.slice(0, 200) || null,
      action: String(input.action).slice(0, 80),
      entityType: String(input.entityType).slice(0, 40),
      entityId: input.entityId || null,
      entityLabel: input.entityLabel?.slice(0, 200) || null,
      summary: String(input.summary).slice(0, 500),
      details,
      source: input.source?.slice(0, 120) || null,
    });
    adminLog({
      requestId: input.requestId || undefined,
      action: input.action,
      path: input.source || undefined,
      actorUserId: input.actorUserId,
      actorEmail: input.actorEmail,
      entityType: input.entityType,
      entityId: input.entityId,
      entityLabel: input.entityLabel,
      outcome: "ok",
      meta: { summary: String(input.summary).slice(0, 120) },
    });
    return { ok: true };
  } catch (e) {
    const msg = e instanceof Error ? e.message : String(e);
    adminLog({
      requestId: input.requestId || undefined,
      action: input.action,
      path: input.source || undefined,
      actorUserId: input.actorUserId,
      actorEmail: input.actorEmail,
      entityType: input.entityType,
      entityId: input.entityId,
      outcome: "error",
      error: msg,
    });
    if (/admin_change_log|does not exist|relation/i.test(msg)) {
      return {
        ok: false,
        skipped: "admin_change_log missing — run 023_admin_change_log.sql",
      };
    }
    console.warn("logAdminChange", e);
    return { ok: false, skipped: msg.slice(0, 120) };
  }
}

export async function listAdminChanges(opts?: {
  limit?: number;
  days?: number;
}): Promise<
  {
    id: string;
    createdAt: Date;
    actorEmail: string | null;
    action: string;
    entityType: string;
    entityId: string | null;
    entityLabel: string | null;
    summary: string;
    details: string | null;
    source: string | null;
  }[]
> {
  const limit = Math.min(200, Math.max(1, opts?.limit ?? 50));
  const days = opts?.days ?? 30;
  const since = new Date(Date.now() - days * 86400000);
  try {
    const rows = await db
      .select()
      .from(adminChangeLog)
      .orderBy(desc(adminChangeLog.createdAt))
      .limit(limit);
    return rows
      .filter((r) => !r.createdAt || r.createdAt >= since)
      .map((r) => ({
        id: r.id,
        createdAt: r.createdAt,
        actorEmail: r.actorEmail,
        action: r.action,
        entityType: r.entityType,
        entityId: r.entityId,
        entityLabel: r.entityLabel,
        summary: r.summary,
        details: r.details,
        source: r.source,
      }));
  } catch {
    return [];
  }
}
