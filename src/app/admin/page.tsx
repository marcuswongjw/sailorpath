import { headers } from "next/headers";
import { notFound } from "next/navigation";
import { AdminDashboard } from "@/components/AdminDashboard";
import { AdminSignInGate } from "@/components/admin/AdminSignInGate";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { getAuthContext } from "@/lib/auth";
import {
  adminReturnUrl,
  isAdminHost,
  publicSiteOrigin,
} from "@/lib/adminHost";

export const dynamic = "force-dynamic";

export default async function AdminPage() {
  const host = (await headers()).get("host") || "";
  if (!isAdminHost(host)) notFound();

  // Don't serialize admin data before auth — client dashboard fetches after gate.
  const ctx = await getAuthContext();
  if (!ctx) {
    return (
      <AdminSignInGate
        reason="unsigned"
        nextUrl={adminReturnUrl(host, "/")}
        siteOrigin={publicSiteOrigin()}
      />
    );
  }
  if (ctx.role !== "superadmin") {
    // Signed in but not admin — stay quiet (no portal confirmation).
    notFound();
  }

  return (
    <ErrorBoundary>
      <AdminDashboard />
    </ErrorBoundary>
  );
}
