#!/usr/bin/env python3
from __future__ import annotations
import json
import re
import uuid

# Base namespace for deterministic UUIDs
NS = uuid.UUID('d4c728e1-5e26-48bc-b2ef-37a505b22591')

def make_uuid(key: str) -> str:
    return str(uuid.uuid5(NS, key))

def make_handle(name: str, disambig: str = "") -> str:
    clean = re.sub(r'[^a-z0-9]+', '-', name.lower().strip()).strip('-')
    suffix = uuid.uuid5(NS, f"{name}:{disambig}").hex[:6]
    return f"{clean}-{suffix}"

# Load live sailors
with open('/tmp/live_sailors_ina.json') as f:
    live_sailors = json.load(f)['rows']

# Index by normalized name
name_map = {}
for s in live_sailors:
    norm = re.sub(r'[^a-z0-9]', '', s['name'].lower())
    name_map.setdefault(norm, []).append(s)

print(f"Loaded {len(live_sailors)} live sailors into name_map.")

# -------------------------------------------------------------
# 1. RAW VERIFIED DATA FOR ALL 8 CLASSES FROM INASAF PDF
# -------------------------------------------------------------

# 1. OPTIMIST (21 entries, 7 races, 2 discards) - pages 8 & 9
optimist_entries = [
    {"rank": 1, "div": "Opt. Green Open", "nat": "INA", "sail": "INA 2510", "name": "Abdul Habibi", "club": "Kaltim", "gender": "M", "races": ["(5)", "1", "4", "(5)", "1", "1", "1"], "total": 18.0, "net": 8.0},
    {"rank": 2, "div": "Optimist Men", "nat": "INA", "sail": "INA 6671", "name": "Novrizam Afka Adrian", "club": "Jakarta", "gender": "M", "races": ["1", "(6)", "2", "1", "3", "(5)", "2"], "total": 20.0, "net": 9.0},
    {"rank": 3, "div": "Opt. Green Open", "nat": "INA", "sail": "INA 2201", "name": "M. Habibie Al-Zahri", "club": "Kepri/Kodaeral IV", "gender": "M", "races": ["(13)", "4", "1", "(11)", "2", "2", "3"], "total": 36.0, "net": 12.0},
    {"rank": 4, "div": "Optimist Men", "nat": "INA", "sail": "INA 2611", "name": "Aguero Pratama Syabani", "club": "Kota Bekasi", "gender": "M", "races": ["2", "3", "3", "2", "(4)", "3", "(4)"], "total": 21.0, "net": 13.0},
    {"rank": 5, "div": "Optimist Women", "nat": "INA", "sail": "INA 2101", "name": "Hannindieta Julia Syabani", "club": "Jakarta", "gender": "F", "races": ["6", "2", "6", "4", "(12)", "6", "(22 DNC)"], "total": 58.0, "net": 24.0},
    {"rank": 6, "div": "Optimist Women", "nat": "INA", "sail": "INA 2530", "name": "Dwi Anisa Aprilia", "club": "Kaltim", "gender": "F", "races": ["(22 DNC)", "5", "5", "6", "5", "(7)", "5"], "total": 55.0, "net": 26.0},
    {"rank": 7, "div": "Optimist Women", "nat": "INA", "sail": "INA 5022", "name": "Carissa Nindra Alunaditiandika", "club": "Kota Cimahi", "gender": "F", "races": ["3", "(22 DNC)", "(9)", "7", "7", "9", "6"], "total": 63.0, "net": 32.0},
    {"rank": 8, "div": "Opt. Green Open", "nat": "INA", "sail": "INA 5805", "name": "Amira Khansa Syabila", "club": "Kota Bekasi", "gender": "F", "races": ["7", "(10)", "(12)", "3", "10", "4", "9"], "total": 55.0, "net": 33.0},
    {"rank": 9, "div": "Optimist Men", "nat": "INA", "sail": "SGP 15379", "name": "Tiyas Nur Falah", "club": "Banten", "gender": "M", "races": ["4", "7", "7", "9", "(17)", "(10)", "8"], "total": 62.0, "net": 35.0},
    {"rank": 10, "div": "Optimist Women", "nat": "INA", "sail": "INA 1579", "name": "Lexy Rizka Ratita", "club": "Banten", "gender": "F", "races": ["8", "8", "11", "8", "(15)", "(15)", "7"], "total": 72.0, "net": 42.0},
    {"rank": 11, "div": "Optimist Women", "nat": "INA", "sail": "1", "name": "Ni Putu Anindya Maheswari", "club": "Bali", "gender": "F", "races": ["9", "11", "8", "(12)", "8", "11", "(14)"], "total": 73.0, "net": 47.0},
    {"rank": 12, "div": "Opt. Green Open", "nat": "INA", "sail": "INA 907", "name": "Okshi Kurniawan", "club": "Jakarta", "gender": "M", "races": ["(14)", "9", "(22 DNC)", "10", "6", "13", "11"], "total": 85.0, "net": 49.0},
    {"rank": 13, "div": "Opt. Green Open", "nat": "MAS", "sail": "MAS 9023", "name": "M Adam Farina Bin Guido Farina", "club": "Kedah Sailing", "gender": "M", "races": ["10", "17", "10", "(22 DNC)", "(18)", "8", "10"], "total": 95.0, "net": 55.0},
    {"rank": 14, "div": "Opt. Green Open", "nat": "INA", "sail": "INA 1736", "name": "Nadira Septiandini Ponanda", "club": "TASS", "gender": "F", "races": ["12", "12", "13", "14", "11", "(17)", "(17)"], "total": 96.0, "net": 62.0},
    {"rank": 15, "div": "Opt. Green Open", "nat": "INA", "sail": "SGP 1", "name": "Radit Bay Supriyadi", "club": "Banten", "gender": "M", "races": ["(22 DNC)", "(22 DNC)", "15", "13", "9", "14", "19"], "total": 114.0, "net": 70.0},
    {"rank": 16, "div": "Opt. Green Open", "nat": "INA", "sail": "INA 2602", "name": "Shafar Raditia Ramlan", "club": "Kepri/Kodaeral IV", "gender": "M", "races": ["(22 DNC)", "15", "(16)", "15", "13", "16", "12"], "total": 109.0, "net": 71.0},
    {"rank": 17, "div": "Optimist Women", "nat": "INA", "sail": "INA 199", "name": "Maura Putri Ariski", "club": "TASS", "gender": "F", "races": ["(22 DNC)", "14", "14", "(22 DNC)", "20", "12", "13"], "total": 117.0, "net": 73.0},
    {"rank": 18, "div": "Opt. Green Open", "nat": "INA", "sail": "INA 159", "name": "M. Nidzar A.", "club": "TASS", "gender": "M", "races": ["11", "16", "17", "(22 DNC)", "16", "(20)", "15"], "total": 117.0, "net": 75.0},
    {"rank": 19, "div": "Optimist Men", "nat": "INA", "sail": "1527", "name": "Galang Bangkit Ramadhan", "club": "TASS", "gender": "M", "races": ["(22 DNC)", "13", "(22 DNC)", "16", "14", "18", "16"], "total": 121.0, "net": 77.0},
    {"rank": 20, "div": "Opt. Green Open", "nat": "INA", "sail": "INA 17", "name": "Aqila Chan Stevany Sarendeng", "club": "TASS", "gender": "F", "races": ["(22 DNC)", "18", "18", "17", "(22 DNC)", "22 DNC", "22 DNC"], "total": 141.0, "net": 97.0},
    {"rank": 21, "div": "Opt. Green Open", "nat": "INA", "sail": "INA 118", "name": "Jigme Suharyo", "club": "TASS", "gender": "M", "races": ["(22 DNC)", "(22 DNC)", "22 DNC", "22 DNC", "19", "19", "18"], "total": 144.0, "net": 100.0}
]

