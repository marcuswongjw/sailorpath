import type { ClaimRelation } from "@/lib/claimRelation";
import type { PersonalSeasonView } from "@/lib/personalSeason";
import { birthYear } from "@/lib/age";

export type Standing = {
  periodLabel: string;
  fleet: string;
  overallRank: number;
  fleetSize: number;
  best3of5: number;
  trendNote: string;
};

export type SelectionTrials = {
  rank: number;
  nettScore: number;
  eventsSailed: number;
  isQualifiedAsian: boolean;
  isQualifiedPerth: boolean;
  asianTeamRank?: number;
  gapToCutoff?: number;
};

export type RecentResult = {
  regattaName: string;
  regattaDate: string;
  rank: number;
  boatClass: string | null;
};

export type PrimaryGearItem = {
  id: string;
  category: string;
  brand: string | null;
  model: string | null;
  label: string | null;
  condition: string;
  status: string;
  isPrimary: boolean;
};

export type CoachFeedbackItem = {
  id: string;
  type: string;
  category: string | null;
  title: string;
  detail: string | null;
  recordDate: string;
  status: string;
};

export type Note = {
  id: string;
  body: string;
  createdAt: string;
};

export type Athlete = {
  id: string;
  name: string;
  handle: string;
  sailNumber: string;
  sailNumberIlca4?: string | null;
  club: string;
  school?: string | null;
  gender?: string | null;
  nationality?: string | null;
  avatarUrl?: string | null;
  currentFleet?: string | null;
  ownerRelation?: ClaimRelation | null;
  nationalSquadStatus?: string | null;
  dob?: string | null;
  standing: Standing | null;
  season?: PersonalSeasonView | null;
  selectionTrials?: SelectionTrials | null;
  recentResults?: RecentResult[];
  primaryGear?: PrimaryGearItem[];
  equipmentAlertCount?: number;
  equipmentAlerts?: { label: string; reason: string }[];
  coachFeedback?: CoachFeedbackItem[];
  notes?: Note[];
};

export type UpcomingRegatta = {
  id: string;
  name: string;
  date: string;
  boatClass: string | null;
  division: string | null;
  slug: string | null;
};

export type PendingClaim = {
  id: string;
  status: string;
  relation: ClaimRelation | null;
  source?: string | null;
  sailorName: string;
  sailorHandle: string;
  createdAt: string;
};

export type NoteCategory =
  | "General"
  | "Training"
  | "Regatta Debrief"
  | "Logistics"
  | "Gear";

export function formatAgeCategory(dob?: string | null) {
  const by = birthYear(dob);
  if (!by) return null;
  const currentYear = new Date().getFullYear();
  const age = currentYear - by;
  return `${by} · U${age + 1} (${age} yrs)`;
}
