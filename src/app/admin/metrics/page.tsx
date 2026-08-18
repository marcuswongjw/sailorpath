import { headers } from "next/headers";
import { notFound } from "next/navigation";
import { AdminMetricsGuide } from "@/components/admin/AdminMetricsGuide";
import { requireSuperadmin } from "@/lib/auth";

export const dynamic = "force-dynamic";

export const metadata = {
  title: "Key metrics | SailorPath Admin",
  description:
    "Playbook of KPIs SailorPath should track — definitions and why they matter.",
};

export default async function AdminMetricsPage() {
  const host = (await headers()).get("host") || "";
  const allowed =
    host.includes("admin.sailorpath.com") ||
    host.includes("localhost") ||
    host.includes("127.0.0.1");
  if (!allowed) notFound();

  try {
    await requireSuperadmin();
  } catch {
    notFound();
  }

  return <AdminMetricsGuide />;
}
