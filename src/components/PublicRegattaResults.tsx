import Link from "next/link";
import { birthYear } from "@/lib/age";
import { formatGenderLabel } from "@/lib/gender";
import { getPercentileBadge } from "@/lib/ranking";
import type { getResultsForRegatta } from "@/lib/queries";
import type { OfficialRaceResultInput } from "@/types/raceResult";

type PublicRegattaResult = Awaited<
  ReturnType<typeof getResultsForRegatta>
>[number];

type Props = {
  results: PublicRegattaResult[];
  totalFleetSize: number;
  raceCount?: number | null;
  accent: "orange" | "sky";
};

const accentClasses = {
  orange: {
    rank: "text-orange-400",
    link: "hover:text-orange-400",
  },
  sky: {
    rank: "text-sky-400",
    link: "hover:text-sky-300",
  },
} as const;

function raceValue(race: OfficialRaceResultInput | undefined) {
  if (!race) return "—";
  return race.rawValue || String(race.score);
}

function raceValueClass(race: OfficialRaceResultInput | undefined) {
  if (!race) return "text-slate-700";
  if (race.discarded) return "text-slate-500";
  if (race.scoringCode) return "text-amber-300";
  return "text-slate-200";
}

function MobileRaceScores({ races }: { races: OfficialRaceResultInput[] }) {
  if (races.length === 0) return null;
  return (
    <details className="group rounded-xl border border-white/5 bg-black/15">
      <summary className="cursor-pointer list-none px-3 py-2 text-[11px] font-semibold text-emerald-300 marker:content-none">
        <span className="inline-flex items-center gap-1.5">
          <span aria-hidden className="transition-transform group-open:rotate-90">›</span>
          {races.length} published race score{races.length === 1 ? "" : "s"}
        </span>
      </summary>
      <div className="grid grid-cols-3 gap-1.5 border-t border-white/5 p-2.5">
        {races.map((race) => (
          <div key={race.raceNumber} className="rounded-lg bg-black/25 px-2 py-1.5 text-center">
            <p className="text-[9px] font-semibold uppercase text-slate-600">R{race.raceNumber}</p>
            <p className={`text-xs font-bold tabular-nums ${raceValueClass(race)}`}>
              {raceValue(race)}
            </p>
          </div>
        ))}
      </div>
    </details>
  );
}

