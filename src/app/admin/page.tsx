import { headers } from "next/headers";
import { notFound } from "next/navigation";
import { AdminDashboard } from "@/components/AdminDashboard";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { requireSuperadmin } from "@/lib/auth";

export const dynamic = "force-dynamic";

export default async function AdminPage() {
  const host = (await headers()).get("host") || "";
  const allowed =
    host.includes("admin.sailorpath.com") ||
    host.includes("localhost") ||
    host.includes("127.0.0.1");
  if (!allowed) notFound();
  // This page is the data boundary for the admin portal. The dashboard is a
  // client component, so passing records here would serialize the full admin
  // dataset to every visitor before client-side role checks can run.
  try {
    await requireSuperadmin();
  } catch {
    // Avoid confirming that an admin portal exists to non-admin accounts.
    notFound();
  }

  return (
    <ErrorBoundary>
      <AdminDashboard />
    </ErrorBoundary>
  );
}
