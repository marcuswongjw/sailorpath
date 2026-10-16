import { createServer, type Server, type Socket } from "node:net";
import { PGlite } from "@electric-sql/pglite";
import { drizzle } from "drizzle-orm/node-postgres";
import { date, integer, jsonb, pgTable, text, timestamp } from "drizzle-orm/pg-core";
import { afterAll, beforeAll, describe, expect, it } from "vitest";
import { DatabasePool, postgresPoolOptions, withDatabaseRetry } from "./client";

// Real PostgreSQL protocol and real pg/Drizzle decoders, with an in-memory
// PostgreSQL engine. The tiny TCP bridge only supplies the startup handshake.
function message(type: string, payload: Buffer) {
  const header = Buffer.alloc(5);
  header.write(type); header.writeInt32BE(payload.length + 4, 1);
  return Buffer.concat([header, payload]);
}

const records = pgTable("transport_records", {
  id: integer("id").primaryKey(),
  name: text("name").notNull(),
  day: date("day").notNull(),
  optionalDay: date("optional_day"),
  at: timestamp("at", { withTimezone: true }).notNull(),
  payload: jsonb("payload"),
});

describe("database transport through PostgreSQL wire protocol", () => {
  let engine: PGlite;
  let server: Server;
  let pool: DatabasePool;
  const sockets = new Set<Socket>();
  beforeAll(async () => {
    engine = await PGlite.create();
    await engine.exec(`create table transport_records (
      id integer primary key, name text not null, day date not null,
      optional_day date, at timestamptz not null, payload jsonb);
      insert into transport_records values (1, 'Regatta', '2026-10-16', null,
      '2026-10-16T07:00:00Z', '{"scores":[1,2,3]}');`);
    server = createServer((socket) => {
      sockets.add(socket);
      socket.on("close", () => sockets.delete(socket));
      let buffer = Buffer.alloc(0);
      let startup = true;
      let pending = Promise.resolve();
      socket.on("data", (bytes) => {
        buffer = Buffer.concat([buffer, bytes]);
        if (startup) {
          if (buffer.length < 4 || buffer.length < buffer.readInt32BE(0)) return;
          buffer = buffer.subarray(buffer.readInt32BE(0));
          startup = false;
          socket.write(Buffer.concat([
            message("R", Buffer.alloc(4)),
            message("S", Buffer.from("client_encoding\0UTF8\0")),
            message("K", Buffer.alloc(8)),
            message("Z", Buffer.from("I")),
          ]));
        }
        while (buffer.length >= 5 && buffer.length >= 1 + buffer.readInt32BE(1)) {
          const frame = Buffer.from(buffer.subarray(0, 1 + buffer.readInt32BE(1)));
          buffer = buffer.subarray(frame.length);
          if (frame[0] === 88) { socket.end(); continue; }
          pending = pending.then(async () => {
            const response = await engine.execProtocolRaw(frame);
            if (!socket.destroyed) socket.write(response);
          });
        }
      });
    });
    await new Promise<void>((resolve) => server.listen(0, "127.0.0.1", resolve));
    const address = server.address();
    if (!address || typeof address === "string") throw new Error("Missing test port");
    pool = new DatabasePool(postgresPoolOptions(`postgresql://postgres:postgres@127.0.0.1:${address.port}/postgres`));
  }, 30_000);
  afterAll(async () => {
    await pool?.end();
    for (const socket of sockets) socket.destroy();
    if (server) await new Promise<void>((resolve) => server.close(() => resolve()));
    await engine?.close();
  });

  it("preserves dates, nulls and JSON while concurrent queries have different row shapes", async () => {
    const database = drizzle(pool);
    const results = await withDatabaseRetry(() => Promise.all(Array.from({ length: 12 }, async (_, index) => {
      const [row, token] = await Promise.all([
        database.select().from(records),
        pool.query("select $1::int as token", [index]),
      ]);
      expect(row[0].day).toBe("2026-10-16");
      expect(row[0].optionalDay).toBeNull();
      expect(row[0].at.toISOString()).toBe("2026-10-16T07:00:00.000Z");
      expect(row[0].payload).toEqual({ scores: [1, 2, 3] });
      expect(token.rows).toEqual([{ token: index }]);
      return row[0].id;
    })));
    expect(results).toHaveLength(12);
  });

  it("keeps transactions atomic and releases the client after rollback", async () => {
    const database = drizzle(pool);
    await expect(database.transaction(async (tx) => {
      await tx.insert(records).values({ id: 2, name: "Rollback", day: "2026-10-17", at: new Date() });
      throw new Error("Rollback requested");
    })).rejects.toThrow("Rollback requested");
    expect((await database.select().from(records)).map((row) => row.id)).toEqual([1]);
    await database.transaction(async (tx) => {
      await tx.insert(records).values({ id: 3, name: "Committed", day: "2026-10-18", at: new Date() });
    });
    expect((await database.select().from(records)).map((row) => row.id)).toEqual([1, 3]);
  });
});
