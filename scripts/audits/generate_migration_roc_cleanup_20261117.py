#!/usr/bin/env python3
"""Generate migration for approved ROC import cleanup (2026-11-17):
1. Purge 81 orphaned ghost sailor profiles created during an intermediate draft run of roc-all-import.
2. Consolidate 27 duplicate ROC sailor pairs (26 Chesva null-nationality + 1 Constantino Conrad USA6USA6).
"""

from pathlib import Path

ORPHAN_IDS = [
    "012dab87-5d68-56c2-9f95-1bd8ae16c1e6", "01b139b5-e79b-5171-adaf-8ae67bedeabe",
    "03105ed9-1f0e-5448-9e56-5288024ea9e8", "0a30edb2-e6ef-5afd-ab34-774ba424daea",
    "0b58777a-c4fb-5277-93b9-9c5901b9dce6", "0ed23ed7-1fa5-590c-87d5-90cc58f8c331",
    "117f7e33-90a4-567d-8c97-11df14b3207c", "129c4826-e4e1-54d5-99f7-84c38ac368ac",
    "1a0ca0e0-0dae-56bd-a044-cb67a715b224", "1b84b467-efad-5e2d-8a63-a3b3767f1de2",
    "1c21a328-2c6a-50ac-ad67-ddcb6b30abfc", "22e6aa7e-81ec-5508-ad47-ec3c1dbd6dce",
    "2424c0b0-0194-57bb-8e4f-5c7801ec59bd", "24fc45d5-df4d-5c78-ac18-a18169d6d2d4",
    "2650a5cd-4dd9-5663-b0bc-304319cf8fb0", "27063061-def4-5334-b207-1d90c39ee4e0",
    "2c56aeec-e9ca-52d4-8566-353f7bcf45f0", "2ed3b849-d0cd-5ad2-ae2a-792dfaac68e8",
    "34aea06d-9b0e-51c3-a44b-36bba7103f27", "34ee0684-cd21-5062-8307-35d2a9d14298",
    "3822acbe-0ebe-53b5-a488-06ba2c53c185", "3baaa83f-6ebe-5f8a-8bdf-52c9aabf506f",
    "3c883c51-1d99-5400-bd39-36c93d98cfc0", "43c5f251-b8ba-552b-b2e1-4e1bf7ed9435",
    "46904de9-cfeb-5992-8042-261d644d7916", "4b0a54ca-a891-5801-a81b-b08d1f78a7fd",
    "53f71994-6a9c-5e84-bacc-309bc6325c84", "5421c174-6f5d-56e8-966a-f4a93e44524f",
    "561e6946-c4e1-53b1-9fb0-9ff4b1f18b63", "59a0c774-987a-5139-baef-c0eb7f045c5d",
    "5d7306f1-16eb-59db-bcff-455ffb46455f", "5dedb361-7cd3-5202-bf7f-4d608aa7f909",
    "5e41ddf6-a3f5-55a5-a44c-72e2d01db2ad", "5fe7c940-ed46-5ce7-85c2-4a90e6f5383a",
    "61d84260-10c5-5836-bd19-6e263f6c747e", "62e66dc6-19ed-52e7-85f5-afdb0b1e5893",
    "63b74518-3fcc-5311-bc53-9d4c3068ad29", "6403013f-0b81-5575-86a7-221e5a1c541c",
    "65a566f0-ff9b-53b1-91f8-c5c9df35d51d", "66fd460a-4aa8-5472-a514-b869d3356971",
    "67388cdf-68eb-5969-aacf-c0cf256eb791", "6cf60af7-6ea9-5eeb-87d4-a2273eed48d3",
    "6d720e72-9ab2-5696-819a-104020051d4d", "6f4e8150-a4bf-56c7-bbf4-16cf9bfd64be",
    "728e1c7b-212a-58e0-834e-266a3da8eb69", "757e0d46-1823-53f9-b2ca-6ca183b7b629",
    "771f6853-cf17-5601-99df-16db0b082be5", "77651495-bd89-5139-a8d6-40b7b47b56d9",
    "7f88327c-a406-5d0a-a6b1-3ae30535cdfb", "82a53358-06da-5117-9414-230f28775621",
    "87856dce-c699-5441-8b0d-0dbf797261ce", "87c7bc3f-540c-55a0-a0b1-d3af4061dbb7",
    "919a45da-7856-54cd-8c3e-ada61a9fec43", "95ac83f1-4fe4-5ba5-8f26-baaa97b9c818",
    "984b6650-5fdc-5a3e-b7af-feb43a3895e6", "9e66d849-cabc-5a9c-aec6-644edcc67795",
    "a2e9e040-7bdc-5cd8-8562-44d6efa563ca", "a64a3c16-45f5-5bd1-80d1-bc6dd33aa017",
    "aa9a66c0-e412-5adb-8fdb-a0939e2a4852", "abb5778e-43da-5a21-a144-4ee2ddab9409",
    "affb12a6-f4f1-5579-847d-c3ed6a6c0294", "b1e12194-1148-5b13-9f54-e125d6f3d276",
    "b42b3d7b-cb31-5fbc-9bc2-94b15d069e5e", "b6721589-5104-5f08-bfa2-2d6e0751a05d",
    "b71d0c58-a257-592a-a914-ccc252c8879d", "c7fcc8cc-5330-5995-b0f3-86b25d3845d2",
    "ce020ed7-6477-5c8e-b6c3-284c01f8aa4c", "d4df5583-e2ec-5438-b7ac-13f11cafdd7f",
    "daa4e3e2-3bc9-5ca2-8b8f-85f13bd7ea53", "dcb7b8a7-a0a7-53cc-97d0-24f3d2ba5208",
    "e285f2ab-1177-5890-abcc-8941ba755c9c", "e5e8453f-27d7-555a-aebd-a8d857d908ae",
    "e8be0e36-6eaf-5503-a32b-95b6d0ae8aec", "f1d91462-0358-5c51-80ee-a282c3d66b6d",
    "f2c5dad5-14f2-56b3-8e09-b52b24a2c6dd", "f6a8dfcd-2e06-5ecd-8266-aecf268727ec",
    "f9f88d42-c202-561d-9b80-fdc7ddcd8148", "fae08fbe-0e5b-5cbe-ba4d-9b34bd109143",
    "fc1fd431-c5f1-5024-a1aa-ccaa62782718", "fe17e812-f602-52af-9e3a-e6f729b02fd3",
    "ff52e46c-d3fe-529d-a029-20cee3e09df5",
]