# 2. TECHNO 293 (10 entries, 8 races, 2 discards) - page 9
techno_entries = [
    {"rank": 1, "div": "Techno 293 Men", "nat": "SGP", "sail": "SGP 45", "name": "Trevor Ng Zong Yang", "club": "Singapore Sailing", "gender": "M", "races": ["1", "1", "(3)", "1", "1", "1", "(5)", "3"], "total": 16.0, "net": 8.0},
    {"rank": 2, "div": "Techno 293 Men", "nat": "INA", "sail": "INA 15", "name": "Achmad Rafa Abyas", "club": "Jakarta", "gender": "M", "races": ["(11 DNC)", "(2)", "2", "2", "2", "2", "1", "1"], "total": 23.0, "net": 10.0},
    {"rank": 3, "div": "Techno 293 Men", "nat": "SGP", "sail": "SGP 143", "name": "Addy Armand Bin Anuar", "club": "Singapore Sailing", "gender": "M", "races": ["2", "3", "(4)", "(5)", "4", "3", "3", "4"], "total": 28.0, "net": 19.0},
    {"rank": 4, "div": "Techno 293 Women", "nat": "SGP", "sail": "SGP 26", "name": "Qi Shan", "club": "Singapore Sailing", "gender": "F", "races": ["(11 DNC)", "(11 RET)", "1", "3", "6", "11 DNC", "4", "2"], "total": 49.0, "net": 27.0},
    {"rank": 5, "div": "Techno 293 Women", "nat": "SGP", "sail": "SGP 87", "name": "Kate Teo", "club": "Singapore Sailing", "gender": "F", "races": ["3", "4", "(6)", "(7)", "5", "4", "6", "6"], "total": 41.0, "net": 28.0},
    {"rank": 6, "div": "Techno 293 Women", "nat": "INA", "sail": "INA 1", "name": "Nazwa Anggraeni", "club": "Jakarta", "gender": "F", "races": ["(11 DNC)", "(11 DNC)", "5", "4", "3", "11 DNC", "2", "5"], "total": 52.0, "net": 30.0},
    {"rank": 7, "div": "Techno 293 Women", "nat": "INA", "sail": "INA 7", "name": "Adhelia Khanza Al Naira", "club": "Jakarta", "gender": "F", "races": ["(11 DNC)", "(11 DNC)", "8", "9", "8", "5", "9", "7"], "total": 68.0, "net": 46.0},
    {"rank": 8, "div": "Techno 293 Men", "nat": "INA", "sail": "INA 8", "name": "Berly Yasta Muammar", "club": "Banten", "gender": "M", "races": ["(11 DNC)", "(11 DNC)", "7", "8", "9", "11 DNC", "8", "8"], "total": 73.0, "net": 51.0},
    {"rank": 9, "div": "Techno 293 Men", "nat": "INA", "sail": "29", "name": "Zulfikri Ilham", "club": "Kaltim", "gender": "M", "races": ["(11 DNC)", "(11 DNC)", "11 DNC", "6", "7", "11 DNC", "7", "11 DNC"], "total": 75.0, "net": 53.0},
    {"rank": 10, "div": "Techno 293 Men", "nat": "SGP", "sail": "SGP 417", "name": "Marcus Thye", "club": "Constant Wind", "gender": "M", "races": ["(11 DNC)", "(11 DNC)", "9", "10", "10", "11 DNC", "11 DNC", "11 DNC"], "total": 84.0, "net": 62.0}
]

