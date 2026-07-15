import Link from "next/link";
import { getSailors } from "@/lib/dbQueries";
import { DemoBanner } from "@/components/DemoBanner";
import { Trophy, Calendar, User, Compass, ArrowRight, Medal, Globe, ShieldAlert } from "lucide-react";

export default async function GoldSailorsPage() {
  const { data: sailors, isDemo } = await getSailors();

  // Filter to sailors who have a Gold Fleet entry date
  const goldSailors = sailors.filter((s) => s.goldEntryDate !== null);

  return (
    <div className="flex-1 bg-[#090a0f] py-12">
      <DemoBanner isDemo={isDemo} />
      
      <div className="mx-auto max-w-[95%] px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 border-b border-white/5 pb-8 mb-12">
          <div>
            <h1 className="text-3xl font-extrabold text-white sm:text-4xl tracking-tight flex items-center gap-3">
              <Trophy className="h-8 w-8 text-yellow-500" />
              All Gold Fleet Sailors
            </h1>
            <p className="mt-2 text-sm text-slate-400 max-w-2xl">
              Singapore Optimist Gold Fleet sailor register. Consolidates historical standings, squad selections, and international campaign representation histories.
            </p>
          </div>
          
          <div className="bg-[#131520] border border-white/5 px-6 py-3 rounded-2xl flex items-center gap-3">
            <span className="text-2xl font-black text-yellow-500">{goldSailors.length}</span>
            <span className="text-xs text-slate-400 font-bold uppercase tracking-wider">
              Total Gold<br />Sailors
            </span>
          </div>
        </div>

        {/* Scrollable Table Layout */}
        <div className="glass-panel rounded-3xl border border-white/5 overflow-hidden shadow-2xl">
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse text-xs min-w-[1400px]">
              <thead>
                {/* Multi-Header row for organization */}
                <tr className="border-b border-white/5 bg-slate-950/60 text-[9px] font-black text-slate-500 uppercase tracking-widest text-center">
                  <th colSpan={3} className="py-2 px-4 border-r border-white/5 text-left">Competitor</th>
                  <th colSpan={4} className="py-2 px-4 border-r border-white/5 bg-orange-600/5 text-orange-400">National Squad History</th>
                  <th colSpan={5} className="py-2 px-4 border-r border-white/5 bg-blue-600/5 text-blue-400">Historical Rankings</th>
                  <th colSpan={4} className="py-2 px-4 border-r border-white/5 bg-emerald-600/5 text-emerald-400">Representative campaigns (Year)</th>
                  <th colSpan={1} className="py-2 px-4">Profile</th>
                </tr>
                <tr className="border-b border-white/5 bg-white/5 text-[9px] font-extrabold text-slate-400 uppercase tracking-wider">
                  <th className="py-4 px-6 text-left">Sailor Name</th>
                  <th className="py-4 px-4 text-center">Sail Number</th>
                  <th className="py-4 px-4 text-center border-r border-white/5">Age/Gender</th>

                  <th className="py-4 px-4 text-center bg-orange-600/5">Jan 25</th>
                  <th className="py-4 px-4 text-center bg-orange-600/5">Jul 25</th>
                  <th className="py-4 px-4 text-center bg-orange-600/5">Jan 26</th>
                  <th className="py-4 px-4 text-center border-r border-white/5 bg-orange-600/5 text-orange-300">Jul 26 (Current)</th>

                  <th className="py-4 px-4 text-center bg-blue-600/5">Jun 24</th>
                  <th className="py-4 px-4 text-center bg-blue-600/5">Dec 24</th>
                  <th className="py-4 px-4 text-center bg-blue-600/5">Jun 25</th>
                  <th className="py-4 px-4 text-center bg-blue-600/5">Dec 25</th>
                  <th className="py-4 px-4 text-center border-r border-white/5 bg-blue-600/5">Jun 26</th>

                  <th className="py-4 px-4 text-center bg-emerald-600/5">Worlds</th>
                  <th className="py-4 px-4 text-center bg-emerald-600/5">European</th>
                  <th className="py-4 px-4 text-center bg-emerald-600/5">Asian</th>
                  <th className="py-4 px-4 text-center border-r border-white/5 bg-emerald-600/5">SEA Games</th>

                  <th className="py-4 px-6 text-center">Action</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-white/5 font-semibold text-slate-300">
                {goldSailors.map((sailor) => {
                  const birthYear = sailor.dob ? new Date(sailor.dob).getFullYear() : null;
                  const currentYear = new Date().getFullYear();
                  const age = birthYear ? currentYear - birthYear : "N/A";
                  const isDropped = sailor.dropDate !== null;

                  return (
                    <tr 
                      key={sailor.id} 
                      className={`hover:bg-white/5 transition-colors text-center ${
                        isDropped ? "opacity-60 bg-slate-950/20" : ""
                      }`}
                    >
                      {/* Name */}
                      <td className="py-4 px-6 text-left font-bold text-white">
                        <Link href={`/${sailor.handle}`} className="hover:text-orange-500 transition-colors">
                          {sailor.name}
                        </Link>
                      </td>
                      {/* Sail number */}
                      <td className="py-4 px-4 font-mono text-slate-400">{sailor.sailNumber}</td>
                      {/* Age / Gender */}
                      <td className="py-4 px-4 text-slate-400 border-r border-white/5">
                        {age} / {sailor.gender || "M"}
                      </td>

                      {/* Jan 25 */}
                      <td className="py-4 px-4 bg-orange-600/5">
                        <span className="text-[10px] text-slate-400">{sailor.natSquadStatusJan25 || "-"}</span>
                      </td>
                      {/* Jul 25 */}
                      <td className="py-4 px-4 bg-orange-600/5">
                        <span className="text-[10px] text-slate-400">{sailor.natSquadStatusJul25 || "-"}</span>
                      </td>
                      {/* Jan 26 */}
                      <td className="py-4 px-4 bg-orange-600/5">
                        <span className="text-[10px] text-slate-400">{sailor.natSquadStatusJan26 || "-"}</span>
                      </td>
                      {/* Jul 26 (Current) */}
                      <td className="py-4 px-4 border-r border-white/5 bg-orange-600/5">
                        {sailor.natSquadStatusJul26 ? (
                          <span className="rounded-full bg-orange-500/10 border border-orange-500/20 px-2 py-0.5 text-[10px] text-orange-400 font-extrabold">
                            {sailor.natSquadStatusJul26}
                          </span>
                        ) : (
                          <span className="text-slate-500">-</span>
                        )}
                      </td>

                      {/* Jun 24 */}
                      <td className="py-4 px-4 bg-blue-600/5 font-mono text-slate-400">{sailor.histRankingJun24 || "-"}</td>
                      {/* Dec 24 */}
                      <td className="py-4 px-4 bg-blue-600/5 font-mono text-slate-400">{sailor.histRankingDec24 || "-"}</td>
                      {/* Jun 25 */}
                      <td className="py-4 px-4 bg-blue-600/5 font-mono text-slate-400">{sailor.histRankingJun25 || "-"}</td>
                      {/* Dec 25 */}
                      <td className="py-4 px-4 bg-blue-600/5 font-mono text-slate-400">{sailor.histRankingDec25 || "-"}</td>
                      {/* Jun 26 */}
                      <td className="py-4 px-4 border-r border-white/5 bg-blue-600/5 font-mono font-bold text-white">
                        {sailor.histRankingJun26 || "-"}
                      </td>

                      {/* Worlds */}
                      <td className="py-4 px-4 bg-emerald-600/5 font-mono text-emerald-400">
                        {sailor.worlds || "-"}
                      </td>
                      {/* European */}
                      <td className="py-4 px-4 bg-emerald-600/5 font-mono text-emerald-400">
                        {sailor.european || "-"}
                      </td>
                      {/* Asian */}
                      <td className="py-4 px-4 bg-emerald-600/5 font-mono text-emerald-400">
                        {sailor.asian || "-"}
                      </td>
                      {/* SEA Games */}
                      <td className="py-4 px-4 border-r border-white/5 bg-emerald-600/5 font-mono text-emerald-400">
                        {sailor.seaGames || "-"}
                      </td>

                      {/* Action */}
                      <td className="py-4 px-6 text-center">
                        <Link
                          href={`/${sailor.handle}`}
                          className="inline-flex items-center gap-1.5 rounded-full bg-white/5 border border-white/10 hover:border-orange-500/40 px-3.5 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white transition-all"
                        >
                          Profile
                          <ArrowRight className="h-3 w-3" />
                        </Link>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>


      </div>
    </div>
  );
}
