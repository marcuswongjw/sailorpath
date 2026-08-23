"use client";

import { type ReactNode } from "react";
import Link from "next/link";
import { useQuery } from "@tanstack/react-query";
import {
  AlertTriangle,
  Database,
  HeartPulse,
  Users,
  RefreshCw,
  Target,
  TrendingUp,
  type LucideIcon,
} from "lucide-react";
import type { AdminStatsPayload } from "@/lib/adminStats";
import { errorMessage } from "@/lib/errors";
import { adminQueryKeys } from "@/components/admin/adminQueryKeys";

type Props = {
  isSuperadmin: boolean;
};

function Card({
  label,
  value,
  hint,
  tone = "default",
}: {
  label: string;
  value: string;
  hint?: string;
  tone?: "default" | "warn" | "ok";
}) {
  const valueColor =
    tone === "warn"
      ? "text-amber-300"
      : tone === "ok"
        ? "text-emerald-300"
        : "text-white";
  return (
    <div className="rounded-2xl border border-white/5 bg-white/[0.03] p-4 min-w-0">
      <p className="text-[10px] font-bold uppercase tracking-wider text-slate-500">
        {label}
      </p>
      <p className={`mt-1.5 text-2xl font-black tabular-nums ${valueColor}`}>
        {value}
      </p>
      {hint && (
        <p className="mt-1 text-[11px] text-slate-500 leading-snug">{hint}</p>
      )}
    </div>
  );
}

function Section({
  icon: Icon,
  title,
  children,
}: {
  icon: LucideIcon;
  title: string;
  children: ReactNode;
}) {
  return (
    <section className="space-y-3">
      <div className="flex items-center gap-2">
        <span className="flex h-8 w-8 items-center justify-center rounded-xl bg-orange-500/15 border border-orange-500/20">
          <Icon className="h-4 w-4 text-orange-400" />
        </span>
        <h2 className="text-sm font-black text-white tracking-tight">{title}</h2>
      </div>
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">{children}</div>
    </section>
  );
}

function fmt(n: number | null | undefined): string {
  if (n == null || Number.isNaN(n)) return "—";
  return n.toLocaleString();
}

/**
 * Lean live Stats — COUNT/DISTINCT cards from GET /api/admin/stats.
 */
