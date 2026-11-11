import LoginFormWithSuspense from "./LoginForm";
import { isTelegramLoginConfigured } from "@/lib/telegram/config";

export const dynamic = "force-dynamic";

export default function LoginPage() {
  return <LoginFormWithSuspense telegramEnabled={isTelegramLoginConfigured()} />;
}
