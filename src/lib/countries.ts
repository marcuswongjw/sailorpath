/**
 * ISO 3166-1 alpha-2 countries for regatta geography / event country.
 * Default for SG Optimist series: SG.
 */

export type CountryOption = {
  code: string;
  name: string;
};

/** Officially assigned ISO 3166-1 alpha-2 codes (249). */
export const COUNTRIES: CountryOption[] = [
  { code: "AF", name: "Afghanistan" },
  { code: "AX", name: "Åland Islands" },
  { code: "AL", name: "Albania" },
  { code: "DZ", name: "Algeria" },
  { code: "AS", name: "American Samoa" },
  { code: "AD", name: "Andorra" },
  { code: "AO", name: "Angola" },
  { code: "AI", name: "Anguilla" },
  { code: "AQ", name: "Antarctica" },
  { code: "AG", name: "Antigua and Barbuda" },
  { code: "AR", name: "Argentina" },
  { code: "AM", name: "Armenia" },
  { code: "AW", name: "Aruba" },
  { code: "AU", name: "Australia" },
  { code: "AT", name: "Austria" },
  { code: "AZ", name: "Azerbaijan" },
  { code: "BS", name: "Bahamas" },
  { code: "BH", name: "Bahrain" },
  { code: "BD", name: "Bangladesh" },
  { code: "BB", name: "Barbados" },
  { code: "BY", name: "Belarus" },
  { code: "BE", name: "Belgium" },
  { code: "BZ", name: "Belize" },
  { code: "BJ", name: "Benin" },
  { code: "BM", name: "Bermuda" },
  { code: "BT", name: "Bhutan" },
  { code: "BO", name: "Bolivia" },
  { code: "BQ", name: "Bonaire, Sint Eustatius and Saba" },
  { code: "BA", name: "Bosnia and Herzegovina" },
  { code: "BW", name: "Botswana" },
  { code: "BV", name: "Bouvet Island" },
  { code: "BR", name: "Brazil" },
  { code: "IO", name: "British Indian Ocean Territory" },
  { code: "BN", name: "Brunei Darussalam" },
  { code: "BG", name: "Bulgaria" },
  { code: "BF", name: "Burkina Faso" },
  { code: "BI", name: "Burundi" },
  { code: "CV", name: "Cabo Verde" },
  { code: "KH", name: "Cambodia" },
  { code: "CM", name: "Cameroon" },
  { code: "CA", name: "Canada" },
  { code: "KY", name: "Cayman Islands" },
  { code: "CF", name: "Central African Republic" },
  { code: "TD", name: "Chad" },
  { code: "CL", name: "Chile" },
  { code: "CN", name: "China" },
  { code: "CX", name: "Christmas Island" },
  { code: "CC", name: "Cocos (Keeling) Islands" },
  { code: "CO", name: "Colombia" },
  { code: "KM", name: "Comoros" },
  { code: "CG", name: "Congo" },
  { code: "CD", name: "Congo, Democratic Republic of the" },
  { code: "CK", name: "Cook Islands" },
  { code: "CR", name: "Costa Rica" },
  { code: "CI", name: "Côte d'Ivoire" },
  { code: "HR", name: "Croatia" },
  { code: "CU", name: "Cuba" },
  { code: "CW", name: "Curaçao" },
  { code: "CY", name: "Cyprus" },
  { code: "CZ", name: "Czechia" },
  { code: "DK", name: "Denmark" },
  { code: "DJ", name: "Djibouti" },
  { code: "DM", name: "Dominica" },
  { code: "DO", name: "Dominican Republic" },
  { code: "EC", name: "Ecuador" },
  { code: "EG", name: "Egypt" },
  { code: "SV", name: "El Salvador" },
  { code: "GQ", name: "Equatorial Guinea" },
  { code: "ER", name: "Eritrea" },
  { code: "EE", name: "Estonia" },
  { code: "SZ", name: "Eswatini" },
  { code: "ET", name: "Ethiopia" },
  { code: "FK", name: "Falkland Islands" },
  { code: "FO", name: "Faroe Islands" },
  { code: "FJ", name: "Fiji" },
  { code: "FI", name: "Finland" },
  { code: "FR", name: "France" },
  { code: "GF", name: "French Guiana" },
  { code: "PF", name: "French Polynesia" },
  { code: "TF", name: "French Southern Territories" },
  { code: "GA", name: "Gabon" },
  { code: "GM", name: "Gambia" },
  { code: "GE", name: "Georgia" },
  { code: "DE", name: "Germany" },
  { code: "GH", name: "Ghana" },
  { code: "GI", name: "Gibraltar" },
  { code: "GR", name: "Greece" },
  { code: "GL", name: "Greenland" },
  { code: "GD", name: "Grenada" },
  { code: "GP", name: "Guadeloupe" },
  { code: "GU", name: "Guam" },
  { code: "GT", name: "Guatemala" },
  { code: "GG", name: "Guernsey" },
  { code: "GN", name: "Guinea" },
  { code: "GW", name: "Guinea-Bissau" },
  { code: "GY", name: "Guyana" },
  { code: "HT", name: "Haiti" },
  { code: "HM", name: "Heard Island and McDonald Islands" },
  { code: "VA", name: "Holy See" },
  { code: "HN", name: "Honduras" },
  { code: "HK", name: "Hong Kong" },
  { code: "HU", name: "Hungary" },
  { code: "IS", name: "Iceland" },
  { code: "IN", name: "India" },
  { code: "ID", name: "Indonesia" },
  { code: "IR", name: "Iran" },
  { code: "IQ", name: "Iraq" },
  { code: "IE", name: "Ireland" },
  { code: "IM", name: "Isle of Man" },
  { code: "IL", name: "Israel" },
  { code: "IT", name: "Italy" },
  { code: "JM", name: "Jamaica" },
  { code: "JP", name: "Japan" },
  { code: "JE", name: "Jersey" },
  { code: "JO", name: "Jordan" },
  { code: "KZ", name: "Kazakhstan" },
  { code: "KE", name: "Kenya" },
  { code: "KI", name: "Kiribati" },
  { code: "KP", name: "Korea, Democratic People's Republic of" },
  { code: "KR", name: "Korea, Republic of" },
  { code: "KW", name: "Kuwait" },
  { code: "KG", name: "Kyrgyzstan" },
  { code: "LA", name: "Lao People's Democratic Republic" },
  { code: "LV", name: "Latvia" },
  { code: "LB", name: "Lebanon" },
  { code: "LS", name: "Lesotho" },
  { code: "LR", name: "Liberia" },
  { code: "LY", name: "Libya" },
  { code: "LI", name: "Liechtenstein" },
  { code: "LT", name: "Lithuania" },
  { code: "LU", name: "Luxembourg" },
  { code: "MO", name: "Macao" },
  { code: "MG", name: "Madagascar" },
  { code: "MW", name: "Malawi" },
  { code: "MY", name: "Malaysia" },
  { code: "MV", name: "Maldives" },
  { code: "ML", name: "Mali" },
  { code: "MT", name: "Malta" },
  { code: "MH", name: "Marshall Islands" },
  { code: "MQ", name: "Martinique" },
  { code: "MR", name: "Mauritania" },
  { code: "MU", name: "Mauritius" },
  { code: "YT", name: "Mayotte" },
  { code: "MX", name: "Mexico" },
  { code: "FM", name: "Micronesia" },
  { code: "MD", name: "Moldova" },
  { code: "MC", name: "Monaco" },
  { code: "MN", name: "Mongolia" },
  { code: "ME", name: "Montenegro" },
  { code: "MS", name: "Montserrat" },
  { code: "MA", name: "Morocco" },
  { code: "MZ", name: "Mozambique" },
  { code: "MM", name: "Myanmar" },
  { code: "NA", name: "Namibia" },
  { code: "NR", name: "Nauru" },
  { code: "NP", name: "Nepal" },
  { code: "NL", name: "Netherlands" },
  { code: "NC", name: "New Caledonia" },
  { code: "NZ", name: "New Zealand" },
  { code: "NI", name: "Nicaragua" },
  { code: "NE", name: "Niger" },
  { code: "NG", name: "Nigeria" },
  { code: "NU", name: "Niue" },
  { code: "NF", name: "Norfolk Island" },
  { code: "MK", name: "North Macedonia" },
  { code: "MP", name: "Northern Mariana Islands" },
  { code: "NO", name: "Norway" },
  { code: "OM", name: "Oman" },
  { code: "PK", name: "Pakistan" },
  { code: "PW", name: "Palau" },
  { code: "PS", name: "Palestine, State of" },
  { code: "PA", name: "Panama" },
  { code: "PG", name: "Papua New Guinea" },
  { code: "PY", name: "Paraguay" },
  { code: "PE", name: "Peru" },
  { code: "PH", name: "Philippines" },
  { code: "PN", name: "Pitcairn" },
  { code: "PL", name: "Poland" },
  { code: "PT", name: "Portugal" },
  { code: "PR", name: "Puerto Rico" },
  { code: "QA", name: "Qatar" },
  { code: "RE", name: "Réunion" },
  { code: "RO", name: "Romania" },
  { code: "RU", name: "Russian Federation" },
  { code: "RW", name: "Rwanda" },
  { code: "BL", name: "Saint Barthélemy" },
  { code: "SH", name: "Saint Helena, Ascension and Tristan da Cunha" },
  { code: "KN", name: "Saint Kitts and Nevis" },
  { code: "LC", name: "Saint Lucia" },
  { code: "MF", name: "Saint Martin (French part)" },
  { code: "PM", name: "Saint Pierre and Miquelon" },
  { code: "VC", name: "Saint Vincent and the Grenadines" },
  { code: "WS", name: "Samoa" },
  { code: "SM", name: "San Marino" },
  { code: "ST", name: "Sao Tome and Principe" },
  { code: "SA", name: "Saudi Arabia" },
  { code: "SN", name: "Senegal" },
  { code: "RS", name: "Serbia" },
  { code: "SC", name: "Seychelles" },
  { code: "SL", name: "Sierra Leone" },
  { code: "SG", name: "Singapore" },
  { code: "SX", name: "Sint Maarten (Dutch part)" },
  { code: "SK", name: "Slovakia" },
  { code: "SI", name: "Slovenia" },
  { code: "SB", name: "Solomon Islands" },
  { code: "SO", name: "Somalia" },
  { code: "ZA", name: "South Africa" },
  { code: "GS", name: "South Georgia and the South Sandwich Islands" },
  { code: "SS", name: "South Sudan" },
  { code: "ES", name: "Spain" },
  { code: "LK", name: "Sri Lanka" },
  { code: "SD", name: "Sudan" },
  { code: "SR", name: "Suriname" },
  { code: "SJ", name: "Svalbard and Jan Mayen" },
  { code: "SE", name: "Sweden" },
  { code: "CH", name: "Switzerland" },
  { code: "SY", name: "Syrian Arab Republic" },
  { code: "TW", name: "Taiwan" },
  { code: "TJ", name: "Tajikistan" },
  { code: "TZ", name: "Tanzania" },
  { code: "TH", name: "Thailand" },
  { code: "TL", name: "Timor-Leste" },
  { code: "TG", name: "Togo" },
  { code: "TK", name: "Tokelau" },
  { code: "TO", name: "Tonga" },
  { code: "TT", name: "Trinidad and Tobago" },
  { code: "TN", name: "Tunisia" },
  { code: "TR", name: "Türkiye" },
  { code: "TM", name: "Turkmenistan" },
  { code: "TC", name: "Turks and Caicos Islands" },
  { code: "TV", name: "Tuvalu" },
  { code: "UG", name: "Uganda" },
  { code: "UA", name: "Ukraine" },
  { code: "AE", name: "United Arab Emirates" },
  { code: "GB", name: "United Kingdom" },
  { code: "US", name: "United States" },
  { code: "UM", name: "United States Minor Outlying Islands" },
  { code: "UY", name: "Uruguay" },
  { code: "UZ", name: "Uzbekistan" },
  { code: "VU", name: "Vanuatu" },
  { code: "VE", name: "Venezuela" },
  { code: "VN", name: "Viet Nam" },
  { code: "VG", name: "Virgin Islands (British)" },
  { code: "VI", name: "Virgin Islands (U.S.)" },
  { code: "WF", name: "Wallis and Futuna" },
  { code: "EH", name: "Western Sahara" },
  { code: "YE", name: "Yemen" },
  { code: "ZM", name: "Zambia" },
  { code: "ZW", name: "Zimbabwe" },
];

