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
  title: "Asian Optimist Index (Beta) methodology | SailorPath",
  description:
    "The full draft methodology for the SailorPath Asian Optimist Index (Beta): eligibility, event grades, scoring, selection limits, expiry, designation and corrections.",
  alternates: { canonical: "/sg/optimist/asian-index/methodology" },
};

const SECTIONS = [
  ["purpose", "Status and purpose"],
  ["eligibility", "1. Sailor eligibility"],
  ["results-list", "2. Which results list is scored"],
  ["starters", "3. Starters, places and races"],
  ["grades", "4. Event grades and criteria"],
  ["points", "5. Result points and expiry"],
  ["selection", "6. Selecting results and ranking"],
  ["examples", "7. Worked examples"],
  ["register", "8. Register, nominations and baseline"],
  ["governance", "9. Verification, corrections, governance"],
  ["launch", "10. Before launch"],
  ["revisions", "Revision log"],
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
    <section id={id} aria-labelledby={`${id}-heading`} className="scroll-mt-24 pt-10">
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
  ["Worlds", 150, 284, 40, "Count"],
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
  ["Japan Open", 75, 45, 20, "Excluded by combined Grade 150/75 cap"],
  ["Singapore Nationals", 40, 83, 2, "Count"],
  ["Thailand Nationals", 40, 70, 10, "Outside the best permitted five"],
] as const;

