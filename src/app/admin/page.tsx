import { headers } from "next/headers";
import { notFound } from "next/navigation";
import { AdminDashboard } from "@/components/AdminDashboard";
import { DbOffline } from "@/components/DbOffline";
import { listSailors, listRegattas, listResults } from "@/lib/queries";
import { DbUnavailableError } from "@/db";

export const dynamic = "force-dynamic";

export default async function AdminPage() {
  const host = (await headers()).get("host") || "";
  const allowed =
    host.includes("admin.sailorpath.com") ||
    host.includes("localhost") ||
    host.includes("127.0.0.1");
  if (!allowed) notFound();

  try {
    const [sailors, regattas, results] = await Promise.all([
      listSailors(),
      listRegattas(),
      listResults(),
    ]);

    return (
      <AdminDashboard
        initialSailors={sailors}
        initialRegattas={regattas}
        initialResults={results}
      />
    );
  } catch (e) {
    return (
      <DbOffline
        message={
          e instanceof DbUnavailableError
            ? e.message
            : "Cannot load admin without database"
        }
      />
    );
  }
}
