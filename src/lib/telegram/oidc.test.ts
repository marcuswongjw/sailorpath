import { generateKeyPairSync, createSign, type KeyObject } from "node:crypto";
import { describe, expect, it } from "vitest";
import {
  TELEGRAM_CALLBACK_PATH,
  TELEGRAM_ISSUER,
  TelegramOidcError,
  assertTelegramState,
  buildTelegramAuthorizeUrl,
  buildTelegramTokenRequest,
  verifyTelegramIdToken,
} from "@/lib/telegram/oidc";

const clientId = "123456789";
const now = 1_700_000_000;

function keyPair() {
  const { publicKey, privateKey } = generateKeyPairSync("rsa", { modulusLength: 2048 });
  const jwk = publicKey.export({ format: "jwk" }) as {
    kty: string;
    n: string;
    e: string;
    kid?: string;
  };
  return { publicKey, privateKey, jwk: { ...jwk, kid: "test-key", alg: "RS256" } };
}

function sign(
  payload: Record<string, unknown>,
  privateKey: KeyObject,
  header: Record<string, unknown> = { alg: "RS256", typ: "JWT", kid: "test-key" }
) {
  const h = Buffer.from(JSON.stringify(header)).toString("base64url");
  const p = Buffer.from(JSON.stringify(payload)).toString("base64url");
  const signer = createSign("RSA-SHA256");
  signer.update(`${h}.${p}`);
  signer.end();
  return `${h}.${p}.${signer.sign(privateKey).toString("base64url")}`;
}

function payload(overrides: Record<string, unknown> = {}) {
  return {
    iss: TELEGRAM_ISSUER,
    aud: clientId,
    sub: "1234123412341234123",
    iat: now,
    exp: now + 3600,
    name: "Jordan Lee",
    preferred_username: "jordan",
    ...overrides,
  };
}

describe("Telegram ID token validation", () => {
  const keys = keyPair();
  const other = keyPair();

  it("accepts a token signed by the issuer key", () => {
    const claims = verifyTelegramIdToken(sign(payload(), keys.privateKey), {
      clientId,
      keys: [keys.jwk],
      now,
    });
    expect(claims.sub).toBe("1234123412341234123");
    expect(claims.name).toBe("Jordan Lee");
    expect(claims.username).toBe("jordan");
  });

  it("rejects a bad signature", () => {
    const token = sign(payload(), other.privateKey);
    expect(() =>
      verifyTelegramIdToken(token, { clientId, keys: [keys.jwk], now })
    ).toThrow(expect.objectContaining({ code: "signature" }));
  });

  it("rejects the wrong audience", () => {
    const token = sign(payload({ aud: "999" }), keys.privateKey);
    expect(() =>
      verifyTelegramIdToken(token, { clientId, keys: [keys.jwk], now })
    ).toThrow(expect.objectContaining({ code: "audience" }));
  });

  it("rejects an expired token", () => {
    const token = sign(payload({ exp: now - 3600 }), keys.privateKey);
    expect(() =>
      verifyTelegramIdToken(token, { clientId, keys: [keys.jwk], now })
    ).toThrow(expect.objectContaining({ code: "expired" }));
  });

  it("rejects an unsigned token", () => {
    const header = Buffer.from(JSON.stringify({ alg: "none", typ: "JWT" })).toString("base64url");
    const body = Buffer.from(JSON.stringify(payload())).toString("base64url");
    expect(() =>
      verifyTelegramIdToken(`${header}.${body}.`, { clientId, keys: [keys.jwk], now })
    ).toThrow(expect.objectContaining({ code: "algorithm" }));
  });
});

describe("Telegram OAuth state", () => {
  it("rejects a state mismatch", () => {
    expect(() => assertTelegramState("expected-state-value", "other-state-value")).toThrow(
      TelegramOidcError
    );
    try {
      assertTelegramState("expected-state-value", "other-state-value");
    } catch (error) {
      expect(error).toMatchObject({ code: "state" });
    }
  });
});

describe("Telegram authorization request", () => {
  it("uses the authorization code flow, S256, and openid profile only", () => {
    const url = new URL(
      buildTelegramAuthorizeUrl({
        clientId,
        redirectUri: `https://sailorpath.com${TELEGRAM_CALLBACK_PATH}`,
        state: "state-value",
        codeChallenge: "challenge-value",
        nonce: "nonce-value",
      })
    );
    expect(url.origin + url.pathname).toBe("https://oauth.telegram.org/auth");
    expect(url.searchParams.get("response_type")).toBe("code");
    expect(url.searchParams.get("code_challenge_method")).toBe("S256");
    expect(url.searchParams.get("scope")).toBe("openid profile");
    expect(url.searchParams.get("scope")).not.toContain("phone");
    expect(url.searchParams.get("scope")).not.toContain("bot_access");
    expect(url.searchParams.get("redirect_uri")).toBe(
      "https://sailorpath.com/auth/telegram/callback"
    );
  });

  it("adds bot access only when the person opts in", () => {
    const url = new URL(
      buildTelegramAuthorizeUrl({
        clientId,
        redirectUri: `https://sailorpath.com${TELEGRAM_CALLBACK_PATH}`,
        state: "state-value",
        codeChallenge: "challenge-value",
        nonce: "nonce-value",
        botAccess: true,
      })
    );
    expect(url.searchParams.get("scope")).toBe("openid profile telegram:bot_access");
    expect(url.searchParams.get("scope")).not.toContain("phone");
  });

  it("sends the client secret only as HTTP Basic auth", () => {
    const request = buildTelegramTokenRequest({
      clientId,
      clientSecret: "top-secret",
      code: "auth-code",
      redirectUri: "https://sailorpath.com/auth/telegram/callback",
      codeVerifier: "verifier",
    });
    expect(request.url).toBe("https://oauth.telegram.org/token");
    expect(request.headers.Authorization).toBe(
      `Basic ${Buffer.from(`${clientId}:top-secret`).toString("base64")}`
    );
    expect(request.body).toContain("grant_type=authorization_code");
    expect(request.body).toContain("code_verifier=verifier");
    expect(request.body).not.toContain("top-secret");
    expect(request.body).not.toContain("phone");
  });
});
