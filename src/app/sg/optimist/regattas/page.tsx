import { getRegattas } from "@/lib/dbQueries";
import { DemoBanner } from "@/components/DemoBanner";
import { Trophy } from "lucide-react";
import { RegattasListClient } from "@/components/RegattasListClient";

export default async function RegattasPage() {
  const response = await getRegattas();
  const regattasList = response.data;

  return (
    <div className="min-h-screen bg-[#090a0f] py-12 px-4 sm:px-6 lg:px-8">
      <DemoBanner isDemo={response.isDemo} />
      
      <div className="max-w-4xl mx-auto space-y-10">
        {/* Page Header */}
        <div className="text-center md:text-left">
          <h1 className="text-3xl font-black text-white tracking-tight flex items-center justify-center md:justify-start gap-2">
            <Trophy className="h-7 w-7 text-orange-500" />
            Ranking Regattas
          </h1>
          <p className="text-slate-400 text-sm mt-2">
            Browse through all ranking regattas and selection trials recorded in the Singapore Optimist circuit.
          </p>
        </div>

        {/* Interactive Client List with Tabs */}
        <RegattasListClient initialRegattas={regattasList} />
      </div>
    </div>
  );
}
