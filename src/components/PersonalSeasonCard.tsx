import Link from "next/link";
import type { PersonalSeasonSlot, PersonalSeasonView } from "@/lib/personalSeason";

const MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

function formatSeasonDate(ymd: string): string {
  const [year, month, day] = String(ymd || "").slice(0, 10).split("-");
  const monthIndex = Number(month) - 1;
  const dayNumber = Number(day);
  if (!year || monthIndex < 0 || monthIndex > 11 || !dayNumber) return ymd;
  return `${dayNumber} ${MONTHS[monthIndex]} ${year}`;
}

function slotChips(slot: PersonalSeasonSlot): string[] {
  if (slot.empty) return ["Open"];
  const chips: string[] = [];
  if (slot.counting) chips.push("Counting");
  if (slot.discarded) chips.push("Dropped");
  if (slot.carryForward) chips.push("Carry-forward");
  if (slot.dns) chips.push("DNS");
  if (slot.overseas) chips.push("Overseas");
  return chips;
}

function chipClass(label: string): string {
  if (label === "Counting") {
    return "bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)] border-[var(--sp-harbour-teal)]/25";
  }
  if (label === "Dropped") {
    return "bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)] border-[var(--sp-cool-veil)]";
  }
  if (label === "DNS" || label === "Overseas") {
    return "bg-[var(--sp-racing-mist)]/60 text-[var(--sp-racing-deep)] border-[var(--sp-racing-orange)]/25";
  }
  return "bg-white text-[var(--sp-charcoal-slate)] border-[var(--sp-cool-veil)]";
}

function SlotCell({ slot }: { slot: PersonalSeasonSlot }) {
  const chips = slotChips(slot);
  return (
    <div
      className={`rounded-xl border p-2.5 min-h-[92px] ${
        slot.counting
          ? "border-[var(--sp-harbour-teal)]/40 bg-[var(--sp-aqua-mist)]/40"
          : "border-[var(--sp-cool-veil)] bg-white"
      }`}
    >
      <p className="text-[10px] font-bold uppercase tracking-wider text-[var(--sp-slate-soft)]">
        R{slot.index + 1}
      </p>
      <p
        className={`mt-1 text-sm font-black tabular-nums ${
          slot.discarded
            ? "text-[var(--sp-slate-soft)] line-through"
            : "text-[var(--sp-harbour-shadow)]"
        }`}
      >
        {slot.empty || slot.score == null ? "—" : slot.score}
      </p>
      <p className="mt-1 text-[11px] font-semibold text-[var(--sp-charcoal)] truncate">
        {slot.regattaName || "No event"}
      </p>
      <div className="mt-2 flex flex-wrap gap-1">
        {chips.map((chip) => (
          <span
            key={chip}
            className={`inline-flex rounded-full border px-1.5 py-0.5 text-[9px] font-bold uppercase tracking-wide ${chipClass(chip)}`}
          >
            {chip}
          </span>
        ))}
      </div>
    </div>
  );
}

export function PersonalSeasonCard({ season }: { season: PersonalSeasonView }) {
  const fleetLabel = season.fleet === "ILCA" ? season.ilcaClass || "ILCA" : season.fleet;
  const place =
    season.rank != null && season.fleetSize != null
      ? `#${season.rank} of ${season.fleetSize}`
      : "Not on this board";
  const scoreLabel = season.higherIsBetter ? "Best 3 high points" : "Best 3 of 5";

  return (
    <section className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 shadow-xs space-y-4">
      <div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p className="text-[11px] font-bold uppercase tracking-[0.16em] text-[var(--sp-racing-orange)]">
            This half
          </p>
          <h2 className="mt-1 text-lg font-black text-[var(--sp-harbour-shadow)]">
            {season.sailorName}
          </h2>
          <p className="mt-1 text-sm text-[var(--sp-charcoal-slate)]">
            {season.periodLabel}
            <span className="text-[var(--sp-slate-soft)]"> · </span>
            {fleetLabel}
            <span className="text-[var(--sp-slate-soft)]"> · </span>
            <span className="font-bold text-[var(--sp-harbour-shadow)]">{place}</span>
          </p>
        </div>
        <div className="text-sm text-[var(--sp-charcoal-slate)] sm:text-right">
          {season.best3 != null ? (
            <p>
              {scoreLabel}:{" "}
              <span className="font-black text-[var(--sp-harbour-shadow)]">{season.best3}</span>
            </p>
          ) : null}
          <p className="text-[13px] text-[var(--sp-slate-soft)]">
            {season.lastResultDate
              ? `Last result ${formatSeasonDate(season.lastResultDate)}`
              : "No published result yet"}
          </p>
        </div>
      </div>

      <div className="grid grid-cols-2 sm:grid-cols-5 gap-2">
        {season.slots.map((slot) => (
          <SlotCell key={slot.index} slot={slot} />
        ))}
      </div>

      <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-4 py-3 space-y-2">
        <p className="text-[11px] font-bold uppercase tracking-[0.14em] text-[var(--sp-harbour-teal)]">
          Why this place
        </p>
        {season.why.map((line) => (
          <p key={line} className="text-sm leading-relaxed text-[var(--sp-charcoal)]">
            {line}
          </p>
        ))}
        <p className="text-sm text-[var(--sp-charcoal-slate)]">
          {season.nextCountingEvent ? (
            <>
              Next counting event:{" "}
              {season.nextCountingEvent.href ? (
                <Link
                  href={season.nextCountingEvent.href}
                  className="font-bold text-[var(--sp-harbour-teal)] hover:underline"
                >
                  {season.nextCountingEvent.name}
                </Link>
              ) : (
                <span className="font-bold text-[var(--sp-harbour-shadow)]">
                  {season.nextCountingEvent.name}
                </span>
              )}
              {" "}
              on {formatSeasonDate(season.nextCountingEvent.date)}
            </>
          ) : (
            "No future counting event is on the calendar for this class yet."
          )}
        </p>
      </div>

      <Link
        href={season.resultsHref}
        className="inline-flex text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline"
      >
        Full results →
      </Link>
    </section>
  );
}
