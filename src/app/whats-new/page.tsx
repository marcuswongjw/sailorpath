import Link from "next/link";
import {
  getPublicChangelogEntries,
  type ProductSeverity,
} from "@/lib/productChangelog";

/** Static curated list — redeploy to refresh. */
export const revalidate = 300;

const SEVERITY_LABEL: Record<ProductSeverity, string> = {
  info: "Note",
  improvement: "Improved",
  breaking: "Important",
};

export default function WhatsNewPage() {
  const entries = getPublicChangelogEntries();

  return (
    <div className="mx-auto max-w-3xl px-4 py-12 sm:py-16 space-y-10">
      <div className="space-y-3">
        <Link
          href="/"
          className="text-[12px] font-semibold text-slate-500 hover:text-white"
        >
          ← Home
        </Link>
        <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
          What&apos;s new
        </h1>
        <p className="text-sm text-slate-400 leading-relaxed">
          Recent SailorPath updates for sailors, parents, and coaches. Admin-only
          tooling changes stay in the operator console.
        </p>
      </div>

      <ol className="space-y-4">
        {entries.map((entry) => {
          const severity = entry.severity ?? "info";
          return (
            <li
              key={entry.id}
              id={entry.slug}
              className="scroll-mt-24 rounded-2xl border border-white/10 bg-white/[0.03] p-5 sm:p-6 space-y-2"
            >
              <div className="flex flex-wrap items-center gap-2 text-[11px]">
                <span className="rounded-full border border-orange-500/25 bg-orange-500/10 px-2 py-0.5 font-black uppercase tracking-wide text-orange-300">
                  {entry.area}
                </span>
                <span className="rounded-full border border-white/10 bg-white/5 px-2 py-0.5 font-bold text-slate-400">
                  {SEVERITY_LABEL[severity]}
                </span>
                <span className="text-slate-500 font-medium">
                  {new Date(`${entry.date}T12:00:00`).toLocaleDateString(
                    undefined,
                    { year: "numeric", month: "short", day: "numeric" }
                  )}
                </span>
              </div>
              <h2 className="text-lg font-bold text-white leading-snug">
                {entry.title}
              </h2>
              <p className="text-sm text-slate-400 leading-relaxed">
                {entry.summary}
              </p>
              {entry.href && !entry.href.startsWith("/admin") && (
                <Link
                  href={entry.href}
                  className="inline-flex text-[12px] font-bold text-orange-400 hover:text-orange-300"
                >
                  {entry.ctaLabel || "Open"} →
                </Link>
              )}
            </li>
          );
        })}
      </ol>

      {entries.length === 0 && (
        <p className="text-sm text-slate-500">No public updates yet.</p>
      )}
    </div>
  );
}