export function PublicRegattaResults({
  results,
  totalFleetSize,
  raceCount,
  accent,
}: Props) {
  const colors = accentClasses[accent];
  const importedRaceCount = results.reduce(
    (max, result) =>
      Math.max(max, ...result.raceResults.map((race) => race.raceNumber), 0),
    0
  );
  const visibleRaceCount = Math.max(Number(raceCount) || 0, importedRaceCount);
  const raceNumbers = Array.from({ length: visibleRaceCount }, (_, index) => index + 1);

  return (
    <>
      <div className="sm:hidden space-y-2">
        {results.map((result) => {
          const badge = getPercentileBadge(result.rank, totalFleetSize);
          const overseas = Boolean(result.isOverseasCommitment);
          const dns = Boolean(result.isDns) && !overseas;
          const races = result.raceResults.slice().sort((a, b) => a.raceNumber - b.raceNumber);
          return (
            <article
              key={`${result.sailorId}-${result.regattaId}`}
              className="rounded-2xl border border-white/5 bg-[#131520]/80 p-3.5 space-y-2"
            >
              <div className="flex items-start justify-between gap-2">
                <div className="min-w-0 flex-1">
                  <div className="flex items-baseline gap-2">
                    <span className={`${colors.rank} shrink-0 font-black tabular-nums`}>
                      #{result.rank}{overseas ? "†" : dns ? "*" : ""}
                    </span>
                    <Link
                      href={`/${result.handle}`}
                      prefetch
                      className={`${colors.link} break-words text-[15px] font-bold leading-snug text-white`}
                    >
                      {result.sailorName}
                    </Link>
                  </div>
                  <p className="mt-1 text-[11px] text-slate-500">
                    {[
                      result.nationality,
                      formatGenderLabel(result.gender) !== "—"
                        ? formatGenderLabel(result.gender)
                        : null,
                      result.birthYear ?? birthYear(result.dob),
                    ].filter(Boolean).join(" · ") || "—"}
                  </p>
                </div>
                <span className={`shrink-0 rounded-full px-2 py-0.5 text-[10px] font-bold ${badge.className}`}>
                  {badge.label}
                </span>
              </div>

              <div className="grid grid-cols-2 gap-2 text-[12px]">
                {[
                  ["Total", result.totalScore],
                  ["Nett", result.nettScore],
                ].map(([label, value]) => (
                  <div key={String(label)} className="rounded-lg bg-black/25 px-2.5 py-2">
                    <p className="text-[10px] font-semibold uppercase text-slate-500">{label}</p>
                    <p className="font-mono font-bold tabular-nums text-white">{value ?? "—"}</p>
                  </div>
                ))}
              </div>

              <MobileRaceScores races={races} />

              {(overseas || dns) && (
                <div className="flex flex-wrap gap-1.5">
                  {overseas && (
                    <span className="rounded-full border border-sky-500/25 bg-sky-500/10 px-2 py-0.5 text-[10px] font-bold text-sky-300">
                      Overseas
                    </span>
                  )}
                  {dns && (
                    <span className="rounded-full border border-rose-500/20 bg-rose-500/10 px-2 py-0.5 text-[10px] font-bold text-rose-400">
                      DNS
                    </span>
                  )}
                </div>
              )}
            </article>
          );
        })}
      </div>

      <div className="hidden sm:block overflow-x-auto rounded-2xl border border-white/5">
        <table className="w-full min-w-[1120px] text-left text-sm">
          <thead className="bg-white/5 text-xs uppercase text-slate-400">
            <tr>
              <th className="px-3 py-3 text-center">Rank</th>
              <th className="px-3 py-3">Name</th>
              <th className="px-3 py-3 text-center">Nationality</th>
              <th className="px-3 py-3 text-center">Gender</th>
              <th className="px-3 py-3 text-center">Birth year</th>
              {raceNumbers.map((raceNumber) => (
                <th key={raceNumber} className="px-2 py-3 text-center">R{raceNumber}</th>
              ))}
              <th className="px-3 py-3 text-center">Total</th>
              <th className="px-3 py-3 text-center">Nett</th>
              <th className="px-3 py-3">Percentile</th>
            </tr>
          </thead>
          <tbody>
            {results.map((result) => {
              const badge = getPercentileBadge(result.rank, totalFleetSize);
              const overseas = Boolean(result.isOverseasCommitment);
              const dns = Boolean(result.isDns) && !overseas;
              const races = new Map(result.raceResults.map((race) => [race.raceNumber, race]));
              return (
                <tr key={`${result.sailorId}-${result.regattaId}`} className="border-t border-white/5">
                  <td className={`px-3 py-3 text-center font-mono font-bold ${colors.rank}`}>
                    {result.rank}{overseas ? "†" : dns ? "*" : ""}
                  </td>
                  <td className="px-3 py-3">
                    <Link href={`/${result.handle}`} prefetch className={`${colors.link} font-bold text-white`}>
                      {result.sailorName}
                    </Link>
                  </td>
                  <td className="px-3 py-3 text-center font-mono text-slate-300">{result.nationality || "—"}</td>
                  <td className="px-3 py-3 text-center text-slate-300">{formatGenderLabel(result.gender)}</td>
                  <td className="px-3 py-3 text-center font-mono text-slate-300">
                    {result.birthYear ?? birthYear(result.dob) ?? "—"}
                  </td>
                  {raceNumbers.map((raceNumber) => {
                    const race = races.get(raceNumber);
                    return (
                      <td
                        key={raceNumber}
                        className={`px-2 py-3 text-center font-mono text-xs font-semibold tabular-nums ${raceValueClass(race)}`}
                        title={race?.discarded ? "Discarded score" : race?.scoringCode || undefined}
                      >
                        {raceValue(race)}
                      </td>
                    );
                  })}
                  <td className="px-3 py-3 text-center font-mono text-slate-300">{result.totalScore ?? "—"}</td>
                  <td className="px-3 py-3 text-center font-mono text-slate-300">{result.nettScore ?? "—"}</td>
                  <td className="px-3 py-3">
                    <div className="flex flex-wrap items-center gap-1.5">
                      {overseas && <span className="rounded-full border border-sky-500/25 bg-sky-500/10 px-2 py-0.5 text-[10px] font-bold text-sky-300">Overseas</span>}
                      {dns && <span className="rounded-full border border-rose-500/20 bg-rose-500/10 px-2 py-0.5 text-[10px] font-bold text-rose-400">DNS</span>}
                      <span className={`rounded-full px-2 py-0.5 text-[10px] font-bold ${badge.className}`}>{badge.label}</span>
                    </div>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </>
  );
}
