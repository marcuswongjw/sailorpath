import { afterEach, describe, expect, it, vi } from "vitest";
import { Pool, type PoolClient } from "pg";
import { DatabasePool, withDatabaseDeadline, withDatabaseRetry } from "./client";

afterEach(() => { vi.useRealTimers(); vi.restoreAllMocks(); });

describe("scoped database recovery", () => {
  it("shares one deadline between both attempts", async () => {
    vi.useFakeTimers();
    const operation = vi.fn(() => new Promise<never>(() => undefined));
    const outcome = withDatabaseRetry(operation, { timeoutMs: 100 }).catch((error: Error) => error);
    await vi.advanceTimersByTimeAsync(50);
    expect(operation).toHaveBeenCalledTimes(2);
    await vi.advanceTimersByTimeAsync(50);
    expect((await outcome).message).toBe("DB_OPERATION_TIMEOUT");
  });
  it("does not retry an invalid query or caller cancellation", async () => {
    const operation = vi.fn().mockRejectedValue(new Error("invalid input syntax for uuid"));
    await expect(withDatabaseRetry(operation)).rejects.toThrow("invalid input");
    expect(operation).toHaveBeenCalledTimes(1);
    const controller = new AbortController();
    controller.abort(new Error("Page closed"));
    await expect(withDatabaseRetry(operation, { signal: controller.signal })).rejects.toThrow("Page closed");
    expect(operation).toHaveBeenCalledTimes(1);
  });
  it("retires only the timed-out lease and tolerates transaction cleanup", async () => {
    vi.useFakeTimers();
    const releases = [vi.fn(), vi.fn()];
    let next = 0;
    vi.spyOn(Pool.prototype, "connect").mockImplementation(((callback: (e: undefined, c: PoolClient, release: () => void) => void) => {
      const release = releases[next++];
      callback(undefined, { release } as unknown as PoolClient, release);
    }) as typeof Pool.prototype.connect);
    const pool = new DatabasePool();
    let first: PoolClient;
    let second: PoolClient;
    const timeout = withDatabaseDeadline(async () => {
      first = await pool.connect();
      await new Promise(() => undefined);
    }, 50).catch((error: Error) => error);
    let finish: () => void = () => undefined;
    const healthy = withDatabaseDeadline(async () => {
      second = await pool.connect();
      await new Promise<void>((resolve) => { finish = resolve; });
      second.release();
      return "ok";
    }, 500);
    await vi.advanceTimersByTimeAsync(50);
    expect(await timeout).toMatchObject({ message: "DB_OPERATION_TIMEOUT", databasePhase: "executing" });
    expect(releases[0]).toHaveBeenCalledExactlyOnceWith(true);
    expect(releases[1]).not.toHaveBeenCalled();
    first!.release();
    expect(releases[0]).toHaveBeenCalledTimes(1);
    finish();
    await expect(healthy).resolves.toBe("ok");
  });
  it("returns a cancelled acquisition without executing a query", async () => {
    vi.useFakeTimers();
    let acquired: (e: undefined, c: PoolClient, release: () => void) => void = () => undefined;
    vi.spyOn(Pool.prototype, "connect").mockImplementation(((cb: typeof acquired) => { acquired = cb; }) as typeof Pool.prototype.connect);
    const pool = new DatabasePool();
    const query = vi.fn();
    const result = withDatabaseDeadline(async () => { const client = await pool.connect(); query(); client.release(); }, 50).catch((error: Error) => error);
    await vi.advanceTimersByTimeAsync(50);
    expect(await result).toMatchObject({ message: "DB_OPERATION_TIMEOUT", databasePhase: "acquiring" });
    const release = vi.fn();
    acquired(undefined, { release } as unknown as PoolClient, release);
    await Promise.resolve();
    expect(release).toHaveBeenCalledExactlyOnceWith(true);
    expect(query).not.toHaveBeenCalled();
  });
});
