"use client";

type Props = {
  q: string;
  fleet: string;
  club: string;
  nationality: string;
};

const controlClassName =
  "w-full rounded-xl border border-cool-veil bg-white px-3 py-2 text-sm text-charcoal focus-visible:outline-2 focus-visible:outline-harbour";

/** Query-string filters for the server-rendered search results. */
export function SearchFilters({ q, fleet, club, nationality }: Props) {
  return (
    <form action="/search" method="get" role="search" className="grid items-end gap-3 rounded-2xl border border-cool-veil bg-warm-white p-4 sm:grid-cols-2 lg:grid-cols-5">
      <label className="space-y-1 text-sm font-semibold text-charcoal sm:col-span-2 lg:col-span-1">
        <span>Search</span>
        <input
          type="search"
          name="q"
          defaultValue={q}
          placeholder="Name, sail number, club, or regatta"
          aria-label="Search sailors and regattas"
          className={controlClassName}
        />
      </label>
      <label className="space-y-1 text-sm font-semibold text-charcoal">
        <span>Fleet</span>
        <select name="fleet" defaultValue={fleet} aria-label="Fleet" className={controlClassName}>
          <option value="all">All fleets</option>
          <option value="gold">Gold</option>
          <option value="silver">Silver</option>
          <option value="ilca">ILCA</option>
        </select>
      </label>
      <label className="space-y-1 text-sm font-semibold text-charcoal">
        <span>Club</span>
        <input type="text" name="club" defaultValue={club} placeholder="CSC, SAFYC" aria-label="Club" className={controlClassName} />
      </label>
      <label className="space-y-1 text-sm font-semibold text-charcoal">
        <span>Nationality</span>
        <input type="text" name="nationality" defaultValue={nationality} placeholder="SGP" aria-label="Nationality" className={controlClassName} />
      </label>
      <button type="submit" className="sp-primary rounded-xl px-4 py-2 text-sm font-bold text-white">Search</button>
    </form>
  );
}
