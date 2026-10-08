import type { Metadata } from "next";
import Link from "next/link";
import { ArrowRight, CalendarDays, Trophy, UserRound } from "lucide-react";

export const metadata: Metadata = {
  title: "About SailorPath",
  description: "Learn how SailorPath brings sailing results, class standings, regattas and sailor profiles together for sailors, parents and coaches.",
};

export default function AboutPage() {
  return (
    <div className="bg-sailcloth text-charcoal">
      <section className="border-b border-cool-veil px-4 py-14 sm:px-6 sm:py-20">
        <div className="mx-auto max-w-3xl">
          <p className="text-xs font-semibold uppercase tracking-wide text-harbour">About SailorPath</p>
          <h1 className="mt-4 text-3xl font-bold tracking-tight text-harbour-shadow sm:text-5xl">A clearer view of your sailing journey.</h1>
          <p className="mt-6 text-lg leading-8 text-slate-soft">SailorPath brings regatta results, class standings and sailor profiles together, helping sailors, parents and coaches follow progress and plan what comes next.</p>
        </div>
      </section>
      <section className="mx-auto max-w-5xl space-y-10 px-4 py-12 sm:px-6 sm:py-16">
        <div className="grid gap-5 sm:grid-cols-3">
          {[
            { title: "Follow your class", text: "Explore Optimist, ILCA, WingFoil and Techno 293 standings and race results. Each class keeps its own scoring context.", href: "/rankings", label: "Explore standings", icon: Trophy },
            { title: "Find your next regatta", text: "Browse upcoming and past weekends, filter by class, region or year, and open the results for a specific fleet.", href: "/calendar", label: "Browse regattas", icon: CalendarDays },
            { title: "Keep your record together", text: "Find your sailor profile, follow published results and milestones, and request ownership to manage your profile details.", href: "/search", label: "Find your profile", icon: UserRound },
          ].map(({ title, text, href, label, icon: Icon }) => (
            <article key={title} className="sp-card flex flex-col p-6">
              <Icon className="h-6 w-6 text-harbour" aria-hidden />
              <h2 className="mt-4 text-lg font-semibold text-harbour-shadow">{title}</h2>
              <p className="mt-3 flex-1 text-sm leading-6 text-slate-soft">{text}</p>
              <Link href={href} className="mt-5 inline-flex items-center gap-2 text-sm font-semibold text-harbour hover:underline">{label}<ArrowRight className="h-4 w-4" aria-hidden /></Link>
            </article>
          ))}
        </div>
        <div className="mx-auto max-w-3xl space-y-8">
          <section>
            <h2 className="text-xl font-semibold text-harbour-shadow">Results with their context</h2>
            <p className="mt-3 leading-7 text-slate-soft">Results are imported from published race records and reviewed before they appear on the site. Updates follow reviewed imports; SailorPath is not a live race timing service.</p>
            <p className="mt-3 leading-7 text-slate-soft">Singapore national ranking eligibility belongs to each Optimist, ILCA 4 or ILCA 6 results sheet. A weekend can include classes with different eligibility. Overseas events appear as sailing results without a Singapore non-ranking label.</p>
            <Link href="/how-rankings-work" className="mt-3 inline-block font-semibold text-harbour hover:underline">How rankings work</Link>
          </section>
          <section>
            <h2 className="text-xl font-semibold text-harbour-shadow">For sailors, families and coaches</h2>
            <p className="mt-3 leading-7 text-slate-soft">Public results and regattas are available to browse. Accounts provide access to profile ownership and the relevant parent and coach tools. Profile claims and coach access are reviewed to help keep records connected to the right people.</p>
          </section>
          <section>
            <h2 className="text-xl font-semibold text-harbour-shadow">Help us keep records accurate</h2>
            <p className="mt-3 leading-7 text-slate-soft">If you spot a missing result, a duplicate sailor or an incorrect detail, include the sailor or regatta name and a source when contacting support. For official entries, selection eligibility and final race decisions, refer to the organiser or Singapore Sailing Federation.</p>
            <Link href="/support" className="sp-primary mt-5 inline-flex min-h-11 items-center justify-center px-6 text-sm font-semibold">Contact support</Link>
            <div className="mt-5 flex gap-5 text-sm text-harbour"><Link href="/privacy" className="hover:underline">Privacy</Link><Link href="/terms" className="hover:underline">Terms</Link></div>
          </section>
        </div>
      </section>
    </div>
  );
}
