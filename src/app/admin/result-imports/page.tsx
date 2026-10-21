import { headers } from "next/headers";
import { notFound, redirect } from "next/navigation";
import { getAuthContext } from "@/lib/auth";
import { adminLoginOrigin, adminReturnUrl, isAdminHost } from "@/lib/adminHost";
import { AdminSignInGate } from "@/components/admin/AdminSignInGate";
import { ResultsImportInbox } from "@/components/admin/ResultsImportInbox";

export const dynamic = "force-dynamic";
export default async function ResultsImportsPage() {
  const host = (await headers()).get("host") || "";
  if (host.includes("sailorpath.com") && !host.includes("admin.sailorpath.com")) redirect("https://admin.sailorpath.com/admin/result-imports");
  if (!isAdminHost(host)) notFound();
  const gate = (reason: "unavailable" | "unsigned" | "forbidden") => <AdminSignInGate reason={reason} nextUrl={adminReturnUrl(host, "/admin/result-imports")} siteOrigin={adminLoginOrigin(host)} />;
  let auth;
  try { auth = await getAuthContext(); } catch { return gate("unavailable"); }
  if (!auth) return gate("unsigned");
  if (auth.role !== "superadmin") return gate("forbidden");
  return <ResultsImportInbox />;
}
