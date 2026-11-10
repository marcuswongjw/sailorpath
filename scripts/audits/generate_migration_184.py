#!/usr/bin/env python3
"""Generate Migration 184: Daily Audit Demographics, Keep-Separates, Deferred Result Import, and Monitor Updates."""

import os
import json

def main():
    migration_path = "src/db/migrations/184_daily_audit_enrichment_kaohsiung_pulau_ujong_and_cleanup.sql"
    
    sql_lines = [
        "-- Migration 184: Daily Audit Demographics, Keep-Separates, Deferred Result Import, and Monitor Updates",
        "-- Generated: 2026-11-10",
        "--",
        "-- 1. Enrich 13 verified sailor genders (Worrakan Saksriklom + 12 Japanese youth sailors)",
        "-- 2. Register 6 keep-separate sailor pairs in admin_change_log",
        "-- 3. Prune orphaned composite profile 'Sean Kum / Nigel Tan' (reassigning result sailor_id to helm)",
        "-- 4. Import deferred rank 6 Christian Wiedmann in 37th Phuket King's Cup 2025 ILCA 7 to Apiwat Christian Wiedmann",
        "-- 5. Populate official results PDF URLs across 7 Pulau Ujong 2026 regatta records",
        "-- 6. Update result_import_monitors status for Pulau Ujong, Japan Youth Worlds, Botchan Cup, and Kaohsiung",
        "",
        "BEGIN;",
        ""
    ]

    # 1. Verified Gender Enrichments
    sql_lines.append("-- ============================================================================")
    sql_lines.append("-- 1. VERIFIED GENDER ENRICHMENTS (13 SAILORS)")
    sql_lines.append("-- ============================================================================")
    sql_lines.append("")

    gender_enrichments = [
        ("b1252473-a364-5f83-851b-8d9740d7e233", "Worrakan Saksriklom", "M", "22nd Langkawi International Regatta Perdana 2026 — 420 Men"),
        ("2b3ed2fa-a6ec-59ac-9227-b780e15f2b69", "マーズデン 琥海", "M", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
        ("666f2ed9-9cd6-5af3-8dcb-e752818002b2", "岡田 海洋", "M", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
        ("0d5fdc5a-4c9a-50c7-9302-a694d6d1c260", "栗田 大河", "M", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
        ("4864e2f5-368a-5772-b72e-aa639bc5a6ec", "臼井 翔海", "M", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
        ("21c91ef1-9491-5cad-9b2a-57ea50a269ce", "金井 稜", "M", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
        ("4ebdde56-268f-5a4a-8f7b-e29d047e0f97", "長堀 滉", "M", "Japan Youth Worlds Selection Regatta 2026 — 29er Boys"),
        ("039f04d9-c0b6-5447-a108-4a9046000f7c", "宮嵜 吏壱", "M", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
        ("24c9b1a5-c955-517b-9f4f-ad84188aa589", "山中 柊都", "M", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
        ("a8a9efd7-eb9d-5cb6-a6c1-beec90eb6317", "山住 愛翔", "M", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
        ("738f45d1-1082-5a56-ae80-e6b46b569f15", "梶村 幸永", "M", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
        ("dbbff3fc-2a59-587a-b1ee-d96191790460", "森山 斗輝", "M", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
        ("d22e0773-c61f-5310-b80e-9d5f2122406e", "稲葉 奏介", "M", "Japan Youth Worlds Selection Regatta 2026 — 420 Boys"),
    ]

    for sid, name, gender, src in gender_enrichments:
        sql_lines.append(f"-- {name} ({sid}) -> {gender} (Source: {src})")
        sql_lines.append(f"UPDATE public.sailors SET gender = '{gender}', updated_at = clock_timestamp() WHERE id = '{sid}' AND gender IS NULL;")
        sql_lines.append("")

    # 2. Keep-Separate Registrations
    sql_lines.append("-- ============================================================================")
    sql_lines.append("-- 2. KEEP-SEPARATE PAIR REGISTRATIONS (6 PAIRS)")
    sql_lines.append("-- ============================================================================")
    sql_lines.append("")

    keep_separates = [
        (
            "2bb09661-11b7-5714-a6b2-a495ed6f517f",
            "6ab02afb-fd98-559c-a6dd-ef7543aa4d1c",
            "Yi San Huang / Yi Huang",
            "Distinct athletes: Taiwanese youth sailors from different associations/schools competing under sail 221513 vs TPE217273 in National President's Cup."
        ),
        (
            "d1e310ac-9ea8-5b8e-959f-493fcb253c7e",
            "d2384e74-ecef-53b2-8006-54f4ccdcbc36",
            "Yu Lee / Shan-Yu Lee",
            "Distinct athletes: Taiwanese youth sailors from different clubs and classes: Yu Lee (Yilan Sailing Committee, ILCA 6, TPE214516) vs Shan-Yu Lee (Lotus Pond Sailing Team Kaohsiung, Optimist, TPE773)."
        ),
        (
            "9f555018-9102-4cc5-a99e-93ee77ccc96b",
            "4d4f65b6-cb72-5665-b991-427a6f366a95",
            "Vaishnavi V Kajale / V Vaishnavi",
            "Distinct athletes: Indian athletes in entirely different disciplines: Vaishnavi V Kajale (Techno 293 windsurfing, YAI) vs V Vaishnavi (420 double-handed dinghy helm, YCH, IND 54658)."
        ),
        (
            "6ab02afb-fd98-559c-a6dd-ef7543aa4d1c",
            "83809dc2-7999-54be-8ab9-5eae50286b93",
            "Yi Huang / Huang Yi Cheng Liam",
            "Distinct athletes: Taiwanese youth sailor Yi Huang (TPE, Yilan) vs Singaporean youth sailor Huang Yi Cheng Liam (SGP, sail 3333)."
        ),
        (
            "c1fef555-4202-4814-8fd3-b397ad4fa912",
            "983252bf-8a99-5f85-a6ea-837957551ac6",
            "Mark Wong / Mack Wong",
            "Distinct athletes: Singapore national windfoiler Mark Wong (SGP, Constant Wind, sail 95) vs Hong Kong athlete Mack Wong (HKG)."
        ),
        (
            "93cb42df-a8cb-419d-96c7-7c0c18738536",
            "3e1da03f-d00f-5604-b46e-716456fd72ee",
            "Ethan Kiu / Louis Polson (composite) / Louis Polson (individual)",
            "Composite team pair entry vs individual sailor profile: Louis Polson is the individual 29er crew athlete."
        )
    ]

    for id1, id2, label, reason in keep_separates:
        pair_key = "|".join(sorted([id1, id2]))
        escaped_reason = reason.replace("'", "''")
        escaped_label = label.replace("'", "''")
        sql_lines.append(f"-- Keep-separate: {label}")
        sql_lines.append(f"""INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.keep_separate',
  'sailor',
  '{id1}',
  '{escaped_label}',
  'Confirmed these are different sailors.',
  jsonb_build_object(
    'pairKey', '{pair_key}',
    'reason', '{escaped_reason}'
  ),
  'migration_184',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.keep_separate'
    AND details->>'pairKey' = '{pair_key}'
);
""")

    # 3. Prune Orphaned Composite Sailor Profile
    sql_lines.append("-- ============================================================================")
    sql_lines.append("-- 3. PRUNE ORPHANED COMPOSITE PROFILE 'Sean Kum / Nigel Tan'")
    sql_lines.append("-- ============================================================================")
    sql_lines.append("")
    sql_lines.append("-- Reassign 20th Asian Games 29er result sailor_id from composite shell to helm Sean Kum Kok Wei")
    sql_lines.append("""UPDATE public.regatta_results
SET sailor_id = 'e84ec5f5-02aa-4b5b-889a-edf1eefdbfbf',
    updated_at = clock_timestamp()
WHERE id = '3e18a002-a020-4100-8001-000000000032'
  AND sailor_id = 'a403cd69-658e-42c1-9d5a-e5b78e466a33';

-- Delete the empty composite sailor shell
DELETE FROM public.sailors
WHERE id = 'a403cd69-658e-42c1-9d5a-e5b78e466a33';

-- Record admin log
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.prune_orphaned_composite',
  'sailor',
  'a403cd69-658e-42c1-9d5a-e5b78e466a33',
  'Sean Kum / Nigel Tan',
  'Pruned orphaned composite double-handed profile; reassigned result to individual helm Sean Kum Kok Wei.',
  jsonb_build_object(
    'helm_id', 'e84ec5f5-02aa-4b5b-889a-edf1eefdbfbf',
    'crew_id', 'ca98c637-aebd-4f38-81c7-80345846c93a',
    'regatta_result_id', '3e18a002-a020-4100-8001-000000000032'
  ),
  'migration_184',
  clock_timestamp()
);
""")

    # 4. Import Deferred Phuket King's Cup 2025 ILCA 7 Result (Christian Wiedmann)
    sql_lines.append("-- ============================================================================")
    sql_lines.append("-- 4. IMPORT DEFERRED PHUKET KING'S CUP 2025 ILCA 7 ENTRY (Christian Wiedmann)")
    sql_lines.append("-- ============================================================================")
    sql_lines.append("")
    sql_lines.append("""DO $$
DECLARE
  v_regatta_id uuid := 'f2d53719-ece3-5162-92dd-87b247029fcd';
  v_sailor_id uuid := '3b468b8a-579d-5429-8d3f-27db5e17aed2'; -- Apiwat Christian Wiedmann
  v_result_id uuid := 'b6c2d134-8c01-5d97-8c34-71285491ce60';
  v_participant_id uuid := 'e49ab812-7091-5821-b845-a75d9284cf31';
BEGIN
  -- Insert regatta_results row if not exists
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, verification_status,
    evidence_name, evidence_type, evidence_notes, verified_at, created_at, updated_at
  ) VALUES (
    v_result_id,
    v_regatta_id,
    v_sailor_id,
    'CHRISTIAN WIEDMANN',
    'THA 49',
    'individual',
    6,
    55.0,
    43.0,
    false,
    false,
    'verified',
    '37th Phuket King’s Cup Regatta 2025 — ILCA 7 Open results',
    'document',
    'Official source document 169974, page 1; source name: CHRISTIAN WIEDMANN; sail: THA 49. User confirmed link to Apiwat Christian Wiedmann.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
  ) ON CONFLICT (id) DO UPDATE
    SET sailor_id = EXCLUDED.sailor_id,
        total_score = EXCLUDED.total_score,
        nett_score = EXCLUDED.nett_score;

  -- Insert participant row
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    v_participant_id,
    v_result_id,
    v_sailor_id,
    'CHRISTIAN WIEDMANN',
    1,
    'solo',
    'matched',
    false,
    clock_timestamp(),
    clock_timestamp()
  ) ON CONFLICT (id) DO NOTHING;

  -- Insert 9 race results (R1..R9)
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES 
    (v_result_id, 1, 7.0, NULL, false, '7.0'),
    (v_result_id, 2, 5.0, NULL, false, '5.0'),
    (v_result_id, 3, 4.0, NULL, false, '4.0'),
    (v_result_id, 4, 12.0, 'UFD', true, '(12.0 UFD)'),
    (v_result_id, 5, 4.0, NULL, false, '4.0'),
    (v_result_id, 6, 5.0, NULL, false, '5.0'),
    (v_result_id, 7, 5.0, NULL, false, '5.0'),
    (v_result_id, 8, 6.0, NULL, false, '6.0'),
    (v_result_id, 9, 7.0, NULL, false, '7.0')
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE
    SET score = EXCLUDED.score,
        scoring_code = EXCLUDED.scoring_code,
        discarded = EXCLUDED.discarded,
        raw_value = EXCLUDED.raw_value;

  -- Admin change log
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'regatta_results.import_deferred_entry',
    'regatta_result',
    v_result_id,
    '37th Phuket King’s Cup Regatta 2025 — ILCA 7 (Rank 6: Apiwat Christian Wiedmann)',
    'Imported verified deferred entry for Apiwat Christian Wiedmann in 37th Phuket King’s Cup 2025.',
    jsonb_build_object(
      'sailor_id', v_sailor_id,
      'regatta_id', v_regatta_id,
      'rank', 6,
      'sail_number', 'THA 49'
    ),
    'migration_184',
    clock_timestamp()
  );
END $$;
""")

    # 5. Link Official Results PDF URLs for Pulau Ujong 2026
    sql_lines.append("-- ============================================================================")
    sql_lines.append("-- 5. LINK OFFICIAL RESULTS PDF URLS FOR PULAU UJONG REGATTA 2026")
    sql_lines.append("-- ============================================================================")
    sql_lines.append("")
    sql_lines.append("""-- Update official results URLs on all 7 Pulau Ujong regattas
UPDATE public.regattas
SET official_results_url = 'https://s3.amazonaws.com/rrs.prod/2hseo0iwy31ouhxwrotf2g9blv1m?response-content-disposition=inline%3B%20filename%3D%22OP%20Gold%20Results%20Day%202_Correction.pdf%22%3B%20filename%2A%3DUTF-8%27%27OP%2520Gold%2520Results%2520Day%25202_Correction.pdf&response-content-type=application%2Fpdf&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJH37WFGGNKRSBH6Q%2F20261023%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20261023T002612Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=dd349b374a0926b046955d8b5e3c36663a7de282db155be4685829b256a06f7e',
    official_results_source_name = 'RRS Official OP Gold Results Day 2 Correction PDF',
    updated_at = clock_timestamp()
WHERE slug = 'pulau-ujong-regatta-2026-gold';

UPDATE public.regattas
SET official_results_url = 'https://s3.amazonaws.com/rrs.prod/w6ckxiy9uj5zyq86y8fqxzhere5f?response-content-disposition=inline%3B%20filename%3D%22OP%20Silver%20Final%20Results.pdf%22%3B%20filename%2A%3DUTF-8%27%27OP%2520Silver%2520Final%2520Results.pdf&response-content-type=application%2Fpdf&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJH37WFGGNKRSBH6Q%2F20261023%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20261023T002610Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6772ef03716857789a9ca7f32c0e21d3325031fa842df07aa8c84927571d1e77',
    official_results_source_name = 'RRS Official OP Silver Final Results PDF',
    updated_at = clock_timestamp()
WHERE slug = 'pulau-ujong-regatta-2026-silver';

UPDATE public.regattas
SET official_results_url = 'https://s3.amazonaws.com/rrs.prod/mq6k5ew6z0da2xrjnrd42vsoz769?response-content-disposition=inline%3B%20filename%3D%22ILCA%204%20Final%20Results.pdf%22%3B%20filename%2A%3DUTF-8%27%27ILCA%25204%2520Final%2520Results.pdf&response-content-type=application%2Fpdf&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJH37WFGGNKRSBH6Q%2F20261023%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20261023T002609Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=50046af7c2fa4a3d51563aadeb99d10799b133c778f2a063ab83c1cd3dc763b3',
    official_results_source_name = 'RRS Official ILCA 4 Final Results PDF',
    updated_at = clock_timestamp()
WHERE slug = 'pulau-ujong-ilca-feb-26-2026-02-21';

UPDATE public.regattas
SET official_results_url = 'https://s3.amazonaws.com/rrs.prod/40bzp5szsvm7dqz9a7phcysyd2ki?response-content-disposition=inline%3B%20filename%3D%22ILCA%206%20Final%20Results.pdf%22%3B%20filename%2A%3DUTF-8%27%27ILCA%25206%2520Final%2520Results.pdf&response-content-type=application%2Fpdf&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJH37WFGGNKRSBH6Q%2F20261023%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20261023T002607Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c253976cd60a8524913b3a1fe3b0041b789ac06bf0a01d2411ee86e1c175cda3',
    official_results_source_name = 'RRS Official ILCA 6 Final Results PDF',
    updated_at = clock_timestamp()
WHERE slug = 'pulau-ujong-2026-ilca-6';

UPDATE public.regattas
SET official_results_url = 'https://s3.amazonaws.com/rrs.prod/w1d8bksrws197j0jnbgksjxsmli8?response-content-disposition=inline%3B%20filename%3D%2229er%20and%20WSF%20Final%20Results.pdf%22%3B%20filename%2A%3DUTF-8%27%2729er%2520and%2520WSF%2520Final%2520Results.pdf&response-content-type=application%2Fpdf&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJH37WFGGNKRSBH6Q%2F20261023%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20261023T002611Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=f74620484272a6e367bf25c968638156fb27eb9f10511e2ec53d8654c6c87a6e',
    official_results_source_name = 'RRS Official 29er and WSF Final Results PDF',
    updated_at = clock_timestamp()
WHERE slug IN ('pulau-ujong-2026-29er', 'pulau-ujong-2026-techno293', 'pulau-ujong-2026-iqfoil');
""")

    # 6. Update Result Import Monitors Status
    sql_lines.append("-- ============================================================================")
    sql_lines.append("-- 6. UPDATE RESULT IMPORT MONITORS STATUS")
    sql_lines.append("-- ============================================================================")
    sql_lines.append("")
    sql_lines.append("""-- Pulau Ujong Regatta 2026: set event_url and mark reviewed
UPDATE public.result_import_monitors
SET event_url = 'https://www.racingrulesofsailing.org/documents/13180/event',
    report = jsonb_set(report, '{status}', '"reviewed"')
WHERE event_id = '058ec35f-c7f7-4677-bd76-39ec738332c6';

-- Japan Youth Worlds Selection Regatta 2026: mark reviewed (Notice of Race verified)
UPDATE public.result_import_monitors
SET report = jsonb_set(report, '{status}', '"reviewed"')
WHERE event_id = 'dd16f02b-2b0a-48bd-b058-5b5ee9f39b11';

-- 22nd Botchan Cup 2026: mark reviewed (Notice of Race verified)
UPDATE public.result_import_monitors
SET report = jsonb_set(report, '{status}', '"reviewed"')
WHERE event_id = '8d8bbdc1-a75a-4d3b-ab7c-275bc078b6b9';

-- Kaohsiung Lotus Pond Optimist Regatta 2026: mark reviewed (Official provisional/final PDF corroborated)
UPDATE public.result_import_monitors
SET report = jsonb_set(
      jsonb_set(report, '{status}', '"reviewed"'),
      '{pdfCorroboration}', '"verified"'
    )
WHERE event_id = 'a9c9af76-240d-4a4b-950b-de5ea77dc495';
""")

    # 7. Summary Log
    sql_lines.append("-- ============================================================================")
    sql_lines.append("-- 7. AUDIT SUMMARY LOG")
    sql_lines.append("-- ============================================================================")
    sql_lines.append("")
    sql_lines.append("""INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.demographics_enrichment',
  'sailor',
  'b1252473-a364-5f83-851b-8d9740d7e233',
  'Worrakan Saksriklom et al.',
  'Enriched 13 verified sailor genders (THA + JPN); registered 6 keep-separate pairs; pruned orphaned composite profile Sean Kum / Nigel Tan; imported deferred Phuket King''s Cup entry for Apiwat Christian Wiedmann; linked official PDFs for 7 Pulau Ujong regattas; updated monitor statuses for Pulau Ujong, Japan Youth Worlds, Botchan Cup, and Kaohsiung.',
  jsonb_build_object(
    'gender_enrichments_count', 13,
    'keep_separates_count', 6,
    'pruned_profile', 'a403cd69-658e-42c1-9d5a-e5b78e466a33',
    'imported_result_sailor', '3b468b8a-579d-5429-8d3f-27db5e17aed2',
    'pulau_ujong_event_id', '058ec35f-c7f7-4677-bd76-39ec738332c6',
    'monitors_reviewed', ARRAY['058ec35f-c7f7-4677-bd76-39ec738332c6', 'dd16f02b-2b0a-48bd-b058-5b5ee9f39b11', '8d8bbdc1-a75a-4d3b-ab7c-275bc078b6b9', 'a9c9af76-240d-4a4b-950b-de5ea77dc495']
  ),
  'migration_184',
  clock_timestamp()
);

COMMIT;
""")

    content = "\n".join(sql_lines)
    with open(migration_path, "w") as f:
        f.write(content)
    print(f"Migration 184 generated at {migration_path} ({len(content)} bytes)")

if __name__ == "__main__":
    main()
