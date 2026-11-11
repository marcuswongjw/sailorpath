import { NextResponse } from "next/server";
import { isTelegramBotConfigured, readTelegramBotConfig } from "@/lib/telegram/bot/config";
import { telegramWebhookAuthorized } from "@/lib/telegram/bot/message";
import { postTelegramMessage } from "@/lib/telegram/bot/deliver";
import { parseTelegramUpdate } from "@/lib/telegram/bot/update";
import {
  consumeTelegramStartToken,
  subscribeChat,
  unsubscribeChat,
} from "@/lib/telegram/bot/store";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

export async function POST(request: Request) {
  if (!isTelegramBotConfigured()) {
    return NextResponse.json({ error: "Not found" }, { status: 404 });
  }
  const { token, webhookSecret } = readTelegramBotConfig();
  if (!telegramWebhookAuthorized(request.headers.get("x-telegram-bot-api-secret-token"), webhookSecret)) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const update = await request.json().catch(() => null);
  const event = parseTelegramUpdate(update);
  if (event.type === "ignore") return NextResponse.json({ ok: true });
  if (event.type === "blocked" || event.type === "stop") {
    await unsubscribeChat(event.chatId, event.type === "blocked");
    if (event.type === "stop") {
      await postTelegramMessage({
        token,
        chatId: event.chatId,
        html: "SailorPath updates are off. You can turn them on again from Account settings.",
      });
    }
    return NextResponse.json({ ok: true });
  }
  const userId = await consumeTelegramStartToken(event.token);
  if (!userId) {
    await postTelegramMessage({
      token,
      chatId: event.chatId,
      html: "That link has expired. Open Account settings on SailorPath and try again.",
    });
    return NextResponse.json({ ok: true });
  }
  const result = await subscribeChat({
    userId,
    chatId: event.chatId,
    telegramUserId: event.telegramUserId,
    username: event.username,
    displayName: event.displayName,
  });
  await postTelegramMessage({
    token,
    chatId: event.chatId,
    html:
      result === "subscribed"
        ? "SailorPath updates are on. Send /stop any time to turn them off."
        : "This Telegram chat is already connected to another SailorPath account.",
  });
  return NextResponse.json({ ok: true });
}
