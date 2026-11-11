/** @vitest-environment jsdom */
import { act, renderHook } from "@testing-library/react";
import { describe, expect, it, vi } from "vitest";
const confirmMock = vi.hoisted(() => vi.fn().mockResolvedValue(true));
vi.mock('next/navigation', () => ({useRouter: () => ({push: vi.fn(),replace: vi.fn(),refresh: vi.fn()})}));
vi.mock('@/components/ui/FeedbackProvider', () => ({useFeedback: () => ({toast:{error:vi.fn(), success:vi.fn(), info:vi.fn()}, confirm:confirmMock})}));
vi.mock('@/lib/supabase/browser', () => ({createBrowserSupabase: vi.fn()}));
import { useSailorProfileState } from './useSailorProfileState';
import type { SailorProfileViewProps, SeriesStandingProps } from './types';

const standing = (boatClass: string, overallRank: number): SeriesStandingProps => ({boatClass,overallRank,fleet:'Open',fleetSize:20,best3of5:25,rScores:[],periodLabel:`${boatClass} · 2026`,trendNote:''});
const props: SailorProfileViewProps = {
  initialSailor:{id:'s1',name:'Mixed rig sailor',handle:'mixed',nationality:'SGP'},
  initialEquipment:{},
  initialResults:[
    {id:'opti',regattaId:'opti',regattaName:'Old Optimist',boatClass:'Optimist',regattaDate:'2023-01-01',rank:1,geography:'SGP'},
    {id:'4',regattaId:'4',regattaName:'Youth Four',boatClass:'ILCA 4',regattaDate:'2024-01-01',rank:4,geography:'SGP'},
    {id:'6',regattaId:'6',regattaName:'Radial Six',boatClass:'Laser Radial',regattaDate:'2025-01-01',rank:6,geography:'SGP'},
    {id:'6-th',regattaId:'6-th',regattaName:'Radial Abroad',boatClass:'ILCA 6',regattaDate:'2025-02-01',rank:16,geography:'THA'},
    {id:'7',regattaId:'7',regattaName:'Standard Seven',boatClass:'ILCA 7',regattaDate:'2026-01-01',rank:7,geography:'SGP'},
  ],
  initialIlcaStandings:{ilca4:standing('ILCA 4',4),ilca6:standing('ILCA 6',6),ilca7:standing('ILCA 7',7)},
};
describe('separate ILCA profile flows', () => {
  it('selects the most recent rig and switches results, statistics, standing and country trend together', () => {
    const {result} = renderHook(() => useSailorProfileState(props));
    expect(result.current.resultsTab).toBe('ilca7');
    expect(result.current.classChoices.map((choice)=>[choice.label,choice.count])).toEqual([['Optimist',1],['ILCA 4',1],['ILCA 6',2],['ILCA 7',1]]);
    for (const [key,label,ids,rank,trendRanks] of [
      ['ilca4','ILCA 4',['4'],4,[4]],
      ['ilca6','ILCA 6',['6-th','6'],6,[6]],
      ['ilca7','ILCA 7',['7'],7,[7]],
    ] as const) {
      act(()=>result.current.setResultsTab(key));
      expect(result.current.selectedClassLabel).toBe(label);
      expect(result.current.activeResultsList.map(row=>row.id)).toEqual(ids);
      expect(result.current.ilcaKeyStats.regattaCount).toBe(ids.length);
      expect(result.current.activeStanding?.overallRank).toBe(rank);
      expect(result.current.trendPoints.map(point=>point.rank)).toEqual(trendRanks);
      expect(result.current.trendCaption).toContain(`last 10 ${label} regattas`);
    }
    act(()=>result.current.setResultsTab('ilca6'));
    act(()=>result.current.setTrendCountry('THA'));
    expect(result.current.trendPoints.map(point=>point.rank)).toEqual([16]);
    expect(result.current.activeResultsList).toHaveLength(2);
  });
  it('never borrows another class standing when the selected rig has none', () => {
    const {result} = renderHook(() => useSailorProfileState({...props,initialIlcaStandings:undefined,initialIlcaStanding:standing('ILCA 4',2)}));
    expect(result.current.resultsTab).toBe('ilca7');
    expect(result.current.activeStanding).toBeNull();
    act(()=>result.current.setResultsTab('ilca6'));
    expect(result.current.activeStanding).toBeNull();
    act(()=>result.current.setResultsTab('ilca4'));
    expect(result.current.activeStanding?.boatClass).toBe('ILCA 4');
  });
  it('handles ILCA 6-only profiles without relabelling them or requiring Optimist history', () => {
    const {result} = renderHook(() => useSailorProfileState({...props,initialResults:props.initialResults.filter(row=>row.id==='6')}));
    expect(result.current.resultsTab).toBe('ilca6');
    expect(result.current.classChoices).toEqual([{id:'ilca6',label:'ILCA 6',count:1}]);
    expect(result.current.primaryIsIlca).toBe(true);
    expect(result.current.activeResultsList.map(row=>row.id)).toEqual(['6']);
  });
  it('removes profile avatar completely and exposes no photo visibility toggle setting', async () => {
    const fetchMock = vi.fn().mockResolvedValue({
      ok: true,
      json: async () => ({
        ok: true,
        sailor: {
          id: 's1',
          avatarUrl: null,
        },
      }),
    });
    global.fetch = fetchMock;

    const { result } = renderHook(() =>
      useSailorProfileState({
        ...props,
        initialSailor: {
          ...props.initialSailor,
          avatarUrl: 'https://example.com/photo.jpg',
          showProfilePhotoOnPublicProfile: false,
        },
      })
    );

    expect('showProfilePhotoOnPublicProfile' in result.current.publicVisibility).toBe(false);
    expect(result.current.displaySailor.avatarUrl).toBe('https://example.com/photo.jpg');

    await act(async () => {
      await result.current.removeAvatar();
    });

    expect(confirmMock).toHaveBeenCalledTimes(1);
    expect(fetchMock).toHaveBeenCalledWith(
      '/api/account/sailor',
      expect.objectContaining({
        method: 'PATCH',
        body: JSON.stringify({
          sailorId: 's1',
          avatarUrl: null,
        }),
      })
    );
    expect(result.current.displaySailor.avatarUrl).toBeNull();
  });
});


describe('X-15 rider profiles', () => {
  it('opens the X-15 result history with no borrowed Optimist or ILCA standing', () => {
    const {result} = renderHook(() => useSailorProfileState({...props,initialResults:[{id:'x15-worlds',regattaId:'x15-worlds',regattaName:'X-15 Worlds',boatClass:'X-15',regattaDate:'2026-11-04',rank:1,geography:'ESP'}]}));
    expect(result.current.resultsTab).toBe('x15');
    expect(result.current.selectedClassLabel).toBe('X-15');
    expect(result.current.classChoices).toEqual([{id:'x15',label:'X-15',count:1}]);
    expect(result.current.activeResultsList.map(row=>row.id)).toEqual(['x15-worlds']);
    expect(result.current.onBoardClass).toBe(true);
    expect(result.current.activeStanding).toBeNull();
  });
});
