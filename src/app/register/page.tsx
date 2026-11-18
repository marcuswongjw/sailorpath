import RegisterFormWithSuspense from "./RegisterForm";
import { isGoogleAuthEnabled } from "@/lib/google/auth";
import { isTelegramBotConfigured } from "@/lib/telegram/bot/config";
import { isTelegramLoginConfigured } from "@/lib/telegram/config";

export const dynamic = "force-dynamic";

export default function RegisterPage() {
  return (
    <RegisterFormWithSuspense
      googleEnabled={isGoogleAuthEnabled()}
      telegramEnabled={isTelegramLoginConfigured()}
      telegramBotEnabled={isTelegramBotConfigured()}
    />
  );
}