# (merged_id, survivor_id, name, nat)
DUPLICATE_PAIRS = [
    ("dc25d7ba-e2f8-5f6d-ae0f-1989dc76aa8d", "cfb4eb58-8611-5931-a847-b7e5d61f9d38", "Agis C. Angelopoulos", "GRE"),
    ("afa3ebc9-ccf8-5a21-bafd-c89e7404cbc6", "181bc8bc-31fc-505a-9990-6263a0fd88aa", "Agis Christos Angelopoulos", "GRE"),
    ("31ae9b64-df7a-56ea-853a-2046726ce6d3", "d69cd1e4-9a41-5f6b-8a3f-62199d4cf872", "Alessandro Menghini", "ITA"),
    ("a46a58e8-d914-537c-b531-3b4e8d138972", "c714b7fd-ab4d-5a83-a0e1-71741028f66b", "Alexander Forssen", "SWE"),
    ("90a555fa-9bbd-5826-9fd8-7ae509ba22b3", "4f8e4714-98ca-5db2-ac1b-a870d840dfac", "Arthur Back", "BRA"),
    ("8606b9d5-2d7a-5c3d-af7f-3a3ecc9cd2cf", "569cbe41-a1b3-5bbe-ac92-67157b463ef6", "Constantino Conrad", "USA"),
    ("868ea8e1-13cd-506d-b40a-bc0334834458", "659e6b6c-aa36-5746-b967-35d3338d4bf9", "Dalton Cellamare", "USA"),
    ("cf49a56c-8952-5297-8262-23244ec4bd0b", "087543e8-87a6-5f24-85a8-c65f68b64212", "Davide Veronesi", "ITA"),
    ("f97b2a0c-d8a8-59f3-ac98-e0ede79a1aee", "36dcb12e-9ddb-53d5-abfd-e8c606f1e04b", "Ernst Akesson", "SWE"),
    ("a5e6cdcf-416a-5535-affc-c35dce9a0463", "112a0993-40ec-5ad0-af95-41d6ac02995a", "Felix Mulder", "NED"),
    ("c1d81539-60bc-593d-9bc5-280a57d7dfcf", "8653b60b-ef5c-5bcd-89ba-839a8114962d", "Francesco Colotto", "ITA"),
    ("de1727c0-7584-5dda-bb1d-7e879da7e55e", "5c0061b9-55ec-51d0-91d4-da40f3bc46b7", "George Kountos", "GRE"),
    ("e050b9f6-879f-57fb-a631-adc15b167a52", "72da1fa3-520f-5f9c-96b3-a59920f4f9c2", "Georgios Mandilas", "GRE"),
    ("33edaf31-bdb3-50e5-ae21-b5b69fef9143", "81da8f62-8f6d-5f9c-9942-a423ca50f752", "Iason Panagopoulos", "GRE"),
    ("83436c12-6206-5384-a305-140d86256ee7", "416b934f-7cbd-5101-88f4-0e4d6774812e", "Irene Faini", "ITA"),
    ("e25ac7d6-cef1-5bc6-98c2-0be4c71da41a", "79791559-a74c-5489-b1a3-c0d09decf245", "Izan Rogel", "ESP"),
    ("3ebbfcf9-c24a-58a2-b491-5937bd469674", "c48c6728-d489-5494-86f1-2c48cdaf22cf", "Joana Freitas", "BRA"),
    ("74e0eb0c-e241-5b8b-8366-2ebfa837c493", "a5c252ea-200f-5fd6-a02a-7f1a92e79234", "Joao Lucena", "BRA"),
    ("7d83fece-0740-5113-8619-c205990e6f4f", "edbbe788-82f5-571b-b757-f55edc9d9c84", "Joaquin Acevedo", "PER"),
    ("576f18bc-77d1-50f1-81e3-3bb904efebe6", "4383d548-cb49-53d2-be7f-4fca586de4de", "Jorge Munoz", "MEX"),
    ("f798aa44-b107-5bfd-8577-dd3755652e0e", "0c0da9c3-6933-5919-9775-ffdbad3ab291", "Konstantina Sinani", "GRE"),
    ("15ae2f3d-bba0-52ae-bccc-4397ed804a21", "12218c8d-51ea-59f3-a3c6-c04a2ecd4190", "Lara Aurora Hummel", "SLO"),
    ("2a4cf3c1-5d48-5f92-ab86-188aba451217", "3c504d33-72fc-5110-af81-ddd14f2136f1", "Leticia Lagutenko", "USA"),
    ("9e6ff40c-8aea-5d9e-b9cb-a5c5ef96bdd1", "46eb1c91-d130-57e3-8c3d-4fcdc3d0c7e6", "Manuel Braganca", "BRA"),
    ("430c7dbc-3315-5664-b2d4-08fd3e9d7058", "dade70e7-23e1-5405-86f5-6ccfa8638b8f", "Marcus Durlach V", "USA"),
    ("494847c3-d2aa-5c4e-8fd2-ea54fa405115", "85c31d2f-4b44-5ec8-8fac-6aab1b57aada", "Maria Anna Makri", "GRE"),
    ("ef2c9c3b-8cff-55cb-8cbb-4c8db0ab9565", "3841538d-bb95-5bc2-a159-7ed46b618cc7", "Maurits Melens", "NED"),
]


