import Link from "next/link";
import { getRegattas } from "@/lib/dbQueries";
import { DemoBanner } from "@/components/DemoBanner";
import { Trophy, Calendar, Users, ChevronRight } from "lucide-react";

export default async function RegattasPage() {
  const response = await getRegattas();
  const regattasList = response.data;

  return (
    <div className="min-h-screen bg-[#090a0f] py-12 px-4 sm:px-6 lg:px-8">
      <DemoBanner isDemo={response.isDemo} />
      
      <div className="max-w-4xl mx-auto">
        {/* Page Header */}
        <div className="mb-10 text-center md:text-left">
          <h1 className="text-3xl font-black text-white tracking-tight flex items-center justify-center md:justify-start gap-2">
            <Trophy className="h-7 w-7 text-orange-500" />
            Ranking Regattas
          </h1>
          <p className="text-slate-400 text-sm mt-2">
            Browse through all ranking regattas and selection trials recorded in the Singapore Optimist circuit.
          </p>
        </div>

        {/* Regattas Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {regattasList.map((reg) => (
            <Link
              key={reg.id}
              href={`/sg/optimist/regattas/${reg.slug}`}
              className="block glass-card rounded-2xl p-6 border border-white/5 hover:border-orange-500/20 hover:scale-[1.01] transition-all group"
            >
              <div className="flex items-center justify-between">
                <div>
                  <h2 className="text-lg font-bold text-white group-hover:text-orange-500 transition-colors">
                    {reg.name}
                  </h2>
                  
                  <div className="mt-4 flex items-center gap-4 text-xs font-semibold text-slate-400">
                    <span className="flex items-center gap-1">
                      <Calendar className="h-3.5 w-3.5 text-orange-500" />
                      {reg.date}
                    </span>
                    <span className="flex items-center gap-1">
                      <Users className="h-3.5 w-3.5 text-orange-500" />
                      {reg.totalFleetSize} Sailors
                    </span>
                  </div>
                </div>

                <div className="h-8 w-8 rounded-full bg-slate-900 border border-white/5 flex items-center justify-center text-slate-400 group-hover:bg-orange-600 group-hover:text-white transition-all">
                  <ChevronRight className="h-4 w-4" />
                </div>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </div>
  );
}
