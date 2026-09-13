import { headers } from "next/headers";
import { notFound } from "next/navigation";
import { AdminMetricsGuide } from "@/components/admin/AdminMetricsGuide";
import { AdminSignInGate } from "@/components/admin/AdminSignInGate";
import { getAuthContext } from "@/lib/auth";
import {
  adminLoginOrigin,
  adminReturnUrl,
  isAdminHost,
} from "@/lib/adminHost";

export const dynamic = "force-dynamic";

export const metadata = {
  title: "Key metrics | SailorPath Admin",
  description:
    "Playbook of KPIs SailorPath should track — definitions and why they matter.",
};

export default async function AdminMetricsPage() {
  const host = (await headers()).get("host") || "";
  if (!isAdminHost(host)) notFound();

  const ctx = await getAuthContext();
  if (!ctx) {
    return (
      <AdminSignInGate
        reason="unsigned"
        nextUrl={adminReturnUrl(host, "/admin/metrics")}
        siteOrigin={adminLoginOrigin(host)}
      />
    );
  }
  if (ctx.role !== "superadmin") {
    notFound();
  }

  return <AdminMetricsGuide />;
}
