#!/usr/bin/env python3
"""
Build idempotent SQL import for all Regatta of Champions (The R.O.C.)
and R.O.C. Kosmos results (2022–2026, excluding Clinics).
"""

import json
import re
import uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
PARSED_PATH = ROOT / ".work" / "roc-import" / "all_parsed.json"
SAILORS_PATH = ROOT / ".work" / "ilca-district-2026" / "db_sailors.json"
ALIASES_PATH = ROOT / ".work" / "ilca-district-2026" / "db_aliases.json"
OUT_SQL = Path(__file__).resolve().parent / "import.sql"

NS = uuid.UUID("9a12c400-2026-4c00-8811-726f63000001")

EVENTS = {
    "2026-roc": {
        "name": "2026 Chesva Regatta of Champions — The R.O.C.",
        "slug": "regatta-of-champions-2026",
        "start_date": "2026-11-11",
        "end_date": "2026-11-14",
        "venue": "Famagusta Nautical Club, Limassol, Cyprus",
        "organizer": "Famagusta Nautical Club & Chesva",
        "classes": '["Optimist"]',
        "geography": "CYP",
    },
    "2026-kosmos": {
        "name": "2026 The R.O.C. Kosmos",
        "slug": "roc-kosmos-2026",
        "start_date": "2026-06-27",
        "end_date": "2026-07-15",
        "venue": "Athens, Greece",
        "organizer": "The R.O.C. & Kalamaki Nautical Club",
        "classes": '["Optimist", "ILCA 4"]',
        "geography": "GRE",
    },
    "2025-roc": {
        "name": "2025 Chesva 2.0 Regatta of Champions — The R.O.C.",
        "slug": "regatta-of-champions-2025",
        "start_date": "2025-11-05",
        "end_date": "2025-11-08",
        "venue": "Famagusta Nautical Club, Limassol, Cyprus",
        "organizer": "Famagusta Nautical Club & Chesva",
        "classes": '["Optimist"]',
        "geography": "CYP",
    },
    "2025-kosmos": {
        "name": "2025 The R.O.C. Kosmos",
        "slug": "roc-kosmos-2025",
        "start_date": "2025-07-24",
        "end_date": "2025-07-31",
        "venue": "Athens, Greece",
        "organizer": "The R.O.C.",
        "classes": '["Optimist"]',
        "geography": "GRE",
    },
    "2024-roc": {
        "name": "2024 Chesva 2.0 Regatta of Champions — The R.O.C.",
        "slug": "regatta-of-champions-2024",
        "start_date": "2024-10-30",
        "end_date": "2024-11-02",
        "venue": "Famagusta Nautical Club, Limassol, Cyprus",
        "organizer": "Famagusta Nautical Club & Chesva",
        "classes": '["Optimist"]',
        "geography": "CYP",
    },
    "2024-kosmos": {
        "name": "2024 The R.O.C. Kosmos",
        "slug": "roc-kosmos-2024",
        "start_date": "2024-06-17",
        "end_date": "2024-06-24",
        "venue": "Athens, Greece",
        "organizer": "The R.O.C.",
        "classes": '["Optimist"]',
        "geography": "GRE",
    },
    "2023-roc": {
        "name": "2023 Chesva 2.0 Regatta of Champions — The R.O.C.",
        "slug": "regatta-of-champions-2023",
        "start_date": "2023-11-15",
        "end_date": "2023-11-18",
        "venue": "Famagusta Nautical Club, Limassol, Cyprus",
        "organizer": "Famagusta Nautical Club & Chesva",
        "classes": '["Optimist"]',
        "geography": "CYP",
    },
    "2022-roc": {
        "name": "2022 Chesva 2.0 Regatta of Champions — The R.O.C.",
        "slug": "regatta-of-champions-2022",
        "start_date": "2022-11-16",
        "end_date": "2022-11-19",
        "venue": "Famagusta Nautical Club, Limassol, Cyprus",
        "organizer": "Famagusta Nautical Club & Chesva",
        "classes": '["Optimist"]',
        "geography": "CYP",
    },
}

