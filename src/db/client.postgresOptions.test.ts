import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";
import { postgresJsOptions } from "./client";

describe("postgres.js serverless options", () => {
  it("does not introspect pg_type and does not prepare statements", () => {
    const pooler = postgresJsOptions(
      "postgresql://user:pass@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres"
    );
    expect(pooler.fetch_types).toBe(false);
    expect(pooler.prepare).toBe(false);
    expect(pooler.max).toBe(1);
    expect(pooler.ssl).toBe("require");

    const local = postgresJsOptions("postgresql://postgres:postgres@127.0.0.1:5432/sailorpath");
    expect(local.fetch_types).toBe(false);
    expect(local.prepare).toBe(false);
    expect(local.ssl).toBeUndefined();
  });

  it("reuses one client on the isolate in production", () => {
    const src = readFileSync(new URL("./client.ts", import.meta.url), "utf8");
    expect(src).toContain("globalForDb.sql = sql");
    expect(src).not.toMatch(
      /if \(process\.env\.NODE_ENV !== "production"\) \{\s*globalForDb\.sql = sql;/
    );
  });
});
