import type { NorAmendment } from "@/lib/admin/norAmendments";

/** Read-only Amendment 1 facts for the admin regatta editor. */
export function AdminNorAmendmentCard({ notice }: { notice: NorAmendment }) {
  return (
    <section className="sm:col-span-2 rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] p-3 space-y-2">
      <div className="flex flex-wrap items-baseline justify-between gap-2">
        <h4 className="text-[13px] font-bold text-[var(--sp-charcoal)]">
          {notice.title}
        </h4>
        <p className="text-[11px] font-semibold text-[var(--sp-slate-soft)]">
          Amended {notice.amendedOn}
        </p>
      </div>
      <p className="text-[12px] leading-relaxed text-[var(--sp-charcoal)]">
        {notice.venue}
      </p>
      <p className="text-[12px] leading-relaxed text-[var(--sp-charcoal)]">
        <span className="font-semibold">Classes. </span>
        {notice.classes}
      </p>
      <p className="text-[12px] leading-relaxed text-[var(--sp-charcoal)]">
        <span className="font-semibold">Fees. </span>
        {notice.fees}
      </p>
      <p className="text-[12px] leading-relaxed text-[var(--sp-charcoal)]">
        <span className="font-semibold">Entry. </span>
        {notice.deadlines}
      </p>
      <ul className="text-[12px] leading-relaxed text-[var(--sp-charcoal)] list-disc pl-4 space-y-0.5">
        {notice.schedule.map((line) => (
          <li key={line}>{line}</li>
        ))}
        {notice.races.map((line) => (
          <li key={line}>{line}</li>
        ))}
      </ul>
      <div className="space-y-1">
        <p className="text-[11px] font-bold uppercase tracking-wide text-[var(--sp-harbour-teal)]">
          Prizes in the NoR
        </p>
        {notice.prizes.map((row) => (
          <p key={row.fleet} className="text-[12px] leading-relaxed text-[var(--sp-charcoal)]">
            <span className="font-semibold">{row.fleet}. </span>
            {row.prizes}
          </p>
        ))}
      </div>
      <ul className="text-[12px] leading-relaxed text-[var(--sp-slate-soft)] list-disc pl-4 space-y-0.5">
        {notice.notes.map((line) => (
          <li key={line}>{line}</li>
        ))}
      </ul>
      <p className="text-[12px]">
        <a
          href={notice.website}
          target="_blank"
          rel="noopener noreferrer"
          className="font-semibold text-[var(--sp-harbour-teal)] hover:underline"
        >
          Event website
        </a>
        <span className="text-[var(--sp-slate-soft)]"> · </span>
        <a
          href={notice.noticeUrl}
          target="_blank"
          rel="noopener noreferrer"
          className="font-semibold text-[var(--sp-harbour-teal)] hover:underline"
        >
          Notice board
        </a>
      </p>
    </section>
  );
}