/** Common boat classes for import (default Optimist). */
export const BOAT_CLASSES = [
  "Optimist",
  "ILCA 4",
  "ILCA 6",
  "ILCA 7",
  "Laser",
  "Laser Radial",
  "420",
  "29er",
  "49er",
  "49erFX",
  "Nacra 15",
  "Nacra 17",
  "iQFoil",
  "Techno 293",
  "RS Feva",
  "RS Tera",
  "Open Bic",
  "Other",
] as const;

/** Default regatta geography — NOC-style (same family as nationality). */
export const DEFAULT_GEOGRAPHY = "SGP";
export const DEFAULT_BOAT_CLASS = "Optimist";
/** Default sailor nationality (IOC / NOC style). */
export const DEFAULT_NATIONALITY = "SGP";

/**
 * ISO 3166-1 alpha-2 → Olympic/NOC-style 3-letter code used for sailor nationality.
 * Covers sailing nations + common Asia-Pacific NOCs.
 */
export const ISO2_TO_NOC: Record<string, string> = {
  SG: "SGP",
  MY: "MAS",
  ID: "INA",
  TH: "THA",
  PH: "PHI",
  VN: "VIE",
  CN: "CHN",
  HK: "HKG",
  MO: "MAC",
  TW: "TPE",
  JP: "JPN",
  KR: "KOR",
  KP: "PRK",
  AU: "AUS",
  NZ: "NZL",
  US: "USA",
  GB: "GBR",
  IE: "IRL",
  FR: "FRA",
  DE: "GER",
  IT: "ITA",
  ES: "ESP",
  PT: "POR",
  NL: "NED",
  BE: "BEL",
  CH: "SUI",
  AT: "AUT",
  SE: "SWE",
  NO: "NOR",
  DK: "DEN",
  FI: "FIN",
  PL: "POL",
  CZ: "CZE",
  HU: "HUN",
  GR: "GRE",
  TR: "TUR",
  RU: "RUS",
  UA: "UKR",
  BR: "BRA",
  AR: "ARG",
  CL: "CHI",
  MX: "MEX",
  CA: "CAN",
  ZA: "RSA",
  IN: "IND",
  AE: "UAE",
  QA: "QAT",
  SA: "KSA",
  BH: "BRN",
  KW: "KUW",
  OM: "OMA",
  IL: "ISR",
  EG: "EGY",
  HR: "CRO",
  SI: "SLO",
  SK: "SVK",
  RO: "ROU",
  BG: "BUL",
  LT: "LTU",
  LV: "LAT",
  EE: "EST",
  IS: "ISL",
  LU: "LUX",
  MT: "MLT",
  CY: "CYP",
  BY: "BLR",
  KZ: "KAZ",
  UZ: "UZB",
  PE: "PER",
  CO: "COL",
  UY: "URU",
  EC: "ECU",
  VE: "VEN",
  CU: "CUB",
  PR: "PUR",
  TT: "TTO",
  JM: "JAM",
  BS: "BAH",
  BB: "BAR",
  FJ: "FIJ",
  PG: "PNG",
  GU: "GUM",
  AS: "ASA",
  CK: "COK",
  WS: "SAM",
  TO: "TGA",
  VU: "VAN",
  NC: "NCL",
  PF: "PYF",
  LK: "SRI",
  BD: "BAN",
  PK: "PAK",
  MM: "MYA",
  KH: "CAM",
  LA: "LAO",
  BN: "BRU",
  MN: "MGL",
  NP: "NEP",
};

