import LoginFormWithSuspense from "./LoginForm";
import { isTelegramBotConfigured } from "@/lib/telegram/bot/config";
import { isTelegramLoginConfigured } from "@/lib/telegram/config";

export const dynamic = "force-dynamic";

export default function LoginPage() {
  return (
    <LoginFormWithSuspense
      telegramEnabled={isTelegramLoginConfigured()}
      telegramBotEnabled={isTelegramBotConfigured()}
    />
  );
}