# 3. TECHNO 293 PLUS (6 entries, 8 races, 2 discards) - page 10
techno_plus_entries = [
    {"rank": 1, "div": "Techno 293 Plus Men", "nat": "INA", "sail": "INA 81", "name": "Afriza Achmad Bagaskara", "club": "Jakarta", "gender": "M", "races": ["(1)", "1", "1", "1", "1", "1", "1", "(2)"], "total": 9.0, "net": 6.0},
    {"rank": 2, "div": "Techno 293 Plus Women", "nat": "INA", "sail": "INA 18", "name": "Syafira Zahra Aulia", "club": "Jakarta", "gender": "F", "races": ["(2)", "2", "2", "(4)", "2", "2", "2", "1"], "total": 17.0, "net": 11.0},
    {"rank": 3, "div": "Techno 293 Plus Women", "nat": "INA", "sail": "INA 111", "name": "Aulia Jumata Savani", "club": "Kaltim", "gender": "F", "races": ["(7 DNC)", "(7 DNC)", "3", "2", "3", "7 DNC", "3", "3"], "total": 35.0, "net": 21.0},
    {"rank": 4, "div": "Techno 293 Plus Men", "nat": "INA", "sail": "12", "name": "Muhammad Fachry Rizky", "club": "Kota Bekasi", "gender": "M", "races": ["(7 DNC)", "(7 DNC)", "4", "3", "4", "3", "4", "7 DNC"], "total": 39.0, "net": 25.0},
    {"rank": 5, "div": "Techno 293 Plus Men", "nat": "INA", "sail": "INA 89", "name": "Febrian Eka Ss.", "club": "TASS", "gender": "M", "races": ["(7 DNC)", "(7 DNC)", "5", "7 DNC", "7 DNC", "7 DNC", "5", "4"], "total": 49.0, "net": 35.0},
    {"rank": 6, "div": "Techno 293 Plus Men", "nat": "INA", "sail": "INA 79", "name": "Ahmad Jaini", "club": "Kaltim", "gender": "M", "races": ["(7 DNC)", "(7 DNC)", "7 DNC", "7 DNC", "7 DNC", "7 DNC", "7 DNC", "7 DNC"], "total": 56.0, "net": 42.0}
]

# 4. IQFOIL (4 entries, 8 races, 2 discards) - page 10
iqfoil_entries = [
    {"rank": 1, "div": "IQ Foil Men", "nat": "INA", "sail": "1", "name": "Dexy Priany", "club": "Banten", "gender": "M", "races": ["(1)", "1", "1", "1", "1", "1", "1", "(5 DNS)"], "total": 12.0, "net": 6.0},
    {"rank": 2, "div": "IQ Foil Women", "nat": "INA", "sail": "INA 99", "name": "Alifah Auralia", "club": "Jakarta", "gender": "F", "races": ["2", "2", "2", "(3)", "3", "2", "3", "(5 DNS)"], "total": 22.0, "net": 14.0},
    {"rank": 3, "div": "IQ Foil Men", "nat": "INA", "sail": "INA 38", "name": "Roy Zulfadli Bahri", "club": "Kaltim", "gender": "M", "races": ["3", "3", "3", "2", "2", "(4)", "2", "(5 DNS)"], "total": 24.0, "net": 15.0},
    {"rank": 4, "div": "IQ Foil Men", "nat": "INA", "sail": "INA 35", "name": "Saitama Junjungan Simanjuntak", "club": "Jakarta", "gender": "M", "races": ["(5 DNC)", "(5 DNC)", "5 DNC", "4", "4", "3", "5 DNC", "5 DNS"], "total": 36.0, "net": 26.0}
]

# 5. INT. 420 (5 boats, 10 sailors, 8 races, 2 discards) - page 10
c420_entries = [
    {
        "rank": 1, "div": "Int. 420 Men", "nat": "INA", "sail": "INA 57240", "boat": "KALTIM 57240", "club": "KALTIM",
        "helm_name": "M Adhit", "crew_name": "Andi M Faruq", "helm_gender": "M", "crew_gender": "M",
        "races": ["(3)", "(2)", "1", "1", "1", "2", "2", "2"], "total": 14.0, "net": 9.0
    },
    {
        "rank": 2, "div": "Int. 420 Women", "nat": "INA", "sail": "10", "boat": "KALTIM 10", "club": "KALTIM",
        "helm_name": "Alya", "crew_name": "Hafizhah Ramadhani H", "helm_gender": "F", "crew_gender": "F",
        "races": ["1", "(3)", "3", "2", "3", "(6 DNC)", "1", "1"], "total": 20.0, "net": 11.0
    },
    {
        "rank": 3, "div": "Int. 420 Women", "nat": "INA", "sail": "INA 65404", "boat": "JAKARTA 65404", "club": "JAKARTA",
        "helm_name": "Kinara Prisha D", "crew_name": "Azaleya Tifani P", "helm_gender": "F", "crew_gender": "F",
        "races": ["(4)", "1", "2", "(3)", "2", "1", "3", "3"], "total": 19.0, "net": 12.0
    },
    {
        "rank": 4, "div": "Int. 420 Women", "nat": "INA", "sail": "INA 888", "boat": "BANTEN 888", "club": "BANTEN",
        "helm_name": "Safira Zaliyanti", "crew_name": "Ratu Sri AW", "helm_gender": "F", "crew_gender": "F",
        "races": ["2", "(4)", "(5)", "4", "4", "4", "4", "4"], "total": 31.0, "net": 22.0
    },
    {
        "rank": 5, "div": "Int. 420 Men", "nat": "INA", "sail": "INA 50389", "boat": "JAKARTA 50389", "club": "JAKARTA",
        "helm_name": "Zevan Adriansah", "crew_name": "Mujaya", "helm_gender": "M", "crew_gender": "M",
        "races": ["(6 DNC)", "(6 DNC)", "4", "5", "6 DNC", "3", "5", "5"], "total": 40.0, "net": 28.0
    }
]

