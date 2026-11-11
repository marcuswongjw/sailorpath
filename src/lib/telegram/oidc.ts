import {
  createHash,
  createHmac,
  createPublicKey,
  createVerify,
  randomBytes,
  timingSafeEqual,
} from "node:crypto";

export const TELEGRAM_ISSUER = "https://oauth.telegram.org";
export const TELEGRAM_AUTHORIZE_URL = "https://oauth.telegram.org/auth";
export const TELEGRAM_TOKEN_URL = "https://oauth.telegram.org/token";
export const TELEGRAM_JWKS_URL = "https://oauth.telegram.org/.well-known/jwks.json";
export const TELEGRAM_CALLBACK_PATH = "/auth/telegram/callback";
export const TELEGRAM_SCOPES = "openid profile";
export const TELEGRAM_OIDC_COOKIE = "sp_telegram_oidc";
export const TELEGRAM_OIDC_MAX_AGE_SECONDS = 600;

export type TelegramOidcCode =
  | "state"
  | "signature"
  | "audience"
  | "expired"
  | "issuer"
  | "claims"
  | "algorithm"
  | "unknown_kid"
  | "token";

export class TelegramOidcError extends Error {
  readonly code: TelegramOidcCode;

  constructor(code: TelegramOidcCode) {
    super(code);
    this.name = "TelegramOidcError";
    this.code = code;
  }
}

export type TelegramIdTokenClaims = {
  sub: string;
  name: string | null;
  username: string | null;
  picture: string | null;
  telegramUserId: string | null;
};

type RsaJwk = {
  kty?: string;
  kid?: string;
  alg?: string;
  n?: string;
  e?: string;
};

export function createPkcePair(): { verifier: string; challenge: string } {
  const verifier = randomBytes(32).toString("base64url");
  const challenge = createHash("sha256").update(verifier).digest("base64url");
  return { verifier, challenge };
}

export function createOidcNonce(): string {
  return randomBytes(32).toString("base64url");
}

export function telegramCallbackUrl(requestUrl: string): string {
  const url = new URL(requestUrl);
  return `${url.origin}${TELEGRAM_CALLBACK_PATH}`;
}

/** Authorization request. Profile by default. Bot messages are an extra, optional scope. */
export function telegramAuthorizeScopes(botAccess: boolean): string {
  return botAccess ? `${TELEGRAM_SCOPES} telegram:bot_access` : TELEGRAM_SCOPES;
}

export function buildTelegramAuthorizeUrl(input: {
  clientId: string;
  redirectUri: string;
  state: string;
  codeChallenge: string;
  nonce: string;
  botAccess?: boolean;
}): string {
  const url = new URL(TELEGRAM_AUTHORIZE_URL);
  url.searchParams.set("client_id", input.clientId);
  url.searchParams.set("redirect_uri", input.redirectUri);
  url.searchParams.set("response_type", "code");
  url.searchParams.set("scope", telegramAuthorizeScopes(input.botAccess === true));
  url.searchParams.set("state", input.state);
  url.searchParams.set("code_challenge", input.codeChallenge);
  url.searchParams.set("code_challenge_method", "S256");
  url.searchParams.set("nonce", input.nonce);
  return url.toString();
}

export function buildTelegramTokenRequest(input: {
  clientId: string;
  clientSecret: string;
  code: string;
  redirectUri: string;
  codeVerifier: string;
}): { url: string; headers: Record<string, string>; body: string } {
  const body = new URLSearchParams({
    grant_type: "authorization_code",
    code: input.code,
    redirect_uri: input.redirectUri,
    client_id: input.clientId,
    code_verifier: input.codeVerifier,
  });
  const basic = Buffer.from(`${input.clientId}:${input.clientSecret}`, "utf8").toString("base64");
  return {
    url: TELEGRAM_TOKEN_URL,
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      Accept: "application/json",
      Authorization: `Basic ${basic}`,
    },
    body: body.toString(),
  };
}

