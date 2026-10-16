import { describe, expect, it } from "vitest";
import { postgresPoolOptions, toSupabaseTransactionPooler, isRetryableDatabaseConnectionError, formatDbError } from "./client";

describe("PostgreSQL transport", () => {
  it("keeps a small bounded pool without opting into pipelining or named statements", () => {
    const options = postgresPoolOptions("postgresql://localhost/sailorpath");
    expect(options.max).toBe(1);
    expect(options.connectionTimeoutMillis).toBeGreaterThan(0);
    expect(options.query_timeout).toBeGreaterThan(0);
    expect(options).not.toHaveProperty("pipeline", true);
    expect(postgresPoolOptions("postgresql://user:pass@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres").ssl).toBe(true);
  });
  it("preserves credentials when resolving a direct Supabase URL", () => {
    expect(toSupabaseTransactionPooler(
      "postgresql://postgres:pass%40word@db.fdziuyexczkngvugvsbu.supabase.co:5432/postgres",
      "ap-southeast-1"
    )).toBe("postgresql://postgres.fdziuyexczkngvugvsbu:pass%40word@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres?sslmode=require");
  });
  it("only retries connection and timeout failures", () => {
    for (const error of ["Query read timeout", "Connection terminated unexpectedly", "timeout exceeded when trying to connect", "DB_OPERATION_TIMEOUT", "code=ECONNRESET"]) {
      expect(isRetryableDatabaseConnectionError(error)).toBe(true);
    }
    expect(isRetryableDatabaseConnectionError("invalid input syntax for type uuid")).toBe(false);
  });
  it("retains the underlying connection failure when the SQL wrapper is long", () => {
    const error = new Error(`Failed query: ${"column ".repeat(200)}`, { cause: new Error("Connection terminated unexpectedly") });
    expect(isRetryableDatabaseConnectionError(formatDbError(error))).toBe(true);
  });
});
