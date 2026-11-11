import { NextResponse } from "next/server";
import { getAuthContext, jsonError } from "@/lib/auth";
import { isTelegramBotConfigured, readTelegramBotConfig, telegramBotLink } from "@/lib/telegram/bot/config";
import { createTelegramStartToken, unsubscribeUser } from "@/lib/telegram/bot/store";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

export async function POST(request: Request) {
  try {
    if (!isTelegramBotConfigured()) {
      return NextResponse.json({ error: "Telegram updates are not available." }, { status: 404 });
    }
    const auth = await getAuthContext();
    if (!auth) return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    const body = (await request.json().catch(() => ({}))) as { action?: string };
    if (body.action === "stop") {
      await unsubscribeUser(auth.userId);
      return NextResponse.json({ ok: true, optedIn: false });
    }
    const token = await createTelegramStartToken(auth.userId);
    const { username } = readTelegramBotConfig();
    return NextResponse.json({ ok: true, url: telegramBotLink(username, token) });
  } catch (error) {
    return jsonError(error);
  }
}
