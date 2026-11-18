import { NextResponse } from "next/server";
import { isTelegramBotConfigured, readTelegramBotConfig } from "@/lib/telegram/bot/config";
import { telegramWebhookAuthorized } from "@/lib/telegram/bot/message";
import { postTelegramMessage } from "@/lib/telegram/bot/deliver";
import { parseTelegramUpdate } from "@/lib/telegram/bot/update";
import { rankingsMessage, regattasMessage, sailorSearchMessage, welcomeMessage } from "@/lib/telegram/bot/discovery";
import { unifiedSearch } from "@/lib/search";
import { rateLimitAsync } from "@/lib/rateLimit";
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
  if (event.type === "welcome" || event.type === "rankings" || event.type === "regattas" || event.type === "find") {
    let html: string;
    if (event.type === "find") {
      if (!event.query || event.query.length > 100) {
        html = sailorSearchMessage(event.query, []);
      } else if (!(await rateLimitAsync(`telegram-search:${event.chatId}`, 20, 60_000)).ok) {
        html = "Please wait a little before searching again.";
      } else {
        try {
          const results = await unifiedSearch(event.query, { type: "sailors", limit: 5 });
          html = sailorSearchMessage(event.query, results.sailors);
        } catch {
          html = "Sailor search is temporarily unavailable. Please try again later.";
        }
      }
    } else {
      html = event.type === "welcome" ? welcomeMessage : event.type === "rankings" ? rankingsMessage : regattasMessage;
    }
    await postTelegramMessage({ token, chatId: event.chatId, html });
    return NextResponse.json({ ok: true });
  }
  if (event.type !== "start") return NextResponse.json({ ok: true });
  const userId = event.token.length <= 64 && !/\s/.test(event.token) ? await consumeTelegramStartToken(event.token) : null;
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
