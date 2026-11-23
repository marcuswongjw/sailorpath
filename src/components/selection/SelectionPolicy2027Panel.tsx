import Link from "next/link";
import {
  Award,
  Calendar,
  CheckCircle2,
  Clock,
  Compass,
  FileText,
  MapPin,
  Plane,
  ShieldCheck,
  Trophy,
} from "lucide-react";
import type {
  ClassSelectionPolicy2027,
  SelectionFundingCategory,
  SelectionPolicyCampaign2027,
} from "@/lib/selectionPolicies2027";

const CLASS_POLICY_LINKS = [
  { id: "optimist", label: "Optimist", href: "/sg/optimist/selection" },
  { id: "ilca4", label: "ILCA 4", href: "/sg/ilca4/selection" },
  { id: "ilca6", label: "ILCA 6", href: "/sg/ilca6/selection" },
] as const;

function fundingBadgeClasses(category: SelectionFundingCategory): string {
  switch (category) {
    case "Key Competition":
      return "bg-[var(--sp-aqua-mist)] border-[var(--sp-harbour-teal)]/35 text-[var(--sp-harbour-shadow)]";
    case "Non-Key Competition":
      return "bg-sky-50 border-sky-300 text-sky-900";
    case "Training Camp":
      return "bg-purple-50 border-purple-300 text-purple-900";
    case "Self-Funded":
      return "bg-amber-50 border-amber-300 text-amber-900";
  }
}

