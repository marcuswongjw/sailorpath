import { headers } from "next/headers";
import { notFound } from "next/navigation";
import { AdminDashboard } from "@/components/AdminDashboard";
import { DbOffline } from "@/components/DbOffline";
import {
  listSailorsFull,
  listRegattasFull,
  listResults,
} from "@/lib/queries";
import { DbUnavailableError } from "@/db";

export const dynamic = "force-dynamic";

export default async function AdminPage() {
  const host = (await headers()).get("host") || "";
  const allowed =
    host.includes("admin.sailorpath.com") ||
    host.includes("localhost") ||
    host.includes("127.0.0.1");
  if (!allowed) notFound();

  let sailors;
  let regattas;
  let results;
  let errorMsg: string | null = null;

  try {
    const [s, r, res] = await Promise.all([
      listSailorsFull(),
      listRegattasFull(),
      listResults(),
    ]);
    sailors = s;
    regattas = r;
    results = res;
  } catch (e) {
    errorMsg =
      e instanceof DbUnavailableError
        ? e.message
        : "Cannot load admin without database";
  }

  if (errorMsg || !sailors || !regattas || !results) {
    return <DbOffline message={errorMsg || "Database load error"} />;
  }

  return (
    <AdminDashboard
      initialSailors={sailors}
      initialRegattas={regattas}
      initialResults={results}
    />
  );
}
