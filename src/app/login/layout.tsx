import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Log in or sign up | SailorPath",
  description: "Log in to SailorPath, or create an account with Google, Telegram, or email.",
};

export default function LoginLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return children;
}
