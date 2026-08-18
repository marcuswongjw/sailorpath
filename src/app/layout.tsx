import type { Metadata, Viewport } from "next";
import { Suspense } from "react";
import "./globals.css";
import { AccountProvider } from "@/components/AccountProvider";
import { FeedbackProvider } from "@/components/ui/FeedbackProvider";
import { SiteHeader } from "@/components/SiteHeader";
import { SiteFooter } from "@/components/SiteFooter";
import { UsageBeacon } from "@/components/UsageBeacon";
import { NavigationProgress } from "@/components/NavigationProgress";

export const metadata: Metadata = {
  title: "SailorPath | Singapore Youth Sailing Rankings & Athlete Logbooks",
  description:
    "National rankings, personal logbooks, and a complete record of the journey from Optimist to ILCA for Singapore youth sailors.",
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  maximumScale: 5,
  viewportFit: "cover",
  themeColor: "#090a0f",
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en" className="h-full antialiased dark overflow-x-clip">
      <body className="min-h-full flex flex-col bg-[#090a0f] text-slate-100 font-sans selection:bg-orange-500/30 overflow-x-clip w-full max-w-[100vw]">
        <AccountProvider>
          <FeedbackProvider>
            <Suspense fallback={null}>
              <NavigationProgress />
            </Suspense>
            <UsageBeacon />
            <SiteHeader />
            <main className="flex-1 flex flex-col min-w-0 w-full max-w-[100vw] overflow-x-clip">
              {children}
            </main>
            <SiteFooter />
          </FeedbackProvider>
        </AccountProvider>
      </body>
    </html>
  );
}
