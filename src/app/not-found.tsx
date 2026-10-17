import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Page not found | SailorPath",
  description: "This page is not on SailorPath. Open rankings, published results, or search.",
};

const links = [
  { href: "/rankings", label: "Rankings", detail: "Current class standings" },
  { href: "/results", label: "Results", detail: "Published scorecards" },
  { href: "/search", label: "Search", detail: "Find a sailor or event" },
] as const;

export default function NotFound() {
  return (
    <div className="mx-auto w-full max-w-3xl px-4 py-14 sm:px-6 sm:py-20">
      <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">SailorPath</p>
      <h1 className="mt-3 text-3xl font-black tracking-tight text-harbour-shadow sm:text-4xl">
        Page not found
      </h1>
      <p className="mt-4 max-w-xl text-base leading-7 text-slate-soft">
        This page is not on SailorPath. Check the address, or continue from rankings, published results, or search.
      </p>
      <nav aria-label="Continue" className="mt-8 grid gap-3 sm:grid-cols-3">
        {links.map((link) => (
          <Link
            key={link.href}
            href={link.href}
            className="rounded-2xl border border-cool-veil bg-warm-white p-5 shadow-xs transition-colors hover:border-harbour"
          >
            <span className="block text-base font-semibold text-harbour-shadow">{link.label}</span>
            <span className="mt-1 block text-sm text-slate-soft">{link.detail}</span>
          </Link>
        ))}
      </nav>
    </div>
  );
}