export async function exchangeTelegramAuthorizationCode(
  input: {
    clientId: string;
    clientSecret: string;
    code: string;
    redirectUri: string;
    codeVerifier: string;
  },
  fetchImpl: typeof fetch = fetch
): Promise<string> {
  if (input.code.length < 1 || input.code.length > 2048) {
    throw new TelegramOidcError("token");
  }
  const request = buildTelegramTokenRequest(input);
  const response = await fetchImpl(request.url, {
    method: "POST",
    headers: request.headers,
    body: request.body,
    signal: AbortSignal.timeout(8_000),
    cache: "no-store",
  });
  const payload = (await response.json().catch(() => null)) as { id_token?: unknown } | null;
  if (!response.ok || !payload || typeof payload.id_token !== "string" || payload.id_token.length > 16_000) {
    throw new TelegramOidcError("token");
  }
  return payload.id_token;
}

export function verifyTelegramIdToken(
  token: string,
  options: {
    clientId: string;
    keys: readonly RsaJwk[];
    now?: number;
    clockSkewSeconds?: number;
    nonce?: string;
  }
): TelegramIdTokenClaims {
  if (!options.clientId || token.length < 1 || token.length > 16_000) {
    throw new TelegramOidcError("claims");
  }
  const parts = token.split(".");
  if (parts.length !== 3 || !parts[0] || !parts[1] || parts[2] === undefined) {
    throw new TelegramOidcError("claims");
  }
  const [headerPart, payloadPart, signaturePart] = parts;
  const header = decodeJson(headerPart);
  if (!header || header.crit) throw new TelegramOidcError("algorithm");
  if (header.alg !== "RS256") throw new TelegramOidcError("algorithm");
  if (header.typ !== undefined && String(header.typ).toLowerCase() !== "jwt") {
    throw new TelegramOidcError("algorithm");
  }

  const jwk = selectRsaKey(options.keys, header.kid);
  let key;
  try {
    key = createPublicKey({ key: { kty: "RSA", n: jwk.n, e: jwk.e }, format: "jwk" });
  } catch {
    throw new TelegramOidcError("signature");
  }
  const verifier = createVerify("RSA-SHA256");
  verifier.update(`${headerPart}.${payloadPart}`);
  verifier.end();
  let valid = false;
  try {
    valid = verifier.verify(key, Buffer.from(signaturePart, "base64url"));
  } catch {
    valid = false;
  }
  if (!valid) throw new TelegramOidcError("signature");

  const payload = decodeJson(payloadPart);
  if (!payload) throw new TelegramOidcError("claims");
  if (payload.iss !== TELEGRAM_ISSUER) throw new TelegramOidcError("issuer");
  if (!audienceValues(payload.aud).includes(options.clientId)) {
    throw new TelegramOidcError("audience");
  }

  const nowSeconds = options.now ?? Math.floor(Date.now() / 1000);
  const skew = options.clockSkewSeconds ?? 60;
  if (typeof payload.exp !== "number" || !Number.isFinite(payload.exp) || payload.exp > 10_000_000_000) {
    throw new TelegramOidcError("claims");
  }
  if (nowSeconds > payload.exp + skew) throw new TelegramOidcError("expired");
  if (
    typeof payload.iat === "number" &&
    Number.isFinite(payload.iat) &&
    payload.iat > nowSeconds + skew
  ) {
    throw new TelegramOidcError("claims");
  }
  if (typeof payload.sub !== "string" || !/^[A-Za-z0-9_-]{1,128}$/.test(payload.sub)) {
    throw new TelegramOidcError("claims");
  }
  if (options.nonce && payload.nonce !== undefined) {
    if (typeof payload.nonce !== "string" || !safeEqual(options.nonce, payload.nonce)) {
      throw new TelegramOidcError("claims");
    }
  }

  const given = [payload.given_name, payload.family_name]
    .filter((part): part is string => typeof part === "string")
    .join(" ");
  return {
    sub: payload.sub,
    name: cleanName(payload.name) || cleanName(given),
    username: cleanUsername(payload.preferred_username),
    picture: cleanPicture(payload.picture),
    telegramUserId: cleanTelegramUserId(payload.id),
  };
}

export type TelegramOidcTransaction = {
  v: 1;
  state: string;
  verifier: string;
  nonce: string;
  mode: "login" | "link";
  userId: string | null;
  next: string;
  exp: number;
  botAccess?: boolean;
};

export function sealTelegramTransaction(tx: TelegramOidcTransaction, secret: string): string {
  const body = Buffer.from(JSON.stringify(tx), "utf8").toString("base64url");
  const sig = createHmac("sha256", secret).update(body).digest("base64url");
  return `${body}.${sig}`;
}

