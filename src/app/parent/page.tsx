import { ParentDashboard } from "@/components/ParentDashboard";

export const dynamic = "force-dynamic";

export const metadata = {
  title: "Parent dashboard | SailorPath",
  description:
    "Manage linked sailor profiles, rankings, and claim status on SailorPath.",
};

export default function ParentPage() {
  return <ParentDashboard />;
}