# 6. ILCA 4 (11 entries, 7 races, 2 discards) - page 11
ilca4_entries = [
    {"rank": 1, "div": "ILCA 4 Men", "nat": "INA", "sail": "INA 225223", "name": "Rizky Marvel", "club": "Kepri/Kodaeral IV", "gender": "M", "races": ["1", "(2)", "1", "1", "1", "1", "(12 DNC)"], "total": 19.0, "net": 5.0},
    {"rank": 2, "div": "ILCA 4 Women", "nat": "INA", "sail": "192409", "name": "Adelia Maisyah Adha", "club": "KALTIM", "gender": "F", "races": ["(3)", "(5)", "2", "2", "2", "3", "1"], "total": 18.0, "net": 10.0},
    {"rank": 3, "div": "ILCA 4 Women", "nat": "INA", "sail": "175899", "name": "Aurora Cantika Lilo Haqqi", "club": "KOTA BEKASI", "gender": "F", "races": ["(8)", "1", "4", "(6)", "4", "2", "4"], "total": 29.0, "net": 15.0},
    {"rank": 4, "div": "ILCA 4 Men", "nat": "INA", "sail": "INA 221026", "name": "Fahri Khalfani Akbar", "club": "KOTA BEKASI", "gender": "M", "races": ["2", "(6)", "3", "5", "(8)", "4", "3"], "total": 31.0, "net": 17.0},
    {"rank": 5, "div": "ILCA 4 Men", "nat": "INA", "sail": "204628", "name": "Fiorentino Gabriel Alberto Awuy", "club": "KOTA CIMAHI", "gender": "M", "races": ["5", "3", "6", "(8)", "3", "5", "(8)"], "total": 38.0, "net": 22.0},
    {"rank": 6, "div": "ILCA 4 Women", "nat": "INA", "sail": "INA 221111", "name": "Naura Adhara Ariyanto", "club": "JAKARTA", "gender": "F", "races": ["4", "(9)", "9", "3", "(10)", "6", "5"], "total": 46.0, "net": 27.0},
    {"rank": 7, "div": "ILCA 4 Men", "nat": "INA", "sail": "INA 220411", "name": "Esta Annabil Syarif Revandi", "club": "JAKARTA", "gender": "M", "races": ["7", "7", "5", "7", "(9)", "(8)", "2"], "total": 45.0, "net": 28.0},
    {"rank": 8, "div": "ILCA 4 Men", "nat": "INA", "sail": "192408", "name": "Surya Tama Saputra", "club": "KALTIM", "gender": "M", "races": ["(12 DNC)", "4", "8", "(9)", "6", "7", "7"], "total": 53.0, "net": 32.0},
    {"rank": 9, "div": "ILCA 4 Men", "nat": "INA", "sail": "INA 209147", "name": "Fachrie Aldiansyah", "club": "Kepri/Kodaeral IV", "gender": "M", "races": ["6", "10", "(12 DNC)", "4", "7", "(12 DNC)", "6"], "total": 57.0, "net": 33.0},
    {"rank": 10, "div": "ILCA 4 Women", "nat": "INA", "sail": "INA 198172", "name": "Nur Azila", "club": "Kepri/Kodaeral IV", "gender": "F", "races": ["(12 DNC)", "8", "7", "(12 DNC)", "5", "12 DNC", "12 DNC"], "total": 68.0, "net": 44.0},
    {"rank": 11, "div": "ILCA 4 Women", "nat": "INA", "sail": "INA 193924", "name": "Rizka Tri Aryani", "club": "Kepri/Kodaeral IV", "gender": "F", "races": ["(12 DNC)", "11", "10", "10", "(12 DNC)", "12 DNC", "12 DNC"], "total": 79.0, "net": 55.0}
]

