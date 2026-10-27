import { createServerSupabase } from "@/lib/supabase/server";
import {
  db,
  DbUnavailableError,
  formatDbError,
  isRetryableDatabaseConnectionError,
  withDatabaseRetry,
  withDatabaseDeadline,
} from "@/db";
import { profiles } from "@/db/schema";
import { eq } from "drizzle-orm";
import {
  superadminRoleDecision,
  type AppRole,
} from "@/lib/superadminEmail";

export type { AppRole } from "@/lib/superadminEmail";
export {
  isConfiguredSuperadminEmail,
  superadminRoleDecision,
} from "@/lib/superadminEmail";

/** Explicit application deadline for Supabase Auth `getUser()` per attempt. */
export const AUTH_GET_USER_TIMEOUT_MS = 5_000;
/** Explicit application deadline for the `profiles` role lookup per attempt. */
export const AUTH_PROFILE_LOOKUP_TIMEOUT_MS = 4_000;
/** Includes provider retries, profile reads and any initial profile sync. */
export const AUTH_CONTEXT_TIMEOUT_MS = 8_000;
/** Emit structured phase timings when authorization takes at least 1s. */
export const AUTH_SLOW_THRESHOLD_MS = 1_000;

export type AuthContext = {
  userId: string;
  email: string | null;
  role: AppRole;
  lastSeenProductChangelogAt?: string | null;
};

function withAuthDeadline<T>(
  operation: Promise<T>,
  timeoutMs: number,
  errorCode: string
): Promise<T> {
  return new Promise<T>((resolve, reject) => {
    const timer = setTimeout(() => reject(new Error(errorCode)), timeoutMs);
    operation.then(resolve, reject).finally(() => clearTimeout(timer));
  });
}

function isTransientAuthError(message: string): boolean {
  return /\b(?:AUTH_GET_USER_TIMEOUT|ETIMEDOUT|ECONNRESET|ECONNREFUSED|EAI_AGAIN|UND_ERR_CONNECT_TIMEOUT|UND_ERR_SOCKET)\b|fetch failed|network|timeout|socket hang up|502|503|504/i.test(
    message
  );
}

export async function getAuthContext(signal?: AbortSignal): Promise<AuthContext | null> {
  try {
    return await withDatabaseDeadline(getAuthContextWithinDeadline, AUTH_CONTEXT_TIMEOUT_MS, signal);
  } catch (error) {
    if (isRetryableDatabaseConnectionError(formatDbError(error))) {
      throw new DbUnavailableError("Authentication service temporarily unavailable");
    }
    throw error;
  }
}

async function getAuthContextWithinDeadline(): Promise<AuthContext | null> {
  const requestStart = Date.now();
  let supabase: Awaited<ReturnType<typeof createServerSupabase>>;
  try {
    supabase = await createServerSupabase();
  } catch (error) {
    // Local/static environments without auth configuration should render as
    // signed out instead of taking the whole page through the error boundary.
    if (
      error instanceof Error &&
      /Missing NEXT_PUBLIC_SUPABASE_URL|Missing NEXT_PUBLIC_SUPABASE_ANON_KEY/.test(
        error.message
      )
    ) {
      return null;
    }
    throw error;
  }

  const authStart = Date.now();
  let user: Awaited<ReturnType<typeof supabase.auth.getUser>>["data"]["user"] =
    null;
  for (let attempt = 1; attempt <= 2; attempt += 1) {
    try {
      const result = await withAuthDeadline(
        supabase.auth.getUser(),
        AUTH_GET_USER_TIMEOUT_MS,
        "AUTH_GET_USER_TIMEOUT"
      );
      if (result.error && isTransientAuthError(result.error.message || "")) {
        throw new Error(result.error.message || "AUTH_GET_USER_FAILED");
      }
      user = result.data?.user ?? null;
      break;
    } catch (authError) {
      const msg = formatDbError(authError);
      if (attempt === 1 && isTransientAuthError(msg)) {
        console.warn("[auth] phase=getUser outcome=retry", {
          attempt,
          authMs: Date.now() - authStart,
          error: msg.slice(0, 240),
        });
        await new Promise<void>((resolve) => setTimeout(resolve, 100));
        continue;
      }
      console.error("[auth] phase=getUser outcome=unavailable", {
        attempt,
        authMs: Date.now() - authStart,
        totalMs: Date.now() - requestStart,
        error: msg.slice(0, 240),
      });
      throw new DbUnavailableError(
        "Authentication service temporarily unavailable"
      );
    }
  }
  const authMs = Date.now() - authStart;

  if (!user) return null;

  const dbStart = Date.now();
  let rows: Array<{
    role: string | null;
    lastSeenProductChangelogAt?: Date | string | null;
  }>;
  try {
    rows = await withDatabaseRetry(
      async () => {
        try {
          return await db
            .select({
              role: profiles.role,
              lastSeenProductChangelogAt: profiles.lastSeenProductChangelogAt,
            })
            .from(profiles)
            .where(eq(profiles.id, user.id))
            .limit(1);
        } catch (colError) {
          const colMsg = formatDbError(colError);
          if (/last_seen_product_changelog_at|does not exist/i.test(colMsg)) {
            const fallback = await db
              .select({ role: profiles.role })
              .from(profiles)
              .where(eq(profiles.id, user.id))
              .limit(1);
            return fallback.map((r) => ({
              ...r,
              lastSeenProductChangelogAt: null,
            }));
          }
          throw colError;
        }
      },
      {
        timeoutMs: AUTH_PROFILE_LOOKUP_TIMEOUT_MS,
        label: "auth.profile_lookup",
      }
    );
  } catch (dbError) {
    const dbMs = Date.now() - dbStart;
    const totalMs = Date.now() - requestStart;
    console.error("[auth] phase=profileLookup outcome=unavailable", {
      userId: user.id,
      authMs,
      dbMs,
      totalMs,
      error: formatDbError(dbError).slice(0, 240),
    });
    throw new DbUnavailableError(
      "Database temporarily unavailable while verifying account role"
    );
  }

  let role: AppRole = "sailor";
  let lastSeenProductChangelogAt: string | null = null;
  const stored = (rows[0]?.role as AppRole | undefined) ?? null;
  const decision = superadminRoleDecision(stored, user.email);
  if (stored) role = stored;
  const rawLastSeen = rows[0]?.lastSeenProductChangelogAt;
  if (rawLastSeen) {
    lastSeenProductChangelogAt =
      rawLastSeen instanceof Date
        ? rawLastSeen.toISOString()
        : String(rawLastSeen);
  }

  if (!rows[0] || decision.persistSuperadmin) {
    try {
      if (!rows[0]) {
        const fullName =
          (user.user_metadata?.full_name as string) ||
          (user.user_metadata?.handle as string) ||
          user.email?.split("@")[0] ||
          "User";
        await db
          .insert(profiles)
          .values({
            id: user.id,
            email: user.email || "",
            fullName,
            role: decision.role,
          })
          .onConflictDoNothing();
        if (!decision.persistSuperadmin) role = decision.role;
      }
      if (decision.persistSuperadmin) {
        const updated = await db
          .update(profiles)
          .set({ role: "superadmin", updatedAt: new Date() })
          .where(eq(profiles.id, user.id))
          .returning({ role: profiles.role });
        if (updated[0]?.role === "superadmin") role = "superadmin";
      }
    } catch (writeError) {
      // Keep a role already read from profiles. Do not elevate from the env var
      // when that write did not succeed.
      console.warn("[auth] phase=profileSync outcome=write_skipped", {
        userId: user.id,
        error: formatDbError(writeError).slice(0, 240),
      });
    }
  }

  const dbMs = Date.now() - dbStart;
  const totalMs = Date.now() - requestStart;
  if (totalMs >= AUTH_SLOW_THRESHOLD_MS) {
    console.warn("[auth] outcome=slow", {
      userId: user.id,
      role,
      authMs,
      dbMs,
      totalMs,
    });
  }

  return {
    userId: user.id,
    email: user.email ?? null,
    role,
    lastSeenProductChangelogAt,
  };
}

