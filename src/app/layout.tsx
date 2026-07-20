import type { Metadata } from "next";
import Link from "next/link";
import "./globals.css";
import { SiteHeader } from "@/components/SiteHeader";
import { UsageBeacon } from "@/components/UsageBeacon";

export const metadata: Metadata = {
  title: "SailorPath | Singapore Optimist Rankings",
  description:
    "Digital logbook and ranking platform for Singapore Optimist sailors.",
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en" className="h-full antialiased dark">
      <body className="min-h-full flex flex-col bg-[#090a0f] text-slate-100 font-sans selection:bg-orange-500/30">
        <UsageBeacon />
        <SiteHeader />
        <main className="flex-1 flex flex-col min-w-0">{children}</main>
        <footer className="border-t border-white/5 bg-[#07080c] py-6 sm:py-8 text-center text-xs text-slate-500">
          <div className="mx-auto max-w-7xl px-4 flex flex-col sm:flex-row items-center justify-between gap-3">
            <p>© {new Date().getFullYear()} SailorPath</p>
            <div className="flex flex-wrap items-center justify-center gap-4">
              <Link href="/support" className="hover:text-orange-400 transition-colors">
                Help / Support
              </Link>
              <Link href="/sample" className="hover:text-slate-300 transition-colors">
                Demo
              </Link>
              <Link href="/sg/optimist/gold" className="hover:text-slate-300 transition-colors">
                Gold standings
              </Link>
            </div>
          </div>
        </footer>
      </body>
    </html>
  );
}
