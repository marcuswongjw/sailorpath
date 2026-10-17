"use client";

type Props = {
  q: string;
  boatClass: string;
  year: string;
  when: string;
  classes: string[];
  years: string[];
};

const controlClassName =
  "w-full rounded-xl border border-cool-veil bg-white px-3 py-2 text-sm text-charcoal focus-visible:outline-2 focus-visible:outline-harbour";

/** Query-string filters for the server-rendered regatta directory. */
export function RegattaDirectoryFilters({ q, boatClass, year, when, classes, years }: Props) {
  return (
    <form action="/regattas" method="get" className="grid items-end gap-3 rounded-2xl border border-cool-veil bg-warm-white p-4 sm:grid-cols-2 lg:grid-cols-5">
      <label className="space-y-1 text-sm font-semibold text-charcoal">
        <span>Search</span>
        <input type="search" name="q" defaultValue={q} placeholder="Event or venue" aria-label="Search regattas" className={controlClassName} />
      </label>
      <label className="space-y-1 text-sm font-semibold text-charcoal">
        <span>Class</span>
        <select name="class" defaultValue={boatClass} aria-label="Class" className={controlClassName}>
          <option value="all">All classes</option>
          {classes.map((value) => (
            <option key={value} value={value}>{value}</option>
          ))}
        </select>
      </label>
      <label className="space-y-1 text-sm font-semibold text-charcoal">
        <span>Year</span>
        <select name="year" defaultValue={year} aria-label="Year" className={controlClassName}>
          <option value="all">All years</option>
          {years.map((value) => (
            <option key={value} value={value}>{value}</option>
          ))}
        </select>
      </label>
      <label className="space-y-1 text-sm font-semibold text-charcoal">
        <span>When</span>
        <select name="when" defaultValue={when} aria-label="When" className={controlClassName}>
          <option value="all">Upcoming and past</option>
          <option value="upcoming">Upcoming</option>
          <option value="past">Past</option>
        </select>
      </label>
      <button type="submit" className="sp-primary rounded-xl px-4 py-2 text-sm font-bold text-white">Filter regattas</button>
    </form>
  );
}
