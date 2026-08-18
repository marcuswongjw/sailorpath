"use client";

import { useCallback, useEffect, useState, type ReactNode } from "react";
import Link from "next/link";
import {
  Activity,
  AlertTriangle,
  Database,
  HeartPulse,
  RefreshCw,
  Target,
  TrendingUp,
  type LucideIcon,
} from "lucide-react";
import type { AdminStatsPayload } from "@/lib/adminStats";
import { errorMessage } from "@/lib/errors";

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
  const [stats, setStats] = useState<AdminStatsPayload | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!isSuperadmin) return;
    setLoading(true);
    setError(null);
    const ac = new AbortController();
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
      setStats(data as AdminStatsPayload);
    } catch (e: unknown) {
      const aborted =
        (e instanceof DOMException && e.name === "AbortError") ||
        (e instanceof Error && e.name === "AbortError");
      setError(
        aborted
          ? "Stats timed out after 20s — try Refresh. If it keeps failing, check DATABASE_URL / usage_events."
          : errorMessage(e, "Failed to load stats")
      );
    } finally {
      window.clearTimeout(timer);
      setLoading(false);
    }
  }, [isSuperadmin]);

  useEffect(() => {
    void load();
  }, [load]);

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
            Live stats
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
            onClick={() => void load()}
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
              Usage events unavailable — traffic cards show zero. Confirm
              migration 016 (`usage_events`) is applied.
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
