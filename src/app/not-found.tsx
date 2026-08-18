import Link from "next/link";
import { Compass } from "lucide-react";

export default function NotFound() {
  return (
    <div className="mx-auto max-w-xl px-4 py-16 text-center space-y-4">
      <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-orange-500/10 border border-orange-500/20 text-orange-400">
        <Compass className="h-6 w-6" />
      </div>
      <h1 className="text-xl font-black text-white">Page not found</h1>
      <p className="text-sm text-slate-400 leading-relaxed">
        This sailor or page doesn&apos;t exist. Check the URL or search below.
      </p>
      <div className="flex flex-wrap justify-center gap-3 pt-2">
        <Link
          href="/search"
          className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500"
        >
          Search sailors
        </Link>
        <Link
          href="/"
          className="rounded-full border border-white/10 px-5 py-2 text-xs font-bold text-slate-300 hover:text-white"
        >
          Home
        </Link>
      </div>
    </div>
  );
}
