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

const baseUrl = (process.env.SMOKE_BASE_URL || "https://sailorpath.com").replace(
  /\/$/,
  ""
);
const cookieJar = new Map();
const supabase = createBrowserClient(
  process.env.SMOKE_SUPABASE_URL,
  process.env.SMOKE_SUPABASE_ANON_KEY,
  {
    isSingleton: false,
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
  });
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

await timedRequest(
  "/admin?tab=stats",
  Number(process.env.SMOKE_ADMIN_PAGE_MAX_MS || 4_000)
);
const statsResponse = await timedRequest(
  "/api/admin/stats",
  Number(process.env.SMOKE_STATS_MAX_MS || 8_000)
);
const stats = await statsResponse.json();
if (!stats.generatedAt || !stats.northStars || !stats.dataTrust) {
  throw new Error("Stats API response is missing required aggregate fields");
}

await supabase.auth.signOut();
