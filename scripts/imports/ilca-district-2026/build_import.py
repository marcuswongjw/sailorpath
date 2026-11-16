#!/usr/bin/env python3
"""
Build idempotent SQL import for ILCA District Championships 2026
Official Final Result PDF: https://www.racingrulesofsailing.org/documents/215450
Event ONB: https://www.racingrulesofsailing.org/documents/15433/event
"""

import json
import re
import uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
PARSED_PATH = ROOT / ".work" / "ilca-district-2026" / "parsed_results.json"
SAILORS_PATH = ROOT / ".work" / "ilca-district-2026" / "db_sailors.json"
ALIASES_PATH = ROOT / ".work" / "ilca-district-2026" / "db_aliases.json"
OUT_SQL = Path(__file__).resolve().parent / "import.sql"

NS = uuid.UUID("7f3b8c9a-2026-4d11-9a10-154330215450")

OFFICIAL_PDF_URL = "https://www.racingrulesofsailing.org/documents/215450"
EVENT_NAME = "ILCA District Championships 2026"
EVENT_SLUG = "ilca-district-championships-2026"
VENUE = "Royal Varuna Yacht Club, Pattaya, Thailand"
ORGANIZER = "Royal Varuna Yacht Club"
START_DATE = "2026-11-06"
END_DATE = "2026-11-08"

# Explicit verified overrides for non-exact name matches & new profiles
MANUAL_SAILOR_MAP = {
    "KITCHAKHUN SOMKHANNGOEN": "90a471f5-bd58-400f-a995-e115951ee1ed",
    "CHIFANG,HUANG": "9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24",
    "REYES TAN": "f268697a-ceb4-483a-8a53-9c5241f3f0cc",
    "JOSH ONG": "607e25ec-a16d-47e7-9782-8cc5406fdd93",
    "JOEL TAN": "79c4b615-7fb3-4c94-81f9-a962cf28d31e",
    "AKTANON JONGJUGKAPHAN": "fda6a9f7-be61-4f3b-8f64-7f29c75592c1",
    "YISAN,HUANG": "2bb09661-11b7-5714-a6b2-a495ed6f517f",
    "AIR MARSHAL AYUTH SALIGUPTA": "6610e632-bab1-56a5-b382-4eb478eab3ad",
    "CHRISTAN WIEDMANN": "3b468b8a-579d-5429-8d3f-27db5e17aed2",
}

NEW_SAILORS = {
    "AARON TAUNT": {
        "id": str(uuid.uuid5(NS, "sailor:AARON TAUNT:1965:THA")),
        "name": "Aaron Taunt",
        "handle": "aaron-taunt",
        "nationality": "THA",
        "gender": "M",
        "club": "RVYC",
        "sail_number": "194999",
    },
    "KEVIN WHITCRAFT": {
        "id": str(uuid.uuid5(NS, "sailor:KEVIN WHITCRAFT:1963:THA")),
        "name": "Kevin Whitcraft",
        "handle": "kevin-whitcraft",
        "nationality": "THA",
        "gender": "M",
        "club": "RVYC",
        "sail_number": "222323",
    },
}

CLASS_META = {
    "ILCA 4": {
        "slug": "ilca-district-championships-2026-ilca-4",
        "name": "ILCA District Championships 2026 — ILCA 4",
        "evidence_name": "Final Result — ILCA District Championships 2026 — ILCA 4",
        "fleet_size": 45,
    },
    "ILCA 6": {
        "slug": "ilca-district-championships-2026-ilca-6",
        "name": "ILCA District Championships 2026 — ILCA 6",
        "evidence_name": "Final Result — ILCA District Championships 2026 — ILCA 6",
        "fleet_size": 15,
    },
    "ILCA 7": {
        "slug": "ilca-district-championships-2026-ilca-7",
        "name": "ILCA District Championships 2026 — ILCA 7",
        "evidence_name": "Final Result — ILCA District Championships 2026 — ILCA 7",
        "fleet_size": 10,
    },
}


def norm(s: str) -> str:
    return re.sub(r"[^a-z0-9]+", " ", (s or "").lower()).strip()


def variants(name: str) -> set[str]:
    vs = {norm(name)}
    if "," in name:
        p0, p1 = [p.strip() for p in name.split(",", 1)]
        vs.add(norm(p0 + " " + p1))
        vs.add(norm(p1 + " " + p0))
    toks = norm(name).split()
    if len(toks) >= 2:
        vs.add(" ".join(reversed(toks)))
        vs.add(" ".join(sorted(toks)))
    return vs


def sql_str(v) -> str:
    if v is None:
        return "NULL"
    return "'" + str(v).replace("'", "''") + "'"


