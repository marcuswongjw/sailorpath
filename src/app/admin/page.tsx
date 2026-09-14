import { headers } from "next/headers";
import { notFound, redirect } from "next/navigation";
import { AdminDashboard } from "@/components/AdminDashboard";
import { AdminSignInGate } from "@/components/admin/AdminSignInGate";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { getAuthContext } from "@/lib/auth";
import {
  adminLoginOrigin,
  adminReturnUrl,
  isAdminHost,
} from "@/lib/adminHost";

export const dynamic = "force-dynamic";

export default async function AdminPage() {
  const host = (await headers()).get("host") || "";

  // If accessed directly on public sailorpath.com domain, redirect to canonical admin subdomain
  if (
    host.includes("sailorpath.com") &&
    !host.includes("admin.sailorpath.com")
  ) {
    redirect("https://admin.sailorpath.com/");
  }

  if (!isAdminHost(host)) notFound();

  // Don't serialize admin data before auth — client dashboard fetches after gate.
  const ctx = await getAuthContext();
  if (!ctx) {
    return (
      <AdminSignInGate
        reason="unsigned"
        nextUrl={adminReturnUrl(host, "/")}
        siteOrigin={adminLoginOrigin(host)}
      />
    );
  }
  if (ctx.role !== "superadmin") {
    return (
      <AdminSignInGate
        reason="forbidden"
        nextUrl={adminReturnUrl(host, "/")}
        siteOrigin={adminLoginOrigin(host)}
      />
    );
  }

  return (
    <ErrorBoundary>
      <AdminDashboard />
    </ErrorBoundary>
  );
}
