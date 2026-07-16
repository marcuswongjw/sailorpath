import type { Metadata } from "next";
import Link from "next/link";
import "./globals.css";
import { SiteHeader } from "@/components/SiteHeader";

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
        <SiteHeader />

        <main className="flex-1 flex flex-col">{children}</main>

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