# 7. ILCA 6 (13 entries, 7 races, 2 discards) - pages 11 & 12
ilca6_entries = [
    {"rank": 1, "div": "ILCA 6 Women", "nat": "INA", "sail": "INA 199449", "name": "Kirana Wardojo", "club": "JATIM", "gender": "F", "races": ["(1)", "(14 DNF)", "1", "1", "1", "1", "1"], "total": 20.0, "net": 5.0},
    {"rank": 2, "div": "ILCA 6 Men", "nat": "INA", "sail": "INA 22", "name": "Lucky Novriansyah", "club": "Kepri/Kodaeral IV", "gender": "M", "races": ["2", "1", "2", "(4)", "3", "2", "(6)"], "total": 20.0, "net": 10.0},
    {"rank": 3, "div": "ILCA 6 Men", "nat": "INA", "sail": "INA 211121", "name": "Rivandi", "club": "KALTIM", "gender": "M", "races": ["(8)", "2", "(4)", "3", "2", "3", "2"], "total": 24.0, "net": 12.0},
    {"rank": 4, "div": "ILCA 6 Women", "nat": "INA", "sail": "221599", "name": "Fitri Alwiyah", "club": "KOTA BEKASI", "gender": "F", "races": ["(5)", "3", "5", "2", "(6)", "4", "4"], "total": 29.0, "net": 18.0},
    {"rank": 5, "div": "ILCA 6 Men", "nat": "INA", "sail": "INA 217961", "name": "Jalesveva Divo Ardiansyah", "club": "Kepri/Kodaeral IV", "gender": "M", "races": ["4", "5", "3", "(6)", "(8)", "6", "3"], "total": 35.0, "net": 21.0},
    {"rank": 6, "div": "ILCA 6 Men", "nat": "INA", "sail": "262021", "name": "Rezky Adrean", "club": "KOTA BANDUNG", "gender": "M", "races": ["3", "4", "(7)", "5", "4", "5", "(7)"], "total": 35.0, "net": 21.0},
    {"rank": 7, "div": "ILCA 6 Men", "nat": "INA", "sail": "12", "name": "Alif Apriliano Ariesta", "club": "KABUPATEN BANDUNG", "gender": "M", "races": ["7", "6", "8", "(14 RET)", "5", "(9)", "5"], "total": 54.0, "net": 31.0},
    {"rank": 8, "div": "ILCA 6 Men", "nat": "INA", "sail": "7", "name": "David Bagustyo", "club": "BANTEN", "gender": "M", "races": ["6", "7", "6", "7", "(14 DNC)", "8", "(9)"], "total": 57.0, "net": 34.0},
    {"rank": 9, "div": "ILCA 6 Women", "nat": "INA", "sail": "INA 20", "name": "Sarmila", "club": "KALTIM", "gender": "F", "races": ["(9)", "8", "9", "(14 DNC)", "7", "7", "8"], "total": 62.0, "net": 39.0},
    {"rank": 10, "div": "ILCA 6 Women", "nat": "INA", "sail": "88", "name": "Amellia", "club": "JAKARTA", "gender": "F", "races": ["(14 DNC)", "10", "(14 DNC)", "14 DNC", "9", "10", "14 DNC"], "total": 85.0, "net": 57.0},
    {"rank": 11, "div": "ILCA 6 Men", "nat": "INA", "sail": "8", "name": "Muhammad Al Jalil Mandala Julyaji", "club": "JAKARTA", "gender": "M", "races": ["(14 DNC)", "12", "11", "(14 DNC)", "10", "11", "14 DNC"], "total": 86.0, "net": 58.0},
    {"rank": 12, "div": "ILCA 6 Men", "nat": "GBR", "sail": "1", "name": "William Woolston", "club": "HORNING SAILING CLUB", "gender": "M", "races": ["(14 DNC)", "9", "10", "(14 DNC)", "14 DNC", "14 DNC", "14 DNC"], "total": 89.0, "net": 61.0},
    {"rank": 13, "div": "ILCA 6 Men", "nat": "INA", "sail": "227676", "name": "Tora Mirsya Pratama", "club": "KOARMADA 1", "gender": "M", "races": ["(14 DNC)", "11", "12", "(14 DNC)", "14 DNC", "12", "14 DNC"], "total": 91.0, "net": 63.0}
]

# 8. ILCA 7 (9 entries, 7 races, 2 discards) - page 12
ilca7_entries = [
    {"rank": 1, "div": "ILCA 7 Men", "nat": "INA", "sail": "INA 225223", "name": "Ahmad Zainuddin", "club": "KEPRI/KODAERAL IV", "gender": "M", "races": ["1", "1", "1", "(2)", "1", "1", "(10 DNC)"], "total": 17.0, "net": 5.0},
    {"rank": 2, "div": "ILCA 7 Men", "nat": "INA", "sail": "INA 201522", "name": "Gregory Roger Wardojo", "club": "JATIM", "gender": "M", "races": ["(2)", "2", "2", "1", "(3)", "2", "1"], "total": 13.0, "net": 8.0},
    {"rank": 3, "div": "ILCA 7 Men", "nat": "INA", "sail": "221121", "name": "Sujatmiko Siswanto", "club": "KOTA BANDUNG", "gender": "M", "races": ["3", "3", "(4)", "3", "(4)", "4", "2"], "total": 23.0, "net": 15.0},
    {"rank": 4, "div": "ILCA 7 Men", "nat": "INA", "sail": "6", "name": "Samsuardi", "club": "KOTA BANDUNG", "gender": "M", "races": ["(5)", "4", "3", "(5)", "5", "3", "3"], "total": 28.0, "net": 18.0},
    {"rank": 5, "div": "ILCA 7 Men", "nat": "INA", "sail": "200998", "name": "Alif Thaariq Sutrisno", "club": "SULAWESI SELATAN", "gender": "M", "races": ["4", "(5)", "(5)", "4", "2", "5", "4"], "total": 29.0, "net": 19.0},
    {"rank": 6, "div": "ILCA 7 Men", "nat": "INA", "sail": "60", "name": "Aditya Rama Dani", "club": "KOARMADA I/JAKARTA", "gender": "M", "races": ["(7)", "6", "(8)", "6", "6", "6", "5"], "total": 44.0, "net": 29.0},
    {"rank": 7, "div": "ILCA 7 Men", "nat": "INA", "sail": "221579", "name": "Kevin Julyo Aldafa", "club": "KOTA BEKASI", "gender": "M", "races": ["6", "7", "6", "(10 DNC)", "(10 DNC)", "7", "6"], "total": 52.0, "net": 32.0},
    {"rank": 8, "div": "ILCA 7 Men", "nat": "INA", "sail": "209145", "name": "Omar Agoes", "club": "TLSC", "gender": "M", "races": ["(10 DNC)", "8", "7", "(10 DNC)", "10 DNC", "10 DNC", "10 DNC"], "total": 65.0, "net": 45.0},
    {"rank": 9, "div": "ILCA 7 Men", "nat": "INA", "sail": "80", "name": "Bagus Susanto", "club": "KOARMADA 1", "gender": "M", "races": ["(10 DNC)", "(10 DNC)", "10 DNC", "10 DNC", "10 DNC", "10 DNC", "10 DNC"], "total": 70.0, "net": 50.0}
]

