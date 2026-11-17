import type { Metadata } from "next";
import Link from "next/link";
import { AsianIndexTable } from "@/components/AsianIndexTable";
import {
  ASIAN_INDEX_BETA_DRAFT_DATE,
  ASIAN_INDEX_BETA_VERSION,
  ASIAN_INDEX_GRADES,
  ASIAN_INDEX_GRADE_75_CRITERIA,
  ASIAN_INDEX_MNA_REGIONS,
  ASIAN_INDEX_PATH,
  ASIAN_INDEX_SELECTION_LIMITS,
  asianIndexPoints,
} from "@/lib/asianOptimistIndexBeta";

export const metadata: Metadata = {
  title: "SailorPath Asian and Oceania Optimist Index Methodology | SailorPath",
  description:
    "Methodology for the SailorPath Asian and Oceania Optimist Index: eligibility, 200/150/75/40 event grades, Season Points, selection limits, Power Rating (Elo), and U13 Next-Gen.",
  alternates: { canonical: "/optimist/asian-index/methodology" },
};

const SECTIONS = [
  ["purpose", "1. Overview & eligibility"],
  ["grades", "2. Event grades & splits"],
  ["points", "3. Season Points & rolling window"],
  ["selection", "4. Selection limits & ties"],
  ["examples", "5. Worked examples"],
  ["power-rating", "6. Power Rating (Elo), Form & U13 Next-Gen"],
  ["revisions", "7. Governance & revision log"],
] as const;

function Section({
  id,
  title,
  children,
}: {
  id: string;
  title: string;
  children: React.ReactNode;
}) {
  return (
    <section id={id} aria-labelledby={`${id}-heading`} className="scroll-mt-24 pt-9">
      <h2 id={`${id}-heading`} className="text-2xl font-extrabold tracking-tight text-harbour">
        {title}
      </h2>
      <div className="mt-3 space-y-4 text-[15px] leading-7 text-charcoal">{children}</div>
    </section>
  );
}

function Sub({ title }: { title: string }) {
  return <h3 className="pt-2 text-lg font-extrabold text-harbour">{title}</h3>;
}

function Bullets({ items }: { items: readonly React.ReactNode[] }) {
  return (
    <ul className="list-disc space-y-1.5 pl-5">
      {items.map((item, index) => (
        <li key={index}>{item}</li>
      ))}
    </ul>
  );
}

const fmt = (value: number) => value.toFixed(2);

const EXAMPLE_1 = [
  ["Worlds", 200, 284, 40, "Count"],
  ["Asian & Oceanian Championship", 150, 170, 25, "Count"],
  ["Malaysia Open B", 75, 50, 5, "Count"],
  ["Malaysia Open A", 75, 59, 8, "Excluded by Grade 75 host cap"],
  ["Thailand Open", 75, 65, 12, "Count"],
  ["Singapore Nationals 1", 40, 106, 3, "Count"],
  ["Singapore Nationals 2", 40, 83, 6, "Excluded by Grade 40 country/year cap"],
  ["Thailand Nationals", 40, 70, 20, "Sixth-highest surviving result"],
] as const;

const EXAMPLE_2 = [
  ["Malaysia Open", 75, 59, 4, "Count"],
  ["Thailand Open", 75, 65, 9, "Count"],
  ["Singapore Open", 75, 106, 15, "Count"],
  ["Hong Kong Open", 75, 77, 30, "Count"],
  ["Japan Open", 75, 45, 20, "Excluded by combined Grade 200/150/75 cap"],
  ["Singapore Nationals", 40, 83, 2, "Count"],
  ["Thailand Nationals", 40, 70, 10, "Outside the best permitted five"],
] as const;

function exampleRows(rows: readonly (readonly [string, 200 | 150 | 75 | 40, number, number, string])[]) {
  return rows.map(([name, grade, n, p, treatment]) => [
    name,
    grade,
    n,
    p,
    fmt(asianIndexPoints(grade, n, p)),
    treatment,
  ]);
}

const COMPARISON_PLACES = [1, 10, 25, 50, 75, 100] as const;