def main() -> None:
    lines = [
        "-- Migration: 20261117093500_roc_orphan_purge_and_duplicate_merges.sql",
        "-- Description: Purge 81 orphaned ghost profiles from draft ROC import and consolidate 27 ROC duplicate pairs.",
        "-- Approved by user during daily scheduled data scan (2026-11-17).",
        "",
        "BEGIN;",
        "",
        "-- ============================================================================",
        "-- 1. PURGE 81 ORPHANED GHOST SAILOR PROFILES",
        "-- ============================================================================",
        "",
        "DELETE FROM public.sailors",
        "WHERE id IN (",
    ]
    for i, oid in enumerate(ORPHAN_IDS):
        comma = "," if i < len(ORPHAN_IDS) - 1 else ""
        lines.append(f"  '{oid}'{comma}")
    lines.extend([
        ")",
        "AND NOT EXISTS (SELECT 1 FROM public.regatta_results rr WHERE rr.sailor_id = sailors.id)",
        "AND NOT EXISTS (SELECT 1 FROM public.regatta_result_participants rrp WHERE rrp.sailor_id = sailors.id);",
        "",
        "-- ============================================================================",
        "-- 2. CONSOLIDATE 27 DUPLICATE ROC SAILOR PAIRS",
        "-- ============================================================================",
        "",
    ])

    for merged_id, survivor_id, name, nat in DUPLICATE_PAIRS:
        safe_name = name.replace("'", "''")
        lines.extend([
            f"-- Merge {name} ({nat}): {merged_id} -> {survivor_id}",
            "UPDATE public.regatta_results",
            f"SET sailor_id = '{survivor_id}',",
            f"    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN '{nat}' ELSE nationality END,",
            "    updated_at = clock_timestamp()",
            f"WHERE sailor_id = '{merged_id}';",
            "",
            "UPDATE public.regatta_result_participants",
            f"SET sailor_id = '{survivor_id}',",
            "    updated_at = clock_timestamp()",
            f"WHERE sailor_id = '{merged_id}';",
            "",
            f"DELETE FROM public.sailors WHERE id = '{merged_id}';",
            "",
            "INSERT INTO public.admin_change_log (",
            "  action, entity_type, entity_id, entity_label, summary, details, source, created_at",
            ") SELECT",
            "  'sailors.duplicates.merge',",
            "  'sailor',",
            f"  '{survivor_id}',",
            f"  '{safe_name}',",
            f"  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical {nat} profile.',",
            f"  jsonb_build_object('mergedId', '{merged_id}', 'survivorId', '{survivor_id}', 'nationality', '{nat}'),",
            "  'daily_audit_20261117',",
            "  clock_timestamp()",
            "WHERE NOT EXISTS (",
            "  SELECT 1 FROM public.admin_change_log",
            "  WHERE action = 'sailors.duplicates.merge'",
            f"    AND details->>'mergedId' = '{merged_id}'",
            ");",
            "",
        ])

    lines.extend([
        "INSERT INTO public.admin_change_log (",
        "  action, entity_type, entity_id, entity_label, summary, details, source, created_at",
        ") VALUES (",
        "  'sailors.orphans.purge',",
        "  'system',",
        "  gen_random_uuid(),",
        "  'ROC Draft Ghost Profiles',",
        "  'Purged 81 orphaned ghost sailor profiles created during intermediate ROC draft parsing.',",
        "  jsonb_build_object('count', 81),",
        "  'daily_audit_20261117',",
        "  clock_timestamp()",
        ");",
        "",
        "COMMIT;",
    ])

    out_path = Path(__file__).resolve().parents[2] / "src" / "db" / "migrations" / "20261117093500_roc_orphan_purge_and_duplicate_merges.sql"
    out_path.write_text("\n".join(lines) + "\n")
    print(f"Written ROC cleanup migration to: {out_path}")


if __name__ == "__main__":
    main()
