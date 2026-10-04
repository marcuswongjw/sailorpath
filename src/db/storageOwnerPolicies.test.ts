import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";

const sql = readFileSync(
  new URL("./migrations/102_storage_object_owner_policies.sql", import.meta.url),
  "utf8"
);

describe("storage owner policies", () => {
  it("drops the bucket-wide write policies and gates writes on the owner checks", () => {
    expect(sql).toContain('DROP POLICY IF EXISTS "Avatar authenticated upload"');
    expect(sql).toContain(
      'DROP POLICY IF EXISTS "Regatta evidence authenticated upload"'
    );
    expect(sql).toContain("can_manage_sailor_storage_folder");
    expect(sql).toContain("can_manage_evidence_object");
    expect(sql).toContain("parent_id = auth.uid()");
    expect(sql).toContain("status = 'approved'");
    expect(sql).toContain("role = 'superadmin'");
    expect(sql).not.toMatch(
      /WITH CHECK\s*\(\s*bucket_id = 'avatars'\s*\)/
    );
    expect(sql).not.toMatch(
      /WITH CHECK\s*\(\s*bucket_id = 'regatta-evidence'\s*\)/
    );
    expect(sql).not.toMatch(
      /USING\s*\(\s*bucket_id = 'regatta-evidence'\s*\)/
    );
  });

  it("does not grant public listing when operation filters are available", () => {
    const arrays = [...sql.matchAll(/allow_any_operation\(ARRAY\[([\s\S]*?)\]\)/g)].map(
      (match) => match[1]
    );
    expect(arrays.length).toBeGreaterThan(0);
    for (const operations of arrays) {
      expect(operations).toContain("'storage.object.get_public'");
      expect(operations).not.toMatch(/list/);
    }
  });
});
