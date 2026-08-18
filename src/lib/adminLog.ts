/**
 * Structured admin mutation logging (JSON lines for Vercel / log drains).
 * Complements DB audit trail in `logAdminChange`.
 */

export type AdminLogOutcome = "ok" | "error" | "denied";

export type AdminLogEvent = {
  /** Correlate a single HTTP request */
  requestId?: string;
  action: string;
  path?: string;
  role?: string | null;
  actorUserId?: string | null;
  actorEmail?: string | null;
  entityType?: string;
  entityId?: string | null;
  entityLabel?: string | null;
  outcome: AdminLogOutcome;
  /** Wall-clock duration in ms */
  ms?: number;
  error?: string;
  /** Small non-PII extras */
  meta?: Record<string, string | number | boolean | null>;
};

export function createAdminRequestId(): string {
  if (typeof crypto !== "undefined" && "randomUUID" in crypto) {
    return crypto.randomUUID().slice(0, 8);
  }
  return `a${Date.now().toString(36).slice(-7)}`;
}

/** Emit one structured log line. Never throws. */
export function adminLog(event: AdminLogEvent): void {
  try {
    const line = {
      ts: new Date().toISOString(),
      scope: "admin",
      ...event,
      error: event.error ? String(event.error).slice(0, 240) : undefined,
    };
    if (event.outcome === "error" || event.outcome === "denied") {
      console.error(JSON.stringify(line));
    } else {
      console.info(JSON.stringify(line));
    }
  } catch {
    /* never break the request */
  }
}

/** Helper: time a mutation and log ok/error. */
export async function withAdminLog<T>(
  base: Omit<AdminLogEvent, "outcome" | "ms" | "error">,
  fn: () => Promise<T>
): Promise<T> {
  const t0 = Date.now();
  try {
    const result = await fn();
    adminLog({ ...base, outcome: "ok", ms: Date.now() - t0 });
    return result;
  } catch (e) {
    adminLog({
      ...base,
      outcome: "error",
      ms: Date.now() - t0,
      error: e instanceof Error ? e.message : String(e),
    });
    throw e;
  }
}
