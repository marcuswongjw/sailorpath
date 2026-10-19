import Link from "next/link";
import { AsianIndexTable } from "@/components/AsianIndexTable";
import {
  ASIAN_INDEX_BETA_DRAFT_DATE,
  ASIAN_INDEX_BETA_VERSION,
  ASIAN_INDEX_CHECK_LABELS,
  ASIAN_INDEX_GRADES,
  ASIAN_INDEX_GRADE_75_CRITERIA,
  ASIAN_INDEX_METHODOLOGY_PATH,
  ASIAN_INDEX_PROPOSED_REGISTER,
  ASIAN_INDEX_SELECTION_LIMITS,
  type AsianIndexGrade,
  type AsianIndexRegisterEntry,
} from "@/lib/asianOptimistIndexBeta";

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
      entry.note,
    ],
  );
}

const REGISTER_HEADERS = ["Event", "Host", "Dates", "Starters", "MNAs", "Check", "Notes"] as const;

export function AsianOptimistIndexBetaSummary() {
  return (
    <>
      <section
        id="beta-summary"
        aria-labelledby="beta-summary-heading"
        className="mx-auto max-w-7xl px-4 pt-7 sm:px-6 lg:px-8"
      >
        <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-sm sm:p-6">
          <p className="text-xs font-extrabold uppercase tracking-[0.16em] text-racing-deep">
            Index methodology · {ASIAN_INDEX_BETA_VERSION}
          </p>
          <h2 id="beta-summary-heading" className="mt-2 text-xl font-extrabold text-harbour sm:text-2xl">
            The Index in one page
          </h2>
          <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-soft">
            The SailorPath Asian and Oceania Optimist Index is an independent analytical index of verified Optimist results. It is not an
            official IODA or national federation ranking and must not be used as a team-selection tool. Updated{" "}
            {ASIAN_INDEX_BETA_DRAFT_DATE}.
          </p>

          <dl className="mt-5 grid gap-4 md:grid-cols-3">
            <div className="rounded-xl bg-sailcloth p-4">
              <dt className="text-xs font-bold uppercase tracking-wide text-slate-soft">Who is ranked</dt>
              <dd className="mt-1 text-sm leading-6 text-charcoal">
                Sailors verified as representing an eligible Asian or Oceanian MNA, through 31 December of the year they turn 15,
                with at least one scoring result in the rolling window.
              </dd>
            </div>
            <div className="rounded-xl bg-sailcloth p-4">
              <dt className="text-xs font-bold uppercase tracking-wide text-slate-soft">What counts</dt>
              <dd className="mt-1 text-sm leading-6 text-charcoal">
                A sailor&apos;s best five eligible results in a rolling 12 months, within the event-grade and country
                limits below. Results expire on their first anniversary.
              </dd>
            </div>
            <div className="rounded-xl bg-sailcloth p-4">
              <dt className="text-xs font-bold uppercase tracking-wide text-slate-soft">Result points</dt>
              <dd className="mt-1 text-sm leading-6 text-charcoal">
                <code className="font-bold text-harbour">E × (N − P + 1) ÷ N</code>, where E is the event grade, N the
                valid starters and P the final place. The winner earns E; last place earns E ÷ N.
              </dd>
            </div>
          </dl>

          <div className="mt-6">
            <h3 className="text-base font-extrabold text-harbour">Event grades</h3>
            <div className="mt-2">
              <AsianIndexTable
                caption="Event grades, host rules and gates"
                headers={["Grade", "Events", "Host", "Gates once racing is finished"]}
                rows={ASIAN_INDEX_GRADES.map((grade) => [
                  `${grade.grade} · ${grade.label}`,
                  grade.events,
                  grade.host,
                  grade.gates,
                ])}
              />
            </div>
            <p className="mt-2 text-xs leading-5 text-slate-soft">
              Other results, including club events, clinics, team racing, development divisions and events that miss
              their gates, stay on sailor histories as Grade 0 and score nothing.
            </p>
          </div>

          <div className="mt-6 grid gap-5 lg:grid-cols-2">
            <div>
              <h3 className="text-base font-extrabold text-harbour">Six limits on the best five</h3>
              <ol className="mt-2 list-decimal space-y-1 pl-5 text-sm leading-6 text-charcoal">
                {ASIAN_INDEX_SELECTION_LIMITS.map((limit) => (
                  <li key={limit}>{limit}</li>
                ))}
              </ol>
              <p className="mt-2 text-xs leading-5 text-slate-soft">
                SailorPath picks the highest-scoring combination that satisfies all six, so a lower-grade result can
                replace a weaker higher-grade one. A missing Worlds result is never a penalty.
              </p>
            </div>
            <div>
              <h3 className="text-base font-extrabold text-harbour">How a Grade 75 open is designated</h3>
              <p className="mt-2 text-sm leading-6 text-charcoal">
                Before racing, a candidate must show at least{" "}
                <strong>{ASIAN_INDEX_GRADE_75_CRITERIA.registeredSailors} registered sailors</strong> from at least{" "}
                <strong>{ASIAN_INDEX_GRADE_75_CRITERIA.verifiedMnas} verified MNAs</strong> in its primary
                competition. After racing, it must confirm at least {ASIAN_INDEX_GRADE_75_CRITERIA.starters} valid
                starters from {ASIAN_INDEX_GRADE_75_CRITERIA.verifiedMnas} MNAs and{" "}
                {ASIAN_INDEX_GRADE_75_CRITERIA.completedRaces} completed races. Grades are fixed in advance and never
                assigned after seeing who won.
              </p>
            </div>
          </div>

          <p className="mt-6 text-sm">
            <Link
              href={ASIAN_INDEX_METHODOLOGY_PATH}
              className="font-bold text-harbour underline decoration-aqua underline-offset-4 hover:text-racing-deep"
            >
              Read the full methodology →
            </Link>
          </p>
        </div>
      </section>

      <section
        id="register"
        aria-labelledby="register-heading"
        className="mx-auto max-w-7xl px-4 pt-7 sm:px-6 lg:px-8"
      >
        <div className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-sm sm:p-6">
          <h2 id="register-heading" className="text-xl font-extrabold text-harbour sm:text-2xl">
            Proposed 2026–27 event register
          </h2>
          <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-soft">
            Every event below is a proposal. Nothing is designated until SailorPath publishes the designation record
            with its timestamp. Starter and MNA counts come from final result sheets imported into SailorPath and
            measure starters, not registrations, so they are a proxy for the registration criterion.
          </p>

          <div className="mt-5 space-y-6">
            <div>
              <h3 className="text-base font-extrabold text-harbour">Grade 150 · championships</h3>
              <div className="mt-2">
                <AsianIndexTable
                  caption="Proposed Grade 150 championships"
                  headers={REGISTER_HEADERS}
                  rows={registerRows(150)}
                  numericColumns={[3, 4]}
                />
              </div>
            </div>
            <div>
              <h3 className="text-base font-extrabold text-harbour">Grade 75 · major international opens</h3>
              <p className="mt-1 text-xs leading-5 text-slate-soft">
                Only one Grade 75 result per host country counts, so Malaysia and Thailand each contribute at most one
                result per sailor.
              </p>
              <div className="mt-2">
                <AsianIndexTable
                  caption="Proposed Grade 75 international opens"
                  headers={REGISTER_HEADERS}
                  rows={registerRows(75)}
                  numericColumns={[3, 4]}
                />
              </div>
            </div>
            <div>
              <h3 className="text-base font-extrabold text-harbour">Grade 40 · national championships</h3>
              <div className="mt-2">
                <AsianIndexTable
                  caption="Proposed Grade 40 national championships"
                  headers={REGISTER_HEADERS}
                  rows={registerRows(40)}
                  numericColumns={[3, 4]}
                />
              </div>
            </div>
          </div>
        </div>
      </section>

      <section
        id="nominate"
        aria-labelledby="nominate-heading"
        className="mx-auto max-w-7xl px-4 pt-7 sm:px-6 lg:px-8"
      >
        <div className="rounded-2xl bg-harbour p-5 text-white shadow-sm sm:p-6">
          <h2 id="nominate-heading" className="text-xl font-extrabold">
            Nominate or confirm an event
          </h2>
          <p className="mt-2 max-w-3xl text-sm leading-6 text-sailcloth">
            National class associations, federations, host clubs, coaches and parents are invited to nominate
            Grade 75 opens and each country&apos;s single premier Grade 40 national championship for 2026–27.
            Nominations must arrive before racing, because we never assign a grade after seeing the result.
          </p>
          <ul className="mt-4 list-disc space-y-1 pl-5 text-sm leading-6 text-sailcloth">
            <li>Event name and edition, organiser or host club, dates and host country.</li>
            <li>Proposed grade (75 or 40) and the Notice of Race.</li>
            <li>Fleet format: one combined overall classification, or separate Gold and Silver entry divisions.</li>
            <li>Entry list or registration statistics, with the number of sailors and MNAs.</li>
            <li>After racing: the official final results and the final race date.</li>
          </ul>
          <p className="mt-4 text-sm text-soft-aqua">
            The nomination and correction submission channel opens with the launch announcement.
          </p>
        </div>
      </section>
    </>
  );
}
