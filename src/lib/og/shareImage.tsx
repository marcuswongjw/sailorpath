import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { ImageResponse } from "next/og";
import type { ResultSheetShare, SailorShareModel } from "@/lib/publicSeo";

export const SHARE_IMAGE_SIZE = { width: 1200, height: 630 };

const TEAL = "#0A5557";
const ORANGE = "#D94C18";
const MIST = "#E7F3F3";

/** Glyphs shipped in the Montserrat subset. Anything else is dropped so image rendering cannot throw. */
const UNSUPPORTED =
  /[^\u0020-\u007E\u00A0-\u017F\u2013\u2014\u2018\u2019\u201C\u201D\u2022\u2026\u00B7]/g;

let fontData: Promise<ArrayBuffer> | null = null;

export function loadShareFont(): Promise<ArrayBuffer> {
  if (!fontData) {
    fontData = readFile(join(process.cwd(), "src/assets/fonts/Montserrat-Bold.ttf")).then((bytes) => {
      return bytes.buffer.slice(bytes.byteOffset, bytes.byteOffset + bytes.byteLength) as ArrayBuffer;
    });
  }
  return fontData;
}

export function ogText(value: string, max: number): string {
  const clean = value.replace(UNSUPPORTED, "").replace(/\s+/g, " ").trim();
  if (clean.length <= max) return clean;
  return `${clean.slice(0, Math.max(0, max - 3)).trimEnd()}...`;
}

async function fonts() {
  return [
    {
      name: "Montserrat",
      data: await loadShareFont(),
      weight: 700 as const,
      style: "normal" as const,
    },
  ];
}

function BrandMark() {
  return (
    <div style={{ display: "flex", alignItems: "center" }}>
      <div style={{ width: 18, height: 18, backgroundColor: ORANGE, marginRight: 16 }} />
      <div style={{ display: "flex", fontSize: 28, letterSpacing: 4, color: ORANGE }}>
        SAILORPATH
      </div>
    </div>
  );
}

export async function renderProfileShareImage(share: SailorShareModel) {
  const name = ogText(share.name, 48) || "Sailor";
  const subtitle =
    ogText([share.country, share.club].filter(Boolean).join(" | "), 80) || "Sailor profile";
  const best = ogText(share.bestResult || "Results on SailorPath", 90);
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          flexDirection: "column",
          backgroundColor: TEAL,
          color: "white",
          fontFamily: "Montserrat",
          padding: "64px 72px",
        }}
      >
        <BrandMark />
        <div style={{ display: "flex", fontSize: 72, lineHeight: 1.05, marginTop: 48 }}>{name}</div>
        <div style={{ display: "flex", fontSize: 32, color: MIST, marginTop: 20 }}>{subtitle}</div>
        <div style={{ display: "flex", flexGrow: 1 }} />
        <div style={{ display: "flex", alignItems: "flex-end" }}>
          <div style={{ display: "flex", flexDirection: "column", marginRight: 64 }}>
            <div style={{ display: "flex", fontSize: 20, color: ORANGE }}>REGATTAS</div>
            <div style={{ display: "flex", fontSize: 48, marginTop: 8 }}>{String(share.regattaCount)}</div>
          </div>
          <div style={{ display: "flex", flexDirection: "column", flexGrow: 1 }}>
            <div style={{ display: "flex", fontSize: 20, color: ORANGE }}>BEST RESULT</div>
            <div style={{ display: "flex", fontSize: 32, marginTop: 8 }}>{best}</div>
          </div>
        </div>
      </div>
    ),
    { ...SHARE_IMAGE_SIZE, fonts: await fonts() }
  );
}

export async function renderResultShareImage(
  sheet: Pick<ResultSheetShare, "regattaName" | "classLabel" | "datesText" | "top3">
) {
  const regatta = ogText(sheet.regattaName, 70) || "SailorPath results";
  const classLabel = ogText(sheet.classLabel, 60) || "Results";
  const dates = ogText(sheet.datesText || "", 60);
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          flexDirection: "column",
          backgroundColor: TEAL,
          color: "white",
          fontFamily: "Montserrat",
          padding: "56px 72px",
        }}
      >
        <BrandMark />
        <div style={{ display: "flex", fontSize: 28, color: ORANGE, marginTop: 36 }}>{classLabel}</div>
        <div style={{ display: "flex", fontSize: 52, lineHeight: 1.1, marginTop: 12 }}>{regatta}</div>
        {dates ? (
          <div style={{ display: "flex", fontSize: 28, color: MIST, marginTop: 16 }}>{dates}</div>
        ) : null}
        <div style={{ display: "flex", flexGrow: 1 }} />
        {sheet.top3.length ? (
          <div style={{ display: "flex", flexDirection: "column" }}>
            {sheet.top3.map((row) => (
              <div
                key={`${row.rank}-${row.name}`}
                style={{ display: "flex", alignItems: "center", marginTop: 10 }}
              >
                <div style={{ display: "flex", width: 56, fontSize: 32, color: ORANGE }}>{row.rank}</div>
                <div style={{ display: "flex", fontSize: 32 }}>{ogText(row.name, 42)}</div>
              </div>
            ))}
          </div>
        ) : (
          <div style={{ display: "flex", fontSize: 32 }}>Full standings on SailorPath</div>
        )}
      </div>
    ),
    { ...SHARE_IMAGE_SIZE, fonts: await fonts() }
  );
}