function exampleRows(rows: readonly (readonly [string, 150 | 75 | 40, number, number, string])[]) {
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
        <div className="mx-auto max-w-4xl px-4 py-10 sm:px-6 lg:py-14">
          <Link
            href={ASIAN_INDEX_PATH}
            className="text-sm font-bold text-soft-aqua hover:text-white hover:underline"
          >
            ← SailorPath Asian Optimist Index (Beta)
          </Link>
          <p className="mt-5 text-xs font-extrabold uppercase tracking-[0.18em] text-soft-aqua">
            Methodology · technical specification
          </p>
          <h1 className="mt-2 font-display text-3xl font-extrabold tracking-tight sm:text-5xl">
            Asian Optimist Index (Beta): Methodology
          </h1>
          <p className="mt-4 text-base leading-7 text-sailcloth">
            Draft v{ASIAN_INDEX_BETA_VERSION} · {ASIAN_INDEX_BETA_DRAFT_DATE} · for consultation. The launch date,
            first event register and publication schedule will be announced together. This draft does not change the
            live Index or designate any event.
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

        <Section id="purpose" title="Status and purpose">
          <p>
            The SailorPath Asian Optimist Index is an independent analytical index of verified Optimist results. It is
            published by SailorPath and is not an official IODA or national federation ranking. It must not be used as
            a team-selection tool. Organisers, juries and national authorities remain the authority for official
            results.
          </p>
          <p>
            The Index is built for sailors representing Asian national authorities, who compete mainly in Asian
            regattas. National championships and most Grade 75 events therefore need to be hosted in Asia (Section 4).
            IODA Worlds and continental championships count wherever they are held.
          </p>
          <p>
            The Index adds a sailor&apos;s best eligible results over a rolling 12-month window, subject to event-grade
            and country limits. It measures finishing position within designated competitions. It limits the advantage
            of attending more events, although more starts still provide more opportunities to improve a score.
          </p>
          <p>
            The Index does not measure field strength directly. Events at the same grade receive the same treatment
            even when their competitors differ substantially in ability. Fleet-size and international-participation
            criteria are eligibility thresholds, not a measurement of competitive strength. A larger fleet does not
            automatically produce a higher score for the same finishing percentile. Different primary-competition
            formats also limit comparability.
          </p>
          <p>
            A strong result at a Grade 150 championship is treated as good evidence of sailor quality. Equal grading of
            Worlds and continental championships is a deliberate policy choice (Section 4).
          </p>
        </Section>

        <Section id="eligibility" title="1. Sailor eligibility">
          <p>A sailor appears in the current Index only when:</p>
          <Bullets
            items={[
              "their current verified representation on the ranking date is an eligible Asian MNA;",
              "they meet the Index age rule; and",
              "they have at least one verified, positive-point result eligible for the current window.",
            ]}
          />
          <p>
            An MNA is a World Sailing Member National Authority. Representation follows verified sporting
            representation, with official results and authority records used as evidence. Residence, club membership
            and sail numbers alone do not establish representation.
          </p>

          <Sub title="Eligible MNA codes" />
          <p>
            For this draft, the following 35 codes reproduce the entries in the{" "}
            <a
              href="https://www.asiansailing.org/asaf-members/"
              target="_blank"
              rel="noreferrer"
              className="font-semibold text-harbour underline underline-offset-2"
            >
              Asian Sailing Federation&apos;s MNA table
            </a>
            , checked on 18 October 2026.
          </p>
          <AsianIndexTable
            caption="Eligible MNA codes by region"
            headers={["Region", "Eligible codes"]}
            rows={ASIAN_INDEX_MNA_REGIONS.map((region) => [region.region, region.codes.join(", ")])}
          />
          <p>
            <strong>Basis of the list.</strong> Eligibility is based on ASAF membership as shown in that table, not on
            geography. The broader geographic country lists on the ASAF page do not determine eligibility. Sailors
            representing a country that is geographically in Asia but absent from the table (for example BAN, NEP or
            MDV) are not eligible until a dated update adds that MNA. Sailors from Oceania and other regions are
            likewise outside the Index, although their results still count toward other sailors&apos; fleet sizes (N).
          </p>
          <p>
            The published version of this list governs each ranking snapshot. Changes require a dated update and apply
            from its stated ranking date; they do not silently rewrite historical snapshots. Alternate codes in source
            documents must be mapped to a verified MNA, with the mapping recorded.
          </p>

          <Sub title="Changes of representation" />
          <p>
            Each sailor is listed under one current verified MNA. A change takes effect at the first ranking date on or
            after verification. All eligible results in the window stay with the verified athlete identity, including
            results sailed under an earlier representation. Each result retains its original representation in the
            ledger.
          </p>
          <p>
            A sailor moving outside the eligible list leaves the current Index; a sailor moving into it can enter with
            their eligible results in the window. Historical snapshots preserve the representation recorded at the
            time. Disputed changes follow the identity-review process.
          </p>

          <Sub title="Age rule" />
          <p>
            For this Index, a sailor remains age-eligible through 31 December of the calendar year in which they turn
            15, and leaves the current Index from 1 January of the following year. For example, a sailor born in 2011
            remains eligible through 31 December 2026. This follows the calendar-year age convention described by the{" "}
            <a
              href="https://www.optimist.org.uk/the-optimist-class/about-the-boat/"
              target="_blank"
              rel="noreferrer"
              className="font-semibold text-harbour underline underline-offset-2"
            >
              UK national Optimist association
            </a>
            .
          </p>
          <p>
            The Index applies this rule on the ranking date, independently of any event-specific permission to finish a
            regatta spanning the year boundary. Birth year or other sufficient age evidence must be verified privately;
            full dates of birth are not required in the public ledger. Where age eligibility cannot be verified,
            listing remains pending.
          </p>
          <p>
            <strong>Year-end snapshot.</strong> Because every 1 January removes the oldest cohort, often including the
            strongest sailors, SailorPath publishes a <strong>final year-end snapshot dated 31 December</strong> each
            year. It lists every sailor who is age-eligible on that date, is archived permanently, and is labelled as
            that year&apos;s final Index. The 1 January ranking then excludes sailors who have aged out. Aged-out
            sailors keep their results as competition history and a link to their final year-end entry.
          </p>
        </Section>

        <Section id="results-list" title="2. Which results list is scored?">
          <p>
            Before racing begins, the register identifies the primary individual competition and the official results
            list to be used. A sailor can receive only one Index result from an event. Award subsets and duplicate
            publications never create additional results.
          </p>
          <Bullets
            items={[
              <>
                <strong>Combined competitions:</strong> where qualifying is followed by Gold, Silver or Bronze flights
                and the organiser publishes one final overall order, use that combined order. Include all valid
                starters in the competition, including sailors assigned to lower final flights.
              </>,
              <>
                <strong>Separate boys&apos; and girls&apos; primary competitions:</strong> score each sailor within
                their own competition. Never manufacture a combined ranking. These are primary competitions, unlike
                gender awards extracted from a mixed fleet. The{" "}
                <a
                  href="https://www.ct-sailing.org.tw/media/k2/attachments/Document_133556_20260210232146_en.pdf"
                  target="_blank"
                  rel="noreferrer"
                  className="font-semibold text-harbour underline underline-offset-2"
                >
                  2026 European Championship Notice of Race, section 7.1
                </a>
                , provides an example of separate primary competitions.
              </>,
              <>
                <strong>Separately entered divisions:</strong> where the event offers a premier division alongside
                Junior, Intermediate, Green or other development divisions, score only the designated premier division.
                Division names alone do not determine eligibility: a post-qualifying Silver flight is different from a
                separately entered development division. This is decided per event at designation and recorded in the
                register.
              </>,
              <>
                <strong>National championships:</strong> use the official open primary classification, including
                foreign sailors. A national-only award subset is not scored. If the championship has no foreign
                entries, its main classification can still qualify.
              </>,
              <>
                <strong>No combined final order:</strong> if a competition splits into final flights but publishes no
                authoritative overall order, seek an official combined classification or written confirmation of the
                ordering. Do not silently substitute a Gold-only denominator or invent an overall order. Scoring
                remains pending until the evidence supports the designated classification.
              </>,
            ]}
          />
          <p>
            Where an event has separate primary competitions, apply starter, nationality and race criteria to each
            competition separately. One may qualify while another does not.
          </p>
        </Section>

        <Section id="starters" title="3. Starters, places and completed races">
          <p>
            A <strong>valid starter</strong> is a sailor who started at least one race in the designated primary
            competition. A later retirement or race disqualification does not by itself remove that sailor from the
            denominator. Entrants who never started are excluded. Race codes alone do not always establish whether a
            sailor started; ambiguous cases require official supporting evidence.
          </p>
          <p>
            <strong>N</strong> is the number of valid starters. <strong>P</strong> is the sailor&apos;s position among
            those starters, preserving the official final ordering after non-starters are removed. SailorPath does not
            assume that official lists always place non-starters last. If removal creates gaps, positions are
            compressed for Index calculation, and both the original official place and the adjusted Index place are
            recorded.
          </p>
          <p>
            If the official result leaves a genuine tied position unresolved, use the average of the tied
            starters&apos; occupied positions for P. For example, a tie occupying positions 10 and 11 gives each sailor
            P = 10.5. Do not break an official tie by alphabetical order.
          </p>
          <p>
            If an official final decision excludes a sailor from the event classification entirely, follow that
            decision. If a sailor remains listed but has no official ranked position, do not invent one: retain the
            result as unscored pending clarification. Explain any effect on N in the ledger.
          </p>
          <p>
            A <strong>completed race</strong> is a numbered race with official results for the designated competition.
            Parallel qualifying groups count as one race number, not multiple races. For a combined competition, count
            a race number only when the official scoring confirms its completion for all relevant groups or flights.
            Abandoned races do not count. Completed races later discarded from a sailor&apos;s net score still count
            toward the race gate.
          </p>
        </Section>

        <Section id="grades" title="4. Event grades, hosting and criteria">
          <p>
            Each event edition receives one designated grade. It must meet its designation criteria before racing and
            pass every confirmation gate afterwards; there is no automatic downgrade after racing if it fails. A future
            lower grade requires its own advance designation. The register also records the host MNA jurisdiction used
            for country caps.
          </p>
          <AsianIndexTable
            caption="Event grades, host location and confirmation gates"
            headers={["Grade", "Eligible events", "Host location", "Confirmation gates for each scored competition"]}
            rows={[
              ...ASIAN_INDEX_GRADES.map((grade) => [
                `${grade.grade}`,
                grade.events,
                grade.host,
                grade.gates,
              ]),
              [
                "0",
                "Other verified competition history, including club events, clinics, team racing, separately entered development divisions, non-Asian national championships and events failing their designated gates",
                "Any",
                "Unscored",
              ],
            ]}
          />

          <Sub title="Grade 75 designation criteria" />
          <p>A Grade 75 event edition is designated before racing only when the published evidence shows:</p>
          <Bullets
            items={[
              <>
                at least <strong>{ASIAN_INDEX_GRADE_75_CRITERIA.registeredSailors} registered sailors</strong> in the
                designated primary competition; and
              </>,
              <>
                at least <strong>{ASIAN_INDEX_GRADE_75_CRITERIA.verifiedMnas} verified MNAs</strong> among those
                registered sailors.
              </>,
            ]}
          />
          <p>
            Evidence is the organiser&apos;s entry list or registration statistics available at the designation
            deadline. Where the current edition&apos;s entry list is not yet available, a{" "}
            <strong>conditional designation</strong> may rest on the previous edition having at least 50 starters from
            at least 4 verified MNAs. A conditional designation is confirmed only if the current edition meets the
            confirmation gates. The 50-registered criterion is deliberately higher than the 40-starter confirmation
            gate, which allows for withdrawals and non-starters. Unknown or unverified representation does not count
            toward the MNA criterion.
          </p>
          <p>
            Meeting the criteria makes an event eligible for designation; it does not oblige SailorPath to designate
            it. Each designation decision and its rationale are published.
          </p>

          <Sub title="Non-Asian-hosted Grade 75 exceptions" />
          <p>
            Because Asian sailors sometimes travel to major European opens (for example, a major open at Lake Garda),
            SailorPath may designate a small published number of non-Asian-hosted Grade 75 events each season. Each
            must meet the same designation criteria and confirmation gates, is announced with its rationale before the
            deadline, and counts under the same Grade 75 caps, including the one-result-per-host-jurisdiction limit.
            The proposed ceiling is two non-Asian-hosted Grade 75 designations per season.
          </p>

          <Sub title="Other notes on grades" />
          <p>
            MNAs counted toward the Grade 75 criteria and gates may be from any region, but must be represented. Host
            jurisdictions use sporting MNA boundaries consistently, including distinct territories with their own MNAs.
            The Grade 40 country/year cap uses the year of the competition&apos;s final race day.
          </p>
          <p>
            All eligible IODA continental fleet-racing championships share Grade 150 with Worlds. Equal grading is a
            policy choice intended to recognise performances across championship pathways; it does not assert equal
            field strength. Team-racing championships are excluded.
          </p>
        </Section>

        <Section id="points" title="5. Result points and expiry">
          <p className="rounded-lg bg-warm-white p-4 text-center text-lg font-extrabold text-harbour">
            Points = E × (N − P + 1) ÷ N
          </p>
          <p>
            E is the event grade, N the valid-starter count and P the Index place defined above. First place earns E
            and last place earns E/N. A sailor who never started earns no Index result.
          </p>
          <p>
            Calculate result points and totals without intermediate rounding. Display each to two decimals. A displayed
            total may differ by 0.01 from the sum of displayed result points because the total uses the underlying
            values.
          </p>
          <p>
            The <strong>final race day</strong> is the local calendar date of the last completed race in the primary
            competition, rather than the prize-giving date or an unused reserve day. Results with an uncertain final
            race date remain pending.
          </p>
          <p>
            For a ranking date D and final race date F, a result is in the window when{" "}
            <strong>F ≤ D &lt; F + 12 calendar months</strong>. It ceases to count on its anniversary date. A result
            dated 18 October 2025 is therefore expired for the ranking dated 18 October 2026. For a 29 February result,
            use 28 February in a non-leap anniversary year.
          </p>
          <p>
            Every ranking snapshot records its ranking date and data cut-off timestamp. Only sources verified by that
            cut-off are included; later corrections produce a new recorded revision. There is no 24-month exception.
          </p>
        </Section>

        <Section id="selection" title="6. Selecting results and ranking sailors">
          <p>Choose the combination with the highest total points subject to all six limits:</p>
          <ol className="list-decimal space-y-1.5 pl-5">
            {ASIAN_INDEX_SELECTION_LIMITS.map((limit) => (
              <li key={limit}>{limit}</li>
            ))}
          </ol>
          <p>
            There are no reserved grade slots and no requirement to count a result merely because it has a higher
            grade. Five Grade 40 results can count if they satisfy the country/year cap. A sailor with no Grade 150
            results can count up to four Grade 75 results and one Grade 40 result, or fewer Grade 75 and more Grade 40
            results. The four-result upper-grade limit also means a sailor with no eligible Grade 40 result can count at
            most four results.
          </p>
          <p>To calculate the Index:</p>
          <ol className="list-decimal space-y-1.5 pl-5">
            <li>
              Collect verified results from Confirmed competitions that meet their gates and fall within the window.
            </li>
            <li>
              For Grade 75, retain the best result per host jurisdiction; for Grade 40, retain the best per
              jurisdiction/year.
            </li>
            <li>
              Select the highest-total combination satisfying all six limits. Compare complete combinations rather than
              filling higher grades first.
            </li>
            <li>
              Add the selected scores. Sailors with fewer than five usable results receive the sum of the results
              selected.
            </li>
          </ol>
          <p>
            Ranking compares the mathematical, unrounded totals. An implementation must not use binary floating-point
            artefacts to distinguish mathematically equal totals. Where totals are equal, compare the selected scores
            from highest to lowest, padding missing scores with zero. If these are also equal, sailors share a rank.
            Shared ranks use competition numbering, such as 1, 2, 2, 4. Alphabetical display order within a shared rank
            does not break the tie; use the verified display name without assuming every naming convention has a family
            name.
          </p>
          <p>
            If several result combinations have the same total, use the combination with the stronger highest-to-lowest
            score sequence for this comparison. If still identical, use newer final race dates and then stable event
            identifiers to choose the displayed set; these display choices do not change rank.
          </p>
        </Section>

        <Section id="examples" title="7. Worked examples">
          <p>
            All events, fleet sizes and places below are hypothetical. P is the Index place after any non-starter
            adjustment. Example 1 assumes both Singapore events ended in the same calendar year and that every
            Grade 40 event is hosted in Asia.
          </p>

          <Sub title="Example 1: country caps and the five-result limit" />
          <AsianIndexTable
            caption="Example 1 results and treatment"
            headers={["Result", "E", "N", "P", "Points", "Treatment"]}
            rows={exampleRows(EXAMPLE_1)}
            numericColumns={[1, 2, 3, 4]}
          />
          <p>
            The sum of the unrounded selected scores is 428.777913…; the displayed Index is <strong>428.78</strong>.
          </p>

          <Sub title="Example 2: five results without Grade 150 access" />
          <AsianIndexTable
            caption="Example 2 results and treatment"
            headers={["Result", "E", "N", "P", "Points", "Treatment"]}
            rows={exampleRows(EXAMPLE_2)}
            numericColumns={[1, 2, 3, 4]}
          />
          <p>
            The sum of the unrounded selected scores is 288.321330…; the displayed Index is <strong>288.32</strong>.
            Japan&apos;s result scores more than Singapore Nationals, but cannot become a fifth upper-grade result.
          </p>

          <Sub title="Example 3: a lower grade can replace a weaker higher grade" />
          <p>
            A sailor has two Grade 150 results worth 120 and 10, two Grade 75 results worth 70 and 60 from different
            hosts, and two Grade 40 results worth 40 and 35 from different country/year groups. Count 120 + 70 + 60 +
            40 + 35 = <strong>325.00</strong>. The 10-point Grade 150 result is excluded despite its higher grade.
          </p>

          <Sub title="Comparing grades" />
          <AsianIndexTable
            caption="Points by place in a 100-starter competition"
            headers={["Place in a 100-starter competition", "Grade 150", "Grade 75", "Grade 40"]}
            rows={COMPARISON_PLACES.map((place) => [
              place,
              fmt(asianIndexPoints(150, 100, place)),
              fmt(asianIndexPoints(75, 100, place)),
              fmt(asianIndexPoints(40, 100, place)),
            ])}
            numericColumns={[1, 2, 3]}
          />
          <p>
            A Grade 75 win is approximately equivalent to a mid-fleet Grade 150 finish. A Grade 40 win is approximately
            equivalent to a mid-fleet Grade 75 finish. This is the intended weighting. Last place earns a positive
            amount, and smaller fleets give a larger last-place score at the same grade. These are disclosed
            limitations.
          </p>
        </Section>

        <Section id="register" title="8. Event register, nominations and the baseline">
          <p>
            The public register identifies each event edition, organiser, dates, host jurisdiction, grade, primary
            competitions, classification policy, applicable methodology version and designation timestamp. The{" "}
            <Link
              href={`${ASIAN_INDEX_PATH}#register`}
              className="font-semibold text-harbour underline underline-offset-2"
            >
              proposed 2026–27 register
            </Link>{" "}
            is on the Index page.
          </p>
          <AsianIndexTable
            caption="Register statuses"
            headers={["Status", "Meaning", "Scores?"]}
            rows={[
              ["Confirmed", "Designated in time and final evidence verifies every gate for the scored competition", "Yes"],
              [
                "Pending verification",
                "Designated in time, but final results or a gate await verification; includes future designated events",
                "No",
              ],
              ["Proposed", "Under review; no designation has been granted", "No"],
              ["Open for nomination", "No specific event has been supplied for the opportunity", "No"],
            ]}
          />
          <p>
            Status is recorded per primary competition where an event has more than one. An event that fails its gates
            remains unscored with the reason published. Confirmation after racing verifies the original designation; it
            cannot create a new grade retrospectively.
          </p>

          <Sub title="Advance designation" />
          <p>
            Publish the grade and classification policy before the first scheduled race time in the Notice of Race and
            any schedule amendments published by designation time. Publish the timestamp and schedule source. A later
            postponement does not reopen an expired designation deadline. Recurring events may be designated by named
            editions for a season in advance. Grade 75 designations must also publish the evidence used for the
            50-registered-sailor and 4-MNA criteria (or the previous-edition evidence for a conditional designation).
          </p>

          <Sub title="Nominations and verification are separate stages" />
          <p>
            Before racing, nominations supply the event name and edition, organiser, dates, host jurisdiction, proposed
            grade, Notice of Race, planned fleet format, entry-list or registration statistics where available, and
            expected evidence that the gates can be met. Previous editions&apos; results may support assessment, but do
            not prove the new edition&apos;s gates.
          </p>
          <p>
            After racing, supply the official final results and supporting evidence of starters, MNAs, race completion
            and final race date. Final results are required for confirmation and scoring, not for advance nomination.
          </p>

          <Sub title="One-time beta baseline" />
          <p>
            At launch, SailorPath may designate a completed 2025 or 2026 event edition as a disclosed baseline
            exception only if it meets the Grade 150, Grade 75 or Grade 40 criteria and gates applying to its grade and
            host location. Publish the complete list, the criteria check for each event, grades, sources and
            designation date together. The baseline is defined by this rule rather than by hand-picked inclusion. Only
            results still inside the 12-month window count. Do not add later historical events under this exception.
            After launch, every new designation must meet the advance deadline.
          </p>
        </Section>

        <Section id="governance" title="9. Verification, corrections and governance">
          <p>
            Never match athletes across events by sail number alone. Use verified identity evidence, representation
            records and manual duplicate review. A disputed result-to-athlete match is suspended from the sailor&apos;s
            score pending review; this does not automatically remove the competitor from the event&apos;s fleet
            denominator.
          </p>
          <p>
            Each public ledger entry records the source URL, retrieval date, archived evidence reference, event and
            competition identity, methodology version, designation record, N, completed race count, official place,
            Index P, any adjustment, result points, expiry, and whether the result is selected or excluded and why.
            Archive only the evidence needed to audit the result, avoiding unnecessary personal information.
          </p>
          <p>
            When an organiser or jury amends the official result, verify the amended source and recalculate affected
            entries. Keep the previous evidence and decision history. Official corrections can change an event&apos;s
            gate status as well as individual points. Record affected ranking revisions rather than overwriting
            historical snapshots without notice.
          </p>
          <p>
            Sailors, parents, coaches and authorities may report errors with supporting sources. The proposed review
            target is 10 working days after receiving sufficient evidence. If review takes longer, provide the reason
            and next update date. Publish the final decision and its basis without exposing private identity evidence.
          </p>
          <p>
            SailorPath controls designation and methodology decisions and publishes their rationale. Its Singapore base
            and coverage of Singapore sailing do not confer different criteria, gates or discretionary exemptions on
            Singapore events. Relevant commercial or organisational relationships are disclosed alongside designation
            decisions.
          </p>
          <p>
            Substantive rule changes receive a version and effective date and apply to events whose first scheduled
            race is on or after that date. Keep the designated methodology for events already underway; do not change
            scoring rules mid-regatta. Existing results retain their applicable version through expiry. Corrections to
            official data, identity errors or implementation mistakes are distinguished from policy changes and
            recorded explicitly.
          </p>
        </Section>

        <Section id="launch" title="10. Items to complete before launch">
          <p>
            The following are operational launch requirements, rather than unresolved scoring rules:
          </p>
          <Bullets
            items={[
              "Publish the effective date, ranking publication schedule and data cut-off convention.",
              "Publish the fixed baseline register and evidence, including the criteria check, for every Confirmed competition.",
              "Provide working nomination and correction submission links, the nomination review timetable and the person or role responsible for decisions.",
              "Confirm that the public ledger, evidence history and calculation implement this version, including substitutions, adjusted places, expiry, ties and the 31 December year-end snapshot.",
              "Identify the initial membership-list version and the process for reviewing subsequent membership changes.",
              "Publish the one-page summary and the explanatory posts, each linking to this specification.",
            ]}
          />
        </Section>

        <Section id="revisions" title="Revision log">
          <AsianIndexTable
            caption="Methodology revision log"
            headers={["Version", "Date", "Changes"]}
            rows={[
              ["0.1", "18 October 2026", "Supplied consultation draft"],
              [
                "0.2",
                "18 October 2026",
                "Clarified starter-adjusted positions, official ties, combined classifications, optimal selection, age-out and expiry; separated advance nominations from final verification; fixed open-classification and mid-event revision contradictions; retained the supplied grade weights and substantive counting limits",
              ],
              [
                "0.3",
                "18 October 2026",
                "Grade 40 limited to Asia-hosted national championships; Grade 75 Asia-hosted by default with a limited, published non-Asian exception (proposed ceiling of two per season); added published Grade 75 designation criteria (at least 50 registered sailors and 4 verified MNAs, conditional designation on previous-edition evidence); stated that eligibility is based on ASAF membership rather than geography; added a 31 December year-end snapshot before the age-out reset; baseline defined by rule; restructured as the technical specification behind a one-page summary and posts",
              ],
            ]}
          />
        </Section>
      </div>
    </main>
  );
}
