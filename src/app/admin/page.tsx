import { getSailors, getRegattas, getRegattaResults } from "@/lib/dbQueries";
import { AdminDashboard } from "@/components/AdminDashboard";
import { DemoBanner } from "@/components/DemoBanner";
import { headers } from "next/headers";
import { notFound } from "next/navigation";

export default async function AdminPage() {
  const host = (await headers()).get("host") || "";
  
  // Enforce admin subdomain checks (allowing local dev hostnames)
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

  return (
    <div className="flex-1 flex flex-col bg-[#090a0f]">
      <DemoBanner isDemo={isDemo} />
      <AdminDashboard 
        initialSailors={sailorsRes.data} 
        initialRegattas={regattasRes.data}
        initialResults={resultsRes.data}
        isDemo={isDemo} 
      />
    </div>
  );
}
