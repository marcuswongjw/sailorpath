import Link from "next/link";
import {
  Search,
  Trophy,
  Zap,
  Shield,
  Compass,
  Anchor,
  Medal,
  BookOpen,
  Users,
  UserRound,
} from "lucide-react";
import { listSailors } from "@/lib/queries";
import { WaitlistForm } from "@/components/WaitlistForm";

export const dynamic = "force-dynamic";

export default async function HomePage() {
  let sailors: Awaited<ReturnType<typeof listSailors>> = [];
  let dbLive = true;

  try {
    sailors = await listSailors();
  } catch (e) {
    dbLive = false;
    void e;
  }

  const featuredSailors = sailors.slice(0, 3);

  return (
    <div className="relative min-h-screen bg-[#090a0f] flex flex-col justify-between overflow-x-hidden">
      <div className="absolute top-0 left-0 right-0 h-[420px] sm:left-1/4 sm:right-auto sm:w-[500px] sm:h-[500px] bg-orange-600/10 rounded-full blur-[100px] pointer-events-none -z-10" />
      <div className="absolute top-40 right-0 w-[320px] h-[320px] bg-sky-600/10 rounded-full blur-[100px] pointer-events-none -z-10 hidden sm:block" />

      {/* Hero */}
      <section className="w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-8 pb-10 sm:pt-16 sm:pb-20 text-center lg:pt-24">
        <h1 className="mx-auto max-w-4xl text-[1.65rem] leading-snug sm:text-5xl lg:text-6xl font-black tracking-tight text-white sm:leading-tight">
          {"The performance tracker for "}
          <span className="bg-gradient-to-r from-orange-500 via-orange-600 to-sky-500 bg-clip-text text-transparent">
            Singapore&apos;s youth sailors
          </span>
        </h1>

        <p className="mx-auto mt-4 sm:mt-6 max-w-xl sm:max-w-2xl text-[13px] sm:text-base md:text-lg text-slate-400 font-medium sm:font-semibold leading-relaxed">
          See your national ranking, track your sailing journey from Optimist to
          ILCA, and claim your athlete profile — all in one place.
        </p>

        <div className="mt-6 sm:mt-8 flex flex-col sm:flex-row gap-2.5 w-full max-w-md mx-auto sm:max-w-none sm:justify-center sm:gap-3">
          <Link
            href="/rankings"
            className="w-full sm:w-auto rounded-full bg-orange-600 hover:bg-orange-500 active:scale-[0.98] transition-all text-xs font-black uppercase tracking-wider text-white px-6 py-3.5 shadow-lg shadow-orange-950/20 border border-orange-500/30 inline-flex items-center justify-center gap-2 min-h-[44px]"
          >
            <Trophy className="h-4 w-4 shrink-0" />
            View Live Rankings
          </Link>
          <Link
            href="/claim-profile"
            className="w-full sm:w-auto rounded-full border border-white/15 bg-white/5 px-6 py-3.5 text-xs font-bold text-white hover:border-orange-500/40 hover:bg-white/10 transition-all text-center min-h-[44px] inline-flex items-center justify-center"
          >
            Claim My Profile
          </Link>
        </div>

        <p className="mx-auto mt-4 max-w-2xl text-[11px] sm:text-[12px] text-slate-500 leading-relaxed">
          Official ranking data for Singapore Sailing&apos;s Optimist Gold/Silver
          Series and ILCA 4 National Ranking
        </p>

        <div className="mx-auto mt-6 sm:mt-12 max-w-md w-full">
          <form action="/search" className="relative">
            <input
              type="search"
              name="query"
              enterKeyHint="search"
              placeholder="Search name or sail #"
              className="w-full rounded-2xl sm:rounded-full border border-white/10 bg-white/5 px-4 py-3 pr-12 text-white placeholder-slate-500 focus:border-orange-500 focus:outline-none focus:ring-2 focus:ring-orange-500/20 text-sm min-h-[48px]"
            />
            <button
              type="submit"
              className="absolute right-1.5 top-1/2 -translate-y-1/2 rounded-xl sm:rounded-full bg-orange-600 p-2.5 text-white min-h-[40px] min-w-[40px] inline-flex items-center justify-center"
              aria-label="Search"
            >
              <Search className="h-5 w-5" />
            </button>
          </form>

          <div className="mt-3 flex flex-wrap justify-center gap-1.5 sm:gap-2 text-[11px] sm:text-xs">
            {featuredSailors.length > 0 ? (
              <>
                <span className="text-slate-600 self-center w-full sm:w-auto mb-0.5 sm:mb-0">
                  Try:
                </span>
                {featuredSailors.map((sailor) => (
                  <Link
                    key={sailor.id}
                    href={`/${sailor.handle}`}
                    className="px-2.5 py-1.5 rounded-lg bg-white/5 border border-white/5 text-slate-300 hover:border-orange-500 hover:text-white transition-all max-w-[11rem] truncate"
                  >
                    {sailor.name}
                  </Link>
                ))}
              </>
            ) : (
              <Link
                href="/sample"
                className="px-2.5 py-1.5 rounded-lg bg-amber-500/10 border border-amber-500/20 text-amber-100"
              >
                Open demo profile
              </Link>
            )}
          </div>
          {!dbLive && (
            <p className="mt-2 text-[11px] text-slate-600">
              Live database offline — sample still works.
            </p>
          )}
        </div>
      </section>

      {/* How it works */}
      <section className="border-t border-white/5 bg-[#0b0c13] py-12 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <h2 className="text-center text-2xl sm:text-3xl font-extrabold text-white tracking-tight mb-8 sm:mb-12">
            How SailorPath Works
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 sm:gap-8 max-w-5xl mx-auto">
            {(
              [
                {
                  step: "1",
                  title: "We collect results",
                  body: "Every ranking regatta in Singapore feeds into SailorPath automatically.",
                },
                {
                  step: "2",
                  title: "Your profile builds itself",
                  body: "Results, ranking points, and fleet positions populate your athlete logbook.",
                },
                {
                  step: "3",
                  title: "You take ownership",
                  body: "Claim your profile to add milestones, equipment notes, and race reflections.",
                },
              ] as const
            ).map((item) => (
              <div
                key={item.step}
                className="relative rounded-2xl border border-white/10 bg-white/[0.03] p-5 sm:p-6 text-center md:text-left"
              >
                <span className="inline-flex h-9 w-9 items-center justify-center rounded-full bg-orange-500/15 text-orange-400 text-sm font-black border border-orange-500/25 mb-3">
                  {item.step}
                </span>
                <h3 className="text-base sm:text-lg font-bold text-white">
                  {item.title}
                </h3>
                <p className="mt-2 text-xs sm:text-sm text-slate-400 leading-relaxed">
                  {item.body}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Live demo profile */}
      <section className="border-t border-white/5 bg-[#090a0f] py-12 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="mx-auto max-w-2xl text-center rounded-2xl border border-orange-500/20 bg-gradient-to-b from-orange-500/[0.08] to-transparent px-6 py-10 sm:py-12">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              See what your profile looks like
            </h2>
            <p className="mt-3 text-sm text-slate-400 leading-relaxed max-w-md mx-auto">
              Explore a full dual-class sample — Optimist Gold ranking, ILCA 4
              results, and Public / Sailor / Parent / Coach views.
            </p>
            <Link
              href="/sample"
              className="mt-6 inline-flex items-center justify-center rounded-full bg-orange-600 hover:bg-orange-500 px-6 py-3 text-sm font-bold text-white shadow-lg shadow-orange-950/20 border border-orange-500/30 min-h-[44px]"
            >
              Open demo profile →
            </Link>
          </div>
        </div>
      </section>

      {/* Audience features */}
      <section className="border-t border-white/5 bg-[#0b0c13] py-12 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 sm:gap-5">
            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-orange-500/25 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-orange-500/15 mb-3">
                <UserRound className="h-5 w-5 text-orange-400" />
              </div>
              <h2 className="text-lg font-bold text-white">For Sailors</h2>
              <p className="text-sm font-semibold text-white mt-1.5">
                Own your sailing journey.
              </p>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                See exactly where you rank nationally. Automatically track every
                regatta result, ranking movement, and personal best from your
                first Optimist race through your ILCA transition. Add milestones,
                equipment notes, and race reflections — then share what you want
                and keep the rest private.
              </p>
              <Link
                href="/claim-profile"
                className="mt-4 text-[12px] font-bold text-orange-400 hover:text-orange-300"
              >
                Claim My Profile →
              </Link>
            </article>

            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-white/10 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-white/10 mb-3">
                <Users className="h-5 w-5 text-slate-200" />
              </div>
              <h2 className="text-lg font-bold text-white">For Parents</h2>
              <p className="text-sm font-semibold text-white mt-1.5">
                Stop the info-hunt.
              </p>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                Get a complete, stress-free view of your child&apos;s sailing
                journey in one private place. Follow ranking progress, results,
                and milestones without chasing WhatsApp groups or club PDFs. You
                stay in control of what&apos;s public and what stays private.
              </p>
              <Link
                href="/claim-profile"
                className="mt-4 text-[12px] font-bold text-slate-300 hover:text-white"
              >
                Link to your child&apos;s profile →
              </Link>
            </article>

            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-sky-500/25 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-sky-500/15 mb-3">
                <Trophy className="h-5 w-5 text-sky-400" />
              </div>
              <h2 className="text-lg font-bold text-white">For Coaches</h2>
              <p className="text-sm font-semibold text-white mt-1.5">
                Escape spreadsheet hell.
              </p>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                Manage your squad, compare athletes side-by-side, spot
                progression trends, and generate selection reports in minutes
                instead of hours. Public rankings and profiles are available now;
                full squad tools and analytics are coming.
              </p>
              <div className="mt-4 flex flex-col gap-1.5">
                <Link
                  href="/coach-tools"
                  className="text-[12px] font-bold text-sky-400 hover:text-sky-300"
                >
                  Explore Coach Tools →
                </Link>
                <a
                  href="#early-access"
                  className="text-[12px] font-bold text-slate-400 hover:text-white"
                >
                  Apply for Early Access to Coach Dashboard →
                </a>
              </div>
            </article>
          </div>
        </div>
      </section>

      {/* Ranking features */}
      <section className="border-t border-white/5 bg-[#090a0f] py-12 sm:py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="text-center max-w-2xl mx-auto mb-8 sm:mb-12">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              Rankings &amp; logbook
            </h2>
            <p className="mt-3 text-slate-400 text-sm leading-relaxed">
              Built for Singapore Sailing series rules — Optimist, ILCA 4, and
              your personal journey.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 sm:gap-5">
            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-orange-500/25 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-orange-500/15 mb-3">
                <Medal className="h-5 w-5 text-orange-400" />
              </div>
              <h3 className="text-lg font-bold text-white">
                Optimist Gold/Silver Series Rankings
              </h3>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                Automatically calculated using Singapore Sailing&apos;s official
                scoring rules. Best 3 of 5 results, with fair handling of DNS,
                overseas commitments, and fleet movements.
              </p>
              <ul className="mt-4 space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                <li>SGP sailors auto-included when they race</li>
                <li>Gold fleet entry and drop on 1 Jan / 1 Jul</li>
                <li>Smart data checks for accuracy</li>
              </ul>
            </article>

            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-sky-500/25 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-sky-500/15 mb-3">
                <Anchor className="h-5 w-5 text-sky-400" />
              </div>
              <h3 className="text-lg font-bold text-white">
                ILCA 4 National Ranking
              </h3>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                Track your position as you transition from Optimist. High Ranking
                Points system with position trend charts and journey timelines.
              </p>
              <ul className="mt-4 space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                <li>Dual Optimist + ILCA sail numbers on one profile</li>
                <li>Best 3 of last 5 results</li>
                <li>Visual timeline showing your class transition</li>
              </ul>
            </article>

            <article className="glass-card rounded-2xl p-5 sm:p-6 border border-white/10 flex flex-col">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-white/10 mb-3">
                <BookOpen className="h-5 w-5 text-amber-300" />
              </div>
              <h3 className="text-lg font-bold text-white">Athlete Logbook</h3>
              <p className="text-xs sm:text-sm text-slate-400 mt-2 leading-relaxed flex-1">
                Your complete sailing history, claimed and controlled by you. Add
                notes, equipment, and milestones with full privacy controls.
              </p>
              <ul className="mt-4 space-y-1.5 text-[11px] text-slate-400 border-t border-white/5 pt-3">
                <li>Dual-class tabs: Optimist and ILCA results together</li>
                <li>Medal tally and key stats</li>
                <li>Privacy controls for sensitive data</li>
              </ul>
            </article>
          </div>

          <p className="mt-8 text-center">
            <Link
              href="/how-rankings-work"
              className="text-[13px] font-semibold text-orange-400 hover:text-orange-300"
            >
              Read our full ranking methodology →
            </Link>
          </p>
        </div>
      </section>

      {/* Roadmap */}
      <section
        id="roadmap"
        className="border-t border-white/5 bg-[#0b0c13] py-12 sm:py-16"
      >
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="text-center max-w-2xl mx-auto mb-10">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white tracking-tight">
              Roadmap
            </h2>
            <p className="mt-3 text-slate-400 text-sm leading-relaxed">
              Rankings and logbooks are live. Here&apos;s what&apos;s coming
              next.
            </p>
          </div>

          <ol className="mx-auto max-w-2xl space-y-0 relative">
            {(
              [
                {
                  date: "Q3 2026",
                  title: "Parent Dashboards",
                  body: "Link your account to your child's profile. See progress, ranking movement, and upcoming events in one private view — without the WhatsApp chase.",
                },
                {
                  date: "Q4 2026",
                  title: "Coach Squads",
                  body: "Manage multiple sailors from one account. Compare athletes, track trends, and prepare selection reports in minutes instead of hours.",
                },
                {
                  date: "2027",
                  title: "Club & Event Tools",
                  body: "Start-list sync, campaign planning, and automated alerts for rank changes and selection windows.",
                },
              ] as const
            ).map((item, i, arr) => (
              <li key={item.date} className="relative flex gap-4 pb-10 last:pb-0">
                {i < arr.length - 1 && (
                  <span
                    className="absolute left-[11px] top-7 bottom-0 w-px bg-white/10"
                    aria-hidden
                  />
                )}
                <span className="relative z-10 mt-1 h-6 w-6 shrink-0 rounded-full border border-orange-500/40 bg-orange-500/15" />
                <div>
                  <p className="text-[11px] font-black uppercase tracking-widest text-orange-400">
                    {item.date}
                  </p>
                  <h3 className="text-base font-bold text-white mt-1">
                    {item.title}
                  </h3>
                  <p className="text-xs sm:text-sm text-slate-400 mt-1.5 leading-relaxed">
                    {item.body}
                  </p>
                </div>
              </li>
            ))}
          </ol>

          <div
            id="early-access"
            className="mt-12 mx-auto max-w-lg rounded-2xl border border-white/10 bg-white/[0.03] p-6 sm:p-8 text-center"
          >
            <h3 className="text-lg font-bold text-white">
              Want first access to parent and coach tools?
            </h3>
            <p className="mt-2 text-xs text-slate-500">
              Join the early access list →
            </p>
            <WaitlistForm />
          </div>
        </div>
      </section>

      {/* Founding Membership */}
      <section
        id="founding-membership"
        className="py-12 sm:py-20 bg-[#090a0f] border-t border-white/5"
      >
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="mx-auto max-w-3xl text-center mb-8 sm:mb-16">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white sm:text-4xl tracking-tight">
              Back the build. Anchor your place in the fleet.
            </h2>
            <p className="mt-4 text-slate-400 max-w-2xl mx-auto leading-relaxed text-sm md:text-base">
              SailorPath is being built for Singapore&apos;s youth sailors,
              parents, and coaches. Become a Founding Supporter and help shape
              the definitive performance tracker for the local scene — while
              locking in permanent recognition and early access.
            </p>
          </div>

          <div className="mx-auto max-w-md w-full rounded-3xl border border-orange-500/20 bg-gradient-to-b from-[#131520] to-[#0d0f17] p-6 sm:p-8 md:p-10 shadow-2xl relative overflow-hidden group hover:border-orange-500/40 transition-all duration-300">
            <div className="absolute top-0 right-0 w-32 h-32 bg-orange-600/10 rounded-full blur-2xl group-hover:bg-orange-600/20 transition-all" />

            <div className="flex justify-between items-center mb-6">
              <div>
                <h3 className="text-xl font-bold text-white">
                  Founding Supporter
                </h3>
                <p className="text-xs text-orange-400 font-semibold mt-1">
                  Limited to 10 members
                </p>
              </div>
              <span className="inline-flex items-center rounded-full bg-orange-500/10 px-3 py-1 text-xs font-bold text-orange-400 border border-orange-500/20">
                Limited
              </span>
            </div>

            <p className="text-4xl font-extrabold text-white tracking-tight flex items-baseline gap-1.5">
              S$99
              <span className="text-xs font-bold text-slate-500">
                {" "}
                (one-time)
              </span>
            </p>

            <p className="mt-6 text-[11px] font-bold uppercase tracking-wide text-slate-500">
              What you get
            </p>
            <ul className="mt-3 space-y-4 text-xs font-medium text-slate-300">
              <li className="flex items-start gap-3">
                <Trophy className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>
                  Permanent Founding Supporter crest on your public profile
                </span>
              </li>
              <li className="flex items-start gap-3">
                <Shield className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>
                  Lifetime access to Sailor / Parent features (claim, private
                  logbook, notes, privacy controls, and future parent dashboard)
                </span>
              </li>
              <li className="flex items-start gap-3">
                <Compass className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>
                  First access to parent dashboards, coach tools, and advanced
                  analytics as they launch
                </span>
              </li>
              <li className="flex items-start gap-3">
                <Zap className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>Priority input on the product roadmap</span>
              </li>
            </ul>

            <div className="mt-8">
              <a
                href="https://buy.stripe.com/00weVd3jFf8h9ZvelL4Rq00"
                target="_blank"
                rel="noreferrer"
                className="flex w-full justify-center rounded-full bg-orange-600 py-3.5 px-4 text-center text-sm font-bold text-white hover:bg-orange-500 transition-all hover:scale-[1.02] shadow-lg shadow-orange-950/20 border border-orange-500/30"
              >
                Become a Founding Supporter — S$99
              </a>
              <p className="mt-3 text-center text-[10px] text-slate-600">
                Secure checkout via Stripe.
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
