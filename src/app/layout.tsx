import type { Metadata } from "next";
import Link from "next/link";
import "./globals.css";
import { SiteHeader } from "@/components/SiteHeader";

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
        <SiteHeader />
        <main className="flex-1 flex flex-col">{children}</main>
        <footer className="border-t border-white/5 bg-[#07080c] py-8 text-center text-xs text-slate-500">
          <div className="mx-auto max-w-7xl px-4 flex flex-col sm:flex-row items-center justify-between gap-4">
            <p>© {new Date().getFullYear()} SailorPath</p>
            <div className="flex gap-4">
              <Link href="/api/health" className="hover:text-slate-300">
                Health
              </Link>
              <a
                href="https://admin.sailorpath.com/"
                className="hover:text-slate-300"
              >
                Admin
              </a>
            </div>
          </div>
        </footer>
      </body>
    </html>
  );
}