# -------------------------------------------------------------
# 2. IDENTITY RESOLUTION & SAILOR MAPPING
# -------------------------------------------------------------
new_sailor_map = {} # norm_name -> sailor dict

def get_or_create_sailor(name: str, default_sail: str, default_club: str, default_nat: str, gender: str | None) -> tuple[str, bool]:
    norm = re.sub(r'[^a-z0-9]', '', name.lower())
    if norm in name_map:
        matches = name_map[norm]
        if len(matches) == 1:
            return matches[0]['id'], False
        else:
            for m in matches:
                if (m.get('nationality') == default_nat) or (default_club and default_club in m.get('club', '')):
                    return m['id'], False
            return matches[0]['id'], False

    if norm in new_sailor_map:
        return new_sailor_map[norm]['id'], False

    s_id = make_uuid(f"sailor:{name}:{default_nat}")
    handle = make_handle(name, default_club or default_nat)
    new_sailor_map[norm] = {
        'id': s_id,
        'name': name,
        'handle': handle,
        'sail_number': default_sail or 'N/A',
        'club': default_club or 'Indonesia National Sailing Center',
        'nationality': default_nat,
        'gender': gender
    }
    return s_id, True

# Resolve all sailors across all single-handed classes
for dataset in [optimist_entries, techno_entries, techno_plus_entries, iqfoil_entries, ilca4_entries, ilca6_entries, ilca7_entries]:
    for e in dataset:
        e['sailor_id'], _ = get_or_create_sailor(e['name'], e['sail'], e['club'], e['nat'], e['gender'])

# Resolve 420 double-handed sailors
for e in c420_entries:
    e['helm_id'], _ = get_or_create_sailor(e['helm_name'], e['sail'], e['club'], e['nat'], e['helm_gender'])
    e['crew_id'], _ = get_or_create_sailor(e['crew_name'], e['sail'], e['club'], e['nat'], e['crew_gender'])

print(f"Total new sailor profiles to insert: {len(new_sailor_map)}")

# -------------------------------------------------------------
# 3. SCORE TOKEN PARSER
# -------------------------------------------------------------
def parse_score_token(tok: str) -> tuple[float, str | None, bool, str]:
    tok = tok.strip()
    is_discard = tok.startswith('(') and ')' in tok
    clean = tok.replace('(', '').replace(')', '').strip()

    code_match = re.search(r'[A-Za-z]+', clean)
    code = code_match.group(0).upper() if code_match else None

    num_match = re.search(r'[\d.]+', clean)
    val = float(num_match.group(0)) if num_match else 0.0
    return val, code, is_discard, tok

# -------------------------------------------------------------
# 4. BUILD SQL MIGRATION
# -------------------------------------------------------------
event_id = make_uuid("event:ina-regatta-ii-national-sailing-championship-2026")

out_lines = [
    "-- Migration 170: Import INA Regatta II & National Sailing Championship 2026",
    "--",
    "-- Imports the official championship results for Indonesia's premier national regatta:",
    "-- Event: INA Regatta II & National Sailing Championship 2026 (Kejurnas Layar 2026)",
    "-- Dates: 20–23 August 2026 · Venue: Indonesia National Sailing Center (INSC), Ancol, Jakarta",
    "-- Authority: Pengurus Besar Persatuan Olahraga Layar Seluruh Indonesia (PB. PORLASI / INASAF)",
    "-- Official Source: Official 18-page results PDF (https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf)",
    "--",
    "-- Classes Imported (8 fleets across 7 permitted classes):",
    f"-- 1. Optimist: {len(optimist_entries)} boats, 7 races, 2 discards ({len(optimist_entries)*7} race scores)",
    f"-- 2. ILCA 4: {len(ilca4_entries)} boats, 7 races, 2 discards ({len(ilca4_entries)*7} race scores)",
    f"-- 3. ILCA 6: {len(ilca6_entries)} boats, 7 races, 2 discards ({len(ilca6_entries)*7} race scores)",
    f"-- 4. ILCA 7: {len(ilca7_entries)} boats, 7 races, 2 discards ({len(ilca7_entries)*7} race scores)",
    f"-- 5. International 420: {len(c420_entries)} boats, 8 races, 2 discards ({len(c420_entries)*8} race scores)",
    f"-- 6. Techno 293: {len(techno_entries)} boards, 8 races, 2 discards ({len(techno_entries)*8} race scores)",
    f"-- 7. Techno 293 Plus: {len(techno_plus_entries)} boards, 8 races, 2 discards ({len(techno_plus_entries)*8} race scores)",
    f"-- 8. iQFoil: {len(iqfoil_entries)} boards, 8 races, 2 discards ({len(iqfoil_entries)*8} race scores)",
    "--",
    "-- All operations execute in a single atomic transaction.",
    "",
    "BEGIN;",
    ""
]

# 1. Insert new sailors
out_lines.append("-- 1. Insert New Verified Sailor Profiles")
for s in new_sailor_map.values():
    escaped_name = s['name'].replace("'", "''")
    escaped_club = s['club'].replace("'", "''")
    gender_val = f"'{s['gender']}'" if s['gender'] else "NULL"
    out_lines.append(f"""INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '{s['id']}', '{escaped_name}', '{s['handle']}', '{s['sail_number']}', '{escaped_club}', '{s['nationality']}', {gender_val}, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);""")

out_lines.append("")

