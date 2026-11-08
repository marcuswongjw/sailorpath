"use client";

import Link from "next/link";
import { useQuery } from "@tanstack/react-query";
import { RefreshCw } from "lucide-react";
import type { AdminStatsPayload } from "@/lib/adminStats";
import { adminQueryKeys } from "./adminQueryKeys";
import { adminJson } from "./adminFetch";

const number = (value: number | null | undefined) =>
  value == null ? "—" : value.toLocaleString();
const pctFormat = (numVal: number, denVal: number) =>
  denVal <= 0 ? "0%" : `${Math.round((numVal / denVal) * 1000) / 10}%`;

function Metric({
  label,
  value,
  hint,
}: {
  label: string;
  value: string;
  hint: string;
}) {
  return (
    <div className="rounded-xl border border-slate-200 bg-white p-4">
      <h3 className="text-sm font-semibold text-slate-600">{label}</h3>
      <p className="my-2 text-2xl font-bold tabular-nums text-slate-900">
        {value}
      </p>
      <p className="text-xs text-slate-600">{hint}</p>
    </div>
  );
}

export function AdminStatsPanel({ isSuperadmin }: { isSuperadmin: boolean }) {
  const query = useQuery({
    queryKey: adminQueryKeys.stats(),
    queryFn: ({ signal }) =>
      adminJson<AdminStatsPayload>("/api/admin/stats", { signal }),
    enabled: isSuperadmin,
    retry: false,
  });
  const stats = query.data;
  if (!isSuperadmin)
    return (
      <p className="text-sm text-slate-700">Superadmin access is required.</p>
    );

  const tb = stats?.trafficBreakdown;
  const fa = stats?.featureAdoption;
  const demo = stats?.demographics;
  const totalDeviceSessions = tb
    ? tb.devices7d.mobile + tb.devices7d.desktop + tb.devices7d.unknown
    : 0;

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <p className="text-sm text-slate-600">
            Usage, adoption and the work behind the numbers.
          </p>
          {stats ? (
            <p className="mt-1 text-xs text-slate-500">
              As of {new Date(stats.generatedAt).toLocaleString()} ·{" "}
              <Link href="/admin/metrics" className="underline">
                Metric definitions
              </Link>
            </p>
          ) : null}
        </div>
        <button
          type="button"
          disabled={query.isFetching}
          onClick={() => void query.refetch()}
          className="inline-flex min-h-11 items-center gap-2 rounded-lg border border-slate-300 bg-white px-3 text-sm font-semibold text-slate-800 disabled:opacity-50"
        >
          <RefreshCw
            className={`h-4 w-4 ${query.isFetching ? "animate-spin" : ""}`}
            aria-hidden="true"
          />
          Refresh insights
        </button>
      </div>
      {query.isPending ? (
        <p role="status" className="py-8 text-sm text-slate-600">
          Loading insights…
        </p>
      ) : null}
      {query.isError ? (
        <p
          role="alert"
          className="rounded-lg bg-amber-50 p-4 text-sm text-amber-900"
        >
          {stats
            ? "Refresh failed. Displayed metrics are from the last successful check."
            : "Insights could not load. This does not mean activity is zero."}{" "}
          Use Refresh insights to try again.
        </p>
      ) : null}
      {stats ? (
        <>
          {!stats.usageEventsOk ? (
            <p
              role="status"
              className="rounded-lg bg-amber-50 p-3 text-sm text-amber-900"
            >
              Usage tracking is unavailable. Traffic values are shown as
              unavailable, not zero.
            </p>
          ) : null}
          <section aria-labelledby="usage-heading">
            <h2
              id="usage-heading"
              className="mb-3 text-base font-bold text-slate-900"
            >
              Recorded usage · last 7 days
            </h2>
            <div className="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
              <Metric
                label="Recorded sessions"
                value={number(
                  stats.usageEventsOk
                    ? stats.northStars.weeklyActiveSessions
                    : null,
                )}
                hint="Distinct session IDs; not unique people or signed-in users"
              />
              <Metric
                label="Profile views"
                value={number(
                  stats.usageEventsOk ? stats.traffic7d.profileViews : null,
                )}
                hint="Recorded profile-view events"
              />
              <Metric
                label="Ranking views"
                value={number(
                  stats.usageEventsOk ? stats.traffic7d.rankingViews : null,
                )}
                hint="Recorded ranking-view events"
              />
              <Metric
                label="Searches"
                value={number(
                  stats.usageEventsOk ? stats.traffic7d.searches : null,
                )}
                hint="Recorded search events"
              />
            </div>
          </section>

          {stats.usageEventsOk && tb ? (
            <section
              aria-labelledby="traffic-breakdown-heading"
              className="space-y-4"
            >
              <h2
                id="traffic-breakdown-heading"
                className="text-base font-bold text-slate-900"
              >
                Traffic & engagement breakdown
              </h2>
              <div className="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
                <Metric
                  label="30-day active sessions"
                  value={number(tb.sessions30d)}
                  hint={`${number(stats.northStars.weeklyActiveSessions)} in the last 7 days · ${number(tb.pageViews30d)} page views (30d)`}
                />
                <Metric
                  label="Returning visitors · 7 days"
                  value={`${number(tb.returningVisitors7d)} / ${number(tb.uniqueVisitors7d)}`}
                  hint={`${pctFormat(tb.returningVisitors7d, tb.uniqueVisitors7d)} visited on 2+ calendar days`}
                />
                <Metric
                  label="Own vs fleet profile views · 7 days"
                  value={`${number(tb.ownProfileViews7d)} / ${number(tb.otherProfileViews7d)}`}
                  hint="Owners checking their own profile vs browsing other sailors"
                />
                <Metric
                  label="Standings → profile funnel · 30 days"
                  value={`${number(tb.rankingToProfileSessions30d)} / ${number(tb.rankingSessions30d)}`}
                  hint={`${pctFormat(tb.rankingToProfileSessions30d, tb.rankingSessions30d)} of ranking sessions also viewed a sailor profile`}
                />
              </div>

              <div className="grid gap-3 lg:grid-cols-2">
                <div className="rounded-xl border border-slate-200 bg-white p-4">
                  <h3 className="text-sm font-semibold text-slate-900">
                    Device & conversion signals
                  </h3>
                  <p className="mt-1 text-xs text-slate-500">
                    Session device split (7d) and sample-to-claim conversion (30d).
                  </p>
                  <div className="mt-3 space-y-3 text-xs text-slate-700">
                    <div>
                      <div className="flex items-center justify-between font-medium">
                        <span>
                          Mobile: {number(tb.devices7d.mobile)} (
                          {pctFormat(tb.devices7d.mobile, totalDeviceSessions)})
                        </span>
                        <span>
                          Desktop: {number(tb.devices7d.desktop)} (
                          {pctFormat(tb.devices7d.desktop, totalDeviceSessions)})
                        </span>
                      </div>
                      <div className="mt-1.5 flex h-2.5 w-full overflow-hidden rounded-full bg-slate-100">
                        <div
                          className="bg-sky-600"
                          style={{
                            width:
                              totalDeviceSessions > 0
                                ? `${(tb.devices7d.mobile / totalDeviceSessions) * 100}%`
                                : "0%",
                          }}
                        />
                        <div
                          className="bg-indigo-500"
                          style={{
                            width:
                              totalDeviceSessions > 0
                                ? `${(tb.devices7d.desktop / totalDeviceSessions) * 100}%`
                                : "0%",
                          }}
                        />
                      </div>
                    </div>
                    <div className="grid grid-cols-2 gap-2 pt-1 sm:grid-cols-3">
                      <div className="rounded-lg bg-slate-50 p-2.5">
                        <p className="text-[11px] text-slate-500">
                          30d ranking views
                        </p>
                        <p className="mt-0.5 text-sm font-bold tabular-nums text-slate-900">
                          {number(tb.rankingViews30d)}
                        </p>
                      </div>
                      <div className="rounded-lg bg-slate-50 p-2.5">
                        <p className="text-[11px] text-slate-500">
                          30d profile views
                        </p>
                        <p className="mt-0.5 text-sm font-bold tabular-nums text-slate-900">
                          {number(tb.profileViews30d)}
                        </p>
                      </div>
                      <div className="rounded-lg bg-slate-50 p-2.5 col-span-2 sm:col-span-1">
                        <p className="text-[11px] text-slate-500">
                          Demo → claim (30d)
                        </p>
                        <p className="mt-0.5 text-sm font-bold tabular-nums text-slate-900">
                          {number(tb.demoToClaimSessions30d)} /{" "}
                          {number(tb.demoSessions30d)}
                        </p>
                      </div>
                    </div>
                  </div>
                </div>

                <div className="rounded-xl border border-slate-200 bg-white p-4">
                  <h3 className="text-sm font-semibold text-slate-900">
                    Top acquisition sources · 7 days
                  </h3>
                  <p className="mt-1 text-xs text-slate-500">
                    First-touch session source (UTM, referrer host or direct).
                  </p>
                  {tb.topSources7d.length ? (
                    <div className="mt-3 flex flex-wrap gap-2">
                      {tb.topSources7d.map((item) => (
                        <span
                          key={item.source}
                          className="inline-flex items-center gap-1.5 rounded-full bg-slate-100 px-3 py-1 text-xs font-medium text-slate-800"
                        >
                          <span className="font-bold capitalize">
                            {item.source}:
                          </span>
                          <span className="tabular-nums">
                            {item.sessions.toLocaleString()} sessions
                          </span>
                          <span className="text-slate-500">
                            ({item.events.toLocaleString()} events)
                          </span>
                        </span>
                      ))}
                    </div>
                  ) : (
                    <p className="mt-3 text-xs text-slate-500">
                      No source data recorded in the last 7 days.
                    </p>
                  )}
                </div>
              </div>

              {tb.topPaths7d.length ? (
                <div className="rounded-xl border border-slate-200 bg-white p-4">
                  <h3 className="text-sm font-semibold text-slate-900">
                    Most viewed pages & hubs · 7 days
                  </h3>
                  <p className="mt-1 text-xs text-slate-500">
                    Top paths across page, ranking, and profile view events.
                  </p>
                  <div className="mt-3 overflow-x-auto">
                    <table className="w-full text-left text-sm text-slate-800">
                      <thead>
                        <tr className="border-b border-slate-200 text-xs font-semibold text-slate-500">
                          <th className="py-2 pr-4">Path</th>
                          <th className="py-2 px-4 text-right">Views</th>
                          <th className="py-2 pl-4 text-right">Sessions</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-slate-100">
                        {tb.topPaths7d.map((row) => (
                          <tr key={row.path} className="hover:bg-slate-50/50">
                            <td className="py-2 pr-4 font-mono text-xs font-semibold text-slate-900">
                              {row.path}
                            </td>
                            <td className="py-2 px-4 text-right tabular-nums font-medium text-slate-900">
                              {row.views.toLocaleString()}
                            </td>
                            <td className="py-2 pl-4 text-right tabular-nums text-slate-600">
                              {row.sessions.toLocaleString()}
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              ) : null}
            </section>
          ) : null}

          <section aria-labelledby="demographics-heading" className="space-y-4">
            <h2
              id="demographics-heading"
              className="text-base font-bold text-slate-900"
            >
              Platform Scale & Demographics
            </h2>
            <div className="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
              <Metric
                label="Unique sailors"
                value={number(
                  demo?.sailorsTotal ?? stats.dataTrust.sailorsTotal,
                )}
                hint={`${number(demo?.sailorsWithResults)} with scored regatta results`}
              />
              <Metric
                label="Nationalities represented"
                value={number(demo?.nationalitiesCount)}
                hint="Countries across Asia, Europe and Oceania"
              />
              <Metric
                label="Classes with results"
                value={number(demo?.classesCount)}
                hint={`${number(demo?.multiClassSailors ?? 0)} multi-class sailors across 2+ classes`}
              />
              <Metric
                label="Recorded results"
                value={number(demo?.resultsTotal)}
                hint="Individual scored race entries"
              />
            </div>

            {demo?.genderBreakdown || demo?.birthYearCohorts?.length ? (
              <div className="grid gap-3 lg:grid-cols-2">
                {demo?.genderBreakdown ? (
                  <div className="rounded-xl border border-slate-200 bg-white p-4">
                    <h3 className="text-sm font-semibold text-slate-900">
                      Athlete Gender & Fleet Split
                    </h3>
                    <p className="mt-1 text-xs text-slate-500">
                      Recorded gender across sailor profiles and active SG Series division split.
                    </p>
                    <div className="mt-3 grid grid-cols-3 gap-2 text-center">
                      <div className="rounded-lg bg-slate-50 p-2.5">
                        <p className="text-xs font-medium text-slate-500">
                          Male
                        </p>
                        <p className="mt-1 text-lg font-bold tabular-nums text-slate-900">
                          {number(demo.genderBreakdown.male)}
                        </p>
                        <p className="text-[11px] text-slate-500">
                          {pctFormat(
                            demo.genderBreakdown.male,
                            demo.sailorsTotal,
                          )}
                        </p>
                      </div>
                      <div className="rounded-lg bg-slate-50 p-2.5">
                        <p className="text-xs font-medium text-slate-500">
                          Female
                        </p>
                        <p className="mt-1 text-lg font-bold tabular-nums text-slate-900">
                          {number(demo.genderBreakdown.female)}
                        </p>
                        <p className="text-[11px] text-slate-500">
                          {pctFormat(
                            demo.genderBreakdown.female,
                            demo.sailorsTotal,
                          )}
                        </p>
                      </div>
                      <div className="rounded-lg bg-slate-50 p-2.5">
                        <p className="text-xs font-medium text-slate-500">
                          Unspecified
                        </p>
                        <p className="mt-1 text-lg font-bold tabular-nums text-slate-900">
                          {number(demo.genderBreakdown.unspecified)}
                        </p>
                        <p className="text-[11px] text-slate-500">
                          {pctFormat(
                            demo.genderBreakdown.unspecified,
                            demo.sailorsTotal,
                          )}
                        </p>
                      </div>
                    </div>
                    {demo.activeSeriesGold != null &&
                    demo.activeSeriesSilver != null ? (
                      <div className="mt-3 flex flex-wrap items-center justify-between gap-2 border-t border-slate-100 pt-3 text-xs text-slate-600">
                        <span>Active SG Series roster breakdown:</span>
                        <span className="font-semibold text-slate-900">
                          Gold: {number(demo.activeSeriesGold)} · Silver:{" "}
                          {number(demo.activeSeriesSilver)}
                        </span>
                      </div>
                    ) : null}
                  </div>
                ) : null}

                {demo?.birthYearCohorts?.length ? (
                  <div className="rounded-xl border border-slate-200 bg-white p-4">
                    <h3 className="text-sm font-semibold text-slate-900">
                      Birth Year & Age Cohorts
                    </h3>
                    <p className="mt-1 text-xs text-slate-500">
                      Age bracket distribution based on recorded dates of birth.
                    </p>
                    <div className="mt-3 space-y-2">
                      {demo.birthYearCohorts.map((item) => (
                        <div key={item.cohort} className="text-xs">
                          <div className="flex items-center justify-between text-slate-700">
                            <span className="font-medium">{item.cohort}</span>
                            <span className="tabular-nums font-semibold text-slate-900">
                              {item.count.toLocaleString()} (
                              {pctFormat(item.count, demo.sailorsTotal)})
                            </span>
                          </div>
                          <div className="mt-1 h-1.5 w-full overflow-hidden rounded-full bg-slate-100">
                            <div
                              className="h-full bg-sky-600"
                              style={{
                                width:
                                  demo.sailorsTotal > 0
                                    ? `${Math.max(2, (item.count / demo.sailorsTotal) * 100)}%`
                                    : "0%",
                              }}
                            />
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                ) : null}
              </div>
            ) : null}

            {/* Top Nationalities & Top Clubs Badges */}
            {demo?.topNationalities?.length || demo?.topClubs?.length ? (
              <div className="grid gap-3 lg:grid-cols-2">
                {demo?.topNationalities?.length ? (
                  <div className="rounded-xl border border-slate-200 bg-white p-4">
                    <h3 className="text-sm font-semibold text-slate-900">
                      Top Sailor Nationalities
                    </h3>
                    <div className="mt-3 flex flex-wrap gap-2">
                      {demo.topNationalities.map((item) => (
                        <span
                          key={item.country}
                          className="inline-flex items-center gap-1.5 rounded-full bg-slate-100 px-3 py-1 text-xs font-medium text-slate-800"
                        >
                          <span className="font-bold">{item.country}:</span>
                          <span>{item.count.toLocaleString()}</span>
                        </span>
                      ))}
                    </div>
                  </div>
                ) : null}

                {demo?.topClubs?.length ? (
                  <div className="rounded-xl border border-slate-200 bg-white p-4">
                    <h3 className="text-sm font-semibold text-slate-900">
                      Top Sailing Clubs & Training Bases
                    </h3>
                    <div className="mt-3 flex flex-wrap gap-2">
                      {demo.topClubs.map((item) => (
                        <span
                          key={item.club}
                          className="inline-flex items-center gap-1.5 rounded-full bg-slate-100 px-3 py-1 text-xs font-medium text-slate-800"
                        >
                          <span className="font-bold">{item.club}:</span>
                          <span>{item.count.toLocaleString()}</span>
                        </span>
                      ))}
                    </div>
                  </div>
                ) : null}
              </div>
            ) : null}

            {/* Classes with Results Table */}
            {demo?.boatClasses?.length ? (
              <div className="rounded-xl border border-slate-200 bg-white p-4">
                <h3 className="text-sm font-semibold text-slate-900">
                  Boat & Board Classes with Results
                </h3>
                <p className="mt-1 text-xs text-slate-500">
                  Distribution of regattas, total race finishes, and participating sailors per class.
                </p>
                <div className="mt-3 overflow-x-auto">
                  <table className="w-full text-left text-sm text-slate-800">
                    <thead>
                      <tr className="border-b border-slate-200 text-xs font-semibold text-slate-500">
                        <th className="py-2 pr-4">Class</th>
                        <th className="py-2 px-4 text-right">Regattas</th>
                        <th className="py-2 px-4 text-right">Results</th>
                        <th className="py-2 px-4 text-right">Sailors</th>
                        <th className="py-2 pl-4 text-right">Share</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-slate-100">
                      {demo.boatClasses.map((cls) => (
                        <tr key={cls.className} className="hover:bg-slate-50/50">
                          <td className="py-2.5 pr-4 font-semibold text-slate-900">
                            {cls.className}
                          </td>
                          <td className="py-2.5 px-4 text-right tabular-nums text-slate-600">
                            {cls.regattaCount.toLocaleString()}
                          </td>
                          <td className="py-2.5 px-4 text-right tabular-nums font-medium text-slate-900">
                            {cls.resultCount.toLocaleString()}
                          </td>
                          <td className="py-2.5 px-4 text-right tabular-nums text-slate-600">
                            {cls.sailorCount.toLocaleString()}
                          </td>
                          <td className="py-2.5 pl-4 text-right tabular-nums text-xs text-slate-500">
                            {pctFormat(cls.resultCount, demo.resultsTotal)}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            ) : null}
          </section>

          <section aria-labelledby="adoption-heading" className="space-y-4">
            <h2
              id="adoption-heading"
              className="text-base font-bold text-slate-900"
            >
              Profile adoption
            </h2>
            <div className="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
              <Metric
                label="Claimed active series roster"
                value={`${number(stats.northStars.claimedSeriesSailors)} / ${number(stats.northStars.seriesSailors)}`}
                hint={`${stats.northStars.rosterClaimedPct == null ? "Percentage unavailable" : `${stats.northStars.rosterClaimedPct}% linked to a parent`}. Uses the active series roster, excluding guests.`}
              />
              <Metric
                label="Claimed sailor profiles"
                value={number(stats.northStars.claimedSailors)}
                hint="All profiles with a linked parent, including those outside the active series roster"
              />
              {fa ? (
                <>
                  <Metric
                    label="Claim approval rate"
                    value={
                      fa.claims.approvalRatePct == null
                        ? "—"
                        : `${fa.claims.approvalRatePct}%`
                    }
                    hint={`${number(fa.claims.approved)} approved · ${number(fa.claims.pending)} pending · ${number(fa.claims.rejected)} rejected`}
                  />
                  <Metric
                    label="Claimed by owner role"
                    value={`${number(fa.claims.byRelation.parent)}P / ${number(fa.claims.byRelation.sailor)}S`}
                    hint={`Parent: ${number(fa.claims.byRelation.parent)} · Sailor: ${number(fa.claims.byRelation.sailor)} · Other: ${number(fa.claims.byRelation.other)}`}
                  />
                </>
              ) : null}
            </div>
            {fa ? (
              <div className="rounded-xl border border-slate-200 bg-white p-4">
                <h3 className="text-sm font-semibold text-slate-900">
                  Public profile enrichment opt-ins
                </h3>
                <p className="mt-1 text-xs text-slate-500">
                  Claimed sailors who enabled optional public profile sections.
                </p>
                <div className="mt-3 flex flex-wrap gap-2 text-xs">
                  {[
                    ["Profile photo", fa.publicProfileOptIns.photo],
                    ["Equipment setup", fa.publicProfileOptIns.equipment],
                    ["School", fa.publicProfileOptIns.school],
                    ["Sailing milestones", fa.publicProfileOptIns.milestones],
                    ["Social links", fa.publicProfileOptIns.social],
                  ].map(([label, count]) => (
                    <span
                      key={String(label)}
                      className="inline-flex items-center gap-1.5 rounded-full bg-slate-100 px-3 py-1 font-medium text-slate-800"
                    >
                      <span className="font-bold">{label}:</span>
                      <span className="tabular-nums">
                        {Number(count).toLocaleString()}
                      </span>
                    </span>
                  ))}
                </div>
              </div>
            ) : null}
            <Link
              href="/admin?area=sailors&view=directory"
              className="inline-flex min-h-11 items-center text-sm font-semibold text-harbour"
            >
              Open sailor directory →
            </Link>
          </section>

          {fa ? (
            <section
              aria-labelledby="feature-adoption-heading"
              className="space-y-4"
            >
              <h2
                id="feature-adoption-heading"
                className="text-base font-bold text-slate-900"
              >
                Feature & community adoption
              </h2>
              <div className="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
                <div className="rounded-xl border border-slate-200 bg-white p-4">
                  <h3 className="text-sm font-semibold text-slate-900">
                    Community & following
                  </h3>
                  <p className="mt-1 text-xs text-slate-500">
                    Sailor watchlists and result-notification followers.
                  </p>
                  <dl className="mt-3 space-y-2 text-xs">
                    <div className="flex items-center justify-between">
                      <dt className="text-slate-600">Followed sailor links</dt>
                      <dd className="font-bold tabular-nums text-slate-900">
                        {number(fa.community.followedSailorLinks)}
                      </dd>
                    </div>
                    <div className="flex items-center justify-between">
                      <dt className="text-slate-600">
                        Unique sailors followed
                      </dt>
                      <dd className="font-bold tabular-nums text-slate-900">
                        {number(fa.community.uniqueSailorsFollowed)}
                      </dd>
                    </div>
                    <div className="flex items-center justify-between">
                      <dt className="text-slate-600">
                        Active follower accounts
                      </dt>
                      <dd className="font-bold tabular-nums text-slate-900">
                        {number(fa.community.activeFollowers)}
                      </dd>
                    </div>
                  </dl>
                </div>

                <div className="rounded-xl border border-slate-200 bg-white p-4">
                  <h3 className="text-sm font-semibold text-slate-900">
                    Coach workspace adoption
                  </h3>
                  <p className="mt-1 text-xs text-slate-500">
                    Squad management, watchlists, and structured athlete logs.
                  </p>
                  <dl className="mt-3 space-y-2 text-xs">
                    <div className="flex items-center justify-between">
                      <dt className="text-slate-600">
                        Coach accounts & squads
                      </dt>
                      <dd className="font-bold tabular-nums text-slate-900">
                        {number(fa.coaching.coachAccounts)} coaches ·{" "}
                        {number(fa.coaching.coachSquads)} squads
                      </dd>
                    </div>
                    <div className="flex items-center justify-between">
                      <dt className="text-slate-600">
                        Squad sailors & watchlist
                      </dt>
                      <dd className="font-bold tabular-nums text-slate-900">
                        {number(fa.coaching.squadSailors)} in squads ·{" "}
                        {number(fa.coaching.watchlistEntries)} watched
                      </dd>
                    </div>
                    <div className="flex items-center justify-between">
                      <dt className="text-slate-600">
                        Development logs & notes
                      </dt>
                      <dd className="font-bold tabular-nums text-slate-900">
                        {number(fa.coaching.developmentRecords)} logs (
                        {number(fa.coaching.sharedRecords)} shared) ·{" "}
                        {number(fa.coaching.coachNotes)} notes
                      </dd>
                    </div>
                  </dl>
                </div>

                <div className="rounded-xl border border-slate-200 bg-white p-4 sm:col-span-2 xl:col-span-1">
                  <h3 className="text-sm font-semibold text-slate-900">
                    Logbook & gear inventory
                  </h3>
                  <p className="mt-1 text-xs text-slate-500">
                    Race observations, parent notes, and equipment tracking.
                  </p>
                  <dl className="mt-3 space-y-2 text-xs">
                    <div className="flex items-center justify-between">
                      <dt className="text-slate-600">Race observations</dt>
                      <dd className="font-bold tabular-nums text-slate-900">
                        {number(fa.logbookAndGear.raceObservations)} (
                        {number(fa.logbookAndGear.sailorsWithRaceNotes)}{" "}
                        sailors)
                      </dd>
                    </div>
                    <div className="flex items-center justify-between">
                      <dt className="text-slate-600">Equipment inventory</dt>
                      <dd className="font-bold tabular-nums text-slate-900">
                        {number(fa.logbookAndGear.equipmentItems)} items (
                        {number(fa.logbookAndGear.sailorsWithEquipment)}{" "}
                        sailors)
                      </dd>
                    </div>
                    <div className="flex items-center justify-between">
                      <dt className="text-slate-600">
                        Gear sessions & parent notes
                      </dt>
                      <dd className="font-bold tabular-nums text-slate-900">
                        {number(fa.logbookAndGear.equipmentSessionsTotal)}{" "}
                        sessions ({number(fa.logbookAndGear.equipmentSessions30d)}{" "}
                        30d) · {number(fa.logbookAndGear.parentNotes)} notes
                      </dd>
                    </div>
                  </dl>
                </div>
              </div>
            </section>
          ) : null}
          <section
            className="rounded-xl border border-slate-200 bg-white p-4"
            aria-labelledby="insights-actions-heading"
          >
            <h2
              id="insights-actions-heading"
              className="font-bold text-slate-900"
            >
              Turn an insight into action
            </h2>
            <div className="mt-2 divide-y divide-slate-100">
              {[
                [
                  "/admin?area=events&view=missing-results",
                  "Results coverage",
                  "Find completed class sheets without results.",
                ],
                [
                  "/admin?area=events&view=attention",
                  "Publication blockers",
                  "Review missing metadata and official source requirements.",
                ],
                [
                  "/admin?area=inbox&view=claims",
                  "Requests awaiting a decision",
                  "Review claims, coach access, suggestions and support in Inbox.",
                ],
                [
                  "/admin?area=settings&view=audit",
                  "Changes and imports",
                  "Inspect the recorded change history and affected records.",
                ],
              ].map(([href, label, hint]) => (
                <Link
                  key={href}
                  href={href}
                  className="flex min-h-16 items-center justify-between gap-3 py-3"
                >
                  <span>
                    <span className="block text-sm font-semibold text-slate-900">
                      {label}
                    </span>
                    <span className="mt-1 block text-xs text-slate-600">
                      {hint}
                    </span>
                  </span>
                  <span className="text-harbour" aria-hidden="true">
                    →
                  </span>
                </Link>
              ))}
            </div>
            <p className="mt-2 text-xs text-slate-500">
              Coverage checks do not certify score accuracy. Turnaround trends
              require complete request history.
            </p>
          </section>
          <details className="rounded-xl border border-slate-200 bg-white p-4">
            <summary className="min-h-11 text-sm font-semibold text-slate-800">
              Diagnostics & account activity
            </summary>
            <p className="my-3 text-xs text-slate-600">
              Technical observations, not daily priorities. Sign-ins, recorded
              sessions and usage are different measures.
            </p>
            <dl className="grid gap-3 text-sm sm:grid-cols-2">
              <div>
                <dt className="font-semibold">Last tracked UI import</dt>
                <dd>
                  {stats.usageEventsOk
                    ? stats.ops.lastImportAt
                      ? new Date(stats.ops.lastImportAt).toLocaleString()
                      : "No tracked UI import"
                    : "Unavailable"}
                </dd>
                <dd className="text-xs text-slate-500">
                  May omit scripted imports and other paths; not a complete
                  import ledger.
                </dd>
              </div>
              <div>
                <dt className="font-semibold">Sailor records</dt>
                <dd>{number(stats.dataTrust.sailorsTotal)}</dd>
              </div>
              <div>
                <dt className="font-semibold">
                  Records without a full birth date
                </dt>
                <dd>{number(stats.dataTrust.missingDob)}</dd>
                <dd className="text-xs text-slate-500">
                  Not necessarily an error. Verify birth year only where age
                  rules require it.
                </dd>
              </div>
              <div>
                <dt className="font-semibold">
                  Missing or placeholder sail numbers
                </dt>
                <dd>{number(stats.dataTrust.missingOrPlaceholderSail)}</dd>
                <dd className="text-xs text-slate-500">
                  Charter sail numbers do not establish identity.
                </dd>
              </div>
              <div>
                <dt className="font-semibold">Registered accounts</dt>
                <dd>
                  {number(
                    stats.authAccountsOk ? stats.accounts.registered : null,
                  )}
                </dd>
              </div>
              <div>
                <dt className="font-semibold">Accounts signing in · 7 days</dt>
                <dd>
                  {number(
                    stats.authAccountsOk ? stats.accounts.signedInLast7d : null,
                  )}
                </dd>
                <dd className="text-xs text-slate-500">
                  Recent session refreshes do not count as a new sign-in.
                </dd>
              </div>
              <div>
                <dt className="font-semibold">Valid auth-session records</dt>
                <dd>
                  {number(
                    stats.authAccountsOk ? stats.accounts.authSessions : null,
                  )}
                </dd>
                <dd className="text-xs text-slate-500">
                  Does not indicate who is online.
                </dd>
              </div>
            </dl>
            {stats.authAccountsOk ? (
              <div className="mt-4 overflow-x-auto">
                <table className="w-full text-left text-sm">
                  <caption className="mb-2 text-left font-semibold">
                    Recent account sign-ins
                  </caption>
                  <thead>
                    <tr className="border-b border-slate-200 text-slate-600">
                      <th className="p-2">Account</th>
                      <th className="p-2">Role</th>
                      <th className="p-2">Last sign-in</th>
                      <th className="p-2">Session refresh</th>
                    </tr>
                  </thead>
                  <tbody>
                    {stats.accounts.recent.map((account) => (
                      <tr
                        key={account.id}
                        className="border-b border-slate-100"
                      >
                        <td className="break-all p-2">
                          {account.fullName ||
                            account.email ||
                            "Unnamed account"}
                        </td>
                        <td className="p-2">{account.role}</td>
                        <td className="p-2">
                          {account.lastSignInAt
                            ? new Date(account.lastSignInAt).toLocaleString()
                            : "Never"}
                        </td>
                        <td className="p-2">
                          {account.lastSessionRefreshAt
                            ? new Date(
                                account.lastSessionRefreshAt,
                              ).toLocaleString()
                            : "—"}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            ) : (
              <p className="mt-3 text-sm text-amber-800">
                Account activity is unavailable.
              </p>
            )}
          </details>
        </>
      ) : null}
    </div>
  );
}
