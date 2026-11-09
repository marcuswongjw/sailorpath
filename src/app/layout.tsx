import type { Metadata, Viewport } from "next";
import { Inter, Montserrat } from "next/font/google";
import { Suspense } from "react";
import "./globals.css";
import { AccountProvider } from "@/components/AccountProvider";
import { FeedbackProvider } from "@/components/ui/FeedbackProvider";
import { SiteHeader } from "@/components/SiteHeader";
import { SiteFooter } from "@/components/SiteFooter";
import { UsageBeacon } from "@/components/UsageBeacon";
import { NavigationProgress } from "@/components/NavigationProgress";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
  display: "swap",
});

const montserrat = Montserrat({
  subsets: ["latin"],
  variable: "--font-montserrat",
  weight: ["600", "700", "800"],
  display: "swap",
});

function siteMetadataBase(): URL {
  const configured = process.env.NEXT_PUBLIC_SITE_URL?.trim().replace(/\/$/, "");
  if (configured && /^https?:\/\//i.test(configured)) {
    try {
      return new URL(configured);
    } catch {
      // Placeholder or malformed env values fall back to the public origin.
    }
  }
  return new URL("https://sailorpath.com");
}

export const metadata: Metadata = {
  metadataBase: siteMetadataBase(),
  title: "SailorPath | Sailing Results, Class Standings & Sailor Profiles",
  description:
    "Verified regatta scorecards across Asia and Oceania, Singapore youth and open class standings, and career records across 13 dinghy, skiff, and windsurfing classes.",
  icons: {
    icon: [{ url: "/brand/sailorpath-icon.png", type: "image/png" }],
    apple: [{ url: "/brand/sailorpath-icon.png", type: "image/png" }],
  },
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  maximumScale: 5,
  viewportFit: "cover",
  themeColor: "#0A5557",
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html
      lang="en"
      className={`${inter.variable} ${montserrat.variable} h-full antialiased overflow-x-clip`}
    >
      <body className="min-h-full flex flex-col bg-background text-foreground font-sans selection:bg-orange-200 overflow-x-clip w-full max-w-[100vw]">
        <AccountProvider>
          <FeedbackProvider>
            <Suspense fallback={null}>
              <NavigationProgress />
            </Suspense>
            <UsageBeacon />
            <a
              href="#main-content"
              className="sr-only focus:not-sr-only focus:fixed focus:top-3 focus:left-3 focus:z-[100] focus:rounded-lg focus:bg-harbour focus:px-4 focus:py-2.5 focus:text-sm focus:font-semibold focus:text-white focus:shadow-lg focus:outline-2 focus:outline-offset-2 focus:outline-racing-orange"
            >
              Skip to main content
            </a>
            <SiteHeader />
            <main
              id="main-content"
              className="flex-1 flex flex-col min-w-0 w-full max-w-[100vw] overflow-x-clip *:min-w-0 *:max-w-full"
            >
              {children}
            </main>
            <SiteFooter />
          </FeedbackProvider>
        </AccountProvider>
      </body>
    </html>
  );
}
