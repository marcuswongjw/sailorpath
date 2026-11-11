import { NextResponse } from "next/server";
import { getAuthContext, jsonError } from "@/lib/auth";
import { isMissingTelegramIdentitiesError, unlinkTelegram } from "@/lib/telegram/accounts";
import { isTelegramLoginConfigured } from "@/lib/telegram/config";
import { canDisconnectTelegram } from "@/lib/telegram/email";
import { TelegramFlowError } from "@/lib/telegram/session";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

export async function DELETE() {
  try {
    const auth = await getAuthContext();
    if (!auth) return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    if (!isTelegramLoginConfigured()) {
      return NextResponse.json({ error: "Telegram sign-in is unavailable." }, { status: 404 });
    }
    if (!canDisconnectTelegram(auth.email)) {
      return NextResponse.json(
        {
          error:
            "This account signs in with Telegram only. Disconnecting it would lock you out.",
        },
        { status: 409 }
      );
    }
    try {
      await unlinkTelegram(auth.userId);
    } catch (error) {
      if (isMissingTelegramIdentitiesError(error)) {
        return NextResponse.json({ error: "Telegram sign-in is unavailable." }, { status: 503 });
      }
      throw error;
    }
    return NextResponse.json({
      ok: true,
      telegram: { enabled: true, linked: false, username: null, canDisconnect: false },
    });
  } catch (error) {
    if (error instanceof TelegramFlowError) {
      return NextResponse.json({ error: "Could not disconnect Telegram." }, { status: 500 });
    }
    return jsonError(error);
  }
}