const NOC_TO_ISO2: Record<string, string> = Object.fromEntries(
  Object.entries(ISO2_TO_NOC).map(([iso, noc]) => [noc, iso])
);

const NAME_TO_ISO2: Map<string, string> = (() => {
  const m = new Map<string, string>();
  for (const c of COUNTRIES) {
    m.set(c.name.toLowerCase(), c.code);
    m.set(c.code.toLowerCase(), c.code);
  }
  // Common aliases
  m.set("singapore", "SG");
  m.set("republic of singapore", "SG");
  m.set("malaysia", "MY");
  m.set("indonesia", "ID");
  m.set("thailand", "TH");
  m.set("philippines", "PH");
  m.set("viet nam", "VN");
  m.set("vietnam", "VN");
  m.set("hong kong", "HK");
  m.set("hong kong, china", "HK");
  m.set("chinese taipei", "TW");
  m.set("taiwan", "TW");
  m.set("korea", "KR");
  m.set("south korea", "KR");
  m.set("great britain", "GB");
  m.set("united kingdom", "GB");
  m.set("uk", "GB");
  m.set("united states", "US");
  m.set("usa", "US");
  m.set("u.s.a.", "US");
  m.set("u.s.", "US");
  return m;
})();

function cleanCountryRaw(v: unknown): string | null {
  if (v == null || v === "") return null;
  const raw = String(v).trim().replace(/\s+/g, " ");
  if (!raw || /^n\/?a$/i.test(raw) || raw === "-" || raw === "—") return null;
  return raw;
}

