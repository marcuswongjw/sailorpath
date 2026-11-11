import { cookies } from "next/headers";
import { NextResponse, type NextRequest } from "next/server";
import { safeAuthNext } from "@/lib/supabase/cookie-options";
import { createServerSupabase } from "@/lib/supabase/server";
import { completeTelegramSignIn } from "@/lib/telegram/accounts";
import { isTelegramLoginConfigured, readTelegramConfig } from "@/lib/telegram/config";
import { verifyTelegramIdTokenFromIssuer } from "@/lib/telegram/jwks";
import {
  TELEGRAM_OIDC_COOKIE,
  TelegramOidcError,
  assertTelegramState,
  exchangeTelegramAuthorizationCode,
  openTelegramTransaction,
  type TelegramOidcTransaction,
} from "@/lib/telegram/oidc";
import { TelegramFlowError } from "@/lib/telegram/session";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

export async function GET(request: NextRequest) {
  const cookieStore = await cookies();
  const raw = cookieStore.get(TELEGRAM_OIDC_COOKIE)?.value ?? "";
  clearOidcCookie(cookieStore, request);

  if (!isTelegramLoginConfigured()) {
    return redirectLogin(request, "telegram_unavailable");
  }

  let tx: TelegramOidcTransaction;
  try {
    const { clientSecret } = readTelegramConfig();
    tx = openTelegramTransaction(raw, clientSecret, Math.floor(Date.now() / 1000));
    assertTelegramState(tx.state, request.nextUrl.searchParams.get("state"));
  } catch {
    return redirectLogin(request, "telegram_state");
  }

  const providerError = request.nextUrl.searchParams.get("error");
  if (providerError) {
    return redirectFlow(request, tx, providerError === "access_denied" ? "denied" : "token");
  }
  const code = request.nextUrl.searchParams.get("code");
  if (!code) return redirectFlow(request, tx, "token");

  try {
    const { clientId, clientSecret } = readTelegramConfig();
    const idToken = await exchangeTelegramAuthorizationCode({
      clientId,
      clientSecret,
      code,
      redirectUri: callbackUrl(request),
      codeVerifier: tx.verifier,
    });
    const claims = await verifyTelegramIdTokenFromIssuer(idToken, clientId, tx.nonce);
    const sessionUserId = await currentUserId(tx.mode);
    if (tx.mode === "link" && sessionUserId !== tx.userId) {
      return redirectFlow(request, tx, "state");
    }
    const outcome = await completeTelegramSignIn({
      mode: tx.mode,
      sessionUserId,
      claims,
    });
    if (outcome === "linked") return redirectNext(request, tx.next, "connected");
    return redirectNext(request, tx.next);
  } catch (error) {
    console.error("[telegram] sign-in failed", {
      code: error instanceof TelegramOidcError || error instanceof TelegramFlowError ? error.code : "unknown",
    });
    return redirectFlow(request, tx, flowCode(error));
  }
}

async function currentUserId(mode: TelegramOidcTransaction["mode"]): Promise<string | null> {
  if (mode !== "link") return null;
  try {
    const supabase = await createServerSupabase();
    const { data } = await supabase.auth.getUser();
    return data.user?.id ?? null;
  } catch {
    return null;
  }
}

function flowCode(error: unknown): string {
  if (error instanceof TelegramFlowError) return error.code === "signed-out" ? "state" : error.code;
  if (error instanceof TelegramOidcError) {
    return error.code === "state" ? "state" : "token";
  }
  return "token";
}

function callbackUrl(request: NextRequest): string {
  return `${request.nextUrl.origin}${request.nextUrl.pathname}`;
}

function clearOidcCookie(
  cookieStore: Awaited<ReturnType<typeof cookies>>,
  request: NextRequest
) {
  cookieStore.set(TELEGRAM_OIDC_COOKIE, "", {
    httpOnly: true,
    sameSite: "lax",
    secure: request.nextUrl.protocol === "https:",
    path: "/",
    maxAge: 0,
  });
}

function redirectLogin(request: NextRequest, code: string) {
  const url = new URL("/login", request.url);
  url.searchParams.set("error", code.startsWith("telegram_") ? code : `telegram_${code}`);
  return noStore(NextResponse.redirect(url));
}

function redirectFlow(request: NextRequest, tx: TelegramOidcTransaction, code: string) {
  if (tx.mode === "link") return redirectNext(request, tx.next, code);
  return redirectLogin(request, code);
}

function redirectNext(request: NextRequest, next: string, telegram?: string) {
  const safe = safeAuthNext(next, "/account", request.nextUrl.hostname);
  const destination = telegram ? withStatus(safe, telegram) : safe;
  const url = destination.startsWith("http") ? destination : new URL(destination, request.url);
  return noStore(NextResponse.redirect(url));
}

function withStatus(next: string, status: string): string {
  const hashAt = next.indexOf("#");
  const hash = hashAt >= 0 ? next.slice(hashAt) : "";
  const withoutHash = hashAt >= 0 ? next.slice(0, hashAt) : next;
  if (withoutHash.startsWith("http")) {
    const url = new URL(withoutHash);
    url.searchParams.set("telegram", status);
    return `${url.toString()}${hash}`;
  }
  const url = new URL(withoutHash || "/account", "https://sailorpath.com");
  url.searchParams.set("telegram", status);
  return `${url.pathname}${url.search}${hash || "#settings"}`;
}

function noStore(response: NextResponse): NextResponse {
  response.headers.set("Cache-Control", "private, no-store");
  return response;
}
