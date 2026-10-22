/** @vitest-environment jsdom */
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { describe, expect, it, vi } from 'vitest';
vi.mock('next/navigation', () => ({useRouter: () => ({push:vi.fn(),replace:vi.fn(),refresh:vi.fn()})}));
vi.mock('next/dynamic', () => ({default: () => () => null}));
vi.mock('@/components/ui/FeedbackProvider', () => ({useFeedback: () => ({toast:{error:vi.fn()}, confirm:vi.fn()})}));
vi.mock('@/lib/supabase/browser', () => ({createBrowserSupabase:vi.fn()}));
import { SailorProfileView } from '@/components/SailorProfileView';

const rows = [4,6,7].map(rig => ({id:`rig-${rig}`,regattaId:`rig-${rig}`,regattaSlug:`cup-ilca-${rig}`,regattaName:`Cup for rig ${rig}`,boatClass:`ILCA ${rig}`,regattaDate:`2026-0${rig}-01`,geography:'SGP',rank:rig,fleetSize:20,raceResults:[{raceNumber:1,score:rig,discarded:false}]}));
describe('ILCA profile rendering', () => {
  it('labels every rig correctly and changes both overview and results when switching class', async () => {
    const user = userEvent.setup();
    render(<SailorProfileView initialSailor={{id:'mixed',name:'Mixed Rig Sailor',handle:'mixed',nationality:'SGP'}} initialEquipment={{}} initialResults={rows} />);
    expect(screen.getByRole('tab',{name:'ILCA 7'})).toHaveAttribute('aria-selected','true');
    expect(screen.getByRole('heading',{name:'Recent ILCA 7 regattas'})).toBeInTheDocument();
    expect(screen.getByText('ILCA 7 rank')).toBeInTheDocument();
    expect(screen.getByRole('group',{name:'1 ILCA 7 regattas'})).toBeInTheDocument();
    for (const rig of [4,6,7]) {
      await user.click(screen.getByRole('tab',{name:`ILCA ${rig}`}));
      expect(screen.getByRole('heading',{name:`Recent ILCA ${rig} regattas`})).toBeInTheDocument();
      expect(screen.getByText(`Cup for rig ${rig}`)).toBeInTheDocument();
      for (const other of [4,6,7].filter(n=>n!==rig)) expect(screen.queryByText(`Cup for rig ${other}`)).not.toBeInTheDocument();
      await user.click(screen.getByRole('button',{name:'Regattas1'}));
      expect(screen.getByRole('heading',{name:`Regatta results · ILCA ${rig}`})).toBeInTheDocument();
      expect(screen.getByText(`Cup for rig ${rig}`)).toBeInTheDocument();
      await user.click(screen.getByRole('button',{name:'Overview'}));
    }
  });
});
