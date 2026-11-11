import Link from "next/link";
import { ChevronRight, ExternalLink } from "lucide-react";
import { AsianIndexTable } from "@/components/AsianIndexTable";
import {
  ASIAN_INDEX_CHECK_LABELS,
  ASIAN_INDEX_GRADES,
  ASIAN_INDEX_GRADE_75_CRITERIA,
  ASIAN_INDEX_METHODOLOGY_PATH,
  ASIAN_INDEX_PROPOSED_REGISTER,
  ASIAN_INDEX_SELECTION_LIMITS,
  type AsianIndexGrade,
  type AsianIndexRegisterEntry,
} from "@/lib/asianOptimistIndexBeta";
import { ASIAN_OPTIMIST_INDEX_SOURCE_PDF_URL } from "@/lib/asianOptimistIndex";

function registerRows(grade: AsianIndexGrade) {
  return ASIAN_INDEX_PROPOSED_REGISTER.filter((entry) => entry.grade === grade).map(
    (entry: AsianIndexRegisterEntry) => [
      entry.name,
      entry.host,
      entry.dates,
      entry.starters ?? "—",
      entry.verifiedMnas ?? "—",
      <span key="status" className="font-semibold text-harbour">
        {ASIAN_INDEX_CHECK_LABELS[entry.check]}
      </span>,
    ],
  );
}

const REGISTER_HEADERS = ["Event", "Host", "Dates", "Starters", "MNAs", "Check"] as const;

export function AsianOptimistIndexBetaSummary() {
  return (
    <section
      aria-label="Scoring rules and event register"
      className="mx-auto max-w-7xl px-4 pt-5 sm:px-6 lg:px-8 space-y-3"
    >
      <details className="sp-accordion group rounded-2xl border border-cool-veil bg-warm-white shadow-sm">
        <summary className="flex list-none [&::-webkit-details-marker]:hidden items-center gap-2 px-5 py-4 text-base font-extrabold text-harbour cursor-pointer select-none">
          <ChevronRight className="h-4 w-4 shrink-0 text-slate-soft transition-transform group-open:rotate-90" aria-hidden="true" />
          Scoring rules &amp; selection limits
        </summary>
        <div className="border-t border-cool-veil px-5 py-4 space-y-5 text-sm leading-6 text-charcoal">
          <div className="grid gap-3 sm:grid-cols-3">
            <div className="rounded-xl bg-sailcloth p-3.5">
              <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">Formula</p>
              <p className="mt-1">
                <code className="font-bold text-harbour">E × (N − P + 1) ÷ N</code>
              </p>
            </div>
            <div className="rounded-xl bg-sailcloth p-3.5">
              <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">Rolling window</p>
              <p className="mt-1">Best 5 results in 12 months.</p>
            </div>
            <div className="rounded-xl bg-sailcloth p-3.5">
              <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">Eligibility</p>
              <p className="mt-1">Eligible Asian/Oceanian MNAs, age ≤ 15 in calendar year.</p>
            </div>
          </div>

          <AsianIndexTable
            caption="Event grades, host rules and gates"
            headers={["Grade", "Events", "Host", "Gates"]}
            rows={ASIAN_INDEX_GRADES.map((grade) => [
              `${grade.grade} · ${grade.label}`,
              grade.events,
              grade.host,
              grade.gates,
            ])}
          />

          <div>
            <p className="font-bold text-harbour">Selection limits</p>
            <ol className="mt-1.5 list-decimal space-y-1 pl-5 text-sm text-charcoal">
              {ASIAN_INDEX_SELECTION_LIMITS.map((limit) => (
                <li key={limit}>{limit}</li>
              ))}
            </ol>
            <p className="mt-2 text-xs text-slate-soft">
              Grade 75 opens require {ASIAN_INDEX_GRADE_75_CRITERIA.starters}+ starters across{" "}
              {ASIAN_INDEX_GRADE_75_CRITERIA.verifiedMnas}+ MNAs and{" "}
              {ASIAN_INDEX_GRADE_75_CRITERIA.completedRaces}+ completed races.
            </p>
          </div>

          <div className="flex flex-wrap items-center gap-4 text-sm font-bold">
            <Link
              href={ASIAN_INDEX_METHODOLOGY_PATH}
              className="text-harbour underline decoration-aqua underline-offset-4 hover:text-racing-deep"
            >
              Read full methodology →
            </Link>
            <a
              href={ASIAN_OPTIMIST_INDEX_SOURCE_PDF_URL}
              target="_blank"
              rel="noreferrer"
              className="inline-flex items-center gap-1.5 text-harbour hover:text-racing-deep hover:underline"
            >
              2025 baseline PDF
              <ExternalLink className="h-3.5 w-3.5" aria-hidden="true" />
            </a>
          </div>
        </div>
      </details>

      <details className="sp-accordion group rounded-2xl border border-cool-veil bg-warm-white shadow-sm">
        <summary className="flex list-none [&::-webkit-details-marker]:hidden items-center gap-2 px-5 py-4 text-base font-extrabold text-harbour cursor-pointer select-none">
          <ChevronRight className="h-4 w-4 shrink-0 text-slate-soft transition-transform group-open:rotate-90" aria-hidden="true" />
          2026–27 event register &amp; nominations
        </summary>
        <div className="border-t border-cool-veil px-5 py-4 space-y-5">
          <div>
            <p className="mb-2 text-xs font-extrabold uppercase tracking-wide text-slate-soft">Grade 150 · Championships</p>
            <AsianIndexTable
              caption="Proposed Grade 150 championships"
              headers={REGISTER_HEADERS}
              rows={registerRows(150)}
              numericColumns={[3, 4]}
            />
          </div>
          <div>
            <p className="mb-2 text-xs font-extrabold uppercase tracking-wide text-slate-soft">Grade 75 · International Opens (max 1 per host country)</p>
            <AsianIndexTable
              caption="Proposed Grade 75 international opens"
              headers={REGISTER_HEADERS}
              rows={registerRows(75)}
              numericColumns={[3, 4]}
            />
          </div>
          <div>
            <p className="mb-2 text-xs font-extrabold uppercase tracking-wide text-slate-soft">Grade 40 · National Championships</p>
            <AsianIndexTable
              caption="Proposed Grade 40 national championships"
              headers={REGISTER_HEADERS}
              rows={registerRows(40)}
              numericColumns={[3, 4]}
            />
          </div>
          <p className="text-xs leading-5 text-slate-soft">
            Associations, clubs, coaches, and parents may nominate Grade 75 opens and Grade 40 national championships before racing with event dates, Notice of Race, and fleet format.
          </p>
        </div>
      </details>
    </section>
  );
}
