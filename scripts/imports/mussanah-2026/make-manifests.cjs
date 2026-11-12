const fs = require('fs');
for (const source of require('./extracted.json')) {
  const eventSlug='mussanah-race-week-2026';
  const manifest={
    officialSource:{url:'https://www.omansail.om/events/mussanah-race-week-2026#results',title:`Oman Sail Mussanah Race Week 2026 ${source.name}, Day 4, updated 21 October 2026`,visuallyReviewed:false},
    event:{slug:eventSlug,startDate:'2026-10-15',endDate:'2026-10-22',venue:'Barceló Mussanah Resort, Oman',organizer:'Oman Sail'},
    sheet:{slug:`${eventSlug}-${source.id}`,name:`Mussanah Race Week 2026 (${source.name})`,boatClass:source.name,division:'Open',raceCount:12,totalFleetSize:source.rows.length,countsForRanking:false,status:'published'},
    results:source.rows.map(r=>({rank:r.rank,name:r.name,sailOrBoardNumber:r.sail,gender:r.gender,nationality:r.nationality,grossScore:r.total,nettScore:r.nett,races:r.race}))
  };
  fs.writeFileSync(`scripts/imports/mussanah-2026/${source.id}.json`,JSON.stringify(manifest,null,2)+'\n');
}
