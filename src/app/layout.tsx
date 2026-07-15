import type { Metadata } from "next";
import Link from "next/link";
import "./globals.css";

export const metadata: Metadata = {
  title: "SailorPath | Singapore Optimist Logbook & Rankings",
  description:
    "The digital logbook, fleet management, and ranking platform for Singapore Optimist sailors. Track performance, analyze results, and view standings.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="h-full antialiased dark">
      <body className="min-h-full flex flex-col bg-[#090a0f] text-slate-100 font-sans selection:bg-orange-500/30 selection:text-orange-300">
        {/* Navigation Header */}
        <header className="sticky top-0 z-50 w-full border-b border-white/5 bg-[#090a0f]/80 backdrop-blur-md">
          <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <div className="flex h-16 items-center justify-between">
              {/* Logo */}
              <div className="flex items-center gap-8">
                <Link href="/" className="flex items-center gap-2 group">
                  <span className="flex h-8 w-8 items-center justify-center rounded-lg bg-orange-600 font-black text-white text-lg tracking-tighter group-hover:bg-orange-500 transition-colors">
                    SP
                  </span>
                  <span className="font-extrabold text-xl tracking-tight text-white group-hover:text-orange-500 transition-colors">
                    Sailor<span className="text-orange-500 group-hover:text-white transition-colors">Path</span>
                  </span>
                </Link>

                {/* Primary Nav Links */}
                <nav className="hidden md:flex items-center gap-6">
                  <div className="relative group">
                    <button className="text-sm font-semibold text-slate-400 hover:text-white transition-colors flex items-center gap-1 py-5 focus:outline-none">
                      SG Optimist
                      <svg
                        className="h-4 w-4 text-slate-500 group-hover:text-slate-300 transition-colors"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                        strokeWidth={2.5}
                      >
                        <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
                      </svg>
                    </button>
                    <div className="absolute left-0 top-[60px] hidden group-hover:block w-48 rounded-2xl bg-[#131520] border border-white/5 p-2 shadow-2xl animate-in fade-in slide-in-from-top-2 duration-200">
                      <Link
                        href="/sg/optimist/gold"
                        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white transition-all"
                      >
                        Gold Fleet Standings
                      </Link>
                      <Link
                        href="/sg/optimist/silver"
                        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white transition-all"
                      >
                        Silver Fleet Standings
                      </Link>
                      <Link
                        href="/sg/optimist/regattas"
                        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white transition-all"
                      >
                        Regattas List
                      </Link>
                      <Link
                        href="/sg/optimist/goldsailors"
                        className="block rounded-xl px-4 py-2.5 text-xs font-bold text-slate-400 hover:bg-white/5 hover:text-white transition-all"
                      >
                        All Gold Fleet Sailors
                      </Link>
                    </div>
                  </div>
                </nav>
              </div>

              {/* Action Buttons */}
              <div className="flex items-center gap-4">
                <Link
                  href="/login"
                  className="text-sm font-semibold text-slate-400 hover:text-white transition-colors"
                >
                  Log In
                </Link>
                <Link
                  href="/register"
                  className="hidden sm:inline-flex rounded-full bg-orange-600 px-4 py-1.5 text-xs font-bold text-white hover:bg-orange-500 transition-all shadow-md shadow-orange-950/20"
                >
                  Claim your profile
                </Link>
              </div>
            </div>
          </div>
        </header>

        {/* Main Content Area */}
        <main className="flex-1 flex flex-col">{children}</main>

        {/* Global Footer */}
        <footer className="border-t border-white/5 bg-[#07080c] py-8 text-center text-xs text-slate-500">
          <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 flex flex-col sm:flex-row items-center justify-between gap-4">
            <p>© {new Date().getFullYear()} SailorPath. All rights reserved.</p>
            <div className="flex gap-4">
              <Link href="/terms" className="hover:text-slate-300">
                Terms
              </Link>
              <Link href="/privacy" className="hover:text-slate-300">
                Privacy
              </Link>
              <Link href="/support" className="hover:text-slate-300">
                Support
              </Link>
            </div>
          </div>
        </footer>
      </body>
    </html>
  );
}