export function openTelegramTransaction(
  raw: string,
  secret: string,
  nowSeconds: number
): TelegramOidcTransaction {
  const dot = raw.lastIndexOf(".");
  if (dot <= 0) throw new TelegramOidcError("state");
  const body = raw.slice(0, dot);
  const sig = raw.slice(dot + 1);
  const expected = createHmac("sha256", secret).update(body).digest("base64url");
  if (!safeEqual(sig, expected)) throw new TelegramOidcError("state");
  let parsed: unknown;
  try {
    parsed = JSON.parse(Buffer.from(body, "base64url").toString("utf8"));
  } catch {
    throw new TelegramOidcError("state");
  }
  if (!parsed || typeof parsed !== "object") throw new TelegramOidcError("state");
  const tx = parsed as Partial<TelegramOidcTransaction>;
  if (tx.v !== 1 || (tx.mode !== "login" && tx.mode !== "link")) {
    throw new TelegramOidcError("state");
  }
  if (!isShortString(tx.state) || !isShortString(tx.verifier) || !isShortString(tx.nonce)) {
    throw new TelegramOidcError("state");
  }
  if (typeof tx.exp !== "number" || tx.exp < nowSeconds) throw new TelegramOidcError("state");
  if (typeof tx.next !== "string" || (tx.userId !== null && typeof tx.userId !== "string")) {
    throw new TelegramOidcError("state");
  }
  return tx as TelegramOidcTransaction;
}

/** CSRF check: the callback `state` must match the value we stored. */
export function assertTelegramState(stored: string, received: string | null): void {
  if (!received || received.length > 256 || !safeEqual(stored, received)) {
    throw new TelegramOidcError("state");
  }
}

function safeEqual(left: string, right: string): boolean {
  const a = Buffer.from(left);
  const b = Buffer.from(right);
  return a.length === b.length && timingSafeEqual(a, b);
}

function isShortString(value: unknown): value is string {
  return typeof value === "string" && value.length > 0 && value.length <= 200;
}

function decodeJson(part: string): Record<string, unknown> | null {
  try {
    const parsed = JSON.parse(Buffer.from(part, "base64url").toString("utf8")) as unknown;
    if (!parsed || typeof parsed !== "object" || Array.isArray(parsed)) return null;
    return parsed as Record<string, unknown>;
  } catch {
    return null;
  }
}

function selectRsaKey(keys: readonly RsaJwk[], kid: unknown): RsaJwk {
  const rsa = keys.filter(
    (key) => key.kty === "RSA" && key.n && key.e && (key.alg === undefined || key.alg === "RS256")
  );
  if (typeof kid === "string" && kid) {
    const match = rsa.find((key) => key.kid === kid);
    if (!match) throw new TelegramOidcError("unknown_kid");
    return match;
  }
  if (rsa.length === 1) return rsa[0];
  throw new TelegramOidcError("unknown_kid");
}

function audienceValues(aud: unknown): string[] {
  if (typeof aud === "string") return [aud];
  if (typeof aud === "number" && Number.isSafeInteger(aud)) return [String(aud)];
  if (Array.isArray(aud)) return aud.flatMap((item) => audienceValues(item));
  return [];
}

function cleanName(value: unknown): string | null {
  if (typeof value !== "string") return null;
  const cleaned = value.replace(/[\u0000-\u001F\u007F]/g, " ").replace(/\s+/g, " ").trim().slice(0, 80);
  return cleaned || null;
}

function cleanUsername(value: unknown): string | null {
  if (typeof value !== "string") return null;
  const cleaned = value.trim().replace(/^@/, "");
  return /^[A-Za-z0-9_]{1,32}$/.test(cleaned) ? cleaned : null;
}

function cleanPicture(value: unknown): string | null {
  if (typeof value !== "string" || value.length > 500) return null;
  try {
    const url = new URL(value);
    if (url.protocol !== "https:" || url.username || url.password) return null;
    return url.toString();
  } catch {
    return null;
  }
}

function cleanTelegramUserId(value: unknown): string | null {
  if (typeof value === "number" && Number.isSafeInteger(value) && value > 0) return String(value);
  if (typeof value === "string" && /^[0-9]{1,32}$/.test(value)) return value;
  return null;
}
