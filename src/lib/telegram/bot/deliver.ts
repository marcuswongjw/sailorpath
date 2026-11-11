import { isTelegramBotConfigured, readTelegramBotConfig } from "@/lib/telegram/bot/config";
import { isTelegramBlockedError, toTelegramHtml } from "@/lib/telegram/bot/message";
import { shouldSendTelegramAlert } from "@/lib/telegram/bot/audience";
import { eq } from "drizzle-orm";
import { db } from "@/db";
import { telegramSubscriptions } from "@/db/schema";
import {
  finishBroadcastIfDone,
  markDelivery,
  nextBroadcastBatch,
  unsubscribeUser,
} from "@/lib/telegram/bot/store";

export const TELEGRAM_BROADCAST_BATCH = 15;

export async function postTelegramMessage(input: {
  token: string;
  chatId: string;
  html: string;
  buttonLabel?: string | null;
  buttonUrl?: string | null;
}): Promise<{ ok: true } | { ok: false; blocked: boolean; description: string }> {
  const replyMarkup =
    input.buttonLabel && input.buttonUrl
      ? { inline_keyboard: [[{ text: input.buttonLabel, url: input.buttonUrl }]] }
      : undefined;
  const response = await fetch(`https://api.telegram.org/bot${input.token}/sendMessage`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      chat_id: input.chatId,
      text: input.html,
      parse_mode: "HTML",
      reply_markup: replyMarkup,
    }),
    signal: AbortSignal.timeout(8_000),
  });
  const body = (await response.json().catch(() => null)) as { ok?: boolean; description?: string } | null;
  if (response.ok && body?.ok) return { ok: true };
  const description = body?.description || `HTTP ${response.status}`;
  return { ok: false, blocked: isTelegramBlockedError(response.status, description), description };
}

export async function deliverBroadcastBatch(broadcastId: string) {
  if (!isTelegramBotConfigured()) throw new Error("Telegram bot is not configured");
  const batch = await nextBroadcastBatch(broadcastId, TELEGRAM_BROADCAST_BATCH);
  if (!batch) return null;
  const { token } = readTelegramBotConfig();
  const html = toTelegramHtml(batch.broadcast.body);
  for (const delivery of batch.pending) {
    let status: "sent" | "failed" | "blocked" = "failed";
    let error: string | undefined;
    try {
      const result = await postTelegramMessage({
        token,
        chatId: delivery.chatId,
        html,
        buttonLabel: batch.broadcast.buttonLabel,
        buttonUrl: batch.broadcast.buttonUrl,
      });
      if (result.ok) status = "sent";
      else if (result.blocked) {
        status = "blocked";
        error = result.description;
      } else error = result.description;
    } catch (sendError) {
      error = sendError instanceof Error ? sendError.message : "send failed";
    }
    await markDelivery({
      deliveryId: delivery.id,
      broadcastId,
      userId: delivery.userId,
      status,
      error: error?.slice(0, 200),
    });
    await new Promise((resolve) => setTimeout(resolve, 40));
  }
  const progress = await finishBroadcastIfDone(broadcastId);
  return progress;
}

/**
 * One opted-in chat. Result publishing can call this later for
 * "new results published for your sailor" without going through a broadcast.
 */
export async function sendTelegramAlert(input: {
  userId: string;
  text: string;
  buttonLabel?: string;
  buttonUrl?: string;
}): Promise<"sent" | "skipped" | "blocked" | "failed"> {
  if (!isTelegramBotConfigured()) return "skipped";
  const [subscription] = await db
    .select({
      optedIn: telegramSubscriptions.optedIn,
      blockedAt: telegramSubscriptions.blockedAt,
      chatId: telegramSubscriptions.chatId,
    })
    .from(telegramSubscriptions)
    .where(eq(telegramSubscriptions.userId, input.userId))
    .limit(1);
  if (!shouldSendTelegramAlert(subscription ?? null) || !subscription?.chatId) return "skipped";
  const { token } = readTelegramBotConfig();
  const result = await postTelegramMessage({
    token,
    chatId: subscription.chatId,
    html: toTelegramHtml(input.text),
    buttonLabel: input.buttonLabel,
    buttonUrl: input.buttonUrl,
  });
  if (result.ok) return "sent";
  if (result.blocked) {
    await unsubscribeUser(input.userId);
    return "blocked";
  }
  return "failed";
}
