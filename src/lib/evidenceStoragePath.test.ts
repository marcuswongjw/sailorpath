import { describe, expect, it } from "vitest";
import { evidenceStoragePath } from "./evidenceStoragePath";

const USER = "11111111-1111-4111-8111-111111111111";

describe("evidenceStoragePath", () => {
  it("stores the file under the signed-in user", () => {
    expect(evidenceStoragePath(USER, "score sheet.pdf", 1000)).toBe(
      `${USER}/1000_score_sheet.pdf`
    );
  });

  it("drops folder tricks from the original file name", () => {
    expect(evidenceStoragePath(USER, "../../other-user/file.pdf", 5)).toBe(
      `${USER}/5_file.pdf`
    );
    expect(evidenceStoragePath(USER, "..", 5)).toBe(`${USER}/5_evidence`);
  });

  it("rejects an id that is not the authenticated user id shape", () => {
    expect(() => evidenceStoragePath("../avatars", "a.pdf", 1)).toThrow(
      "Invalid uploader"
    );
    expect(() => evidenceStoragePath("evidence", "a.pdf", 1)).toThrow(
      "Invalid uploader"
    );
  });
});
