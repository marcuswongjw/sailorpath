import { BADGE_STYLES, type EquipmentBadge } from "@/lib/equipment";

export function BadgeChip({
  badge,
  label,
}: {
  badge: EquipmentBadge;
  label: string;
}) {
  if (badge === "good" || badge === "new") return null;
  return (
    <span
      className={`inline-flex rounded-full border px-1.5 py-0.5 text-[9px] font-bold ${BADGE_STYLES[badge].className}`}
    >
      {label}
    </span>
  );
}
