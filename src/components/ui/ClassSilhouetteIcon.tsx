import React from "react";

type ClassSilhouetteIconProps = {
  className?: string;
  boatClass: string;
};

/**
 * Lightweight, decorative inline SVG silhouettes for each sailing class.
 * Zero network requests, <1 KB total, and strictly decorative (aria-hidden="true").
 */
export function ClassSilhouetteIcon({
  boatClass,
  className = "h-6 w-6 text-harbour",
}: ClassSilhouetteIconProps) {
  const key = boatClass.toLowerCase().replace(/[\s._-]+/g, "");

  if (key.includes("optimist")) {
    // Optimist: classic pram (blunt) bow hull with diagonal sprit rig
    return (
      <svg
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="1.75"
        strokeLinecap="round"
        strokeLinejoin="round"
        aria-hidden="true"
        className={className}
      >
        {/* Mast */}
        <path d="M8 3.5v13.5" />
        {/* Sprit-rigged quadrilateral main */}
        <path d="M8 4.5 18 3.5 17.5 14.5 8 15Z" fill="currentColor" fillOpacity="0.12" />
        {/* Diagonal sprit pole */}
        <path d="M8 13.5 18 3.5" strokeDasharray="1.5 1.5" />
        {/* Pram bow hull (blunt front & transom) */}
        <path d="M4.5 17h15l-1.2 3H5.8L4.5 17Z" />
      </svg>
    );
  }

  if (key.includes("wingfoil") || key.includes("x15")) {
    // WingFoil / X-15: board elevated on hydrofoil mast + swept handheld wing
    return (
      <svg
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="1.75"
        strokeLinecap="round"
        strokeLinejoin="round"
        aria-hidden="true"
        className={className}
      >
        {/* Swept wing */}
        <path
          d="M6.5 6.5C9.5 3.5 15.5 3.5 19.5 6.5 16.5 10.5 11.5 11.5 6.5 6.5Z"
          fill="currentColor"
          fillOpacity="0.14"
        />
        {/* Rider / boom strut */}
        <path d="M11.5 9.5 10 15" />
        {/* Compact foil board */}
        <path d="M5 15.2h13.5" />
        {/* Hydrofoil mast & fuselage */}
        <path d="M12.5 15.2v4.8" />
        <path d="M9.5 20h6.5" />
      </svg>
    );
  }

  if (key.includes("iqfoil")) {
    // iQFOiL: high-aspect windsurf sail with wishbone boom + deep hydrofoil
    return (
      <svg
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="1.75"
        strokeLinecap="round"
        strokeLinejoin="round"
        aria-hidden="true"
        className={className}
      >
        {/* Cambered windsurf sail */}
        <path
          d="M9.5 2.5C15.5 5 17.5 10 16.5 14.5H9.5V2.5Z"
          fill="currentColor"
          fillOpacity="0.14"
        />
        {/* Wishbone boom */}
        <path d="M8.5 10.5h8.2" />
        {/* Foil board */}
        <path d="M4.5 16h14.5" />
        {/* Hydrofoil T-strut */}
        <path d="M13 16v4.5" />
        <path d="M10 20.5h6" />
      </svg>
    );
  }

  if (key.includes("techno")) {
    // Techno 293: windsurfer longboard with wishbone boom & daggerboard/fin
    return (
      <svg
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="1.75"
        strokeLinecap="round"
        strokeLinejoin="round"
        aria-hidden="true"
        className={className}
      >
        {/* Windsurf sail */}
        <path
          d="M9.5 3C15 5.5 17.5 10.5 16.5 15.5H9.5V3Z"
          fill="currentColor"
          fillOpacity="0.14"
        />
        {/* Wishbone boom */}
        <path d="M8.5 11.2h8.2" />
        {/* Longboard hull */}
        <path d="M3.5 17.5c4-0.8 12-0.8 17 0" />
        {/* Daggerboard & rear fin */}
        <path d="M11.5 17.5l-1 3" />
        <path d="M17.5 17.5l-0.8 2.2" />
      </svg>
    );
  }

  if (key.includes("ilca") || key.includes("laser")) {
    // ILCA 4 / 6 / 7: low-profile cat-rigged racing dinghy with swept roach & boom
    return (
      <svg
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="1.75"
        strokeLinecap="round"
        strokeLinejoin="round"
        aria-hidden="true"
        className={className}
      >
        {/* Raked mast & triangular roach sail */}
        <path
          d="M8.5 3v13.5h9C17.5 10.5 14 5.5 8.5 3Z"
          fill="currentColor"
          fillOpacity="0.13"
        />
        {/* Upper batten hint */}
        <path d="M12.5 8.5h3.2" />
        {/* Low-freeboard hull */}
        <path d="M4 18h16l-2 2.2H5.5L4 18Z" />
      </svg>
    );
  }

  // Default / 29er / 420: double-handed sloop (mainsail + jib)
  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="1.75"
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden="true"
      className={className}
    >
      {/* Mainsail */}
      <path d="M11 3v13h7.5L11 3Z" fill="currentColor" fillOpacity="0.14" />
      {/* Jib */}
      <path d="M9.5 5.5v10.5H4.5L9.5 5.5Z" />
      {/* Hull */}
      <path d="M3.5 18h17l-2 2.2H5.5L3.5 18Z" />
    </svg>
  );
}
