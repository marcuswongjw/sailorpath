import Link from "next/link";

export default function NewsArticleNotFound() {
  return (
    <main className="mx-auto max-w-3xl px-4 py-14 sm:px-6">
      <p className="text-xs font-bold uppercase tracking-[0.16em] text-harbour">
        SailorPath updates
      </p>
      <h1 className="mt-3 text-3xl font-black tracking-tight text-harbour-shadow">
        Update not found
      </h1>
      <p className="mt-3 max-w-xl leading-7 text-slate-soft">
        This update may have been moved, archived, or is not published for public viewing.
      </p>
      <Link href="/news" className="mt-6 inline-flex text-sm font-bold text-harbour hover:underline">
        Browse SailorPath updates →
      </Link>
    </main>
  );
}
