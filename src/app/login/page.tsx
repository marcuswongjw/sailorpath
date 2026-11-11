import LoginFormWithSuspense from "./LoginForm";
import { isGoogleAuthEnabled } from "@/lib/google/auth";
import { isTelegramLoginConfigured } from "@/lib/telegram/config";

export const dynamic = "force-dynamic";

export default function LoginPage() {
  return (
    <LoginFormWithSuspense
      googleEnabled={isGoogleAuthEnabled()}
      telegramEnabled={isTelegramLoginConfigured()}
    />
  );
}