export function AdminStatsPanel({ isSuperadmin }: Props) {
  const statsQuery = useQuery({
    queryKey: adminQueryKeys.stats(),
    enabled: isSuperadmin,
    staleTime: 60_000,
    retry: false,
    queryFn: async ({ signal }) => {
      const ac = new AbortController();
      const onAbort = () => ac.abort();
      signal.addEventListener("abort", onAbort, { once: true });
      const timer = window.setTimeout(() => ac.abort(), 20_000);
      try {
        const res = await fetch("/api/admin/stats", {
          credentials: "include",
          signal: ac.signal,
          cache: "no-store",
        });
        const data = await res.json().catch(() => ({}));
        if (!res.ok) {
          throw new Error(
            typeof data.error === "string" ? data.error : "Failed to load stats"
          );
        }
        return data as AdminStatsPayload;
      } catch (e: unknown) {
        const aborted =
          (e instanceof DOMException && e.name === "AbortError") ||
          (e instanceof Error && e.name === "AbortError");
        throw new Error(
          aborted
            ? "Stats took too long to load. Try Refresh, then contact support if the problem continues."
            : errorMessage(e, "Failed to load stats")
        );
      } finally {
        window.clearTimeout(timer);
        signal.removeEventListener("abort", onAbort);
      }
    },
  });
  const stats = statsQuery.data ?? null;
  const loading = statsQuery.isFetching;
  const error = statsQuery.error
    ? errorMessage(statsQuery.error, "Failed to load stats")
    : null;

  if (!isSuperadmin) {
    return (
      <div className="rounded-xl border border-red-500/20 bg-red-500/10 p-4 text-sm text-red-300">
        Superadmin only.
      </div>
    );
  }

  return (
    <div className="space-y-6 sm:space-y-8">
      <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-3">
        <div className="min-w-0 space-y-1">
          <h1 className="text-lg sm:text-xl font-black text-white tracking-tight">
            Platform stats
          </h1>
          <p className="text-[12px] text-slate-400 leading-relaxed max-w-xl">
            Privacy-safe aggregates (counts only). Cached ~{stats?.cacheSeconds ?? 60}
            s. Definitions live in the{" "}
            <Link
              href="/admin/metrics"
              className="text-orange-400 hover:text-orange-300 font-semibold"
            >
              metrics guide
            </Link>
            .
          </p>
        </div>
        <div className="flex items-center gap-2 shrink-0">
          {stats?.generatedAt && (
            <span className="text-[10px] text-slate-500 tabular-nums">
              As of {new Date(stats.generatedAt).toLocaleString()}
            </span>
          )}
          <button
            type="button"
            onClick={() => void statsQuery.refetch()}
            disabled={loading}
            className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-[11px] font-bold text-slate-200 hover:border-orange-500/40 disabled:opacity-50"
          >
            <RefreshCw
              className={`h-3.5 w-3.5 ${loading ? "animate-spin text-orange-400" : ""}`}
            />
            Refresh
          </button>
        </div>
      </div>

      {error && (
        <div className="rounded-xl border border-rose-500/30 bg-rose-500/10 px-4 py-3 text-sm text-rose-200 flex gap-2">
          <AlertTriangle className="h-4 w-4 shrink-0 mt-0.5" />
          <span>{error}</span>
        </div>
      )}

      {loading && !stats && (
        <div className="flex items-center gap-2 py-16 justify-center text-xs text-slate-400">
          <RefreshCw className="h-4 w-4 animate-spin text-orange-500" />
          Loading stats…
        </div>
      )}

      {stats && (
        <>
          {!stats.usageEventsOk && (
            <div className="rounded-xl border border-amber-500/30 bg-amber-500/10 px-4 py-3 text-[12px] text-amber-100">
              Traffic metrics are temporarily unavailable. Other platform
              statistics are unaffected.
            </div>
          )}
          {!stats.authAccountsOk && (
            <div className="rounded-xl border border-amber-500/30 bg-amber-500/10 px-4 py-3 text-[12px] text-amber-100">
              Account activity is temporarily unavailable. Aggregate traffic
              and platform statistics are unaffected.
            </div>
          )}

          <Section icon={Target} title="North stars">
            <Card
              label="Weekly active sessions"
              value={fmt(stats.northStars.weeklyActiveSessions)}
              hint="Distinct session IDs · last 7 days"
            />
            <Card
              label="Claimed sailors"
              value={fmt(stats.northStars.claimedSailors)}
              hint="Profiles with a linked parent"
            />
            <Card
              label="% roster claimed"
              value={
                stats.northStars.rosterClaimedPct == null
                  ? "—"
                  : `${stats.northStars.rosterClaimedPct}%`
              }
              hint={`${fmt(stats.northStars.claimedSailors)} / ${fmt(stats.northStars.seriesSailors)} series`}
              tone={
                (stats.northStars.rosterClaimedPct ?? 0) >= 40 ? "ok" : "default"
              }
            />
            <Card
              label="Claims pending"
              value={fmt(stats.northStars.claimsPending)}
              hint="Awaiting approve / reject"
              tone={stats.northStars.claimsPending > 0 ? "warn" : "ok"}
            />
          </Section>

          <Section icon={HeartPulse} title="Ops pulse">
            <Card
              label="Support new"
              value={fmt(stats.ops.supportNew)}
              hint="Unread inbox"
              tone={stats.ops.supportNew > 0 ? "warn" : "ok"}
            />
            <Card
              label="Days since import"
              value={
                stats.ops.daysSinceLastImport == null
                  ? "—"
                  : fmt(stats.ops.daysSinceLastImport)
              }
              hint={
                stats.ops.lastImportAt
                  ? `Last: ${new Date(stats.ops.lastImportAt).toLocaleDateString()}`
                  : "No import events yet"
              }
              tone={
                stats.ops.daysSinceLastImport != null &&
                stats.ops.daysSinceLastImport > 14
                  ? "warn"
                  : "default"
              }
            />
            <Card
              label="Ranking regattas"
              value={fmt(stats.ops.rankingRegattas)}
              hint="counts_for_ranking = true"
            />
            <Card
              label="Series sailors"
              value={fmt(stats.northStars.seriesSailors)}
              hint="Active series membership"
            />
          </Section>

          <Section icon={TrendingUp} title="Traffic · 7 days">
            <Card label="Ranking views" value={fmt(stats.traffic7d.rankingViews)} />
            <Card label="Profile views" value={fmt(stats.traffic7d.profileViews)} />
            <Card label="Searches" value={fmt(stats.traffic7d.searches)} />
            <Card
              label="Sample · Admin"
              value={`${fmt(stats.traffic7d.sampleViews)} · ${fmt(stats.traffic7d.adminOpens)}`}
              hint="sample_view · admin_open"
            />
          </Section>

          <Section icon={Users} title="Signed-in accounts">
            <Card label="Registered" value={fmt(stats.accounts.registered)} />
            <Card label="Confirmed" value={fmt(stats.accounts.confirmed)} />
            <Card
              label="Signed in · 7 days"
              value={fmt(stats.accounts.signedInLast7d)}
              hint="Accounts with a recent sign-in"
            />
            <Card
              label="Auth sessions"
              value={fmt(stats.accounts.authSessions)}
              hint="Valid session records, not live online presence"
            />
          </Section>

          {stats.authAccountsOk && (
            <section className="space-y-3">
              <div>
                <h2 className="text-sm font-black text-white tracking-tight">
                  Recent account activity
                </h2>
                <p className="mt-1 text-[11px] text-slate-500">
                  Superadmin only. A session can remain valid while the person
                  is away, so this does not claim real-time online status.
                </p>
              </div>
              <div className="overflow-x-auto rounded-2xl border border-white/5 bg-white/[0.03]">
                <table className="w-full min-w-[720px] text-left text-[11px]">
                  <thead className="border-b border-white/5 text-[10px] uppercase tracking-wider text-slate-500">
                    <tr>
                      <th className="px-4 py-3 font-bold">Account</th>
                      <th className="px-4 py-3 font-bold">Role</th>
                      <th className="px-4 py-3 font-bold">Last sign-in</th>
                      <th className="px-4 py-3 font-bold">Last session refresh</th>
                      <th className="px-4 py-3 font-bold text-right">Sessions</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-white/5">
                    {stats.accounts.recent.map((account) => (
                      <tr key={account.id} className="text-slate-300">
                        <td className="px-4 py-3">
                          <p className="font-bold text-white">
                            {account.fullName ||
                              account.email ||
                              "Unnamed account"}
                          </p>
                          {account.fullName && account.email && (
                            <p className="mt-0.5 text-slate-500">{account.email}</p>
                          )}
                        </td>
                        <td className="px-4 py-3 capitalize">{account.role}</td>
                        <td className="px-4 py-3 tabular-nums">
                          {account.lastSignInAt
                            ? new Date(account.lastSignInAt).toLocaleString()
                            : "Never"}
                        </td>
                        <td className="px-4 py-3 tabular-nums">
                          {account.lastSessionRefreshAt
                            ? new Date(
                                account.lastSessionRefreshAt
                              ).toLocaleString()
                            : "—"}
                        </td>
                        <td className="px-4 py-3 text-right font-bold tabular-nums">
                          {fmt(account.authSessionCount)}
                        </td>
                      </tr>
                    ))}
                    {stats.accounts.recent.length === 0 && (
                      <tr>
                        <td colSpan={5} className="px-4 py-8 text-center text-slate-500">
                          No accounts found.
                        </td>
                      </tr>
                    )}
                  </tbody>
                </table>
              </div>
            </section>
          )}

          <Section icon={Database} title="Data trust">
            <Card
              label="Sailors total"
              value={fmt(stats.dataTrust.sailorsTotal)}
            />
            <Card
              label="Missing DOB"
              value={fmt(stats.dataTrust.missingDob)}
              tone={stats.dataTrust.missingDob > 0 ? "warn" : "ok"}
            />
            <Card
              label="Missing / placeholder sail #"
              value={fmt(stats.dataTrust.missingOrPlaceholderSail)}
              hint="Empty or SGP 000"
              tone={
                stats.dataTrust.missingOrPlaceholderSail > 0 ? "warn" : "ok"
              }
            />
            <Card
              label="Cache"
              value={`${stats.cacheSeconds}s`}
              hint="Server revalidate window"
            />
          </Section>
        </>
      )}
    </div>
  );
}
