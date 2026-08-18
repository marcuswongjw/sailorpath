import type { ComponentType } from "react";
import Link from "next/link";
import {
  Activity,
  ArrowLeft,
  Database,
  HeartPulse,
  Shield,
  Target,
  TrendingUp,
  Users,
  Wrench,
} from "lucide-react";

type MetricRow = {
  metric: string;
  definition: string;
  why: string;
  source?: string;
};

function Section({
  icon: Icon,
  title,
  intro,
  rows,
}: {
  icon: ComponentType<{ className?: string }>;
  title: string;
  intro: string;
  rows: MetricRow[];
}) {
  return (
    <section className="glass-panel rounded-2xl border border-white/5 overflow-hidden">
      <div className="px-4 sm:px-5 py-4 border-b border-white/5 flex items-start gap-3">
        <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-xl bg-orange-500/15 border border-orange-500/20">
          <Icon className="h-4 w-4 text-orange-400" />
        </span>
        <div className="min-w-0">
          <h2 className="text-sm font-black text-white tracking-tight">
            {title}
          </h2>
          <p className="text-[12px] text-slate-400 mt-0.5 leading-relaxed">
            {intro}
          </p>
        </div>
      </div>
      <div className="overflow-x-auto">
        <table className="w-full text-left text-xs min-w-[640px]">
          <thead>
            <tr className="text-[10px] font-bold uppercase tracking-wider text-slate-500 border-b border-white/5 bg-white/[0.02]">
              <th className="px-4 py-2.5 w-[22%]">Metric</th>
              <th className="px-4 py-2.5 w-[38%]">Definition</th>
              <th className="px-4 py-2.5">Why it matters</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-white/[0.04]">
            {rows.map((r) => (
              <tr key={r.metric} className="align-top hover:bg-white/[0.02]">
                <td className="px-4 py-3">
                  <p className="font-bold text-white leading-snug">{r.metric}</p>
                  {r.source && (
                    <p className="text-[10px] text-slate-600 mt-1 font-mono">
                      {r.source}
                    </p>
                  )}
                </td>
                <td className="px-4 py-3 text-slate-300 leading-relaxed">
                  {r.definition}
                </td>
                <td className="px-4 py-3 text-slate-400 leading-relaxed">
                  {r.why}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
}

const NORTH_STARS: MetricRow[] = [
  {
    metric: "Weekly active sessions",
    definition:
      "Distinct anonymous session IDs in usage_events over the last 7 days.",
    why: "Top-line interest without identifying people.",
    source: "usage_events.session_id",
  },
  {
    metric: "Claimed sailors",
    definition: "Sailors with parent_id set (someone owns the profile).",
    why: "Core product adoption — ownership unlocks private tools.",
    source: "sailors.parent_id",
  },
  {
    metric: "% roster claimed",
    definition: "Claimed sailors ÷ series / ranked sailors on the platform.",
    why: "Progress toward covering the addressable Singapore roster.",
  },
  {
    metric: "Claims pending",
    definition: "sailor_claims with status = pending.",
    why: "Ops backlog you must clear to keep trust high.",
    source: "sailor_claims",
  },
];

const FUNNELS: MetricRow[] = [
  {
    metric: "Ranking → profile",
    definition:
      "Same-session: ranking_view then profile_view (unique sessions).",
    why: "Do standings drive deeper engagement?",
    source: "usage_events",
  },
  {
    metric: "Demo → claim",
    definition: "Same-session: sample_view then claim_submit.",
    why: "Is the demo converting curiosity into ownership?",
  },
  {
    metric: "Register → claim",
    definition: "Same-session (or short window): register then claim_submit.",
    why: "Quality of new signups vs looky-loos.",
  },
  {
    metric: "Claim approve rate",
    definition: "Approved ÷ (approved + rejected).",
    why: "Process health and fake/wrong-claim rate.",
  },
  {
    metric: "Traffic by source",
    definition:
      "First-touch meta.source on sessions (utm / referrer / direct).",
    why: "Where to double down (WhatsApp, Instagram, school groups).",
    source: "usage_events.meta.source",
  },
  {
    metric: "Mobile vs desktop",
    definition: "Share of sessions with meta.device = mobile | desktop.",
    why: "Prioritize mobile UX where most parents live.",
  },
];

const ENGAGEMENT: MetricRow[] = [
  {
    metric: "Own vs other profile views",
    definition: "profile_view with meta.own true vs false.",
    why: "Parents checking their kid vs browsing the fleet.",
  },
  {
    metric: "Returning visitors (7d)",
    definition: "Visitor IDs (vid) seen on 2+ calendar days in the window.",
    why: "Habit formation — stronger than raw sessions.",
  },
  {
    metric: "Personal logbook adds",
    definition: "Owner-added non-ranking / overseas results.",
    why: "Depth beyond series tables.",
  },
  {
    metric: "Race notes adoption",
    definition: "Claimed sailors with ≥1 race_observations row.",
    why: "Are owners using the race-by-race log?",
  },
];

const FEATURES: MetricRow[] = [
  {
    metric: "Equipment adoption",
    definition: "Claimed sailors with ≥1 equipment_items row.",
    why: "ROI of the gear inventory feature.",
  },
  {
    metric: "Equipment sessions / week",
    definition: "equipment_usages rows in the last 7 days.",
    why: "Is “Log session” sticky after first setup?",
  },
  {
    metric: "Dual-class sailors",
    definition: "Sailors with both Optimist and ILCA 4 results (or ILCA fields).",
    why: "Tracks the Optimist → ILCA journey narrative.",
  },
];

const DATA_TRUST: MetricRow[] = [
  {
    metric: "Days since last series import",
    definition: "Days since last import event or newest ranking regatta date.",
    why: "Freshness SLA — stale boards lose credibility.",
  },
  {
    metric: "Gold / Silver coverage ≥3",
    definition:
      "Active fleet sailors with ≥3 scoring results in the current half.",
    why: "Ranking completeness and fair comparisons.",
  },
  {
    metric: "Missing profile fields",
    definition: "Counts missing DOB, sail number, or nationality.",
    why: "Import / data quality backlog.",
  },
  {
    metric: "DNS rate (optional)",
    definition: "DNS results ÷ all results for recent ranking regattas.",
    why: "Spot outlier events or scoring quirks.",
  },
];

const SUPPORT: MetricRow[] = [
  {
    metric: "Support new / resolved",
    definition: "support_messages by status; optional avg hours to resolve.",
    why: "Responsiveness and trust.",
  },
  {
    metric: "Waitlist / founding interest",
    definition: "waitlist_submit events (and founding-tagged roles).",
    why: "Demand signal before payments exist.",
  },
];

export function AdminMetricsGuide() {
  return (
    <div className="mx-auto max-w-5xl w-full min-w-0 px-3 sm:px-6 lg:px-8 py-6 sm:py-10 space-y-6 overflow-x-clip">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <Link
          href="/admin"
          className="inline-flex items-center gap-1.5 text-[12px] font-bold text-slate-400 hover:text-white"
        >
          <ArrowLeft className="h-3.5 w-3.5" />
          Back to admin
        </Link>
        <span className="inline-flex items-center gap-1.5 rounded-full border border-orange-500/25 bg-orange-500/10 px-2.5 py-1 text-[10px] font-black uppercase tracking-wide text-orange-300">
          <Shield className="h-3 w-3" />
          Superadmin
        </span>
      </div>

      <header className="glass-panel rounded-2xl border border-white/5 p-5 sm:p-6 space-y-3">
        <div className="flex items-start gap-3">
          <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-2xl bg-orange-500/15 border border-orange-500/25">
            <Target className="h-5 w-5 text-orange-400" />
          </span>
          <div className="min-w-0">
            <h1 className="text-xl sm:text-2xl font-black text-white tracking-tight">
              Key metrics to track
            </h1>
            <p className="text-[13px] text-slate-400 mt-1.5 leading-relaxed max-w-2xl">
              A playbook for SailorPath — what to measure, how to define it, and
              why it matters. This page is documentation only (no heavy live
              queries). Prefer privacy-light aggregates; never store emails or
              names in traffic events.
            </p>
          </div>
        </div>
        <div className="flex flex-wrap gap-2 text-[11px]">
          <span className="rounded-full border border-white/10 bg-white/5 px-2.5 py-1 text-slate-300">
            North stars weekly
          </span>
          <span className="rounded-full border border-white/10 bg-white/5 px-2.5 py-1 text-slate-300">
            Funnels for growth
          </span>
          <span className="rounded-full border border-white/10 bg-white/5 px-2.5 py-1 text-slate-300">
            Ops for trust
          </span>
        </div>
      </header>

      <Section
        icon={TrendingUp}
        title="A · North stars (weekly glance)"
        intro="If you only check four numbers each week, use these."
        rows={NORTH_STARS}
      />
      <Section
        icon={Users}
        title="B · Acquisition & conversion"
        intro="How people discover SailorPath and whether they claim a profile."
        rows={FUNNELS}
      />
      <Section
        icon={Activity}
        title="C · Engagement (after claim)"
        intro="Depth among people who already own a profile."
        rows={ENGAGEMENT}
      />
      <Section
        icon={Wrench}
        title="D · Feature adoption"
        intro="Are newer product surfaces (equipment, dual-class) actually used?"
        rows={FEATURES}
      />
      <Section
        icon={Database}
        title="E · Ranking & data trust"
        intro="Credibility of public boards depends on fresh, complete data."
        rows={DATA_TRUST}
      />
      <Section
        icon={HeartPulse}
        title="F · Support & demand"
        intro="Responsiveness and early demand signals."
        rows={SUPPORT}
      />

      <section className="glass-panel rounded-2xl border border-white/5 p-5 space-y-3">
        <h2 className="text-sm font-black text-white">Do not prioritize yet</h2>
        <ul className="text-[12px] text-slate-400 space-y-1.5 list-disc pl-5 leading-relaxed">
          <li>
            Full Stripe / payment funnels — not instrumented; waitlist is enough
            for now.
          </li>
          <li>
            Individual sailor stalking or PII in analytics — keep usage events
            privacy-light.
          </li>
          <li>
            Heavy real-time dashboards that scan all results (removed from the
            admin Stats tab for load time).
          </li>
        </ul>
        <p className="text-[11px] text-slate-500 leading-relaxed pt-1">
          Instrumentation already exists for many of these via{" "}
          <code className="text-slate-400">usage_events</code>, claims, support,
          and inventory tables. Live numbers can be added later as small, cached
          cards — not another full-table dashboard.
        </p>
      </section>
    </div>
  );
}
