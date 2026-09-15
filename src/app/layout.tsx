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
  weight: ["600", "700"],
  display: "swap",
});

export const metadata: Metadata = {
  title: "SailorPath | Singapore Youth Sailing Rankings & Athlete Logbooks",
  description:
    "Explore Singapore Optimist and ILCA 4 rankings, regatta results, race scores, and privacy-controlled sailor profiles.",
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
