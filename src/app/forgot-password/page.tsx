import type { Metadata } from "next";
import { ForgotPasswordForm } from "./ForgotPasswordForm";

export const metadata: Metadata = {
  title: "Reset password | SailorPath",
  description: "Request a secure SailorPath password reset link.",
};

export default function ForgotPasswordPage() {
  return <ForgotPasswordForm />;
}
