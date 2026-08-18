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

/**
 * Closed meta schema — drop anything else so callers cannot store emails,
 * names, free-text notes, or other PII in usage_events.
 */
export const USAGE_META_KEYS = [
  "vid",
  "source",
  "device",
  "refHost",
  "fleet",
  "year",
  "half",
  "intake",
  "mode",
  "status",
  "relation",
  "geography",
  "own",
  "ms",
  "topic",
  "role",
  "from",
  "to",
  "claimId",
  "matched",
  "created",
  "inputRows",
  "rowErrors",
  "nationalityUpdated",
] as const;

export type UsageMetaKey = (typeof USAGE_META_KEYS)[number];

const META_KEY_SET = new Set<string>(USAGE_META_KEYS);

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

function sanitizeMetaValue(
  value: unknown
): string | number | boolean | null | undefined {
  if (value == null) return null;
  if (typeof value === "boolean") return value;
  if (typeof value === "number") {
    return Number.isFinite(value) ? value : undefined;
  }
  if (typeof value === "string") {
    const trimmed = value.trim().slice(0, 80);
    return trimmed || null;
  }
  return undefined;
}

/** Keep only allowlisted scalar keys. */
export function sanitizeUsageMeta(
  raw: unknown
): Record<string, string | number | boolean | null> | null {
  if (!raw || typeof raw !== "object" || Array.isArray(raw)) return null;
  const out: Record<string, string | number | boolean | null> = {};
  for (const [key, value] of Object.entries(raw as Record<string, unknown>)) {
    if (!META_KEY_SET.has(key)) continue;
    const cleaned = sanitizeMetaValue(value);
    if (cleaned === undefined) continue;
    out[key] = cleaned;
  }
  return Object.keys(out).length ? out : null;
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
  const cleaned = sanitizeUsageMeta(input.meta);
  if (cleaned) {
    try {
      meta = JSON.stringify(cleaned).slice(0, 500);
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