# Also enrich existing profiles that had missing nationality (Kirana Wardojo, Gregory Roger Wardojo)
out_lines.append("""-- Enrich existing profiles with verified Indonesian nationality & club
UPDATE public.sailors SET nationality = 'INA', club = 'JATIM' WHERE id = '79c6406b-143d-542d-a3fc-b8a328b93f96' AND nationality IS NULL;
UPDATE public.sailors SET nationality = 'INA', club = 'JATIM' WHERE id = 'd2d167b4-52fc-532a-8d72-11ffb103a300' AND nationality IS NULL;
""")

# 2. Insert Regatta Event
out_lines.append("-- 2. Insert INA Regatta II & National Sailing Championship 2026 Event")
out_lines.append(f"""INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules,
    created_at, updated_at
) VALUES (
    '{event_id}',
    'INA Regatta II & National Sailing Championship 2026',
    'ina-regatta-ii-national-sailing-championship-2026',
    '2026-08-20',
    '2026-08-23',
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'Pengurus Besar Persatuan Olahraga Layar Seluruh Indonesia (PB PORLASI / INASAF)',
    '["Optimist", "ILCA 4", "ILCA 6", "ILCA 7", "420", "Techno 293", "Techno 293 Plus", "iQFoil"]'::jsonb,
    false,
    false,
    'Official Indonesian National Sailing Championship 2026 (Kejurnas Layar) held 20–23 August 2026 at INSC Ancol, Jakarta.',
    'Low Point System (Appendix A) with 2 discards.',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;""")

out_lines.append("")

# 3. Helper to write single-handed regatta sheet and results
def write_single_handed_regatta(slug_suffix, sheet_name, boat_class, division, race_count, entries):
    r_id = make_uuid(f"regatta:{slug_suffix}")
    full_slug = f"ina-regatta-ii-national-sailing-championship-2026-{slug_suffix}"
    out_lines.append(f"-- Regatta Sheet: {sheet_name}")
    out_lines.append(f"""INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '{r_id}',
    '{event_id}',
    '{sheet_name}',
    '{full_slug}',
    '2026-08-23',
    '2026-08-23',
    {len(entries)},
    '{division}',
    {race_count},
    'INA',
    '{boat_class}',
    'individual',
    1,
    1,
    false,
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'PB. PORLASI / INASAF',
    'published',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'Official Final Results PDF from Indonesian Sailing Federation (PB. PORLASI / INASAF)',
    'Official Indonesian National Championship final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;""")

    for e in entries:
        res_id = make_uuid(f"result:{slug_suffix}:{e['rank']}:{e['sail']}")
        part_id = make_uuid(f"part:{res_id}")
        escaped_name = e['name'].replace("'", "''")
        escaped_club = e['club'].replace("'", "''")
        escaped_notes = f"INA Regatta II 2026. Sailor: {escaped_name}. Club: {escaped_club}. Division: {e['div']}. Nat: {e['nat']}."

        out_lines.append(f"""INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '{res_id}', '{e['sailor_id']}', '{r_id}', '{escaped_name}', '{e['sail']}', 'individual', {e['rank']},
    {e['total']}, {e['net']}, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', '{escaped_notes}', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;""")

        out_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{part_id}', '{res_id}', '{e['sailor_id']}', '{escaped_name}', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

        for race_num, tok in enumerate(e['races'], start=1):
            score, code, is_discard, raw_val = parse_score_token(tok)
            code_val = f"'{code}'" if code else "NULL"
            discard_val = "true" if is_discard else "false"
            out_lines.append(f"""INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{res_id}', {race_num}, {score}, {code_val}, {discard_val}, '{raw_val.replace("'", "''")}'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;""")

    out_lines.append("")

# Write 7 single-handed sheets
write_single_handed_regatta("optimist", "INA Regatta II & National Sailing Championship 2026 — Optimist", "Optimist", "Open", 7, optimist_entries)
write_single_handed_regatta("ilca-4", "INA Regatta II & National Sailing Championship 2026 — ILCA 4", "ILCA 4", "Open", 7, ilca4_entries)
write_single_handed_regatta("ilca-6", "INA Regatta II & National Sailing Championship 2026 — ILCA 6", "ILCA 6", "Open", 7, ilca6_entries)
write_single_handed_regatta("ilca-7", "INA Regatta II & National Sailing Championship 2026 — ILCA 7", "ILCA 7", "Men", 7, ilca7_entries)
write_single_handed_regatta("techno-293", "INA Regatta II & National Sailing Championship 2026 — Techno 293", "Techno 293", "Open", 8, techno_entries)
write_single_handed_regatta("techno-293-plus", "INA Regatta II & National Sailing Championship 2026 — Techno 293 Plus", "Techno 293", "Plus", 8, techno_plus_entries)
write_single_handed_regatta("iqfoil", "INA Regatta II & National Sailing Championship 2026 — iQFoil", "iQFoil", "Open", 8, iqfoil_entries)

# 4. Write double-handed 420 sheet
r420_id = make_uuid("regatta:420")
full_420_slug = "ina-regatta-ii-national-sailing-championship-2026-420"
out_lines.append("-- Regatta Sheet: 420")
out_lines.append(f"""INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '{r420_id}',
    '{event_id}',
    'INA Regatta II & National Sailing Championship 2026 — 420',
    '{full_420_slug}',
    '2026-08-23',
    '2026-08-23',
    {len(c420_entries)},
    'Open',
    8,
    'INA',
    '420',
    'crew',
    2,
    2,
    false,
    'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'PB. PORLASI / INASAF',
    'published',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'Official Final Results PDF from Indonesian Sailing Federation (PB. PORLASI / INASAF)',
    'Official Indonesian National Championship final results.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;""")

