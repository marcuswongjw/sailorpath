import type {
  EquipmentBoatClass,
  EquipmentCategory,
  EquipmentCondition,
  EquipmentItemDto,
  EquipmentStatus,
  EquipmentTag,
  SessionType,
  WindRange,
} from "@/lib/equipment";

export type EquipmentInventoryProps = {
  sailorId: string;
  isOwner: boolean;
  canSeeEquipment: boolean;
  mayHaveIlca: boolean;
  regattaOptions?: { id: string; name: string; date: string }[];
  cardClass?: string;
  onGearByRegatta?: (
    map: Record<
      string,
      { category: string; brand: string | null; label: string | null }[]
    >
  ) => void;
};

export type EquipmentFormState = {
  boatClass: EquipmentBoatClass;
  category: EquipmentCategory;
  brand: string;
  brandCustom: string;
  model: string;
  label: string;
  status: EquipmentStatus;
  condition: EquipmentCondition;
  isPrimary: boolean;
  tags: EquipmentTag[];
  windRange: WindRange | "";
  acquiredOn: string;
  notes: string;
};

export type ModalKind =
  | "quick"
  | "advanced"
  | "edit"
  | "use"
  | "fullRig"
  | "bulkTag"
  | null;

export type RegattaOption = { id: string; name: string; date: string };

export type { EquipmentItemDto, SessionType, EquipmentTag, EquipmentCategory };