def fmt_num(v: float) -> str:
    return str(int(v)) if float(v).is_integer() else str(v)


def main() -> None:
    rows = json.loads(PARSED_PATH.read_text())
    db_s = json.loads(SAILORS_PATH.read_text())["rows"]
    db_a = json.loads(ALIASES_PATH.read_text())["rows"]

    name_index: dict[str, set[str]] = {}
    for s in db_s:
        for v in variants(s["name"]):
            name_index.setdefault(v, set()).add(s["id"])
    for a in db_a:
        for v in variants(a["alias_name"]):
            name_index.setdefault(v, set()).add(a["sailor_id"])

    existing_aliases = {(a["sailor_id"], a["alias_name"].strip().lower()) for a in db_a}

    lines: list[str] = [
        "-- ILCA District Championships 2026 (Royal Varuna Yacht Club)",
        f"-- Official Final Result PDF: {OFFICIAL_PDF_URL}",
        "BEGIN;",
        "SELECT pg_advisory_xact_lock(20261108, 15433);",
        "",
        "-- 1. New sailor profiles (no invented DOBs)",
    ]

    for key, ns in NEW_SAILORS.items():
        lines.append(
            "INSERT INTO public.sailors (id, name, handle, nationality, gender, club, sail_number) "
            f"VALUES ({sql_str(ns['id'])}, {sql_str(ns['name'])}, {sql_str(ns['handle'])}, {sql_str(ns['nationality'])}, "
            f"{sql_str(ns['gender'])}, {sql_str(ns['club'])}, {sql_str(ns['sail_number'])}) "
            "ON CONFLICT (id) DO NOTHING;"
        )

    lines.append("")
    lines.append("-- 2. Sailor aliases for PDF source names")
    aliases_to_add: list[tuple[str, str]] = []
    for helm, sid in MANUAL_SAILOR_MAP.items():
        if (sid, helm.strip().lower()) not in existing_aliases:
            aliases_to_add.append((sid, helm))
    for helm, ns in NEW_SAILORS.items():
        if helm.upper() != ns["name"].upper():
            aliases_to_add.append((ns["id"], helm))
    for sid, alias in aliases_to_add:
        aid = str(uuid.uuid5(NS, f"alias:{sid}:{alias}"))
        lines.append(
            "INSERT INTO public.sailor_aliases (id, sailor_id, alias_name) "
            f"VALUES ({sql_str(aid)}, {sql_str(sid)}, {sql_str(alias)}) "
            "ON CONFLICT DO NOTHING;"
        )

    event_id = str(uuid.uuid5(NS, f"event:{EVENT_SLUG}"))
    lines.extend([
        "",
        "-- 3. Regatta Event",
        "INSERT INTO public.regatta_events (id, name, slug, start_date, end_date, venue, organizer, classes, counts_for_ranking, is_selection_trial, nor_url, schedule_summary, scoring_rules) VALUES ("
        f"{sql_str(event_id)}, {sql_str(EVENT_NAME)}, {sql_str(EVENT_SLUG)}, {sql_str(START_DATE)}, {sql_str(END_DATE)}, "
        f"{sql_str(VENUE)}, {sql_str(ORGANIZER)}, '[\"ILCA 4\", \"ILCA 6\", \"ILCA 7\"]'::jsonb, false, false, "
        "'https://www.racingrulesofsailing.org/documents/214937', "
        "'Official final class results imported from Royal Varuna Yacht Club Sailwave PDF (7 races, 1 discard).', "
        "'Appendix A low points; 7 races completed with 1 discard per fleet.'"
        ") ON CONFLICT (id) DO NOTHING;",
    ])

    lines.append("")
    lines.append("-- 4. Regattas (3 Open class sheets)")
    regatta_ids: dict[str, str] = {}
    for cls, meta in CLASS_META.items():
        rid = str(uuid.uuid5(NS, f"regatta:{meta['slug']}"))
        regatta_ids[cls] = rid
        lines.append(
            "INSERT INTO public.regattas (id, event_id, name, slug, date, end_date, venue, organizer, boat_class, division, race_count, total_fleet_size, entry_type, counts_for_ranking, status, geography, official_results_url, official_results_source_name, schedule_notes) VALUES ("
            f"{sql_str(rid)}, {sql_str(event_id)}, {sql_str(meta['name'])}, {sql_str(meta['slug'])}, "
            f"{sql_str(START_DATE)}, {sql_str(END_DATE)}, {sql_str(VENUE)}, {sql_str(ORGANIZER)}, "
            f"{sql_str(cls)}, 'Open', 7, {meta['fleet_size']}, 'individual', false, 'published', 'THA', "
            f"{sql_str(OFFICIAL_PDF_URL)}, {sql_str(meta['evidence_name'])}, "
            "'Sailwave Scoring Software 2.38.02; 7 races sailed, 1 discard; published 2026-11-08 14:45.'"
            ") ON CONFLICT (id) DO NOTHING;"
        )

    lines.append("")
    lines.append("-- 5. Regatta Results, Participants, and Race Results")
    for r in rows:
        cls = r["class"]
        rid = regatta_ids[cls]
        helm = r["helm_name"]
        if helm in MANUAL_SAILOR_MAP:
            sid = MANUAL_SAILOR_MAP[helm]
        elif helm in NEW_SAILORS:
            sid = NEW_SAILORS[helm]["id"]
        else:
            strict_vs = {norm(helm)}
            if "," in helm:
                p0, p1 = [p.strip() for p in helm.split(",", 1)]
                strict_vs.add(norm(p0 + " " + p1))
                strict_vs.add(norm(p1 + " " + p0))
            mids = set()
            for v in strict_vs:
                mids |= name_index.get(v, set())
            if not mids:
                for v in variants(helm):
                    mids |= name_index.get(v, set())
            assert len(mids) == 1, f"Expected 1 match for {helm}, got {mids}"
            sid = next(iter(mids))

        rr_id = str(uuid.uuid5(NS, f"result:{rid}:{r['rank']}:{sid}"))
        rrp_id = str(uuid.uuid5(NS, f"participant:{rr_id}:{sid}"))
        g_short = "M" if r["gender"] == "Male" else ("F" if r["gender"] == "Female" else None)
        sail_lbl = f"{r['nat']} {r['sail_number']}"
        ev_name = CLASS_META[cls]["evidence_name"]
        is_dns = all(x["code"] in ("DNC", "DNS") for x in r["races"])

        lines.append(
            "INSERT INTO public.regatta_results (id, sailor_id, regatta_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, official_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at, entry_label, entry_sail_number, entry_type) VALUES ("
            f"{sql_str(rr_id)}, {sql_str(sid)}, {sql_str(rid)}, {r['rank']}, {fmt_num(r['nett'])}, {fmt_num(r['total'])}, "
            f"{'true' if is_dns else 'false'}, false, {sql_str(g_short)}, {sql_str(r['nat'])}, "
            f"{sql_str(OFFICIAL_PDF_URL)}, {sql_str(ev_name)}, 'link', "
            f"{sql_str('Imported from official Final Result PDF (club=' + r['club'] + ', YOB=' + str(r['yob']) + ').')}, "
            f"'verified', NOW(), {sql_str(helm)}, {sql_str(sail_lbl)}, 'individual'"
            ") ON CONFLICT (id) DO NOTHING;"
        )
        lines.append(
            "INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit) VALUES ("
            f"{sql_str(rrp_id)}, {sql_str(rr_id)}, {sql_str(sid)}, {sql_str(helm)}, 1, 'solo', 'matched', false"
            ") ON CONFLICT (id) DO NOTHING;"
        )
        for race_idx, rc in enumerate(r["races"], 1):
            race_id = str(uuid.uuid5(NS, f"race:{rr_id}:{race_idx}"))
            lines.append(
                "INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ("
                f"{sql_str(race_id)}, {sql_str(rr_id)}, {race_idx}, {fmt_num(rc['score'])}, "
                f"{sql_str(rc['code'])}, {'true' if rc['discarded'] else 'false'}, {sql_str(rc['raw'])}"
                ") ON CONFLICT (id) DO NOTHING;"
            )

    lines.append("")
    lines.append("-- 6. Admin Change Log")
    for cls, rid in regatta_ids.items():
        log_id = str(uuid.uuid5(NS, f"changelog:{rid}"))
        lines.append(
            "INSERT INTO public.admin_change_log (id, action, entity_type, entity_id, entity_label, summary, details, source) VALUES ("
            f"{sql_str(log_id)}, 'import', 'regatta', {sql_str(rid)}, {sql_str(CLASS_META[cls]['name'])}, "
            f"{sql_str('Imported ' + str(CLASS_META[cls]['fleet_size']) + ' results (7 races, 1 discard) from official Final Result PDF.')}, "
            f"{sql_str(json.dumps({'official_pdf': OFFICIAL_PDF_URL, 'fleet_size': CLASS_META[cls]['fleet_size'], 'race_count': 7}))}::jsonb, "
            "'ilca-district-2026-import'"
            ") ON CONFLICT (id) DO NOTHING;"
        )

    lines.append("COMMIT;")
    OUT_SQL.write_text("\n".join(lines) + "\n")
    print(f"Wrote {OUT_SQL} ({len(lines)} lines)")


if __name__ == "__main__":
    main()
