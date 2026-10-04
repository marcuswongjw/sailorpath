export function joinDateRange(start?: string | null, end?: string | null): string {
  const startDate = String(start || "").trim();
  const endDate = String(end || "").trim();
  if (!startDate) return "";
  if (!endDate || endDate === startDate) return startDate;
  return `${startDate} – ${endDate}`;
}

/**
 * Dates, venue, and organiser on their own rows so the values share one baseline.
 */
export function EventFacts({
  dates,
  venue,
  organiser,
  className = "",
  labelClassName = "",
  valueClassName = "",
}: {
  dates?: string | null;
  venue?: string | null;
  organiser?: string | null;
  className?: string;
  labelClassName?: string;
  valueClassName?: string;
}) {
  const rows = [
    { label: "Dates", value: String(dates || "").trim() },
    { label: "Venue", value: String(venue || "").trim() },
    { label: "Organiser", value: String(organiser || "").trim() },
  ].filter((row) => row.value);

  if (!rows.length) return null;

  return (
    <dl className={className}>
      {rows.map((row) => (
        <div key={row.label} className="flex flex-wrap items-baseline gap-x-2">
          <dt className={labelClassName}>{row.label}:</dt>
          <dd className={valueClassName}>{row.value}</dd>
        </div>
      ))}
    </dl>
  );
}
