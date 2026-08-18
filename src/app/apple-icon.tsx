import { ImageResponse } from "next/og";
import { BRAND } from "@/lib/brand";

export const size = { width: 180, height: 180 };
export const contentType = "image/png";

/** iOS home-screen icon — same BrandMark with more padding. */
export default function AppleIcon() {
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          background: BRAND.orange,
          borderRadius: 36,
          color: "#ffffff",
          fontSize: 72,
          fontWeight: 900,
          letterSpacing: "-0.05em",
          fontFamily:
            "ui-sans-serif, system-ui, -apple-system, Segoe UI, sans-serif",
        }}
      >
        {BRAND.markLetters}
      </div>
    ),
    { ...size }
  );
}
