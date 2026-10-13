import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";

function read(relativePath: string): string {
  return readFileSync(new URL(relativePath, import.meta.url), "utf8");
}

describe("security advisor migrations", () => {
  const remediation = read("./migrations/113_security_advisor_remediation.sql");

  it("records the live RLS and security_invoker changes idempotently", () => {
    expect(remediation).toContain(
      "ALTER TABLE public.regatta_result_participants ENABLE ROW LEVEL SECURITY"
    );
    expect(remediation).toContain("security_invoker = true");
    expect(remediation).toContain(
      "ALTER VIEW public.published_regattas SET (security_invoker = true)"
    );
  });

  it("moves pg_trgm to extensions and checks trigram search still works", () => {
    expect(remediation).toContain("ALTER EXTENSION pg_trgm SET SCHEMA extensions");
    expect(remediation).toContain("extensions.similarity(");
    expect(remediation).toContain("extensions.gin_trgm_ops");
    expect(remediation).toContain("OPERATOR(extensions.%)");
  });

  it("keeps storage helpers off the public API but executable by authenticated", () => {
    expect(remediation).toContain(
      "CREATE OR REPLACE FUNCTION private.can_manage_evidence_object(object_name text)"
    );
    expect(remediation).toContain(
      "CREATE OR REPLACE FUNCTION private.can_manage_sailor_storage_folder(folder text)"
    );
    expect(remediation).toContain("FROM PUBLIC, anon");
    expect(remediation).toContain(
      "TO authenticated, service_role"
    );
    expect(remediation).toContain(
      "DROP FUNCTION IF EXISTS public.can_manage_evidence_object(text)"
    );
    expect(remediation).toContain(
      "DROP FUNCTION IF EXISTS public.can_manage_sailor_storage_folder(text)"
    );
  });
});

describe("definitions that would recreate the view or extension", () => {
  it("creates published_regattas with security_invoker", () => {
    for (const file of [
      "./migrations/053_regatta_lifecycle_and_rls.sql",
      "./migrations/103_remediate_public_class_policy.sql",
    ]) {
      const sql = read(file);
      expect(sql).toContain("WITH (security_invoker = true)");
      expect(sql).not.toMatch(
        /CREATE OR REPLACE VIEW public\.published_regattas AS/
      );
    }
  });

  it("installs pg_trgm in the extensions schema", () => {
    const sql = read("./migrations/001_init.sql");
    expect(sql).toContain('CREATE EXTENSION IF NOT EXISTS "pg_trgm" WITH SCHEMA extensions');
  });

  it("declares the Drizzle view with securityInvoker and RLS on participants", () => {
    const schema = read("./schema.ts");
    expect(schema).toContain("securityInvoker: true");
    expect(schema).toContain('pgView("published_regattas")');
    const participants = schema.slice(
      schema.indexOf('pgTable(\n  "regatta_result_participants"')
    );
    expect(participants.slice(0, participants.indexOf("export const regattaRaceResults"))).toContain(
      ".enableRLS()"
    );
  });
});
