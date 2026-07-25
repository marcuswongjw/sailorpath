/**
 * Display helpers for sailor profile result chips and dates.
 */

export type PlaceBadge = {
  label: string;
  className: string;
};

/** Medal / place chips inspired by modern athlete profiles */
export function placeBadge(
  rank: number | null | undefined,
  opts?: { isDns?: boolean; isOverseas?: boolean }
): PlaceBadge | null {
  if (opts?.isDns) {
    return {
      label: "DNS",
      className: "bg-rose-500/15 text-rose-300 border border-rose-500/30",
    };
  }
  if (opts?.isOverseas) {
    return {
      label: "Overseas",
      className: "bg-sky-500/15 text-sky-300 border border-sky-500/30",
    };
  }
  if (rank == null || !Number.isFinite(Number(rank))) return null;
  const r = Number(rank);
  if (r === 1) {
    return {
      label: "Gold",
      className:
        "bg-amber-500/15 text-amber-300 border border-amber-500/35",
    };
  }
  if (r === 2) {
    return {
      label: "Silver",
      className: "bg-slate-300/15 text-slate-200 border border-slate-300/30",
    };
  }
  if (r === 3) {
    return {
      label: "Bronze",
      className:
        "bg-orange-700/20 text-orange-300 border border-orange-600/35",
    };
  }
  if (r <= 10) {
    return {
      label: "Top 10",
      className: "bg-blue-500/15 text-blue-300 border border-blue-500/30",
    };
  }
  if (r <= 25) {
    return {
      label: "Top 25",
      className: "bg-violet-500/10 text-violet-300 border border-violet-500/25",
    };
  }
  return null;
}

function monthLabel(ymd: string): string {
  const m = Number(ymd.slice(5, 7));
  const y = ymd.slice(0, 4);
  const names = [
    "",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  return `${names[m] || ymd.slice(5, 7)} ${y}`;
}

export function formatEventWhen(date: string | null | undefined): string {
  const d = String(date || "").slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(d)) return d || "—";
  return monthLabel(d);
}
