import { describe, expect, it } from "vitest";
import { postgresPoolOptions, toSupabaseTransactionPooler, isRetryableDatabaseConnectionError, formatDbError, isMissingDatabaseSchemaError } from "./client";

describe("PostgreSQL transport", () => {
  it("keeps a small bounded pool without opting into pipelining or named statements", () => {
    const options = postgresPoolOptions("postgresql://localhost/sailorpath");
    expect(options.max).toBe(1);
    expect(options.idleTimeoutMillis).toBe(30_000);
    expect(options.keepAlive).toBe(true);
    expect(options.keepAliveInitialDelayMillis).toBe(10_000);
    expect(options.connectionTimeoutMillis).toBeGreaterThan(0);
    expect(options.query_timeout).toBeGreaterThan(0);
    expect(options).not.toHaveProperty("pipeline", true);
    expect(postgresPoolOptions("postgresql://user:pass@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres").ssl).toMatchObject({ rejectUnauthorized: true, ca: expect.stringContaining("BEGIN CERTIFICATE") });
  });
  it("keeps the configured CA from being replaced by connection-string SSL options", async () => {
    const { Client } = await import("pg");
    const options = postgresPoolOptions("postgresql://user:pass@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres?sslmode=require");
    const client = new Client(options);
    const parameters = (client as unknown as { connectionParameters: { ssl: unknown } }).connectionParameters;
    expect(parameters.ssl).toMatchObject({ rejectUnauthorized: true, ca: expect.stringContaining("BEGIN CERTIFICATE") });
    expect(options.connectionString).not.toContain("sslmode=");
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
  it("does not mistake query table names for missing schema during a timeout", () => {
    const timeout = new Error('Failed query: select venue from regatta_race_results', { cause: new Error("DB_OPERATION_TIMEOUT") });
    expect(isMissingDatabaseSchemaError(timeout)).toBe(false);
    expect(isMissingDatabaseSchemaError(new Error('column "venue" does not exist'))).toBe(true);
    expect(isMissingDatabaseSchemaError(new Error('relation "regatta_race_results" does not exist'))).toBe(true);
  });
  it("retains the underlying connection failure when the SQL wrapper is long", () => {
    const error = new Error(`Failed query: ${"column ".repeat(200)}`, { cause: new Error("Connection terminated unexpectedly") });
    expect(isRetryableDatabaseConnectionError(formatDbError(error))).toBe(true);
  });
});
