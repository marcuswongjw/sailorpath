import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Log in | SailorPath",
  description: "Log in to manage your SailorPath account and claimed sailor profiles.",
};

export default function LoginLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return children;
}
