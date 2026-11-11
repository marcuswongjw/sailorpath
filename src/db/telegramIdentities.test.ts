import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";

describe("telegram identities migration", () => {
  const sql = readFileSync(
    new URL("./migrations/20261111120000_telegram_identities.sql", import.meta.url),
    "utf8"
  );

  it("keeps Telegram subjects private to the server connection", () => {
    expect(sql).toContain("CREATE TABLE public.telegram_identities");
    expect(sql).toContain("telegram_sub text PRIMARY KEY");
    expect(sql).toContain("user_id uuid NOT NULL UNIQUE");
    expect(sql).toContain("ENABLE ROW LEVEL SECURITY");
    expect(sql).toContain("REVOKE ALL ON TABLE public.telegram_identities FROM PUBLIC, anon, authenticated");
  });

  it("does not store the Telegram placeholder address on the profile", () => {
    expect(sql).toContain("ILIKE '%@telegram.sailorpath.invalid'");
    expect(sql).toContain("next_email := '';");
  });
});