function CampaignCard({
  campaign,
}: {
  campaign: SelectionPolicyCampaign2027;
}) {
  const isSplitPathway = campaign.pathways.length > 1;

  return (
    <article
      aria-labelledby={`campaign-${campaign.id}`}
      className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 shadow-xs space-y-4"
    >
      {/* Campaign Header */}
      <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-3 pb-4 border-b border-[var(--sp-cool-veil)]">
        <div className="space-y-1.5 min-w-0">
          <div className="flex flex-wrap items-center gap-2">
            <span className="inline-flex h-6 min-w-6 items-center justify-center rounded-md bg-[var(--sp-racing-mist)]/40 border border-[var(--sp-racing-orange)]/30 px-2 text-xs font-black text-[var(--sp-racing-deep)]">
              {campaign.code})
            </span>
            <h3
              id={`campaign-${campaign.id}`}
              className="text-base sm:text-lg font-black text-[var(--sp-harbour-shadow)] tracking-tight"
            >
              {campaign.name}
            </h3>
            <span
              className={`rounded-full border px-2.5 py-0.5 text-[11px] font-bold ${fundingBadgeClasses(
                campaign.fundingCategory
              )}`}
            >
              {campaign.fundingCategory}
            </span>
            {!campaign.datesConfirmed && (
              <span className="rounded-full border border-amber-300 bg-amber-50 px-2.5 py-0.5 text-[11px] font-bold text-amber-900">
                Dates TBC
              </span>
            )}
          </div>

          <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-xs text-[var(--sp-slate-soft)]">
            <span className="inline-flex items-center gap-1.5">
              <MapPin className="h-3.5 w-3.5 shrink-0 text-[var(--sp-harbour-teal)]" aria-hidden="true" />
              <span>{campaign.venue}</span>
            </span>
            <span className="inline-flex items-center gap-1.5">
              <Calendar className="h-3.5 w-3.5 shrink-0 text-[var(--sp-harbour-teal)]" aria-hidden="true" />
              <span>{campaign.dates}</span>
            </span>
            <span className="inline-flex items-center gap-1.5">
              <Plane className="h-3.5 w-3.5 shrink-0 text-[var(--sp-racing-orange)]" aria-hidden="true" />
              <span>Travel: {campaign.travelPeriod}</span>
            </span>
          </div>
        </div>

        {campaign.calendarSlug && (
          <Link
            href={`/regattas/${campaign.calendarSlug}`}
            className="inline-flex min-h-10 shrink-0 items-center gap-1.5 rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-3.5 py-2 text-xs font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--sp-harbour-teal)]"
          >
            <Compass className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" aria-hidden="true" />
            <span>{campaign.name} event page →</span>
          </Link>
        )}
      </div>

      {/* Pathways (single or Part A / Part B) */}
      <div
        className={`grid grid-cols-1 ${
          isSplitPathway ? "lg:grid-cols-2" : ""
        } gap-4`}
      >
        {campaign.pathways.map((pathway) => (
          <div
            key={pathway.id}
            className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-4 space-y-3"
          >
            <div className="flex flex-wrap items-center justify-between gap-2">
              <h4 className="text-xs font-black uppercase tracking-wider text-[var(--sp-harbour-shadow)]">
                {pathway.title}
              </h4>
              <span className="text-[11px] font-bold text-[var(--sp-harbour-teal)]">
                {pathway.fleetOrClassNote}
              </span>
            </div>

            {/* Quotas */}
            <ul className="space-y-1.5">
              {pathway.quotas.map((quota, qIdx) => (
                <li
                  key={`${pathway.id}-q-${qIdx}`}
                  className="rounded-lg border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-3 py-2 flex flex-wrap items-center justify-between gap-2"
                >
                  <span className="text-xs sm:text-sm font-black text-[var(--sp-harbour-shadow)]">
                    {quota.label}
                  </span>
                  {quota.ageRule && (
                    <span className="rounded-full bg-[var(--sp-aqua-mist)] border border-[var(--sp-harbour-teal)]/25 px-2.5 py-0.5 text-[11px] font-bold text-[var(--sp-harbour-shadow)]">
                      {quota.ageRule}
                    </span>
                  )}
                </li>
              ))}
            </ul>

            {/* Scoring rule & ranking floor */}
            <div className="space-y-1.5 text-xs">
              <div className="flex items-start gap-2 text-[var(--sp-charcoal)]">
                <Award
                  className="h-3.5 w-3.5 mt-0.5 shrink-0 text-[var(--sp-racing-orange)]"
                  aria-hidden="true"
                />
                <span>
                  <strong className="font-bold">Criteria:</strong> {pathway.scoringRule}
                </span>
              </div>
              {pathway.rankingRequirement && (
                <div className="flex items-start gap-2 text-[var(--sp-charcoal)]">
                  <ShieldCheck
                    className="h-3.5 w-3.5 mt-0.5 shrink-0 text-[var(--sp-harbour-teal)]"
                    aria-hidden="true"
                  />
                  <span>
                    <strong className="font-bold">Eligibility Floor:</strong>{" "}
                    {pathway.rankingRequirement}
                  </span>
                </div>
              )}
            </div>

            {/* Selection Events */}
            {pathway.events.length > 0 ? (
              <div className="space-y-1.5 pt-1 border-t border-[var(--sp-cool-veil)]">
                <p className="text-[11px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
                  Qualifying Events
                </p>
                <ol className="space-y-1.5">
                  {pathway.events.map((ev, eIdx) => (
                    <li
                      key={`${pathway.id}-ev-${eIdx}`}
                      className="flex flex-wrap items-center justify-between gap-2 text-xs rounded-lg border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-3 py-2"
                    >
                      <div className="flex items-center gap-2 min-w-0">
                        <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-[var(--sp-aqua-mist)] text-[11px] font-black text-[var(--sp-harbour-shadow)]">
                          {eIdx + 1}
                        </span>
                        {ev.calendarSlug ? (
                          <Link
                            href={`/regattas/${ev.calendarSlug}`}
                            className="font-bold text-[var(--sp-harbour-shadow)] hover:text-[var(--sp-harbour-teal)] hover:underline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--sp-harbour-teal)]"
                          >
                            {ev.name}
                          </Link>
                        ) : (
                          <span className="font-bold text-[var(--sp-harbour-shadow)]">
                            {ev.name}
                          </span>
                        )}
                      </div>
                      <span className="font-mono text-[12px] text-[var(--sp-slate-soft)]">
                        {ev.dates}
                      </span>
                    </li>
                  ))}
                </ol>
              </div>
            ) : (
              <p className="text-xs text-[var(--sp-slate-soft)] pt-1 border-t border-[var(--sp-cool-veil)]">
                No trial regattas — selected directly from stated pool or ranking date.
              </p>
            )}

            {pathway.restrictionNote && (
              <p className="rounded-lg border border-amber-300 bg-amber-50 px-3 py-2 text-xs text-amber-950 leading-relaxed">
                {pathway.restrictionNote}
              </p>
            )}
          </div>
        ))}
      </div>

      {/* Funding & Notes */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4 pt-1">
        <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3.5 space-y-1">
          <h4 className="text-[11px] font-black uppercase tracking-wider text-[var(--sp-harbour-shadow)]">
            Funding
          </h4>
          <p className="text-xs text-[var(--sp-charcoal)] leading-relaxed">
            {campaign.fundingText}
          </p>
        </div>

        <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3.5 space-y-1.5">
          <h4 className="text-[11px] font-black uppercase tracking-wider text-[var(--sp-harbour-shadow)]">
            Policy Notes
          </h4>
          <ol className="space-y-1 list-decimal list-inside text-xs text-[var(--sp-charcoal)] leading-relaxed">
            {campaign.notes.map((note, nIdx) => (
              <li key={`${campaign.id}-note-${nIdx}`}>{note}</li>
            ))}
          </ol>
        </div>
      </div>
    </article>
  );
}

