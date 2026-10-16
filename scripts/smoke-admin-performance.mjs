import { performance } from "node:perf_hooks";
import { createBrowserClient } from "@supabase/ssr";

const required = [
  "SMOKE_SUPABASE_URL",
  "SMOKE_SUPABASE_ANON_KEY",
  "SMOKE_ADMIN_EMAIL",
  "SMOKE_ADMIN_PASSWORD",
];
const missing = required.filter((name) => !process.env[name]?.trim());
if (missing.length > 0) {
  throw new Error(`Missing production smoke secrets: ${missing.join(", ")}`);
}

const baseUrl = (process.env.SMOKE_BASE_URL || "https://admin.sailorpath.com").replace(
  /\/$/,
  ""
);
const smokeHost = new URL(baseUrl).hostname.toLowerCase();
const authCookieName =
  smokeHost === "admin.sailorpath.com"
    ? "sailorpath-admin-auth"
    : "sailorpath-public-auth";
const cookieJar = new Map();
const supabase = createBrowserClient(
  process.env.SMOKE_SUPABASE_URL,
  process.env.SMOKE_SUPABASE_ANON_KEY,
  {
    isSingleton: false,
    cookieOptions: { name: authCookieName },
    cookies: {
      getAll: () =>
        [...cookieJar].map(([name, value]) => ({ name, value })),
      setAll: (cookies) => {
        for (const cookie of cookies) {
          if (cookie.value) cookieJar.set(cookie.name, cookie.value);
          else cookieJar.delete(cookie.name);
        }
      },
    },
  }
);

const { error: signInError } = await supabase.auth.signInWithPassword({
  email: process.env.SMOKE_ADMIN_EMAIL,
  password: process.env.SMOKE_ADMIN_PASSWORD,
});
if (signInError) throw signInError;

const cookieHeader = [...cookieJar]
  .map(([name, value]) => `${name}=${value}`)
  .join("; ");
if (!cookieHeader) throw new Error("Supabase login did not produce auth cookies");

async function timedRequest(pathname, maxMs) {
  const startedAt = performance.now();
  const response = await fetch(`${baseUrl}${pathname}`, {
    headers: { cookie: cookieHeader },
    redirect: "manual",
    signal: AbortSignal.timeout(maxMs),
  });
  // Include receipt of the body in the budget, not just response headers.
  await response.clone().arrayBuffer();
  const durationMs = Math.round(performance.now() - startedAt);
  if (!response.ok) {
    const body = await response.text();
    throw new Error(
      `${pathname} returned ${response.status} in ${durationMs}ms: ${body.slice(0, 240)}`
    );
  }
  if (durationMs > maxMs) {
    throw new Error(
      `${pathname} exceeded response budget: ${durationMs}ms > ${maxMs}ms`
    );
  }
  console.log(`${pathname}: ${response.status} in ${durationMs}ms`);
  return response;
}

console.log("Checking admin shell and role revalidation...");
await timedRequest(
  "/admin?tab=overview",
  Number(process.env.SMOKE_ADMIN_PAGE_MAX_MS || 5_000)
);

const meResponse = await timedRequest(
  "/api/admin/me",
  Number(process.env.SMOKE_AUTH_MAX_MS || 5_000)
);
const me = await meResponse.json();
if (!me.user || me.role !== "superadmin") {
  throw new Error(`Admin role verification failed: role=${me.role}`);
}

console.log("Checking compact overview aggregation...");
const overviewResponse = await timedRequest(
  "/api/admin/overview",
  Number(process.env.SMOKE_OVERVIEW_MAX_MS || 6_000)
);
const overview = await overviewResponse.json();
if (!overview.counts || typeof overview.duplicateCount !== "number") {
  throw new Error("Overview API response is missing required aggregate fields");
}

console.log("Checking stats API...");
const statsResponse = await timedRequest(
  "/api/admin/stats",
  Number(process.env.SMOKE_STATS_MAX_MS || 8_000)
);
const stats = await statsResponse.json();
if (!stats.generatedAt || !stats.northStars || !stats.dataTrust) {
  throw new Error("Stats API response is missing required aggregate fields");
}

console.log("Checking regattas and batch readiness checks...");
const regattasResponse = await timedRequest(
  "/api/admin/regattas?all=1",
  Number(process.env.SMOKE_REGATTAS_MAX_MS || 8_000)
);
const regattasData = await regattasResponse.json();
const sampleSheets = (regattasData.regattas || []).slice(0, 5).map((r) => r.id);
if (sampleSheets.length > 0) {
  const readinessResponse = await timedRequest(
    `/api/admin/regatta-readiness?sheets=${encodeURIComponent(sampleSheets.join(","))}`,
    Number(process.env.SMOKE_READINESS_MAX_MS || 6_000)
  );
  const readinessData = await readinessResponse.json();
  if (!readinessData.readinessBySheet) {
    throw new Error("Batch readiness API response missing readinessBySheet");
  }
}

async function checkConcurrentAdminReads() {
  const responses = await Promise.all([
    timedRequest("/api/admin/me", Number(process.env.SMOKE_AUTH_MAX_MS || 5_000)),
    timedRequest("/api/admin/overview", Number(process.env.SMOKE_OVERVIEW_MAX_MS || 6_000)),
    timedRequest("/api/admin/coach-access", Number(process.env.SMOKE_AUTH_MAX_MS || 5_000)),
  ]);
  const [role, summary, coaches] = await Promise.all(responses.map((response) => response.json()));
  if (role.role !== "superadmin" || !Array.isArray(summary.sheets) || !Array.isArray(coaches.requests)) {
    throw new Error("Concurrent reads returned invalid or mismatched admin data");
  }
}

console.log("Checking concurrent authorization, Overview and coach-access reads...");
await checkConcurrentAdminReads();
console.log("Testing recovery after the pool idle timeout (waiting 6 seconds)...");
await new Promise((resolve) => setTimeout(resolve, 6_000));
await checkConcurrentAdminReads();

await supabase.auth.signOut();
console.log("Smoke verification completed successfully.");