export default function AsianOptimistIndexMethodologyPage() {
  return (
    <main className="min-h-screen bg-sailcloth pb-16">
      <header className="border-b border-harbour-shadow bg-harbour text-white">
        <div className="mx-auto max-w-4xl px-4 py-10 sm:px-6 lg:py-12">
          <Link
            href={ASIAN_INDEX_PATH}
            className="text-sm font-bold text-soft-aqua hover:text-white hover:underline"
          >
            ← SailorPath Asian and Oceania Optimist Index
          </Link>
          <p className="mt-4 text-xs font-extrabold uppercase tracking-[0.18em] text-soft-aqua">
            Methodology · {ASIAN_INDEX_BETA_VERSION}
          </p>
          <h1 className="mt-2 font-display text-3xl font-extrabold tracking-tight sm:text-5xl">
            Asian &amp; Oceania Optimist Index: Methodology
          </h1>
          <p className="mt-3 text-base leading-7 text-sailcloth">
            V1.1 (Beta), dated {ASIAN_INDEX_BETA_DRAFT_DATE}. The live calculation and source evidence remain under
            review. This is not an official IODA or national federation ranking.
          </p>
        </div>
      </header>

      <div className="mx-auto max-w-4xl px-4 sm:px-6">
        <nav
          aria-label="Methodology sections"
          className="mt-6 rounded-xl border border-cool-veil bg-warm-white p-4 shadow-sm"
        >
          <p className="text-xs font-bold uppercase tracking-wide text-slate-soft">On this page</p>
          <ol className="mt-2 grid gap-x-6 gap-y-1 text-sm font-semibold text-harbour sm:grid-cols-2">
            {SECTIONS.map(([id, label]) => (
              <li key={id}>
                <a href={`#${id}`} className="underline-offset-2 hover:text-racing-deep hover:underline">
                  {label}
                </a>
              </li>
            ))}
          </ol>
        </nav>

        <Section id="purpose" title="1. Overview & eligibility">
          <p>
            The <strong>SailorPath Asian and Oceania Optimist Index</strong> is an independent analytical index of
            published Optimist results. It is not an official IODA or national federation ranking and must not be used
            as a team-selection tool. Event organisers, juries, and national authorities remain the authority for
            official results.
          </p>
          <p id="eligibility">A sailor appears in the live Index when:</p>
          <Bullets
            items={[
              "their recorded MNA representation belongs to Asia or Oceania (listed below);",
              "their recorded birth year, when available, indicates Optimist age eligibility (15 or under in the current calendar year); and",
              "they have at least one verified, positive-point result in a designated event within the active window.",
            ]}
          />
          <p>
            The current beta can include sailors whose birth year is not recorded. Their age eligibility is not yet
            confirmed. Representation, ages, fleet sizes and source evidence remain subject to review.
          </p>
          <AsianIndexTable
            caption="Eligible Asian and Oceanian MNA codes by region"
            headers={["Region", "Eligible MNA codes"]}
            rows={ASIAN_INDEX_MNA_REGIONS.map((r) => [r.region, r.codes.join(", ")])}
          />
        </Section>

        <Section id="grades" title="2. Event grades & split fleets">
          <p>
            Season Points uses four designated event tiers. Grade 75 opens generally require at least{" "}
            {ASIAN_INDEX_GRADE_75_CRITERIA.starters} starters across {ASIAN_INDEX_GRADE_75_CRITERIA.verifiedMnas}+ MNAs
            and {ASIAN_INDEX_GRADE_75_CRITERIA.completedRaces}+ completed races.
          </p>
          <AsianIndexTable
            caption="Event grades, host scope and gates"
            headers={["Grade", "Events", "Host", "Gates"]}
            rows={ASIAN_INDEX_GRADES.map((g) => [`${g.grade} · ${g.label}`, g.events, g.host, g.gates])}
          />
          <Sub title="Qualifying-split fleets (Gold + Silver)" />
          <p>
            When an event runs a qualifying series before splitting into Gold and Silver fleets (for example{" "}
            <strong>Eastern Seaboard</strong> or <strong>R.O.C. Kosmos</strong>), the Index scores the{" "}
            <strong>combined recorded fleet size</strong> (<code>N = Gold + Silver</code>) with Silver finishers placed
            continuously behind Gold (<code>Gold 1..G</code>, <code>Silver G+1..G+S</code>). Separate Boys and Girls
            divisions (for example Europeans and Taiwan President&apos;s Cup) use their own division fleet size. The
            2026 ASAF Cup boys&apos; and girls&apos; fleets do not meet the Grade 75 fleet-size gate and are excluded
            from both Season Points and the separate Power Rating pool.
          </p>
        </Section>

        <Section id="points" title="3. Season Points & rolling window">
          <p className="rounded-lg bg-warm-white p-4 text-center text-lg font-extrabold text-harbour">
            Points = E × (N − P + 1) ÷ N
          </p>
          <Bullets
            items={[
              <>
                <strong>Variables:</strong> <code>E</code> is the event grade (200, 150, 75, or 40), <code>N</code> is
                the fleet size used by the calculation, and <code>P</code> is the place used for the Index. First place earns{" "}
                <code>E</code>; last place earns <code>E ÷ N</code>.
              </>,
              <>
                <strong>Rounding:</strong> Totals are computed using full precision and rounded to two decimal places
                for display.
              </>,
              <>
                <strong>Rolling window &amp; Championship anchor:</strong> The intended policy is to retain an annual
                event until its next matching edition concludes and its final results are verified, even if that takes
                more than 12 months. The current calculation applies that rollover to the{" "}
                <strong>Asian &amp; Oceanian Championship</strong> anchor, retaining <code>2025 Asians</code> until
                the next edition (<code>2026 Asians</code>, Colombo) publishes verified final results. Other events
                currently use a rolling 12-month window while broader annual rollover is implemented and reviewed.
              </>,
            ]}
          />
        </Section>

        <Section id="selection" title="4. Selection limits & ties">
          <p>
            For each sailor, the Index selects the highest-scoring combination of eligible results that satisfies all
            six rules:
          </p>
          <ol className="list-decimal space-y-1.5 pl-5">
            {ASIAN_INDEX_SELECTION_LIMITS.map((limit) => (
              <li key={limit}>{limit}</li>
            ))}
          </ol>
          <p>
            Because the algorithm evaluates complete valid combinations, a strong Grade 40 or Grade 75 score can replace
            a weak higher-grade finish when the overall or upper-grade cap is reached. Ties on total Season Points are
            broken by highest championship points, then best Asian &amp; Oceanian anchor finish.
          </p>
        </Section>

        <Section id="examples" title="5. Worked examples">
          <Sub title="Example 1: country caps and the five-result limit" />
          <AsianIndexTable
            caption="Example 1 results and treatment"
            headers={["Result", "E", "N", "P", "Points", "Treatment"]}
            rows={exampleRows(EXAMPLE_1)}
            numericColumns={[1, 2, 3, 4]}
          />
          <p>
            Sum of unrounded selected scores: 471.911716… → displayed Season Points: <strong>471.91</strong>.
          </p>

          <Sub title="Example 2: five results without Grade 200 or Grade 150 access" />
          <AsianIndexTable
            caption="Example 2 results and treatment"
            headers={["Result", "E", "N", "P", "Points", "Treatment"]}
            rows={exampleRows(EXAMPLE_2)}
            numericColumns={[1, 2, 3, 4]}
          />
          <p>
            Sum of unrounded selected scores: 288.321330… → displayed Season Points: <strong>288.32</strong>.
          </p>

          <Sub title="Points comparison across grades (100-boat fleet)" />
          <AsianIndexTable
            caption="Points by place in a 100-starter competition"
            headers={["Place", "Grade 200", "Grade 150", "Grade 75", "Grade 40"]}
            rows={COMPARISON_PLACES.map((place) => [
              place,
              fmt(asianIndexPoints(200, 100, place)),
              fmt(asianIndexPoints(150, 100, place)),
              fmt(asianIndexPoints(75, 100, place)),
              fmt(asianIndexPoints(40, 100, place)),
            ])}
            numericColumns={[1, 2, 3, 4]}
          />
        </Section>

        <Section id="power-rating" title="6. Power Rating (Elo), Form & U13 Next-Gen">
          <p>
            Alongside <strong>Season Points</strong>, the Index hub provides two complementary views calculated live
            across designated events and other published Optimist regattas with at least 3 completed races in the
            rolling 12-month window. Events explicitly excluded in the Index register are omitted. The retained 2025
            Asian &amp; Oceanian anchor is also included:
          </p>

          <Sub title="Power Rating (Elo)" />
          <p>
            Estimates head-to-head performance across the available results, taking opponents&apos; ratings into
            account. Participation opportunities and the coverage of results can still affect the rating. Every sailor starts at <strong>1500</strong>, and events are processed
            chronologically by end date:
          </p>
          <Bullets
            items={[
              <>
                <strong>Symmetric regatta pool:</strong> Includes both designated Index events and all published
                national/regional regattas available in SailorPath across countries. Split fleets (Gold + Silver + Bronze, Open +
                Intermediate, Class A + B) sharing an event can be combined into one ordered field, placing the higher
                division ahead of the lower one. This is a calculation assumption and is not necessarily an official
                combined classification.
              </>,
              <>
                <strong>Pairwise update:</strong> For each event of <code>N</code> finishers, expected score{" "}
                <code>E_ij = 1 / (1 + 10^((R_j − R_i) / 400))</code> and update{" "}
                <code>R&apos;_i = R_i + K × (Σ(S_ij − E_ij) / (N − 1))</code>.
              </>,
              <>
                <strong>Tier sensitivity (K):</strong> <strong>48</strong> (Grade 200 Worlds), <strong>40</strong>{" "}
                (Grade 150 Continentals &amp; R.O.C.), <strong>32</strong> (Grade 75 Opens), <strong>24</strong>{" "}
                (Grade 40 Nationals), and <strong>16</strong> (other published domestic/regional regattas).
              </>,
            ]}
          />

          <Sub title="90-Day Momentum (Form)" />
          <p>
            Tracks the net change in a sailor&apos;s Elo rating over the trailing 90 days (
            <code>Δ_90 = round(R_current − R_90_days_ago)</code>), highlighting rising form (<code>≥ +5</code>) and
            cooling form (<code>≤ −5</code>).
          </p>

          <Sub title="U13 / Next-Gen" />
          <p>
            Filters Index sailors with a recorded birth year to those aged{" "}
            <strong>under 13 in the current calendar year</strong> (for 2026: recorded birth year{" "}
            <strong>2014 or later</strong>; for 2027: 2015 or later) and ranks them by <strong>Power Rating (Elo)</strong> descending. Sailors
            without a recorded birth year are excluded from this view until a year is recorded.
          </p>
        </Section>

        <Section id="revisions" title="7. Governance & revision log">
          <p>
            Standings, event registers, and Elo ratings recompute from SailorPath&apos;s published regatta records.
            Corrections to results or sailor birth years/MNAs can update the live Index on a subsequent revalidation
            cycle. Event gates, starter counts, identity matching and source evidence remain under review; the Index
            should not be used for team selection.
          </p>
          <AsianIndexTable
            caption="Methodology revision log"
            headers={["Version", "Date", "Changes"]}
            rows={[
              ["0.1–0.3", "18 October 2026", "Initial consultation drafts defining formula, caps, and Grade 75/40 criteria."],
              [
                "V1 (Beta)",
                "18 October 2026",
                "Expanded scope to include Oceania (AUS, NZL, etc.) alongside Asia; launched at /optimist/asian-index.",
              ],
              [
                "V1.1 (Beta)",
                "16 November 2026",
                "Promoted Worlds to Grade 200 (max 1); retained Continentals and added R.O.C. at Grade 150 (max 2); combined Gold+Silver qualifying-split fleets (Kosmos 122, Eastern Seaboard 135); moved standings to live DB scoring; added symmetric Power Rating (Elo), 90-day Form, and U13 / Next-Gen (2014+).",
              ],
            ]}
          />
        </Section>
      </div>
    </main>
  );
}