for e in c420_entries:
    res_id = make_uuid(f"result:420:{e['rank']}:{e['sail']}")
    part_helm_id = make_uuid(f"part:helm:420:{res_id}")
    part_crew_id = make_uuid(f"part:crew:420:{res_id}")
    entry_label = f"{e['helm_name']} & {e['crew_name']}"
    escaped_label = entry_label.replace("'", "''")
    escaped_boat = e['boat'].replace("'", "''")
    escaped_notes = f"INA Regatta II 2026. Boat: {escaped_boat}. Helm: {e['helm_name']}, Crew: {e['crew_name']}. Club: {e['club']}.".replace("'", "''")

    out_lines.append(f"""INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '{res_id}', '{e['helm_id']}', '{r420_id}', '{escaped_label}', '{e['sail']}', 'crew', {e['rank']},
    {e['total']}, {e['net']}, false, false, 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf', 'Official INASAF Results PDF',
    'document', '{escaped_notes}', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;""")

    # Helm
    out_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{part_helm_id}', '{res_id}', '{e['helm_id']}', '{e['helm_name'].replace("'", "''")}', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

    # Crew
    out_lines.append(f"""INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '{part_crew_id}', '{res_id}', '{e['crew_id']}', '{e['crew_name'].replace("'", "''")}', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;""")

    # 8 races
    for race_num, tok in enumerate(e['races'], start=1):
        score, code, is_discard, raw_val = parse_score_token(tok)
        code_val = f"'{code}'" if code else "NULL"
        discard_val = "true" if is_discard else "false"
        out_lines.append(f"""INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '{res_id}', {race_num}, {score}, {code_val}, {discard_val}, '{raw_val.replace("'", "''")}'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;""")

out_lines.append("")

# 5. Admin Change Log Record
total_boats = len(optimist_entries) + len(ilca4_entries) + len(ilca6_entries) + len(ilca7_entries) + len(c420_entries) + len(techno_entries) + len(techno_plus_entries) + len(iqfoil_entries)
total_race_scores = (len(optimist_entries)*7) + (len(ilca4_entries)*7) + (len(ilca6_entries)*7) + (len(ilca7_entries)*7) + (len(c420_entries)*8) + (len(techno_entries)*8) + (len(techno_plus_entries)*8) + (len(iqfoil_entries)*8)

out_lines.append(f"""-- 5. Admin Change Log Record
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'regattas.import_championships',
  'regatta',
  '{event_id}',
  'INA Regatta II & National Sailing Championship 2026',
  'Imported premier Indonesian National Sailing Championship across 8 fleets (Optimist, ILCA 4, ILCA 6, ILCA 7, 420, Techno 293, Techno 293 Plus, iQFoil) totaling {total_boats} entries and {total_race_scores} race scores from official INASAF PDF.',
  jsonb_build_object(
    'country', 'INA',
    'fleets_count', 8,
    'total_entries', {total_boats},
    'new_profiles_created', {len(new_sailor_map)},
    'total_race_scores', {total_race_scores},
    'status', 'published'
  ),
  'migration_170',
  clock_timestamp()
);""")

out_lines.append("")
out_lines.append("COMMIT;")

migration_sql = "\n".join(out_lines) + "\n"
migration_path = 'src/db/migrations/170_import_indonesia_national_sailing_championship_2026.sql'
with open(migration_path, 'w') as f:
    f.write(migration_sql)

print(f"Generated migration file {migration_path} ({len(out_lines)} lines).")

# Also save evidence manifest
evidence = {
    'event': 'INA Regatta II & National Sailing Championship 2026 (Kejurnas Layar 2026)',
    'venue': 'Indonesia National Sailing Center (INSC), Ancol, Jakarta, Indonesia',
    'dates': '20–23 August 2026',
    'country': 'INA',
    'organizer': 'Pengurus Besar Persatuan Olahraga Layar Seluruh Indonesia (PB PORLASI / INASAF)',
    'official_pdf_url': 'https://inasaf.org/result/doks/Results%20INA%20Regatta%20II%202026.pdf',
    'rrs_event_id': 15712,
    'rrs_url': 'https://www.racingrulesofsailing.org/documents/15712/event?name=ina-regatta-ii-national-championship-2026',
    'total_boats': total_boats,
    'total_race_scores': total_race_scores,
    'new_profiles_created': len(new_sailor_map),
    'fleets': [
        {'class': 'Optimist', 'fleet_size': len(optimist_entries), 'races': 7, 'discards': 2},
        {'class': 'ILCA 4', 'fleet_size': len(ilca4_entries), 'races': 7, 'discards': 2},
        {'class': 'ILCA 6', 'fleet_size': len(ilca6_entries), 'races': 7, 'discards': 2},
        {'class': 'ILCA 7', 'fleet_size': len(ilca7_entries), 'races': 7, 'discards': 2},
        {'class': '420', 'fleet_size': len(c420_entries), 'races': 8, 'discards': 2},
        {'class': 'Techno 293', 'fleet_size': len(techno_entries), 'races': 8, 'discards': 2},
        {'class': 'Techno 293 Plus', 'fleet_size': len(techno_plus_entries), 'races': 8, 'discards': 2},
        {'class': 'iQFoil', 'fleet_size': len(iqfoil_entries), 'races': 8, 'discards': 2}
    ]
}

with open('scripts/imports/indonesia-regatta-2026/evidence.json', 'w') as f:
    json.dump(evidence, f, indent=2)

print("Saved evidence manifest scripts/imports/indonesia-regatta-2026/evidence.json.")
