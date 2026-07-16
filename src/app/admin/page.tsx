import { getSailors, getRegattas, getRegattaResults } from "@/lib/dbQueries";
import { AdminDashboard } from "@/components/AdminDashboard";
import { DemoBanner } from "@/components/DemoBanner";
import { headers } from "next/headers";
import { notFound } from "next/navigation";
import { getAuthContext } from "@/lib/auth";

export default async function AdminPage() {
  const host = (await headers()).get("host") || "";

  const isAdminHost =
    host.includes("admin.sailorpath.com") ||
    host.includes("localhost") ||
    host.includes("127.0.0.1");

  if (!isAdminHost) {
    notFound();
  }

  const [sailorsRes, regattasRes, resultsRes] = await Promise.all([
    getSailors(),
    getRegattas(),
    getRegattaResults(),
  ]);

  const isDemo = sailorsRes.isDemo || regattasRes.isDemo || resultsRes.isDemo;
  const auth = await getAuthContext();

  // When DB is live, only superadmins may open the full admin UI
  if (!isDemo && auth && auth.role !== "superadmin") {
    return (
      <div className="flex-1 flex flex-col items-center justify-center bg-[#090a0f] px-4 py-20">
        <div className="max-w-md rounded-3xl border border-red-500/20 bg-red-500/10 p-8 text-center">
          <h1 className="text-xl font-black text-white">Forbidden</h1>
          <p className="mt-2 text-sm text-red-200/80">
            Superadmin role required. Your role: <strong>{auth.role}</strong>
          </p>
          <a href="/" className="mt-4 inline-block text-xs font-bold text-orange-400">
            ← Home
          </a>
        </div>
      </div>
    );
  }

  return (
    <div className="flex-1 flex flex-col bg-[#090a0f]">
      <DemoBanner isDemo={isDemo} />
      {isDemo && (
        <div className="mx-auto max-w-7xl w-full px-4 pt-4">
          <p className="rounded-xl border border-amber-500/30 bg-amber-500/10 px-4 py-3 text-xs text-amber-200">
            Demo / DB offline mode: admin UI is simulated. Writes will fail until DATABASE_URL works
            and your <code className="text-amber-100">profiles.role</code> is{" "}
            <code className="text-amber-100">superadmin</code>.
          </p>
        </div>
      )}
      <AdminDashboard
        initialSailors={sailorsRes.data}
        initialRegattas={regattasRes.data}
        initialResults={resultsRes.data}
        isDemo={isDemo}
      />
    </div>
  );
}
