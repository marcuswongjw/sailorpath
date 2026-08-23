import type { Metadata } from "next";
import { ResetPasswordForm } from "./ResetPasswordForm";

export const metadata: Metadata = {
  title: "Choose a new password | SailorPath",
  description: "Securely update your SailorPath account password.",
};

export default function ResetPasswordPage() {
  return <ResetPasswordForm />;
}
