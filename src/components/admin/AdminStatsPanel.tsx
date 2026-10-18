"use client";

import Link from "next/link";
import { useQuery } from "@tanstack/react-query";
import { RefreshCw } from "lucide-react";
import type { AdminStatsPayload } from "@/lib/adminStats";
import { adminQueryKeys } from "./adminQueryKeys";
import { adminJson } from "./adminFetch";

const number = (value: number | null | undefined) =>
  value == null ? "—" : value.toLocaleString();
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
          <section aria-labelledby="adoption-heading">
            <h2
              id="adoption-heading"
              className="mb-3 text-base font-bold text-slate-900"
            >
              Profile adoption
            </h2>
            <div className="grid gap-3 sm:grid-cols-2">
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
            </div>
            <Link
              href="/admin?area=sailors&view=directory"
              className="mt-2 inline-flex min-h-11 items-center text-sm font-semibold text-harbour"
            >
              Open sailor directory →
            </Link>
          </section>
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
