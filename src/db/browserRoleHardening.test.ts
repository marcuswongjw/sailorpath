import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";

const migration = readFileSync(
  new URL("./migrations/122_harden_browser_roles_and_split_class_write_policies.sql", import.meta.url),
  "utf8"
);

describe("browser role hardening migration", () => {
  it("revokes direct browser-role access to private profile and workspace tables", () => {
    expect(migration).toContain("REVOKE ALL ON TABLE");
    for (const table of [
      "public.profiles",
      "public.sailors",
      "public.sailor_claims",
      "public.regatta_results",
      "public.regatta_result_participants",
      "public.race_observations",
      "public.equipment_logs",
      "public.parent_notes",
      "public.coach_squads",
      "public.coach_sailor_notes",
      "public.coach_development_records",
      "public.coach_followed_sailors",
      "public.followed_sailors",
    ]) {
      expect(migration).toContain(table);
    }
    expect(migration).toContain("FROM anon, authenticated");
  });

  it("keeps only published public collections in the browser SELECT allow-list", () => {
    expect(migration).toContain("GRANT SELECT ON TABLE");
    for (const table of [
      "public.regattas",
      "public.wingfoil_regattas",
      "public.techno293_regattas",
      "public.news_articles",
      "public.published_regattas",
    ]) {
      expect(migration).toContain(table);
    }
  });

  it("uses separate superadmin writes rather than permissive FOR ALL policies", () => {
    expect(migration).not.toMatch(/CREATE POLICY (regattas|wingfoil|techno293)_superadmin_mutate[\s\S]*FOR ALL/);
    for (const policy of [
      "regattas_superadmin_insert",
      "regattas_superadmin_update",
      "regattas_superadmin_delete",
      "wingfoil_superadmin_insert",
      "wingfoil_superadmin_update",
      "wingfoil_superadmin_delete",
      "techno293_superadmin_insert",
      "techno293_superadmin_update",
      "techno293_superadmin_delete",
    ]) {
      expect(migration).toContain(`CREATE POLICY ${policy}`);
    }
  });

  it("does not expose the superadmin helper to anonymous callers", () => {
    expect(migration).toContain("REVOKE ALL ON FUNCTION private.is_superadmin() FROM PUBLIC, anon");
    expect(migration).toContain("GRANT EXECUTE ON FUNCTION private.is_superadmin() TO authenticated, service_role");
    expect(migration).toContain("ALTER VIEW public.published_regattas SET (security_invoker = true)");
  });
});