export async function requireSuperadmin(signal?: AbortSignal): Promise<AuthContext> {
  return requireRoles(["superadmin"], signal);
}

/** Require an authenticated coach workspace user. Superadmins retain access for support/testing. */
export async function requireCoach(): Promise<AuthContext> {
  return requireRoles(["coach", "superadmin"]);
}

async function requireRoles(roles: AppRole[], signal?: AbortSignal): Promise<AuthContext> {
  const ctx = await getAuthContext(signal);
  if (!ctx) {
    const err = new Error("UNAUTHORIZED");
    (err as Error & { status: number }).status = 401;
    throw err;
  }
  if (!roles.includes(ctx.role)) {
    const err = new Error("FORBIDDEN");
    (err as Error & { status: number }).status = 403;
    throw err;
  }
  return ctx;
}

export function jsonError(error: unknown) {
  // Always log internal server errors so they appear in Vercel / server logs
  console.error("[jsonError]", error);

  const rawMsg = error instanceof Error ? error.message : String(error || "Error");
  const dbDetail = formatDbError(error);
  const fullText = `${rawMsg} ${dbDetail}`;
  const explicitStatus = (error as { status?: number } | null)?.status;
  const isTemporarilyUnavailable =
    error instanceof DbUnavailableError ||
    explicitStatus === 503 ||
    isRetryableDatabaseConnectionError(fullText) ||
    /Authentication service temporarily unavailable|Database temporarily unavailable/i.test(
      fullText
    );

  const status =
    rawMsg === "UNAUTHORIZED"
      ? 401
      : rawMsg === "FORBIDDEN"
        ? 403
        : isTemporarilyUnavailable
          ? 503
          : 500;

  const isProduction = process.env.NODE_ENV === "production";

  let publicMsg: string;
  let detail: string | undefined;

  if (rawMsg === "UNAUTHORIZED") {
    publicMsg = "Not signed in";
  } else if (rawMsg === "FORBIDDEN") {
    publicMsg = "You do not have access to this area";
  } else if (isTemporarilyUnavailable) {
    publicMsg =
      "Temporary service timeout while connecting to the database. Please retry in a moment.";
    if (!isProduction) detail = dbDetail ? dbDetail.slice(0, 500) : rawMsg.slice(0, 500);
  } else if (isProduction) {
    publicMsg = "Internal error";
  } else {
    // Development: surface full messages for debugging
    publicMsg = dbDetail && dbDetail.length < 280 ? dbDetail : rawMsg.length < 280 ? rawMsg : rawMsg.slice(0, 240) + "…";
    detail = dbDetail ? dbDetail.slice(0, 500) : rawMsg.slice(0, 500);
  }

  const body: Record<string, string> = { error: publicMsg };
  if (detail) body.detail = detail;

  return Response.json(body, {
    status,
    headers: { "Cache-Control": "private, no-store", ...(isTemporarilyUnavailable ? { "Retry-After": "2" } : {}) },
  });
}
