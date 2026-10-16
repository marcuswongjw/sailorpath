import { describe, expect, it } from "vitest";
import {
  AUTH_GET_USER_TIMEOUT_MS,
  AUTH_PROFILE_LOOKUP_TIMEOUT_MS,
  AUTH_SLOW_THRESHOLD_MS,
  jsonError,
} from "./auth";
import { DbUnavailableError } from "@/db";

describe("auth bounds and error handling", () => {
  it("defines explicit bounded timeouts for auth phases", () => {
    expect(AUTH_GET_USER_TIMEOUT_MS).toBe(5_000);
    expect(AUTH_PROFILE_LOOKUP_TIMEOUT_MS).toBe(4_000);
    expect(AUTH_SLOW_THRESHOLD_MS).toBe(1_000);
  });

  describe("jsonError", () => {
    it("returns 401 for UNAUTHORIZED", async () => {
      const res = jsonError(new Error("UNAUTHORIZED"));
      expect(res.status).toBe(401);
      const data = await res.json();
      expect(data.error).toBe("Not signed in");
    });

    it("returns 403 for FORBIDDEN", async () => {
      const res = jsonError(new Error("FORBIDDEN"));
      expect(res.status).toBe(403);
      const data = await res.json();
      expect(data.error).toBe("You do not have access to this area");
    });

    it("returns 503 with Retry-After header for DbUnavailableError", async () => {
      const res = jsonError(new DbUnavailableError("Database temporarily unavailable"));
      expect(res.status).toBe(503);
      expect(res.headers.get("Retry-After")).toBe("2");
      const data = await res.json();
      expect(data.error).toContain("Temporary service timeout while connecting to the database");
    });

    it("returns 503 with Retry-After header for connection timeout errors", async () => {
      const res = jsonError(new Error("DB_OPERATION_TIMEOUT"));
      expect(res.status).toBe(503);
      expect(res.headers.get("Retry-After")).toBe("2");
      const data = await res.json();
      expect(data.error).toContain("Temporary service timeout while connecting to the database");
    });

    it("returns 503 when error has explicit status 503", async () => {
      const err = new Error("Custom upstream timeout");
      (err as unknown as { status: number }).status = 503;
      const res = jsonError(err);
      expect(res.status).toBe(503);
      expect(res.headers.get("Retry-After")).toBe("2");
    });
  });
});