export function SelectionPolicy2027Panel({
  policy,
  showClassNav = true,
}: {
  policy: ClassSelectionPolicy2027;
  showClassNav?: boolean;
}) {
  return (
    <div className="space-y-6">
      {/* 2027 Policy Overview Banner */}
      <section
        aria-labelledby="policy-2027-heading"
        className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 shadow-xs space-y-4"
      >
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div className="space-y-1.5">
            <div className="inline-flex items-center gap-1.5 rounded-full border border-[var(--sp-harbour-teal)]/30 bg-[var(--sp-aqua-mist)] px-3 py-0.5 text-[11px] font-bold text-[var(--sp-harbour-shadow)]">
              <FileText className="h-3 w-3 text-[var(--sp-harbour-teal)]" aria-hidden="true" />
              <span>Issued on: {policy.issuedDate} · {policy.authority}</span>
            </div>
            <h2
              id="policy-2027-heading"
              className="text-lg sm:text-xl font-black text-[var(--sp-harbour-shadow)] tracking-tight"
            >
              2027 Selection Policy for {policy.classLabel}
            </h2>
            <p className="text-xs sm:text-sm text-[var(--sp-slate-soft)] max-w-3xl leading-relaxed">
              {policy.summary}
            </p>
          </div>

          <div className="shrink-0 flex flex-wrap items-center gap-2">
            <Link
              href={`/calendar?class=${policy.classId}&trials=1`}
              className="inline-flex min-h-11 items-center gap-1.5 rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-3.5 py-2 text-xs font-bold text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)] transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--sp-harbour-teal)]"
            >
              <Calendar className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)]" aria-hidden="true" />
              <span>{policy.classLabel} Selection Calendar →</span>
            </Link>
          </div>
        </div>

        {showClassNav && (
          <nav
            aria-label="2027 selection policy classes"
            className="flex flex-wrap items-center gap-2 pt-3 border-t border-[var(--sp-cool-veil)]"
          >
            <span className="text-[11px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)] mr-1">
              Class Policies:
            </span>
            {CLASS_POLICY_LINKS.map((item) => {
              const isCurrent = item.id === policy.classId;
              return (
                <Link
                  key={item.id}
                  href={item.href}
                  aria-current={isCurrent ? "page" : undefined}
                  className={`inline-flex min-h-9 items-center rounded-lg border px-3 py-1.5 text-xs font-bold transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--sp-harbour-teal)] ${
                    isCurrent
                      ? "border-[var(--sp-harbour-teal)] bg-[var(--sp-harbour-teal)] text-white"
                      : "border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] text-[var(--sp-harbour-shadow)] hover:border-[var(--sp-harbour-teal)]"
                  }`}
                >
                  {item.label}
                </Link>
              );
            })}
          </nav>
        )}
      </section>

      {/* 2027 Selection Trial Schedule */}
      <section aria-labelledby="trial-schedule-2027-heading" className="space-y-3">
        <div className="flex flex-wrap items-center justify-between gap-2">
          <h2
            id="trial-schedule-2027-heading"
            className="text-xs font-black uppercase tracking-wider text-[var(--sp-slate-soft)] flex items-center gap-1.5"
          >
            <Trophy className="h-3.5 w-3.5 text-[var(--sp-racing-orange)]" aria-hidden="true" />
            <span>2027 {policy.classLabel} Selection Trial Schedule</span>
          </h2>
          <span className="text-xs font-semibold text-[var(--sp-slate-soft)]">
            {policy.keyTrialSchedule.length} qualifying regattas
          </span>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3">
          {policy.keyTrialSchedule.map((item, idx) => (
            <div
              key={item.selectionEventId || `${item.name}-${idx}`}
              className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-4 shadow-xs flex flex-col justify-between gap-2.5"
            >
              <div className="space-y-1.5">
                <div className="flex items-start justify-between gap-2">
                  <span className="inline-flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-[var(--sp-aqua-mist)] text-[11px] font-black text-[var(--sp-harbour-shadow)]">
                    {idx + 1}
                  </span>
                  <span
                    className={`inline-flex items-center gap-1 rounded-full border px-2 py-0.5 text-[11px] font-bold ${
                      item.datesConfirmed
                        ? "bg-emerald-50 border-emerald-300 text-emerald-800"
                        : "bg-amber-50 border-amber-300 text-amber-900"
                    }`}
                  >
                    {item.datesConfirmed ? (
                      <CheckCircle2 className="h-3 w-3" aria-hidden="true" />
                    ) : (
                      <Clock className="h-3 w-3" aria-hidden="true" />
                    )}
                    <span>{item.datesConfirmed ? "Confirmed" : "Month / TBC"}</span>
                  </span>
                </div>

                {item.calendarSlug ? (
                  <Link
                    href={`/regattas/${item.calendarSlug}`}
                    className="block text-sm font-black text-[var(--sp-harbour-shadow)] hover:text-[var(--sp-harbour-teal)] hover:underline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--sp-harbour-teal)]"
                  >
                    {item.name}
                  </Link>
                ) : (
                  <p className="text-sm font-black text-[var(--sp-harbour-shadow)]">
                    {item.name}
                  </p>
                )}

                <p className="text-xs text-[var(--sp-slate-soft)] flex items-center gap-1.5">
                  <Calendar className="h-3 w-3 shrink-0 text-[var(--sp-harbour-teal)]" aria-hidden="true" />
                  <span>{item.dates}</span>
                </p>
                <p className="text-xs text-[var(--sp-slate-soft)] flex items-center gap-1.5">
                  <MapPin className="h-3 w-3 shrink-0 text-[var(--sp-slate-soft)]" aria-hidden="true" />
                  <span>{item.venue}</span>
                </p>
              </div>

              <div className="pt-2 border-t border-[var(--sp-cool-veil)]">
                <p className="text-[11px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)] mb-1">
                  Feeds Campaigns
                </p>
                <p className="text-xs text-[var(--sp-charcoal)] leading-snug">
                  {item.feedsCampaigns.join(" · ")}
                </p>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* Campaign Breakdown Cards */}
      <section aria-labelledby="campaigns-2027-heading" className="space-y-4">
        <div className="flex flex-wrap items-center justify-between gap-2">
          <h2
            id="campaigns-2027-heading"
            className="text-xs font-black uppercase tracking-wider text-[var(--sp-slate-soft)]"
          >
            2027 Campaigns &amp; Selection Criteria ({policy.campaigns.length})
          </h2>
        </div>
        <div className="space-y-4">
          {policy.campaigns.map((campaign) => (
            <CampaignCard key={campaign.id} campaign={campaign} />
          ))}
        </div>
      </section>
    </div>
  );
}