/**
 * Regatta geography — stored as NOC-style codes (SGP, MAS, …), same as nationality.
 * Accepts ISO2, NOC, or country names.
 */
export function normalizeGeography(v: unknown): string | null {
  return normalizeNationalityCode(v);
}

/**
 * Sailor nationality as IOC/NOC-style code when known (SGP, MAS, …),
 * otherwise ISO2 or original uppercased token.
 */
export function normalizeNationalityCode(v: unknown): string | null {
  const raw = cleanCountryRaw(v);
  if (!raw) return null;
  const key = raw.toLowerCase();

  // Explicit NOC aliases
  const aliasNoc: Record<string, string> = {
    singapore: "SGP",
    sgp: "SGP",
    sin: "SGP",
    sg: "SGP",
    "singapore (sgp)": "SGP",
    "republic of singapore": "SGP",
    malaysia: "MAS",
    mas: "MAS",
    mal: "MAS",
    my: "MAS",
    indonesia: "INA",
    ina: "INA",
    idn: "INA",
    id: "INA",
    thailand: "THA",
    tha: "THA",
    th: "THA",
    philippines: "PHI",
    phi: "PHI",
    phl: "PHI",
    ph: "PHI",
    vietnam: "VIE",
    "viet nam": "VIE",
    vie: "VIE",
    vnm: "VIE",
    vn: "VIE",
    china: "CHN",
    chn: "CHN",
    cn: "CHN",
    "hong kong": "HKG",
    hkg: "HKG",
    hk: "HKG",
    japan: "JPN",
    jpn: "JPN",
    jp: "JPN",
    korea: "KOR",
    "south korea": "KOR",
    kor: "KOR",
    kr: "KOR",
    australia: "AUS",
    aus: "AUS",
    au: "AUS",
    "new zealand": "NZL",
    nzl: "NZL",
    nz: "NZL",
    "united states": "USA",
    usa: "USA",
    us: "USA",
    "great britain": "GBR",
    "united kingdom": "GBR",
    gbr: "GBR",
    uk: "GBR",
    gb: "GBR",
  };
  if (aliasNoc[key]) return aliasNoc[key];

  if (/^[A-Za-z]{3}$/.test(raw)) {
    const noc = raw.toUpperCase();
    // Known NOC or treat as code
    return noc;
  }

  if (/^[A-Za-z]{2}$/.test(raw)) {
    const iso = raw.toUpperCase();
    return ISO2_TO_NOC[iso] || iso;
  }

  const isoFromName = NAME_TO_ISO2.get(key);
  if (isoFromName) return ISO2_TO_NOC[isoFromName] || isoFromName;

  return raw.length <= 12 ? raw.toUpperCase() : raw.slice(0, 40);
}