SHEET_META = {
    "2026-roc-opti": ("2026-roc", "regatta-of-champions-2026-optimist", "2026 Chesva Regatta of Champions — Optimist", "Optimist", "Open", "2026-11-11", "2026-11-14"),
    "2026-kosmos-opti__Fina_Results_Gold_Fleet": ("2026-kosmos", "roc-kosmos-2026-optimist-gold", "2026 The R.O.C. Kosmos — Optimist Gold", "Optimist", "Gold", "2026-07-08", "2026-07-15"),
    "2026-kosmos-opti__Fina_Results_Silver_Fleet": ("2026-kosmos", "roc-kosmos-2026-optimist-silver", "2026 The R.O.C. Kosmos — Optimist Silver", "Optimist", "Silver", "2026-07-08", "2026-07-15"),
    "2026-kosmos-ilca4__2026_Kosmos_ILCA4_Results_Race_20": ("2026-kosmos", "roc-kosmos-2026-ilca-4", "2026 The R.O.C. Kosmos — ILCA 4", "ILCA 4", "Open", "2026-06-27", "2026-07-02"),
    "2025-roc-opti__FINAL_2025_R.O.C._Results_Race_25": ("2025-roc", "regatta-of-champions-2025-optimist", "2025 Chesva 2.0 Regatta of Champions — Optimist", "Optimist", "Open", "2025-11-05", "2025-11-08"),
    "2025-kosmos-opti-gold__ROC-KOSMOS-Final-Results-Gold-Fleet": ("2025-kosmos", "roc-kosmos-2025-optimist-gold", "2025 The R.O.C. Kosmos — Optimist Gold", "Optimist", "Gold", "2025-07-24", "2025-07-31"),
    "2025-kosmos-opti-silver__ROC-KOSMOS-Final-Results-Silver-Fleet": ("2025-kosmos", "roc-kosmos-2025-optimist-silver", "2025 The R.O.C. Kosmos — Optimist Silver", "Optimist", "Silver", "2025-07-24", "2025-07-31"),
    "2025-kosmos-opti-bronze__1753894532wpdm_ROC-KOSMOS-Final-Results-Bronze-Fleet": ("2025-kosmos", "roc-kosmos-2025-optimist-bronze", "2025 The R.O.C. Kosmos — Optimist Bronze", "Optimist", "Bronze", "2025-07-24", "2025-07-31"),
    "2024-roc-opti__2024-R.O.C.-Results-Race-23": ("2024-roc", "regatta-of-champions-2024-optimist", "2024 Chesva 2.0 Regatta of Champions — Optimist", "Optimist", "Open", "2024-10-30", "2024-11-02"),
    "2024-kosmos-opti-gold__1719160127wpdm_Kosmos-Results-Race-18-GF": ("2024-kosmos", "roc-kosmos-2024-optimist-gold", "2024 The R.O.C. Kosmos — Optimist Gold", "Optimist", "Gold", "2024-06-17", "2024-06-24"),
    "2024-kosmos-opti-silver__1719160187wpdm_Kosmos-Results-Race-14-SF": ("2024-kosmos", "roc-kosmos-2024-optimist-silver", "2024 The R.O.C. Kosmos — Optimist Silver", "Optimist", "Silver", "2024-06-17", "2024-06-24"),
    "2024-kosmos-opti-bronze__1719160157wpdm_Kosmos-Results-Race-14-BF": ("2024-kosmos", "roc-kosmos-2024-optimist-bronze", "2024 The R.O.C. Kosmos — Optimist Bronze", "Optimist", "Bronze", "2024-06-17", "2024-06-24"),
    "2023-roc-opti__Results-Race-19": ("2023-roc", "regatta-of-champions-2023-optimist", "2023 Chesva 2.0 Regatta of Champions — Optimist", "Optimist", "Open", "2023-11-15", "2023-11-18"),
    "2022-roc-opti__FINAL-RESULTS-for-2022-Chesva-2.0-Regatta-Of-Champions-The-R.O.C.-at-Famagusta-Nautical-Club-2022": ("2022-roc", "regatta-of-champions-2022-optimist", "2022 Chesva 2.0 Regatta of Champions — Optimist", "Optimist", "Open", "2022-11-16", "2022-11-19"),
}


