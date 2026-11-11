import { cookies } from "next/headers";
import { NextResponse, type NextRequest } from "next/server";
import { safeAuthNext } from "@/lib/supabase/cookie-options";
import { createServerSupabase } from "@/lib/supabase/server";
import { isTelegramLoginConfigured, readTelegramConfig } from "@/lib/telegram/config";
import {
  TELEGRAM_OIDC_COOKIE,
  TELEGRAM_OIDC_MAX_AGE_SECONDS,
  createOidcNonce,
  createPkcePair,
  buildTelegramAuthorizeUrl,
  sealTelegramTransaction,
  telegramCallbackUrl,
  type TelegramOidcTransaction,
} from "@/lib/telegram/oidc";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

export async function GET(request: NextRequest) {
  if (request.headers.get("next-router-prefetch") || request.headers.get("purpose") === "prefetch") {
    return new NextResponse(null, { status: 204 });
  }
  const login = new URL("/login", request.url);
  if (!isTelegramLoginConfigured()) {
    login.searchParams.set("error", "telegram_unavailable");
    return noStore(NextResponse.redirect(login));
  }

  const mode = request.nextUrl.searchParams.get("mode") === "link" ? "link" : "login";
  const next = safeAuthNext(
    request.nextUrl.searchParams.get("next"),
    mode === "link" ? "/account#settings" : "/account",
    request.nextUrl.hostname
  );
  let userId: string | null = null;
  if (mode === "link") {
    try {
      const supabase = await createServerSupabase();
      const { data } = await supabase.auth.getUser();
      userId = data.user?.id ?? null;
    } catch {
      userId = null;
    }
    if (!userId) {
      const back = new URL("/login", request.url);
      back.searchParams.set("next", "/account#settings");
      return noStore(NextResponse.redirect(back));
    }
  }

  const { verifier, challenge } = createPkcePair();
  const state = createOidcNonce();
  const nonce = createOidcNonce();
  const tx: TelegramOidcTransaction = {
    v: 1,
    state,
    verifier,
    nonce,
    mode,
    userId,
    next,
    exp: Math.floor(Date.now() / 1000) + TELEGRAM_OIDC_MAX_AGE_SECONDS,
  };
  const { clientId, clientSecret } = readTelegramConfig();
  const sealed = sealTelegramTransaction(tx, clientSecret);
  const cookieStore = await cookies();
  cookieStore.set(TELEGRAM_OIDC_COOKIE, sealed, {
    httpOnly: true,
    sameSite: "lax",
    secure: request.nextUrl.protocol === "https:",
    path: "/",
    maxAge: TELEGRAM_OIDC_MAX_AGE_SECONDS,
  });

  const authorize = buildTelegramAuthorizeUrl({
    clientId,
    redirectUri: telegramCallbackUrl(request.url),
    state,
    codeChallenge: challenge,
    nonce,
  });
  return noStore(NextResponse.redirect(authorize));
}

function noStore(response: NextResponse): NextResponse {
  response.headers.set("Cache-Control", "private, no-store");
  return response;
}
