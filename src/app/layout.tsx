import type { Metadata } from "next";
import "./globals.css";
import { SiteHeader } from "@/components/SiteHeader";
import { SiteFooter } from "@/components/SiteFooter";
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
        <SiteFooter />
      </body>
    </html>
  );
}