def norm(s: str) -> str:
    return re.sub(r"[^a-z0-9]+", " ", (s or "").lower()).strip()


def variants(name: str) -> set[str]:
    vs = {norm(name)}
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


def make_handle(name: str, nat: str, used: set[str]) -> str:
    base = re.sub(r"[^a-z0-9]+", "-", name.lower()).strip("-") or "sailor"
    cand = base
    if cand in used and nat:
        cand = f"{base}-{nat.lower()}"
    idx = 2
    while cand in used:
        cand = f"{base}-{idx}"
        idx += 1
    used.add(cand)
    return cand


def main() -> None:
    all_parsed = json.loads(PARSED_PATH.read_text())
    db_s = json.loads(SAILORS_PATH.read_text())["rows"]
    db_a = json.loads(ALIASES_PATH.read_text())["rows"]

    sailor_by_id = {s["id"]: s for s in db_s}
    used_handles = {s["handle"] for s in db_s if s.get("handle")}

    strict_index: dict[str, set[str]] = {}
    fuzzy_index: dict[str, set[str]] = {}
    for s in db_s:
        strict_index.setdefault(norm(s["name"]), set()).add(s["id"])
        for v in variants(s["name"]):
            fuzzy_index.setdefault(v, set()).add(s["id"])
    for a in db_a:
        strict_index.setdefault(norm(a["alias_name"]), set()).add(a["sailor_id"])
        for v in variants(a["alias_name"]):
            fuzzy_index.setdefault(v, set()).add(a["sailor_id"])

    new_sailors: dict[tuple[str, str], dict] = {}
    resolved_rows = []

    def resolve_sailor(name: str, nat: str, gender: str, sail_no: str) -> str:
        n = norm(name)
        cands = list(strict_index.get(n, set()))
        if not cands:
            for v in variants(name):
                cands.extend(fuzzy_index.get(v, set()))
            cands = list(dict.fromkeys(cands))

        # Filter by nationality if available
        if cands and nat:
            nat_cands = [
                sid for sid in cands
                if (sailor_by_id[sid].get("nationality") or "").upper() in (nat.upper(), "")
            ]
            exact_nat = [
                sid for sid in cands
                if (sailor_by_id[sid].get("nationality") or "").upper() == nat.upper()
            ]
            cands = exact_nat or nat_cands

        if len(cands) > 1 and gender:
            g_cands = [
                sid for sid in cands
                if not sailor_by_id[sid].get("gender")
                or sailor_by_id[sid]["gender"][0].upper() == gender[0].upper()
            ]
            if g_cands:
                cands = g_cands

        if len(cands) >= 1:
            # Prefer profile with DOB or exact name match
            cands.sort(key=lambda sid: (
                0 if norm(sailor_by_id[sid]["name"]) == n else 1,
                0 if sailor_by_id[sid].get("dob") else 1,
                sid,
            ))
            return cands[0]

        key = (n, nat.upper())
        if key not in new_sailors:
            sid = str(uuid.uuid5(NS, f"sailor:{key[0]}:{key[1]}"))
            handle = make_handle(name, nat, used_handles)
            new_sailors[key] = {
                "id": sid,
                "name": name,
                "handle": handle,
                "nationality": nat or None,
                "gender": gender[0].upper() if gender else None,
                "sail_number": sail_no or None,
            }
        return new_sailors[key]["id"]

    lines: list[str] = [
        "-- Regatta of Champions (The R.O.C.) & R.O.C. Kosmos (2022–2026)",
        "BEGIN;",
        "SELECT pg_advisory_xact_lock(20261116, 72663);",
        "",
    ]

    # Resolve all sailors first so we can emit INSERT INTO sailors cleanly
    for stem, block in all_parsed.items():
        ev_key, r_slug, r_name, b_class, div, s_date, e_date = SHEET_META[stem]
        rid = str(uuid.uuid5(NS, f"regatta:{r_slug}"))
        for idx, r in enumerate(block["rows"], 1):
            sid = resolve_sailor(r["name"], r["nat"], r["gender"], r["sail_no"])
            resolved_rows.append((stem, rid, ev_key, r_name, block["url"], len(block["rows"]), idx, r, sid))

    lines.append(f"-- 1. New Sailor Profiles ({len(new_sailors)} profiles, no invented DOBs)")
    for ns in new_sailors.values():
        lines.append(
            "INSERT INTO public.sailors (id, name, handle, nationality, gender, club, sail_number) "
            f"VALUES ({sql_str(ns['id'])}, {sql_str(ns['name'])}, {sql_str(ns['handle'])}, "
            f"{sql_str(ns['nationality'])}, {sql_str(ns['gender'])}, 'N/A', {sql_str(ns['sail_number'])}) "
            "ON CONFLICT (id) DO NOTHING;"
        )

    lines.append("")
    lines.append(f"-- 2. Regatta Events ({len(EVENTS)})")
    event_ids = {}
    for ev_key, ev in EVENTS.items():
        eid = str(uuid.uuid5(NS, f"event:{ev['slug']}"))
        event_ids[ev_key] = eid
        lines.append(
            "INSERT INTO public.regatta_events (id, name, slug, start_date, end_date, venue, organizer, classes, counts_for_ranking, is_selection_trial, nor_url, schedule_summary, scoring_rules) VALUES ("
            f"{sql_str(eid)}, {sql_str(ev['name'])}, {sql_str(ev['slug'])}, {sql_str(ev['start_date'])}, {sql_str(ev['end_date'])}, "
            f"{sql_str(ev['venue'])}, {sql_str(ev['organizer'])}, {sql_str(ev['classes'])}::jsonb, false, false, "
            "'https://www.regattaofchampions.com/', "
            "'Official final class results imported from regattaofchampions.com PDF.', "
            "'Appendix A low points as published on the official R.O.C. / Kosmos final PDF.'"
            ") ON CONFLICT (id) DO NOTHING;"
        )

    lines.append("")
    lines.append(f"-- 3. Regattas ({len(SHEET_META)} sheets)")
    for stem, meta in SHEET_META.items():
        ev_key, r_slug, r_name, b_class, div, s_date, e_date = meta
        ev = EVENTS[ev_key]
        rid = str(uuid.uuid5(NS, f"regatta:{r_slug}"))
        rows = all_parsed[stem]["rows"]
        race_cnt = len(rows[0]["races"]) if rows else 0
        lines.append(
            "INSERT INTO public.regattas (id, event_id, name, slug, date, end_date, venue, organizer, boat_class, division, race_count, total_fleet_size, entry_type, counts_for_ranking, status, geography, official_results_url, official_results_source_name, schedule_notes) VALUES ("
            f"{sql_str(rid)}, {sql_str(event_ids[ev_key])}, {sql_str(r_name)}, {sql_str(r_slug)}, "
            f"{sql_str(s_date)}, {sql_str(e_date)}, {sql_str(ev['venue'])}, {sql_str(ev['organizer'])}, "
            f"{sql_str(b_class)}, {sql_str(div)}, {race_cnt}, {len(rows)}, 'individual', false, 'published', "
            f"{sql_str(ev['geography'])}, {sql_str(all_parsed[stem]['url'])}, {sql_str(r_name + ' — Official Final PDF')}, "
            f"{sql_str(f'{len(rows)} entries, {race_cnt} races; imported from regattaofchampions.com.')}"
            ") ON CONFLICT (id) DO NOTHING;"
        )

    lines.append("")
    lines.append(f"-- 4. Regatta Results, Participants, and Race Results ({len(resolved_rows)} results)")
    for stem, rid, ev_key, r_name, url, fleet_sz, idx, r, sid in resolved_rows:
        # Use idx in UUID so duplicate ranks (ties) never collide
        rr_id = str(uuid.uuid5(NS, f"result:{rid}:{idx}:{sid}"))
        rrp_id = str(uuid.uuid5(NS, f"participant:{rr_id}:{sid}"))
        g_short = r["gender"][0].upper() if r["gender"] else None
        is_dns = all(x["code"] in ("DNC", "DNS") for x in r["races"])
        lines.append(
            "INSERT INTO public.regatta_results (id, sailor_id, regatta_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, official_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at, entry_label, entry_sail_number, entry_type) VALUES ("
            f"{sql_str(rr_id)}, {sql_str(sid)}, {sql_str(rid)}, {r['rank']}, {fmt_num(r['nett'])}, {fmt_num(r['total'])}, "
            f"{'true' if is_dns else 'false'}, false, {sql_str(g_short)}, {sql_str(r['nat'] or None)}, "
            f"{sql_str(url)}, {sql_str(r_name + ' — Official Final PDF')}, 'link', "
            f"'Imported from official R.O.C. / Kosmos final PDF.', "
            f"'verified', NOW(), {sql_str(r['name'])}, {sql_str(r['sail_no'])}, 'individual'"
            ") ON CONFLICT (id) DO NOTHING;"
        )
        lines.append(
            "INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit) VALUES ("
            f"{sql_str(rrp_id)}, {sql_str(rr_id)}, {sql_str(sid)}, {sql_str(r['name'])}, 1, 'solo', 'matched', false"
            ") ON CONFLICT (id) DO NOTHING;"
        )
        for race_idx, rc in enumerate(r["races"], 1):
            race_id = str(uuid.uuid5(NS, f"race:{rr_id}:{race_idx}"))
            score_val = rc["score"] if rc["score"] is not None else (fleet_sz + 1)
            lines.append(
                "INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ("
                f"{sql_str(race_id)}, {sql_str(rr_id)}, {race_idx}, {fmt_num(score_val)}, "
                f"{sql_str(rc['code'])}, {'true' if rc['discarded'] else 'false'}, {sql_str(rc['raw'])}"
                ") ON CONFLICT (id) DO NOTHING;"
            )

    lines.append("")
    lines.append("-- 5. Admin Change Log")
    for stem, meta in SHEET_META.items():
        ev_key, r_slug, r_name, b_class, div, s_date, e_date = meta
        rid = str(uuid.uuid5(NS, f"regatta:{r_slug}"))
        rows = all_parsed[stem]["rows"]
        log_id = str(uuid.uuid5(NS, f"changelog:{rid}"))
        lines.append(
            "INSERT INTO public.admin_change_log (id, action, entity_type, entity_id, entity_label, summary, details, source) VALUES ("
            f"{sql_str(log_id)}, 'import', 'regatta', {sql_str(rid)}, {sql_str(r_name)}, "
            f"{sql_str(f'Imported {len(rows)} results from official R.O.C. / Kosmos final PDF.')}, "
            f"{sql_str(json.dumps({'official_pdf': all_parsed[stem]['url'], 'fleet_size': len(rows)}))}::jsonb, "
            "'roc-all-import'"
            ") ON CONFLICT (id) DO NOTHING;"
        )

    lines.append("COMMIT;")
    OUT_SQL.write_text("\n".join(lines) + "\n")
    print(f"Wrote {OUT_SQL} ({len(lines)} lines, {len(new_sailors)} new sailors, {len(resolved_rows)} results)")


if __name__ == "__main__":
    main()
