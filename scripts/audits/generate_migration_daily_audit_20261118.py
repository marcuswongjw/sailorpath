#!/usr/bin/env python3
"""Generate 2026-11-18 daily audit & WAIODA 2026 import migrations."""

from __future__ import annotations
import json
import re
import uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
MIGRATIONS = ROOT / "src" / "db" / "migrations"
WAIODA_JSON = Path("/Users/marcus/.gemini/antigravity/brain/ab80f091-6c38-43bb-91bc-07fb160dd409/scratch/waioda_2026.json")
AUS_JSON = Path("/Users/marcus/.gemini/antigravity/brain/ab80f091-6c38-43bb-91bc-07fb160dd409/.system_generated/steps/180/output.txt")


def sql_str(val: str | None) -> str:
    if val is None:
        return "NULL"
    return "'" + val.replace("'", "''") + "'"


def build_daily_audit_migration() -> str:
    nsw_girls = [
        ("a68e8e7f-d347-5326-a405-7f795be50f87", "Lara Dorling", "1729", "82460.12 (Optimist Open)"),
        ("23b717b1-7d59-5014-b1ae-3358bf3e8445", "Laura OHara", "1214", "82460.12 (Optimist Open)"),
        ("c720156e-a4fc-5c44-8505-4ad78bb60d73", "Willow Murray", "1863", "82460.12 (Optimist Open)"),
        ("0f1dbaf1-c074-5cba-9abc-c91bdde4434f", "Amelia McKelvey", "162", "82460.11 (Optimist Intermediate)"),
        ("97f0b854-923f-5124-9cfa-8360389bc308", "Ebba Nixey", "1786", "82460.11 (Optimist Intermediate)"),
        ("6809147a-acdc-5a68-9d3a-a6ff1f4ecd6e", "Ellery Chai", "1078", "82460.11 (Optimist Intermediate)"),
        ("dd86222a-4380-55f0-b7c9-f727b6f32f65", "Maelyn Gilchrist", "1624", "82460.11 (Optimist Intermediate)"),
        ("98067f40-3792-57bb-9716-fc7bca16d664", "Molly O'Donnell", "48", "82460.11 (Optimist Intermediate)"),
        ("9b4f7a85-aa7d-5d77-9cd7-afb06469bc69", "Sylvia Carlson", "1236", "82460.11 (Optimist Intermediate)"),
    ]

    # (keep_id, merge_id, label, reason)
    merges = [
        ("513cb803-c254-5aa2-9e32-f0f84e91c476", "f64c17d3-dbd0-57b1-a8dc-24c13826fbe0", "Alexandros Seiko Thomaidis", "Same Greek athlete (GRE3231 / GRE5) with reversed surname order at R.O.C. 2026."),
        ("691e47b3-3ada-582b-a8e6-576466fdffbc", "618bac98-6dcb-5c94-b553-3b827d12f461", "Carl Birgersson", "Same athlete (SWE 4946 / DEN 2 / DEN8756) across 2024 Kosmos, 2025 R.O.C., and 2026 Worlds."),
        ("abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6", "d00ec375-6dc8-55f8-8b0e-9505719e0f4e", "Ethan Kiu", "Same HKSI/RHKYC athlete sailing under HKG 506 in SNSC 2023 and 2024 Kosmos."),
        ("8ece753b-6d66-acf3-f6c0-f7b73cef8100", "1e650ba8-9500-5942-972b-7b5e6e7ac8c4", "Giorgos Papavasileiou", "Same athlete (GRE3161 -> MON 227175) across 2024 Kosmos and 2026 ILCA 4 Youth Worlds."),
        ("8209fc88-14a4-5642-a10e-b99459c49348", "6884967e-5f08-59ac-82dd-05f8a1e04465", "Luca Nueschen", "Same athlete (USA23661 charter at 2024 Kosmos -> ESP 3733 at 2026 Europeans)."),
        ("fb1901c9-319b-8180-7310-a0ba953118d3", "beb0f823-82d4-595b-af29-0592606fefc9", "Mark Slotboom", "Same Yacht Club de Monaco athlete (GRE3081 charter at 2025 Kosmos -> MON 221163)."),
        ("cf755c52-e110-54fa-b05f-84b31fd1e84c", "b14c9b83-610d-5762-ba00-99b8b05d52d9", "Maryam Consolini", "Same athlete (ITA249 -> MAR 127) across 2025 Kosmos and 2026 Worlds."),
        ("bca1d7ab-46b1-5b6e-8ebb-4b005ee90d48", "0179f2ce-0a77-5da6-bd83-9e98b6ec9101", "Nikole Victoria Douglass", "Same athlete (ESP3111 -> UKR 317) across 2025 Kosmos, 2026 Worlds, and 2026 R.O.C."),
        ("9947ea73-32cb-5599-a5b8-6410fa10d206", "b8a5d0ac-8d18-4dde-b5d8-a21d950c75fe", "Toprak Caglayan", "Same athlete (TUR1123 at 2024 Kosmos -> Team Abu Dhabi UAE 217415 at 2026 Mussanah)."),
        ("31b6b1e2-632c-48c2-bd63-3cb98fcefd31", "7ec7f344-b352-5fb5-beb1-324dfe74025e", "Youjia Xu", "Same athlete (CHN 272 / GRE3083 charter at 2026 Kosmos, identical DOB 2011-01-01)."),
        ("3ecd12a0-9c8f-42e7-adfe-1094e760c0b3", "042e1398-2b8b-5dc5-943c-9b5024b549a7", "Zihan Liu", "Same HKSI athlete sailing under HKG 253 in SNSC 2023, 2023 Asians, and 2024 Kosmos."),
        ("7798f226-3db1-54d0-939e-dfc42047e352", "e239a714-2ba4-5e49-9263-2cec118db750", "Nicolas Rigas Charalambous", "Same CYP100 athlete (middle name vs initial)."),
        ("45d8b966-72b2-53e5-b56e-416f0b3b398c", "4f29a097-e2e5-519d-80d8-9e0f02ffeba5", "Theodoros Georgios Eracleous", "Same CYP105 athlete (Georgios vs Georghios spelling variant)."),
        ("347488c5-18ea-5414-9f73-ed83525d4b94", "03e7d6d9-6b80-568f-b591-747cbc88b7a5", "Rafael Nicolaou", "Same CYP12 athlete (Nicolaou vs Nikolaou spelling variant)."),
        ("9e2d9e84-b37b-5c44-a92b-3b761b515cfd", "5f64c816-b5fb-53e9-b2ac-e4aec68abce9", "Juan Pablo Garcia Laconico", "Same CYP46 athlete (full surname vs short surname)."),
        ("cd5d1fbb-1eff-54a7-b23d-c17ca21246ba", "ddc9bd35-9933-57de-a19f-50ee7e70afd9", "Lucia Pascual Cabrera", "Same ESP3481 athlete (middle name vs initial)."),
        ("1d9f0584-544c-5d76-8353-d29c2fd2c3d0", "602a2ecb-bafd-5d5e-8922-402e75ec72b4", "Hugo Gonzalez Morales", "Same ESP3584 athlete (two surnames vs one)."),
        ("f8188019-23f4-5c5e-89c3-6af6513381d3", "eacd5ff6-0d47-5ab6-94bd-56fcf198a233", "Tomas Carbonell Monte", "Same ESP3651 athlete (Carbonell Monte vs Carbonnell)."),
        ("175248f9-87d6-5472-b98a-b6aaa587b8d9", "e3728eba-92fc-5234-a431-2bede3a04c8d", "Thodoris N. Andritsopoulos", "Same GRE1027 athlete (with/without middle initial N.)."),
        ("8cdc808c-126e-5b0d-b612-5dbecfc9c160", "2b943667-c7f5-5062-ae20-baf70f413538", "Odysseas Apostolos Moschos", "Same GRE1030 athlete (with/without middle name Apostolos)."),
        ("91a26841-850c-56ae-942f-62b3d29b4125", "a78c773b-f55f-526c-8396-d792eaeaa191", "Magdalini D. Panagiotopoulou", "Same GRE2698 athlete (Panagiotopoulou vs Papagiotopoulou typo)."),
        ("caf3d567-b590-55f6-ab08-9ad79cf8bd3f", "0decba07-172c-5fb3-9218-9d153f63eb6b", "Marios Panagiotis Moschos", "Same GRE2820 athlete (with/without middle name Panagiotis)."),
        ("181bc8bc-31fc-505a-9990-6263a0fd88aa", "cfb4eb58-8611-5931-a847-b7e5d61f9d38", "Agis Christos Angelopoulos", "Same GRE3074 athlete (Christos vs C.)."),
        ("d468159b-f0f9-54db-bcbe-128f8b936eaf", "eb850c44-35bf-5aa5-95c1-c2312c02a071", "Maria Paisia Kelli", "Same GRE3128 athlete (Paisia vs P.)."),
        ("dfb04a34-e6c2-5381-a9c2-19455f3486e1", "5771a286-e87a-56c8-8d83-829b9b410335", "Christos Diangelakis", "Same GRE3242 athlete (Diangelakis vs Diaggelakis transliteration)."),
        ("de9bae1a-a687-5d5a-92eb-eb88a7d6dfe2", "4383d548-cb49-53d2-be7f-4fca586de4de", "Jorge Munoz Uribe", "Same MEX1041 athlete (with/without accent & second surname)."),
        ("c2f694f9-dcff-4e9b-95da-4ec8a4ba12f8", "29ddfa4f-539c-562f-a972-71323cabb063", "Hilda Wallstrom", "Same SWE4882 athlete (Wallström vs Wallstrom)."),
    ]

    keep_separates = [
        ("9ef5cb54-a5f2-5c06-9c07-14abd1f76215", "b6ece983-f66d-52c7-b559-1bc2f2dc387c", "Christos Psaltis / Christos Michalakis", "Distinct Greek sailors sharing charter sail GRE3077 across 2024 vs 2025 Kosmos."),
        ("8139af57-2867-51a4-880d-ea4548b04c6c", "f9bed12a-11a2-55ed-8404-87f8a5a4f14c", "Diego Andres Delgado Ripepi / Diego C. Marrero", "Distinct Puerto Rican sailors sharing R.O.C. charter code PUR 2 across 2024 and 2025."),
        ("8139af57-2867-51a4-880d-ea4548b04c6c", "fd9ef3af-9d28-5346-a57a-cca7a4cce2df", "Diego Andres Delgado Ripepi / Diego J. Marrero", "Distinct Puerto Rican sailors sharing R.O.C. charter code PUR 2 across 2023 and 2025."),
        ("19971e93-836b-40bc-b75d-7720eb3a0ba7", "ab1187f5-9a3a-50a5-9407-60769dd0a492", "Russell Xavier Quek / Russell Lim", "Distinct Singapore sailors who used sail number 3008 in different years."),
        ("87aee68c-038c-53d5-8294-6daf8fb1167a", "b22f69f0-2da0-539b-b720-1eb2c1316008", "Caleb Lim Xinquan / Caleb Aaron Quek", "Distinct Singapore sailors who used sail number 3286."),
        ("2b3ed2fa-a6ec-59ac-9227-b780e15f2b69", "a8fd220f-14f1-5610-88bb-ed6681ce72c6", "マーズデン 琥海 / マーズデン 珀空", "Distinct Japanese siblings sharing family sail JPN 1526."),
        ("08ea54bb-85c7-57ec-852e-b4e43ec045ec", "96dac3a2-4d7f-53b0-af17-808c44056f3d", "舩澤 夏美 / 舩澤 夏子", "Distinct Japanese sisters sharing family sail JPN 3525."),
        ("5b9e6612-96be-592e-bd9b-06b558b96f63", "c9df556b-7b8e-5944-92c8-0cc863207d9b", "Muhammad Abrisam Athmar Bin Aslan / Muhammad Yusri Bin Syahrizan", "Distinct Malaysian sailors sharing sail 56051."),
        ("7d79261f-75e1-5069-a10e-567d9c9816f3", "f1d035dc-2510-5f18-a6d0-09b8f9827d52", "Nur Aqilah Raifana Binti Aslan / Nur Asma Binti Syahrizan", "Distinct Malaysian sailors sharing sail 56054."),
        ("580a0306-cd4c-548f-a98c-38bde8e7846c", "9e4c2cd7-24d6-51e0-8d7e-5e6d91ee137a", "Muhammad Nazmi Qusyairi Bin Mohd Nazri / Muhammad Idris Bin Mohd Zahawi", "Distinct Malaysian sailors sharing sail 57346."),
    ]

    lines = [
        "-- Migration: 20261118101000_daily_audit_enrichments_merges_and_monitors.sql",
        "-- Description: Daily audit (2026-11-18) verified demographic enrichments, gender/nationality fixes,",
        "--              27 duplicate sailor merges, 10 keep-separate registrations, monitor updates,",
        "--              SNSC 2026 official result URLs, and SNSC 2026 Gold 6-race Index fix.",
        "",
        "BEGIN;",
        "",
        "-- ============================================================================",
        "-- 1. VERIFIED DEMOGRAPHIC ENRICHMENTS & CORRECTIONS",
        "-- ============================================================================",
        "",
    ]

    for sid, name, sail, src in nsw_girls:
        lines.append(f"-- {name} (AUS {sail}) -> F ({src})")
        lines.append(f"UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '{sid}' AND (gender IS NULL OR gender = '');")
        lines.append(f"UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = '{sid}' AND (gender IS NULL OR gender = '');")
    lines.append("")

    lines.extend([
        "-- Songha Lee (KOR 223204): M -> F (2026 ILCA 4 Youth Worlds Girls, 2026 LYSC ILCA 4 Women, 2026 Asian Games Girls Bronze)",
        "UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d';",
        "UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = 'd3bdd575-51a9-46c8-8b02-b254b18b100d' AND gender IS DISTINCT FROM 'F';",
        "",
        "-- En-Rui Hsu (TPE 208532): M -> F (115th President's Cup ILCA 4 Girls 女子組, 2024 Asians)",
        "UPDATE public.sailors SET gender = 'F', updated_at = clock_timestamp() WHERE id = '70371bac-6222-4625-8df8-296f67f622dc';",
        "UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp() WHERE sailor_id = '70371bac-6222-4625-8df8-296f67f622dc' AND gender IS DISTINCT FROM 'F';",
        "",
        "-- Sync rsyc-2026-silver result-level gender for An Hu & Yu An Li (both F)",
        "UPDATE public.regatta_results SET gender = 'F', updated_at = clock_timestamp()",
        "WHERE sailor_id IN ('0d6be542-5e52-496c-b9e9-cb30fb83b218', '05a5835e-9845-4a66-9357-c901f95ecea7') AND gender IS DISTINCT FROM 'F';",
        "",
        "-- Ethan Kiu & Zihan Liu: override auto-guessed SGP nationality_from_sail -> HKG (HKSI)",
        "UPDATE public.sailors SET nationality = 'HKG', nationality_from_sail = false, updated_at = clock_timestamp()",
        "WHERE id IN ('abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3');",
        "",
        "-- ============================================================================",
        "-- 2. MERGE 27 VERIFIED DUPLICATE SAILOR PAIRS",
        "-- ============================================================================",
        "",
    ])

    for keep_id, merge_id, label, reason in merges:
        lines.extend([
            f"-- Merge {label}: {merge_id} -> {keep_id}",
            "UPDATE public.regatta_results",
            f"SET sailor_id = '{keep_id}', updated_at = clock_timestamp()",
            f"WHERE sailor_id = '{merge_id}'",
            f"  AND NOT EXISTS (SELECT 1 FROM public.regatta_results r2 WHERE r2.sailor_id = '{keep_id}' AND r2.regatta_id = regatta_results.regatta_id);",
            "UPDATE public.regatta_result_participants",
            f"SET sailor_id = '{keep_id}', updated_at = clock_timestamp()",
            f"WHERE sailor_id = '{merge_id}';",
            "UPDATE public.sailor_aliases",
            f"SET sailor_id = '{keep_id}'",
            f"WHERE sailor_id = '{merge_id}'",
            f"  AND NOT EXISTS (SELECT 1 FROM public.sailor_aliases sa2 WHERE sa2.sailor_id = '{keep_id}' AND sa2.alias = sailor_aliases.alias);",
            "UPDATE public.asian_optimist_index_sailors",
            f"SET sailor_id = '{keep_id}', updated_at = clock_timestamp()",
            f"WHERE sailor_id = '{merge_id}';",
            f"DELETE FROM public.sailors WHERE id = '{merge_id}';",
            "INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)",
            f"SELECT 'sailors.duplicates.merge', 'sailor', '{keep_id}', {sql_str(label)},",
            f"  {sql_str(f'Merged duplicate profile {merge_id} into {keep_id}.')},",
            f"  jsonb_build_object('survivorId', '{keep_id}', 'mergedId', '{merge_id}', 'reason', {sql_str(reason)}),",
            "  'daily_audit_20261118', clock_timestamp()",
            f"WHERE EXISTS (SELECT 1 FROM public.sailors WHERE id = '{keep_id}');",
            "",
        ])

    lines.extend([
        "-- ============================================================================",
        "-- 3. REGISTER 10 KEEP-SEPARATE PAIRS IN ADMIN_CHANGE_LOG",
        "-- ============================================================================",
        "",
    ])
    for a_id, b_id, label, reason in keep_separates:
        lo, hi = sorted([a_id, b_id])
        pair_key = f"{lo}|{hi}"
        lines.extend([
            "INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)",
            "SELECT 'sailors.duplicates.keep_separate', 'sailor',",
            f"  '{lo}', {sql_str(label)}, 'Confirmed these are different sailors.',",
            f"  jsonb_build_object('pairKey', '{pair_key}', 'reason', {sql_str(reason)}),",
            "  'daily_audit_20261118', clock_timestamp()",
            "WHERE NOT EXISTS (",
            "  SELECT 1 FROM public.admin_change_log",
            f"  WHERE action = 'sailors.duplicates.keep_separate' AND details->>'pairKey' = '{pair_key}'",
            ");",
        ])

    lines.extend([
        "",
        "-- ============================================================================",
        "-- 4. RESULT IMPORT MONITORS, SNSC 2026 OFFICIAL URLS & 6-RACE INDEX FIX",
        "-- ============================================================================",
        "",
        "-- 2026 Chesva Regatta of Champions: Race 14 final PDF already published",
        "UPDATE public.result_import_monitors",
        "SET report = jsonb_set(jsonb_set(COALESCE(report, '{}'::jsonb), '{status}', '\"reviewed\"'::jsonb), '{pdfCorroboration}', '\"verified\"'::jsonb)",
        "WHERE event_id = '52e16c9b-ea1a-5698-a3fa-2ba518e1bb6f';",
        "",
        "-- Singapore National Sailing Championships 2026: mark reviewed + backfill official URLs",
        "UPDATE public.result_import_monitors",
        "SET report = jsonb_set(jsonb_set(COALESCE(report, '{}'::jsonb), '{status}', '\"reviewed\"'::jsonb), '{pdfCorroboration}', '\"verified\"'::jsonb)",
        "WHERE event_id = 'f248e22e-34bf-4dcb-8a3c-50ec8c68ce3e';",
        "",
        "UPDATE public.regattas SET official_results_url = 'https://www.racingrulesofsailing.org/documents/206850', official_results_source_name = 'OP Gold Final Results.pdf (SSF, 6 races)', updated_at = clock_timestamp() WHERE slug = 'singapore-national-sailing-championships-2026-gold';",
        "UPDATE public.regattas SET official_results_url = 'https://drive.google.com/file/d/1KzATo7dIxvyxAJQ1Zip5lTOFikYCKdx2/view?usp=sharing', official_results_source_name = 'SSF SNSC 2026 Optimist Silver Fleet PDF', updated_at = clock_timestamp() WHERE slug = 'singapore-national-sailing-championships-2026-silver';",
        "UPDATE public.regattas SET official_results_url = 'https://drive.google.com/file/d/1mBVnXEmo7osTdfynhF_kngZBXeknEz_O/view?usp=sharing', official_results_source_name = 'SSF SNSC 2026 ILCA 4 PDF', updated_at = clock_timestamp() WHERE slug = 'singapore-national-sailing-championships-2026-ilca4';",
        "UPDATE public.regattas SET official_results_url = 'https://drive.google.com/file/d/18TAmgj9r-5-bhifp2AMr_N9tF_iXZRxx/view?usp=sharing', official_results_source_name = 'SSF SNSC 2026 ILCA 6 PDF', updated_at = clock_timestamp() WHERE slug = 'snsc-ilca-6-sep-26';",
        "",
        "-- SNSC 2026 Gold official final PDF has 6 races (1 discard, 5 to count)",
        "UPDATE public.asian_optimist_index_events",
        "SET race_count = 6, discard_count = 1, updated_at = clock_timestamp()",
        "WHERE id = 'snsc-gold-sep-26-2026-09-11';",
        "",
        "-- 2026 WAIODA Optimist WA State Championships: point monitor to RFBYC portal & mark reviewed",
        "UPDATE public.result_import_monitors",
        "SET event_url = 'https://rfbyc.asn.au/web/pages/optimiststatechampionships2026',",
        "    report = jsonb_set(jsonb_set(COALESCE(report, '{}'::jsonb), '{status}', '\"reviewed\"'::jsonb), '{pdfCorroboration}', '\"not_found_in_checked_pages\"'::jsonb)",
        "WHERE event_id = 'f30715c5-c80c-433a-a6e2-6f7b61e5ed2b';",
        "",
        "COMMIT;",
    ])
    return "\n".join(lines) + "\n"