/** True when raw could not be mapped to a known country/NOC list entry. */
export function isUnrecognizedCountry(v: unknown): boolean {
  const raw = cleanCountryRaw(v);
  if (!raw) return false;
  const key = raw.toLowerCase();
  // Known country name → recognized
  if (NAME_TO_ISO2.has(key)) return false;
  const nat = normalizeNationalityCode(raw);
  if (!nat) return true;
  if (NOC_TO_ISO2[nat]) return false;
  if (nat.length === 2 && COUNTRIES.some((c) => c.code === nat)) return false;
  const knownNocs = new Set(Object.values(ISO2_TO_NOC));
  if (knownNocs.has(nat)) return false;
  // Multi-word free text that didn't map is unrecognized
  if (/\s/.test(raw) || raw.length > 3) return true;
  // Bare 2–3 letter token: treat as a code (possibly valid NOC we don't list)
  if (/^[A-Za-z]{2,3}$/.test(raw)) return false;
  return true;
}

export function countryLabelForIso2(code: string | null | undefined): string {
  if (!code) return "—";
  const c = COUNTRIES.find((x) => x.code === code.toUpperCase());
  return c ? `${c.code} — ${c.name}` : code;
}

export function nationalityLabelForCode(code: string | null | undefined): string {
  if (!code) return "—";
  const noc = code.toUpperCase();
  const iso = NOC_TO_ISO2[noc];
  if (iso) {
    const c = COUNTRIES.find((x) => x.code === iso);
    if (c) return `${noc} — ${c.name}`;
  }
  if (noc.length === 2) {
    const c = COUNTRIES.find((x) => x.code === noc);
    if (c) return `${ISO2_TO_NOC[noc] || noc} — ${c.name}`;
  }
  return noc;
}

