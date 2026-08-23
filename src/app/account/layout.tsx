import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "My account | SailorPath",
  description: "Manage your SailorPath account, profile claims, and security settings.",
};

export default function AccountLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return children;
}
