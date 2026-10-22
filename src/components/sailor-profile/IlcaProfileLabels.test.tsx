import { renderToStaticMarkup } from 'react-dom/server';
import { describe, expect, it } from 'vitest';
import { PositionTrendChart } from './PositionTrendChart';
import { ProfileStandingCard } from './ProfileStandingCard';
describe('ILCA rig labels and standings destinations', () => {
  for (const rig of [4,6,7]) it(`keeps ILCA ${rig} on the chart and its own standings link`, () => {
    const label = `ILCA ${rig}`;
    const chart = renderToStaticMarkup(<PositionTrendChart classLabel={label} points={[{date:'2026-01-01',rank:2,name:'One',fleet:'Open'},{date:'2026-02-01',rank:3,name:'Two',fleet:'Open'}]} mode="other" goldEntryDate={null} />);
    expect(chart).toContain(label);
    if (rig !== 4) expect(chart).not.toContain('ILCA 4');
    const card = renderToStaticMarkup(<ProfileStandingCard standing={{boatClass:label,fleet:'Open',overallRank:2,fleetSize:20,best3of5:10,rScores:[],periodLabel:label,trendNote:''}} standingIsIlca seriesDnsCount={0} cardClass="" />);
    expect(card).toContain(`href="/sg/ilca${rig}"`);
    expect(card).toContain(`View full ${label} standings`);
  });
});