def build_waioda_migration() -> str:
    waioda = json.loads(WAIODA_JSON.read_text())
    raw_aus = json.loads(AUS_JSON.read_text())["result"]
    m = re.search(r"<untrusted-data-[^>]+>\n(.*?)\n</untrusted-data-", raw_aus, re.S)
    aus_sailors = json.loads(m.group(1))
    by_name = {}
    for s in aus_sailors:
        by_name[s["name"].strip().lower()] = s

    event_id = "f30715c5-c80c-433a-a6e2-6f7b61e5ed2b"
    open_url = "https://www.sportspage.com.au/yacht_clubs/rfbyc/OptimistStates2026/Open_Fleet_Championship.htm"
    int_url = "https://www.sportspage.com.au/yacht_clubs/rfbyc/OptimistStates2026/Intermediate_Fleet_Championship.htm"

    lines = [
        "-- Migration: 20261118101500_import_waioda_2026_optimist_state_championships.sql",
        "-- Description: Import 2026 WAIODA Optimist WA State Championships (Open 23, Intermediate 19; 10 races, 2 discards).",
        "-- Source: Royal Freshwater Bay Yacht Club / Sportspage official result sheets (no official PDF published; confirmed final by user).",
        "",
        "BEGIN;",
        "",
        "CREATE TEMP TABLE _waioda_2026_payload (",
        "  fleet text NOT NULL,",
        "  source_rank integer NOT NULL,",
        "  sail_number text NOT NULL,",
        "  source_name text NOT NULL,",
        "  club text NOT NULL,",
        "  total_score real NOT NULL,",
        "  nett_score real NOT NULL,",
        "  race_scores jsonb NOT NULL,",
        "  sailor_id uuid,",
        "  handle text",
        ") ON COMMIT DROP;",
        "",
        "INSERT INTO _waioda_2026_payload (fleet, source_rank, sail_number, source_name, club, total_score, nett_score, race_scores, sailor_id, handle) VALUES",
    ]

    rows_sql = []
    for fleet_key, fleet_name in (("open", "Open"), ("intermediate", "Intermediate")):
        for r in waioda[fleet_key]:
            existing = by_name.get(r["name"].strip().lower())
            sid = f"'{existing['id']}'::uuid" if existing else "NULL"
            slug_name = re.sub(r"[^a-z0-9]+", "-", r["name"].lower()).strip("-")[:18]
            h = f"'waioda26-{slug_name}-{r['sail'].lower()}'"
            races_json = json.dumps(r["races"])
            rows_sql.append(
                f"  ('{fleet_name}', {r['rank']}, {sql_str(r['sail'])}, {sql_str(r['name'])}, {sql_str(r['club'])}, {r['total']}, {r['nett']}, {sql_str(races_json)}::jsonb, {sid}, {h})"
            )
    lines.append(",\n".join(rows_sql) + ";")
    lines.extend([
        "",
        "-- Create minimal profiles for the 7 new WAIODA sailors",
        "INSERT INTO public.sailors (id, name, handle, sail_number, club, nationality, created_at, updated_at)",
        "SELECT gen_random_uuid(), p.source_name, p.handle, p.sail_number, p.club, 'AUS', now(), now()",
        "FROM _waioda_2026_payload p",
        "WHERE p.sailor_id IS NULL",
        "ON CONFLICT (handle) DO NOTHING;",
        "",
        "UPDATE _waioda_2026_payload p",
        "SET sailor_id = s.id",
        "FROM public.sailors s",
        "WHERE p.sailor_id IS NULL AND s.handle = p.handle;",
        "",
        f"UPDATE public.regatta_events SET venue = 'Royal Freshwater Bay Yacht Club, Peppermint Grove, WA', organizer = 'WAIODA / Royal Freshwater Bay Yacht Club', nor_url = 'https://rfbyc.asn.au/web/pages/optimiststatechampionships2026', scoring_rules = 'Appendix A low-point system; 10 races sailed, 8 to count (2 discards).', updated_at = now() WHERE id = '{event_id}';",
        "",
        "WITH fleets (slug, name, division, fleet_size, url) AS (VALUES",
        f"  ('waioda-optimist-wa-state-championships-2026-open', '2026 WAIODA Optimist WA State Championships — Open Fleet', 'Open', 23, '{open_url}'),",
        f"  ('waioda-optimist-wa-state-championships-2026-intermediate', '2026 WAIODA Optimist WA State Championships — Intermediate Fleet', 'Intermediate', 19, '{int_url}')",
        ")",
        "INSERT INTO public.regattas (",
        "  id, event_id, name, slug, date, end_date, total_fleet_size, division, race_count,",
        "  geography, boat_class, counts_for_ranking, is_selection_trial, venue, organizer,",
        "  official_results_url, official_results_source_name, schedule_notes, status, created_at, updated_at",
        ")",
        "SELECT gen_random_uuid(), " + f"'{event_id}'::uuid" + ", f.name, f.slug, DATE '2026-11-14', DATE '2026-11-15',",
        "  f.fleet_size, f.division, 10, 'AUS', 'Optimist', false, false,",
        "  'Royal Freshwater Bay Yacht Club, Peppermint Grove, WA', 'WAIODA / Royal Freshwater Bay Yacht Club',",
        "  f.url, 'RFBYC / Sportspage Official Results (15 Nov 2026)',",
        "  f.fleet_size::text || ' entries · 10 races · 2 discards · official RFBYC/Sportspage results.',",
        "  'published', now(), now()",
        "FROM fleets f",
        "ON CONFLICT (slug) DO UPDATE SET",
        "  event_id = EXCLUDED.event_id, name = EXCLUDED.name, total_fleet_size = EXCLUDED.total_fleet_size,",
        "  race_count = 10, official_results_url = EXCLUDED.official_results_url, status = 'published', updated_at = now();",
        "",
        "DELETE FROM public.regatta_results WHERE regatta_id IN (",
        "  SELECT id FROM public.regattas WHERE slug IN ('waioda-optimist-wa-state-championships-2026-open', 'waioda-optimist-wa-state-championships-2026-intermediate')",
        ");",
        "",
        "INSERT INTO public.regatta_results (",
        "  id, sailor_id, entry_label, entry_sail_number, entry_type, regatta_id, rank,",
        "  nett_score, total_score, is_dns, is_overseas_commitment, gender, birth_year, nationality,",
        "  evidence_url, evidence_name, evidence_type, official_url, evidence_notes,",
        "  verification_status, verified_at, created_at, updated_at",
        ")",
        "SELECT gen_random_uuid(), p.sailor_id, p.source_name, p.sail_number, 'individual',",
        "  r.id, p.source_rank, p.nett_score, p.total_score, false, false, s.gender,",
        "  CASE WHEN s.dob IS NOT NULL THEN EXTRACT(YEAR FROM s.dob)::int ELSE NULL END, COALESCE(s.nationality, 'AUS'),",
        "  r.official_results_url, r.official_results_source_name, 'link', r.official_results_url,",
        "  'Imported from RFBYC / Sportspage official result sheet (confirmed final by user; no official PDF published).',",
        "  'verified', now(), now(), now()",
        "FROM _waioda_2026_payload p",
        "JOIN public.sailors s ON s.id = p.sailor_id",
        "JOIN public.regattas r ON r.slug = CASE p.fleet WHEN 'Open' THEN 'waioda-optimist-wa-state-championships-2026-open' ELSE 'waioda-optimist-wa-state-championships-2026-intermediate' END;",
        "",
        "INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at)",
        "SELECT gen_random_uuid(), rr.id, p.sailor_id, p.source_name, 0, 'solo', 'matched', false, now(), now()",
        "FROM _waioda_2026_payload p",
        "JOIN public.regattas r ON r.slug = CASE p.fleet WHEN 'Open' THEN 'waioda-optimist-wa-state-championships-2026-open' ELSE 'waioda-optimist-wa-state-championships-2026-intermediate' END",
        "JOIN public.regatta_results rr ON rr.regatta_id = r.id AND rr.sailor_id = p.sailor_id;",
        "",
        "INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)",
        "SELECT gen_random_uuid(), rr.id, token.ordinality::integer,",
        "  (regexp_match(token.raw_value, '([0-9.]+)'))[1]::real,",
        "  NULLIF(NULLIF((regexp_match(token.raw_value, '\\(([^)]+)\\)'))[1], (regexp_match(token.raw_value, '([0-9.]+)'))[1]), ''),",
        "  token.raw_value LIKE '[%',",
        "  token.raw_value, now(), now()",
        "FROM _waioda_2026_payload p",
        "JOIN public.regattas r ON r.slug = CASE p.fleet WHEN 'Open' THEN 'waioda-optimist-wa-state-championships-2026-open' ELSE 'waioda-optimist-wa-state-championships-2026-intermediate' END",
        "JOIN public.regatta_results rr ON rr.regatta_id = r.id AND rr.sailor_id = p.sailor_id",
        "CROSS JOIN LATERAL jsonb_array_elements_text(p.race_scores) WITH ORDINALITY AS token(raw_value, ordinality);",
        "",
        "INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)",
        "VALUES (",
        f"  'import', 'regatta', '{event_id}', '2026 WAIODA Optimist WA State Championships',",
        "  'Imported Open (23) and Intermediate (19) fleets from official RFBYC/Sportspage result sheets.',",
        f"  jsonb_build_object('open_entries', 23, 'intermediate_entries', 19, 'races', 10, 'pdf_corroboration', 'unavailable_on_rfbyc_waioda'),",
        "  'daily_audit_20261118', clock_timestamp()",
        ");",
        "",
        "COMMIT;",
    ])
    return "\n".join(lines) + "\n"


if __name__ == "__main__":
    p1 = MIGRATIONS / "20261118101000_daily_audit_enrichments_merges_and_monitors.sql"
    p2 = MIGRATIONS / "20261118101500_import_waioda_2026_optimist_state_championships.sql"
    p1.write_text(build_daily_audit_migration())
    p2.write_text(build_waioda_migration())
    print("Generated:", p1)
    print("Generated:", p2)
