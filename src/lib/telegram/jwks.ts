import {
  TELEGRAM_JWKS_URL,
  TelegramOidcError,
  verifyTelegramIdToken,
  type TelegramIdTokenClaims,
} from "@/lib/telegram/oidc";

type Jwk = {
  kty?: string;
  kid?: string;
  alg?: string;
  n?: string;
  e?: string;
};

let cache: { keys: Jwk[]; expires: number } | null = null;

export function clearTelegramJwksCache(): void {
  cache = null;
}

export async function fetchTelegramJwks(
  fetchImpl: typeof fetch = fetch,
  now = Date.now()
): Promise<Jwk[]> {
  if (cache && cache.expires > now) return cache.keys;
  const response = await fetchImpl(TELEGRAM_JWKS_URL, {
    signal: AbortSignal.timeout(8_000),
    cache: "no-store",
  });
  const body = (await response.json().catch(() => null)) as { keys?: unknown } | null;
  if (!response.ok || !body || !Array.isArray(body.keys)) {
    throw new TelegramOidcError("token");
  }
  const keys = body.keys.filter((key): key is Jwk => Boolean(key) && typeof key === "object");
  cache = { keys, expires: now + 10 * 60 * 1000 };
  return keys;
}

export async function verifyTelegramIdTokenFromIssuer(
  token: string,
  clientId: string,
  nonce: string,
  fetchImpl: typeof fetch = fetch
): Promise<TelegramIdTokenClaims> {
  const verify = (keys: Jwk[]) =>
    verifyTelegramIdToken(token, { clientId, keys, nonce });
  try {
    return verify(await fetchTelegramJwks(fetchImpl));
  } catch (error) {
    if (!(error instanceof TelegramOidcError) || error.code !== "unknown_kid") throw error;
    clearTelegramJwksCache();
    return verify(await fetchTelegramJwks(fetchImpl));
  }
}
