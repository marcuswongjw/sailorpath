/**
 * Admin sailor list/form shape.
 * Matches Drizzle sailors columns used in admin UI; dates often arrive as ISO strings.
 */
export type SailorAdmin = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  club: string;
  school?: string | null;
  nationality?: string | null;
  avatarUrl?: string | null;
  bio?: string | null;
  gender?: string | null;
  nationalSquadStatus?: string | null;
  currentFleet?: string | null;

  instagram?: string | null;
  facebook?: string | null;
  natSquadStatusJan25?: string | null;
  natSquadStatusJul25?: string | null;
  natSquadStatusJan26?: string | null;
  natSquadStatusJul26?: string | null;
  histRankingJun24?: number | null;
  histRankingDec24?: number | null;
  histRankingJun25?: number | null;
  histRankingDec25?: number | null;
  histRankingJun26?: number | null;
  worlds?: string | number | null;
  european?: string | number | null;
  asian?: string | number | null;
  seaGames?: string | number | null;
  dob?: string | Date | null;
  weight?: number | null;
  goldEntryDate?: string | Date | null;
  silverEntryDate?: string | Date | null;
  dropDate?: string | Date | null;
  isPublicWeight?: boolean | null;
  isPublicDob?: boolean | null;
  isPublicEquipment?: boolean | null;
  hullBrand?: string | null;
  sailMake?: string | null;
  foilBrand?: string | null;
  mast?: string | null;
  equipmentNotes?: string | null;
  parentId?: string | null;
  createdAt?: Date | string | null;
  updatedAt?: Date | string | null;
};