/**
 * Options for geography + nationality selects (NOC values).
 * Singapore first, then remaining countries by name.
 */
export function nationalitySelectOptions(): { code: string; name: string }[] {
  const seen = new Set<string>();
  const out: { code: string; name: string }[] = [];
  const push = (code: string, name: string) => {
    if (seen.has(code)) return;
    seen.add(code);
    out.push({ code, name });
  };
  push("SGP", "Singapore");
  for (const c of COUNTRIES) {
    if (c.code === "SG") continue;
    const noc = ISO2_TO_NOC[c.code] || c.code;
    push(noc, c.name);
  }
  return out;
}

/** Alias — geography uses the same NOC option list as nationality. */
export function geographySelectOptions(): { code: string; name: string }[] {
  return nationalitySelectOptions();
}

/** Classes with a single open fleet (no Gold/Silver split). */
export const SINGLE_FLEET_CLASSES = new Set([
  "ILCA 4",
  "ILCA4",
  "Laser 4.7",
]);

export function isSingleFleetClass(boatClass: string | null | undefined): boolean {
  if (!boatClass) return false;
  const n = boatClass.trim().toLowerCase().replace(/\s+/g, " ");
  if (SINGLE_FLEET_CLASSES.has(boatClass.trim())) return true;
  if (n === "ilca 4" || n === "ilca4") return true;
  if (n === "laser 4.7" || n === "laser4.7") return true;
  return false;
}

/**
 * Optimist: sailors may also race ILCA 4.
 * Must leave Optimist only when age > 15 (calendar year rules may vary by authority —
 * we flag DOB year + 15 as a soft advisory, not hard enforcement).
 */
export const OPTIMIST_MAX_AGE = 15;

export function classImportNote(boatClass: string): string | null {
  if (isSingleFleetClass(boatClass)) {
    return "This class has a single open fleet — no Gold/Silver division.";
  }
  if (boatClass === "Optimist") {
    return "Sailors under 15 may hold two sail numbers (Optimist + ILCA 4) and race both classes. Optimist eligibility ends when the sailor is over 15. ILCA results never affect Optimist Gold/Silver rankings.";
  }
  if (boatClass === "ILCA 4" || boatClass === "ILCA 6") {
    return "High Ranking Points (1st = fleet size pts). Best 3 of last 5 ranking regattas. Sail number for ILCA 4 is stored separately from Optimist.";
  }
  return null;
}
