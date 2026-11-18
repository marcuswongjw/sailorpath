import { createHmac, timingSafeEqual } from "node:crypto";

function getSecret(): string {
  return (
    process.env.SQUAD_CLAIM_SECRET ||
    process.env.SUPABASE_SERVICE_ROLE_KEY ||
    process.env.AUTH_SECRET ||
    "sailorpath-squad-claim-dev"
  );
}

function sign(payloadB64: string): string {
  return createHmac("sha256", getSecret())
    .update(payloadB64)
    .digest("base64url")
    .slice(0, 22);
}

export function createSquadClaimToken(squadId: string): string {
  const payload = Buffer.from(squadId, "utf8").toString("base64url");
  return `${payload}.${sign(payload)}`;
}

export function verifySquadClaimToken(token: string): string | null {
  const parts = String(token || "").split(".");
  if (parts.length !== 2) return null;
  const [payload, sig] = parts;
  if (!payload || !sig) return null;
  const expected = sign(payload);
  const a = Buffer.from(sig, "utf8");
  const b = Buffer.from(expected, "utf8");
  if (a.length !== b.length || !timingSafeEqual(a, b)) return null;
  try {
    const decoded = Buffer.from(payload, "base64url").toString("utf8").trim();
    return /^[0-9a-f-]{36}$/i.test(decoded) ? decoded : null;
  } catch {
    return null;
  }
}
