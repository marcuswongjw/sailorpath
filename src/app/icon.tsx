import { ImageResponse } from "next/og";
import { BRAND } from "@/lib/brand";

export const size = { width: 32, height: 32 };
export const contentType = "image/png";

/** Tab favicon — matches BrandMark (orange SP). */
export default function Icon() {
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
          borderRadius: 8,
          color: "#ffffff",
          fontSize: 16,
          fontWeight: 900,
          letterSpacing: "-0.04em",
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
