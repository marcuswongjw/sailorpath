/**
 * Privacy-light product usage tracking.
 * Prefer DB (usage_events). Never store emails, names, or full query strings.
 */

import { db } from "@/db";
import { usageEvents } from "@/db/schema";

export const USAGE_EVENT_TYPES = [
  "page_view",
  "ranking_view",
  "profile_view",
  "search",
  "sample_view",
  "claim_submit",
  "claim_approved",
  "claim_rejected",
  "import",
  "support_submit",
  "waitlist_submit",
  "login",
  "register",
  "admin_open",
  "demo_role_switch",
  "ranking_period_change",
  "nav_perf",
] as const;

export type UsageEventType = (typeof USAGE_EVENT_TYPES)[number] | string;

export type TrackUsageInput = {
  eventType: UsageEventType;
  path?: string | null;
  role?: string | null;
  sessionId?: string | null;
  meta?: Record<string, string | number | boolean | null> | undefined | null;
};

/** Strip query/hash; cap length; only allow path-like strings. */
export function sanitizePath(raw: unknown): string | null {
  if (raw == null || raw === "") return null;
  let s = String(raw).trim();
  s = s.split("?")[0].split("#")[0];
  if (!s.startsWith("/")) s = `/${s}`;
  if (s.length > 200) s = s.slice(0, 200);
  if (/[\x00-\x1f]/.test(s)) return null;
  return s;
}

export async function trackUsage(
  input: TrackUsageInput
): Promise<{ ok: boolean; skipped?: string }> {
  const eventType = String(input.eventType || "").trim().slice(0, 64);
  if (!eventType) return { ok: false, skipped: "missing eventType" };

  const path = sanitizePath(input.path);
  const role =
    input.role != null && String(input.role).trim()
      ? String(input.role).trim().slice(0, 32)
      : null;
  const sessionId =
    input.sessionId != null && String(input.sessionId).trim()
      ? String(input.sessionId).trim().slice(0, 64)
      : null;
  let meta: string | null = null;
  if (input.meta && typeof input.meta === "object") {
    try {
      meta = JSON.stringify(input.meta).slice(0, 500);
    } catch {
      meta = null;
    }
  }

  try {
    await db.insert(usageEvents).values({
      eventType,
      path,
      role,
      sessionId,
      meta,
    });
    return { ok: true };
  } catch (e) {
    const msg = e instanceof Error ? e.message : String(e);
    if (/usage_events|does not exist|relation/i.test(msg)) {
      return {
        ok: false,
        skipped: "usage_events table missing — run migration 016",
      };
    }
    console.error("[usage] track failed", msg.slice(0, 200));
    return { ok: false, skipped: "db error" };
  }
}
