import Link from "next/link";

export function pageNumber(value: string | undefined, total: number, size = 30): number {
  const n = Number(value);
  return Math.min(Math.max(1, Math.ceil(total / size)), Number.isSafeInteger(n) && n > 0 ? n : 1);
}

export function Pagination({ path, filters, page, total, size = 30 }: {
  path: string; filters: Record<string, string | undefined>; page: number; total: number; size?: number;
}) {
  const pages = Math.max(1, Math.ceil(total / size));
  if (pages === 1) return null;
  const href = (n: number) => {
    const params = new URLSearchParams();
    for (const [key, value] of Object.entries(filters)) if (value && key !== "page") params.set(key, value);
    params.set("page", String(n));
    return `${path}?${params}`;
  };
  return <nav aria-label="Pagination" className="flex flex-wrap items-center justify-between gap-4 py-4 text-sm text-harbour">
    {page > 1 ? <Link prefetch={false} className="sp-secondary px-4 py-3" href={href(page - 1)}>Previous</Link> : <span />}
    <span>Page {page} of {pages} · {total} results</span>
    {page < pages ? <Link prefetch={false} className="sp-secondary px-4 py-3" href={href(page + 1)}>Next</Link> : <span />}
  </nav>;
}
