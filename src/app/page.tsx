import Link from "next/link";
import {
  Search,
  Trophy,
  Zap,
  Shield,
  Compass,
  Sparkles,
} from "lucide-react";
import { listSailors } from "@/lib/queries";
import { DbUnavailableError } from "@/db";

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
    <div className="relative min-h-screen bg-[#090a0f] flex flex-col justify-between">
      <div className="absolute top-0 left-1/4 w-[500px] h-[500px] bg-orange-600/10 rounded-full blur-[120px] pointer-events-none -z-10" />
      <div className="absolute top-[800px] right-1/4 w-[400px] h-[400px] bg-blue-600/5 rounded-full blur-[120px] pointer-events-none -z-10 hidden md:block" />

      {/* Hero */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 pt-16 pb-20 text-center lg:pt-24">
        <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full border border-white/5 bg-white/5 text-xs text-orange-400 font-bold mb-6 hover:bg-white/10 transition-colors">
          <Sparkles className="h-3 w-3 text-orange-500 animate-pulse" />
          <span>Singapore&apos;s Premium Sailing Analytics Platform</span>
        </div>

        <h1 className="mx-auto max-w-4xl text-4xl sm:text-5xl lg:text-7xl font-black tracking-tight text-white">
          Chart your progress. <br />
          <span className="bg-gradient-to-r from-orange-500 via-orange-600 to-red-500 bg-clip-text text-transparent">
            Command your sailing journey.
          </span>
        </h1>

        <p className="mx-auto mt-6 max-w-3xl text-base md:text-lg text-slate-400 font-semibold leading-relaxed">
          SailorPath is the digital logbook and performance tracker for
          Singapore&apos;s youth sailors. Start your pathway in the Optimist
          fleet and track every regatta, ranking, and equipment change as you
          grow.
        </p>

        <div className="mt-8 flex flex-col sm:flex-row justify-center gap-3">
          <Link
            href="/register"
            className="rounded-full bg-orange-600 hover:bg-orange-500 hover:scale-105 transition-all text-xs font-black uppercase tracking-wider text-white px-8 py-3.5 shadow-lg shadow-orange-950/20 border border-orange-500/30 inline-flex items-center justify-center gap-2"
          >
            <Trophy className="h-4 w-4" />
            Claim Your Sailor Profile (Free)
          </Link>
          <Link
            href="/sample"
            className="rounded-full border border-amber-500/40 bg-amber-500/10 px-8 py-3.5 text-xs font-bold text-amber-100 hover:border-amber-400/60 transition-all"
          >
            View sample profile
          </Link>
          <Link
            href="/sg/optimist/gold"
            className="rounded-full border border-white/10 px-8 py-3.5 text-xs font-bold text-white hover:border-orange-500/40 transition-all"
          >
            Gold standings
          </Link>
        </div>

        <div className="mx-auto mt-12 max-w-lg">
          <form action="/search" className="relative group">
            <input
              type="text"
              name="query"
              placeholder="Search by name or sail number (e.g. SGP 115)..."
              className="w-full rounded-full border border-white/10 bg-white/5 px-6 py-4 pr-16 text-white placeholder-slate-500 focus:border-orange-500 focus:outline-none focus:ring-2 focus:ring-orange-500/20 shadow-xl shadow-black/30 text-sm md:text-base transition-all"
            />
            <button
              type="submit"
              className="absolute right-2 top-2 rounded-full bg-orange-600 p-2.5 text-white hover:bg-orange-500 hover:scale-105 transition-all shadow-md shadow-orange-950/20"
            >
              <Search className="h-5 w-5" />
            </button>
          </form>

          <div className="mt-4 flex flex-wrap justify-center gap-2 text-xs">
            {featuredSailors.length > 0 ? (
              <>
                <span className="text-slate-500 self-center">Try searching:</span>
                {featuredSailors.map((sailor) => (
                  <Link
                    key={sailor.id}
                    href={`/${sailor.handle}`}
                    className="px-2.5 py-1 rounded-md bg-white/5 border border-white/5 text-slate-300 hover:border-orange-500 hover:text-white transition-all"
                  >
                    {sailor.name} ({sailor.sailNumber})
                  </Link>
                ))}
              </>
            ) : (
              <>
                <span className="text-slate-500 self-center">Preview:</span>
                <Link
                  href="/sample"
                  className="px-2.5 py-1 rounded-md bg-amber-500/10 border border-amber-500/20 text-amber-100 hover:border-amber-400 transition-all"
                >
                  Sample profile — Ashlyn Tan (SGP 115)
                </Link>
              </>
            )}
          </div>
          {!dbLive && (
            <p className="mt-3 text-[11px] text-slate-600">
              Live database offline — sample profile still works.
            </p>
          )}
        </div>
      </section>

      {/* Development Pathway */}
      <section className="border-t border-white/5 bg-[#0b0c13] py-16 sm:py-20">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="text-center max-w-3xl mx-auto mb-12 sm:mb-16">
            <h2 className="text-3xl font-extrabold text-white sm:text-4xl tracking-tight">
              Development Pathway
            </h2>
            <p className="mt-4 text-slate-400">
              Follow the active development milestones of the SailorPath
              application.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 relative">
            <div className="hidden md:block absolute top-1/2 left-4 right-4 h-0.5 bg-gradient-to-r from-orange-500/10 via-orange-500/50 to-orange-500/10 -translate-y-1/2 -z-10" />

            <div className="glass-card rounded-2xl p-6 border border-white/5 hover:border-orange-500/20 transition-all flex flex-col justify-between group">
              <div>
                <span className="text-xs font-bold text-orange-500">LIVE TODAY</span>
                <h3 className="text-lg font-bold text-white mt-2 group-hover:text-orange-500 transition-colors">
                  The Foundation
                </h3>
                <p className="text-xs text-slate-400 mt-2">
                  The core digital identity for youth sailors to track and share
                  their progress.
                </p>
                <ul className="mt-4 space-y-3 text-[11px] text-slate-400 font-semibold border-t border-white/5 pt-3">
                  <li className="flex items-start gap-1.5">
                    <span className="text-orange-500 mt-0.5">•</span>
                    <span>
                      <strong className="text-white">Digital trophy cabinet</strong>
                      : Public profiles consolidating your complete regatta
                      history and individual race scores.
                    </span>
                  </li>
                  <li className="flex items-start gap-1.5">
                    <span className="text-orange-500 mt-0.5">•</span>
                    <span>
                      <strong className="text-white">Equipment log</strong>: Track
                      hull, sail, and foil choices to see what gear drives your
                      best results.
                    </span>
                  </li>
                  <li className="flex items-start gap-1.5">
                    <span className="text-orange-500 mt-0.5">•</span>
                    <span>
                      <strong className="text-white">Achievement timeline</strong>
                      : A visual progression of your journey from the Silver
                      fleet to the Gold fleet.
                    </span>
                  </li>
                  <li className="flex items-start gap-1.5">
                    <span className="text-orange-500 mt-0.5">•</span>
                    <span>
                      <strong className="text-white">Fleet rankings</strong>: Best
                      3 of 5 Gold/Silver standings with DNS handling.
                    </span>
                  </li>
                </ul>
              </div>
              <div className="mt-6 flex h-8 w-8 items-center justify-center rounded-full bg-orange-600 text-white text-xs font-bold shadow-md shadow-orange-950/20">
                ✓
              </div>
            </div>

            <div className="glass-card rounded-2xl p-6 border border-white/5 hover:border-orange-500/20 transition-all flex flex-col justify-between group">
              <div>
                <span className="text-xs font-bold text-orange-500">UP NEXT</span>
                <h3 className="text-lg font-bold text-white mt-2 group-hover:text-orange-500 transition-colors">
                  The Fleet Ecosystem
                </h3>
                <p className="text-xs text-slate-400 mt-2">
                  Expanding the platform to support the coaches and parents who
                  manage the logistics behind the athletes, and connecting the
                  fleet.
                </p>
                <ul className="mt-4 space-y-2 text-[11px] text-slate-400 font-semibold border-t border-white/5 pt-3">
                  <li className="flex items-start gap-1.5">
                    <span className="text-orange-500 mt-0.5">•</span>
                    <span>
                      <strong className="text-white">Coach and squad dashboards</strong>
                      : Aggregate data, compare head-to-head nett scores, and
                      analyse fleet-wide performance trends.
                    </span>
                  </li>
                  <li className="flex items-start gap-1.5">
                    <span className="text-orange-500 mt-0.5">•</span>
                    <span>
                      <strong className="text-white">Family management</strong>:
                      Secure parent accounts to manage multiple young sailors
                      from a single dashboard.
                    </span>
                  </li>
                  <li className="flex items-start gap-1.5">
                    <span className="text-orange-500 mt-0.5">•</span>
                    <span>
                      <strong className="text-white">Condition tagging</strong>:
                      Log wind, tide, and wave conditions alongside results.
                    </span>
                  </li>
                  <li className="flex items-start gap-1.5">
                    <span className="text-orange-500 mt-0.5">•</span>
                    <span>
                      <strong className="text-white">Sailor connections</strong>:
                      Find and connect with fellow athletes in the fleet.
                    </span>
                  </li>
                </ul>
              </div>
              <div className="mt-6 flex h-8 w-8 items-center justify-center rounded-full bg-slate-900 border border-white/5 text-slate-500 text-xs font-bold">
                02
              </div>
            </div>

            <div className="glass-card rounded-2xl p-6 border border-white/5 hover:border-orange-500/20 transition-all flex flex-col justify-between group">
              <div>
                <span className="text-xs font-bold text-orange-500">
                  ON THE HORIZON
                </span>
                <h3 className="text-lg font-bold text-white mt-2 group-hover:text-orange-500 transition-colors">
                  Institutional Integration
                </h3>
                <p className="text-xs text-slate-400 mt-2 font-semibold">
                  Exploring tools for sailing associations and regatta
                  organisers to streamline operations, driven by your feedback.
                </p>
                <ul className="mt-4 space-y-2 text-[11px] text-slate-400 font-semibold border-t border-white/5 pt-3">
                  <li className="flex items-start gap-1.5">
                    <span className="text-orange-500 mt-0.5">•</span>
                    <span>
                      <strong className="text-white">Shape the fleet</strong>:
                      Feature requests and roadmap input from the community.
                    </span>
                  </li>
                  <li className="flex items-start gap-1.5">
                    <span className="text-orange-500 mt-0.5">•</span>
                    <span>
                      <strong className="text-white">Regatta registration sync</strong>
                      : Pull official start lists and publish results.
                    </span>
                  </li>
                  <li className="flex items-start gap-1.5">
                    <span className="text-orange-500 mt-0.5">•</span>
                    <span>
                      <strong className="text-white">Campaign logistics planner</strong>
                      : Itineraries and budget tools for away regattas.
                    </span>
                  </li>
                </ul>
              </div>
              <div className="mt-6 flex h-8 w-8 items-center justify-center rounded-full bg-slate-900 border border-white/5 text-slate-500 text-xs font-bold">
                03
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Founding Membership */}
      <section
        id="founding-membership"
        className="py-16 sm:py-20 bg-[#090a0f] border-t border-white/5"
      >
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <div className="mx-auto max-w-3xl text-center mb-12 sm:mb-16">
            <h2 className="text-3xl font-extrabold text-white sm:text-4xl tracking-tight">
              Back the build. Anchor your legacy.
            </h2>
            <p className="mt-4 text-slate-400 max-w-2xl mx-auto leading-relaxed text-sm md:text-base">
              Become a founding supporter of SailorPath. Your one-time
              contribution helps build the definitive performance tracker for
              Singapore&apos;s youth sailors, unlocking permanent profile
              recognition and insider access.
            </p>
          </div>

          <div className="mx-auto max-w-md rounded-3xl border border-orange-500/20 bg-gradient-to-b from-[#131520] to-[#0d0f17] p-8 md:p-10 shadow-2xl relative overflow-hidden group hover:border-orange-500/40 transition-all duration-300">
            <div className="absolute top-0 right-0 w-32 h-32 bg-orange-600/10 rounded-full blur-2xl group-hover:bg-orange-600/20 transition-all" />

            <div className="flex justify-between items-center mb-6">
              <div>
                <h3 className="text-xl font-bold text-white">
                  Founding Supporter
                </h3>
                <p className="text-xs text-orange-400 font-semibold mt-1">
                  First 100 Members Only
                </p>
              </div>
              <span className="inline-flex items-center rounded-full bg-orange-500/10 px-3 py-1 text-xs font-bold text-orange-400 border border-orange-500/20">
                Limited
              </span>
            </div>

            <p className="text-4xl font-extrabold text-white tracking-tight flex items-baseline gap-1.5">
              $49
              <span className="text-xs font-bold text-slate-500">
                {" "}
                (One-time contribution)
              </span>
            </p>

            <ul className="mt-8 space-y-4 text-xs font-medium text-slate-300">
              <li className="flex items-start gap-3">
                <Trophy className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>
                  <strong className="text-white">Exclusive badge</strong>: A
                  permanent &apos;Founding Supporter&apos; crest on your public
                  profile.
                </span>
              </li>
              <li className="flex items-start gap-3">
                <Compass className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>
                  <strong className="text-white">Beta access</strong>: First
                  access to upcoming parent dashboards and advanced fleet
                  analytics.
                </span>
              </li>
              <li className="flex items-start gap-3">
                <Zap className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>
                  <strong className="text-white">Shape the fleet</strong>:
                  Priority voting rights on our feature development roadmap.
                </span>
              </li>
              <li className="flex items-start gap-3">
                <Shield className="h-4 w-4 text-orange-500 flex-shrink-0 mt-0.5" />
                <span>
                  <strong className="text-white">Premium themes</strong>:
                  Exclusive colour palettes to customize your digital trophy
                  cabinet.
                </span>
              </li>
            </ul>

            <div className="mt-8">
              <a
                href="https://buy.stripe.com/mock_founding_membership"
                target="_blank"
                rel="noreferrer"
                className="flex w-full justify-center rounded-full bg-orange-600 py-3 text-center text-sm font-bold text-white hover:bg-orange-500 transition-all hover:scale-[1.02] shadow-lg shadow-orange-950/20 border border-orange-500/30"
              >
                Back the Build
              </a>
              <p className="mt-3 text-center text-[10px] text-slate-600">
                Payment link is a placeholder until Stripe is connected.
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
