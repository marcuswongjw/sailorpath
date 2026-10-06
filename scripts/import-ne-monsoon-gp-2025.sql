-- Official event 10645 import. Result PDF screenshots visually checked on 6 October 2026.
-- Re-runnable upserts; no unrelated event or sailor data is removed.
BEGIN;
DO $import$
DECLARE event_json jsonb; entry jsonb; race jsonb; board jsonb;
 event_uuid uuid; sheet_uuid uuid; sailor_uuid uuid; result_uuid uuid;
 fleet text; sheet_slug text; canonical text; matches int; race_no int;
BEGIN
 FOR event_json IN SELECT value FROM jsonb_array_elements($events$[{"key": "series2", "slug": "ne-monsoon-grand-prix-2025-series-2", "name": "2025 Northeast Monsoon Grand Prix Series 2", "start": "2025-02-08", "end": "2025-02-09", "dates": "8\u20139 February 2025", "source": "129774", "summary": "Series 2 at Changi Beach Park CP 1 / Tanah Merah. Results provisional as of 21:14 on 10 February 2025.", "rows": [{"fleet": "Windfoil", "rank": 1, "name": "Angel Chew", "sailNumber": "SGP 42", "gender": "F", "club": "Changi Sailing Club", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 26, "nettScore": 17, "races": [{"score": 1.0, "isDiscarded": true}, {"score": 1.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 3.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 2.0, "isDiscarded": true}, {"score": 1.0}], "sourceName": "Angel Chew"}, {"fleet": "Windfoil", "rank": 2, "name": "Angyal Chew", "sailNumber": "SGP", "gender": "F", "club": "Changi Sailing Club", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 41, "nettScore": 31, "races": [{"score": 2.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 1.0}, {"score": 2.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 2.0}, {"score": 1.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 1.0}, {"score": 2.0}], "sourceName": "Angyal Chew"}, {"fleet": "Windfoil", "rank": 3, "name": "Jonas Haris Knick", "sailNumber": "SGP 39", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 77, "nettScore": 56, "races": [{"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0, "isDiscarded": true}, {"score": 4.0, "isDiscarded": true}, {"score": 3.0}, {"score": 2.0}, {"score": 3.0}, {"score": 3.0}, {"score": 5.0, "isDiscarded": true}, {"score": 4.0, "isDiscarded": true}, {"score": 4.0, "isDiscarded": true}, {"score": 4.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 4.0}, {"score": 3.0}, {"score": 4.0}, {"score": 4.0}], "sourceName": "Jonas Knick"}, {"fleet": "Windfoil", "rank": 4, "name": "Lukas Knick", "sailNumber": "SGP 31", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 79, "nettScore": 57, "races": [{"score": 4.0, "isDiscarded": true}, {"score": 5.0, "isDiscarded": true}, {"score": 4.0, "isDiscarded": true}, {"score": 4.0, "isDiscarded": true}, {"score": 3.0}, {"score": 3.0}, {"score": 5.0, "isDiscarded": true}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}], "sourceName": "Lukas Knick"}, {"fleet": "Windfoil", "rank": 5, "name": "Trevor Ng", "sailNumber": "SGP 21", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 107, "nettScore": 82, "races": [{"score": 5.0, "isDiscarded": true}, {"score": 4.0}, {"score": 5.0, "isDiscarded": true}, {"score": 5.0, "isDiscarded": true}, {"score": 5.0, "isDiscarded": true}, {"score": 5.0, "isDiscarded": true}, {"score": 4.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 4.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}], "sourceName": "Trevor Ng"}, {"fleet": "Windfoil", "rank": 6, "name": "John Tze Xiang Wong", "sailNumber": "SGP 2", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 154, "nettScore": 119, "races": [{"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}], "sourceName": "John Tze Xiang Wong"}, {"fleet": "Techno 293", "rank": 1, "name": "Jun Ler Chuah", "sailNumber": "16", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 5, "nettScore": 4, "races": [{"score": 1.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}], "sourceName": "Jun Ler Chuah"}, {"fleet": "Techno 293", "rank": 2, "name": "Axl Tan", "sailNumber": "SGP 82", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 10, "nettScore": 8, "races": [{"score": 2.0, "isDiscarded": true}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}], "sourceName": "Axl Tan"}, {"fleet": "Techno 293", "rank": 3, "name": "Muhammad Razin", "sailNumber": "3", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 30, "nettScore": 24, "races": [{"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}], "sourceName": "Muhammad Razin"}, {"fleet": "Techno 293", "rank": 3, "name": "Reynold Chan", "sailNumber": "52", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 30, "nettScore": 24, "races": [{"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}], "sourceName": "Reynold Chan"}, {"fleet": "Techno 293", "rank": 3, "name": "Jonathan Chan", "sailNumber": "1", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 30, "nettScore": 24, "races": [{"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}], "sourceName": "Jonathan Chan"}, {"fleet": "Wingfoil", "rank": 1, "name": "Jackson Ho", "sailNumber": "11", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 43, "nettScore": 16, "races": [{"score": 1.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 6.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 18.0, "isDiscarded": true, "code": "OCS"}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}], "sourceName": "Jackson Ho"}, {"fleet": "Wingfoil", "rank": 2, "name": "Ryusai Hatano", "sailNumber": "42", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 69, "nettScore": 36, "races": [{"score": 2.0}, {"score": 2.0}, {"score": 3.0}, {"score": 2.0}, {"score": 1.0}, {"score": 1.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 18.0, "isDiscarded": true, "code": "OCS"}, {"score": 3.0}, {"score": 4.0, "isDiscarded": true}, {"score": 2.0}, {"score": 3.0}, {"score": 3.0}, {"score": 2.0}, {"score": 7.0, "isDiscarded": true}, {"score": 3.0}, {"score": 4.0, "isDiscarded": true}, {"score": 3.0}], "sourceName": "Ryusai Hatano"}, {"fleet": "Wingfoil", "rank": 3, "name": "Guillaume Pichoir", "sailNumber": "16", "gender": "M", "club": "ONE\u00b015 Marina Club", "ageCategory": "Grand Master, Fun Open, Fun Master", "division": "Grand Master, Fun Open, Fun Master", "schoolName": "", "grossScore": 79, "nettScore": 44, "races": [{"score": 6.0}, {"score": 8.0, "isDiscarded": true}, {"score": 2.0}, {"score": 9.0, "isDiscarded": true}, {"score": 11.0, "isDiscarded": true}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 1.0}, {"score": 2.0}, {"score": 2.0}, {"score": 6.0}, {"score": 2.0}, {"score": 2.0}, {"score": 7.0, "isDiscarded": true}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}], "sourceName": "Guillaume Pichoir"}, {"fleet": "Wingfoil", "rank": 4, "name": "Ker Wan Chew", "sailNumber": "15", "gender": "M", "club": "PAssion Wave (East Coast)", "ageCategory": "Grand Master", "division": "Grand Master", "schoolName": "", "grossScore": 112, "nettScore": 58, "races": [{"score": 4.0}, {"score": 3.0}, {"score": 11.0, "isDiscarded": true}, {"score": 3.0}, {"score": 2.0}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 4.0}, {"score": 6.0}, {"score": 5.0}, {"score": 18.0, "isDiscarded": true, "code": "OCS"}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 7.0, "isDiscarded": true}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 3.0}, {"score": 4.0}], "sourceName": "Chew Ker Wan"}, {"fleet": "Wingfoil", "rank": 5, "name": "Felix Knick", "sailNumber": "50", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Master", "division": "Master", "schoolName": "", "grossScore": 110, "nettScore": 69, "races": [{"score": 3.0}, {"score": 5.0, "isDiscarded": true}, {"score": 4.0}, {"score": 10.0, "isDiscarded": true}, {"score": 4.0}, {"score": 8.0, "isDiscarded": true}, {"score": 5.0}, {"score": 4.0}, {"score": 3.0}, {"score": 18.0, "isDiscarded": true, "code": "OCS"}, {"score": 5.0}, {"score": 5.0}, {"score": 4.0}, {"score": 5.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}], "sourceName": "Felix Knick"}, {"fleet": "Wingfoil", "rank": 6, "name": "Sven Welak", "sailNumber": "25", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 131, "nettScore": 87, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 4.0}, {"score": 6.0}, {"score": 6.0}, {"score": 5.0}, {"score": 4.0}, {"score": 8.0, "isDiscarded": true}, {"score": 5.0}, {"score": 7.0}, {"score": 2.0}, {"score": 8.0, "isDiscarded": true}, {"score": 10.0, "isDiscarded": true}, {"score": 5.0}, {"score": 6.0}, {"score": 5.0}, {"score": 6.0}, {"score": 6.0}, {"score": 7.0}, {"score": 6.0}, {"score": 7.0}], "sourceName": "Sven Welack"}, {"fleet": "Wingfoil", "rank": 7, "name": "Arthur Phan", "sailNumber": "29", "gender": "M", "club": "Kitesurfing Association of Singapore", "ageCategory": "Grand Master", "division": "Grand Master", "schoolName": "", "grossScore": 159, "nettScore": 105, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 6.0}, {"score": 18.0, "isDiscarded": true, "code": "OCS"}, {"score": 7.0}, {"score": 7.0}, {"score": 6.0}, {"score": 7.0}, {"score": 7.0}, {"score": 6.0}, {"score": 3.0}, {"score": 9.0, "isDiscarded": true}, {"score": 7.0}, {"score": 7.0}, {"score": 8.0}, {"score": 6.0}, {"score": 9.0, "isDiscarded": true}, {"score": 9.0}, {"score": 6.0}, {"score": 7.0}, {"score": 6.0}], "sourceName": "Arther Phan"}, {"fleet": "Wingfoil", "rank": 8, "name": "Malo Pichoir", "sailNumber": "6", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "U16, U19, Fun Open", "division": "U16, U19, Fun Open", "schoolName": "", "grossScore": 207, "nettScore": 135, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 10.0}, {"score": 8.0}, {"score": 8.0}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 9.0}, {"score": 8.0}, {"score": 9.0}, {"score": 18.0, "isDiscarded": true, "code": "OCS"}, {"score": 10.0}, {"score": 9.0}, {"score": 9.0}, {"score": 7.0}, {"score": 8.0}, {"score": 8.0}, {"score": 8.0}, {"score": 8.0}, {"score": 8.0}, {"score": 8.0}], "sourceName": "Malo Pichoir"}, {"fleet": "Wingfoil", "rank": 9, "name": "Xavier Lau", "sailNumber": "38", "gender": "M", "club": "", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 238, "nettScore": 166, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 9.0}, {"score": 4.0}, {"score": 3.0}, {"score": 5.0}, {"score": 6.0}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 7.0}, {"score": 6.0}, {"score": 8.0}, {"score": 18.0, "code": "RET"}, {"score": 18.0, "code": "RET"}, {"score": 5.0}, {"score": 5.0}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Xavier Lau"}, {"fleet": "Wingfoil", "rank": 10, "name": "Mikhail McEntyre", "sailNumber": "22", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "U16, U19", "division": "U16, U19", "schoolName": "", "grossScore": 261, "nettScore": 189, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 13.0}, {"score": 11.0}, {"score": 9.0}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 11.0}, {"score": 11.0}, {"score": 11.0}, {"score": 9.0}, {"score": 9.0}, {"score": 10.0}, {"score": 11.0}, {"score": 10.0}, {"score": 10.0}, {"score": 10.0}], "sourceName": "Mikhail McEntyre"}, {"fleet": "Wingfoil", "rank": 11, "name": "Greg McEntyre", "sailNumber": "43", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 279, "nettScore": 207, "races": [{"score": 5.0}, {"score": 9.0}, {"score": 8.0}, {"score": 12.0}, {"score": 10.0}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 10.0}, {"score": 9.0}, {"score": 9.0}, {"score": 9.0}], "sourceName": "Greg McEntyre"}, {"fleet": "Wingfoil", "rank": 12, "name": "Bill Hickling", "sailNumber": "45", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Grand Master", "division": "Grand Master", "schoolName": "", "grossScore": 325, "nettScore": 253, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 7.0}, {"score": 7.0}, {"score": 5.0}, {"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Bill Hickling"}, {"fleet": "Wingfoil", "rank": 13, "name": "Ryan Lo", "sailNumber": "17", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 328, "nettScore": 256, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 5.0}, {"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 9.0}, {"score": 8.0}, {"score": 18.0, "code": "OCS"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Ryan Lo"}, {"fleet": "Wingfoil", "rank": 14, "name": "Andrew Lees", "sailNumber": "24", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Master", "division": "Master", "schoolName": "", "grossScore": 330, "nettScore": 258, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 6.0}, {"score": 8.0}, {"score": 10.0}, {"score": 18.0, "code": "RET"}, {"score": 18.0, "code": "RET"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Andrew Lees"}, {"fleet": "Wingfoil", "rank": 15, "name": "Mason Qifeng Lau", "sailNumber": "8", "gender": "M", "club": "", "ageCategory": "U16, U19", "division": "U16, U19", "schoolName": "", "grossScore": 332, "nettScore": 260, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 18.0, "isDiscarded": true, "code": "DNF"}, {"score": 12.0}, {"score": 13.0}, {"score": 12.0}, {"score": 7.0}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNF"}, {"score": 18.0, "code": "DNS"}, {"score": 18.0, "code": "DNS"}, {"score": 18.0, "code": "RET"}, {"score": 18.0, "code": "RET"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Mason Lau"}, {"fleet": "Wingfoil", "rank": 16, "name": "James Feathers", "sailNumber": "19", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Master", "division": "Master", "schoolName": "", "grossScore": 360, "nettScore": 288, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "James Feathers"}, {"fleet": "Wingfoil", "rank": 16, "name": "Jun Hao Lo", "sailNumber": "21", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 360, "nettScore": 288, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Lo Jun Hao"}], "docs": {"Windfoil": "129774", "Techno 293": "129774", "Wingfoil": "129774"}}, {"key": "combined", "slug": "ne-monsoon-grand-prix-2025-combined", "name": "2025 Northeast Monsoon Grand Prix Combined Series", "start": "2025-01-25", "end": "2025-02-09", "dates": "25 January \u2013 9 February 2025", "source": "", "summary": "Published combined standings for Series 1, Series 2 and Series 3 GPS Speed Challenge. Provisional March 7, 2025. Combined Windfoil PDF incorrectly headed Series 1; 41 race columns represent the combined series. Jackson Ho Wingfoil totals do not agree with displayed race sums; preserved as published.", "rows": [{"fleet": "Techno 293", "rank": 1, "name": "Axl Tan", "sailNumber": "SGP 82", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 110, "nettScore": 74, "races": [{"score": 2.0}, {"score": 2.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 3.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}], "sourceName": "Axl Tan"}, {"fleet": "Techno 293", "rank": 2, "name": "Jonathan Chan", "sailNumber": "1", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 126, "nettScore": 90, "races": [{"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "RET"}, {"score": 4.0}, {"score": 2.0}, {"score": 6.0, "isDiscarded": true, "code": "OCS"}, {"score": 3.0}, {"score": 2.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}], "sourceName": "Jonathan Chan"}, {"fleet": "Techno 293", "rank": 3, "name": "Muhammad Razin", "sailNumber": "3", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 140, "nettScore": 104, "races": [{"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 3.0}, {"score": 2.0}, {"score": 4.0}, {"score": 2.0}, {"score": 2.0}, {"score": 4.0}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}], "sourceName": "Muhammad Razin"}, {"fleet": "Techno 293", "rank": 4, "name": "Reynold Chan", "sailNumber": "52", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 169, "nettScore": 133, "races": [{"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}], "sourceName": "Reynold Chan"}, {"fleet": "Techno 293", "rank": 5, "name": "Jun Ler Chuah", "sailNumber": "16", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 179, "nettScore": 143, "races": [{"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}], "sourceName": "Jun Ler Chuah"}, {"fleet": "Wingfoil", "rank": 1, "name": "Jackson Ho", "sailNumber": "11", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 66.5, "nettScore": 37.0, "races": [{"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 6.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 20.0, "isDiscarded": true, "code": "OCS"}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0, "isDiscarded": true}, {"score": 1.0, "isDiscarded": true}, {"score": 1.0, "isDiscarded": true}, {"score": 1.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}], "sourceNotes": "Published gross 66.5 and net 37 differ from displayed race sums 62 and 30. Preserved as published; no correction inferred.", "sourceName": "Jackson Ho"}, {"fleet": "Wingfoil", "rank": 2, "name": "Ker Wan Chew", "sailNumber": "15", "gender": "M", "club": "PAssion Wave (East Coast)", "ageCategory": "Master", "division": "Master", "schoolName": "", "grossScore": 196.0, "nettScore": 92.0, "races": [{"score": 2.0}, {"score": 2.0}, {"score": 3.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 20.0, "isDiscarded": true, "code": "DNF"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 4.0}, {"score": 3.0}, {"score": 11.0, "isDiscarded": true}, {"score": 3.0}, {"score": 2.0}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 4.0}, {"score": 6.0, "isDiscarded": true}, {"score": 5.0}, {"score": 20.0, "isDiscarded": true, "code": "OCS"}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 7.0, "isDiscarded": true}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 3.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}], "sourceName": "Chew Ker Wan"}, {"fleet": "Wingfoil", "rank": 3, "name": "Guillaume Pichoir", "sailNumber": "16", "gender": "M", "club": "ONE\u00b015 Marina Club", "ageCategory": "Grand Master", "division": "Grand Master", "schoolName": "", "grossScore": 248.0, "nettScore": 108.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0}, {"score": 6.0}, {"score": 8.0}, {"score": 2.0}, {"score": 9.0}, {"score": 11.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 1.0}, {"score": 2.0}, {"score": 2.0}, {"score": 6.0}, {"score": 2.0}, {"score": 2.0}, {"score": 7.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}], "sourceName": "Guillaume Pichoir"}, {"fleet": "Wingfoil", "rank": 4, "name": "Sven Welak", "sailNumber": "25", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 329.0, "nettScore": 189.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNF"}, {"score": 4.0}, {"score": 6.0}, {"score": 6.0}, {"score": 5.0}, {"score": 4.0}, {"score": 8.0}, {"score": 5.0}, {"score": 7.0}, {"score": 2.0}, {"score": 8.0}, {"score": 10.0}, {"score": 5.0}, {"score": 6.0}, {"score": 5.0}, {"score": 6.0}, {"score": 6.0}, {"score": 7.0}, {"score": 6.0}, {"score": 7.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}], "sourceName": "Sven Welack"}, {"fleet": "Wingfoil", "rank": 5, "name": "Felix Knick", "sailNumber": "50", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Master", "division": "Master", "schoolName": "", "grossScore": 331.0, "nettScore": 191.0, "races": [{"score": 3.0}, {"score": 3.0}, {"score": 2.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 20.0, "isDiscarded": true, "code": "RET"}, {"score": 2.0}, {"score": 3.0}, {"score": 5.0}, {"score": 4.0}, {"score": 10.0}, {"score": 4.0}, {"score": 8.0}, {"score": 5.0}, {"score": 4.0}, {"score": 3.0}, {"score": 20.0, "isDiscarded": true, "code": "OCS"}, {"score": 5.0}, {"score": 5.0}, {"score": 4.0}, {"score": 5.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Felix Knick"}, {"fleet": "Wingfoil", "rank": 6, "name": "Ryusai Hatano", "sailNumber": "42", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Fun", "division": "Fun", "schoolName": "", "grossScore": 411.0, "nettScore": 271.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 2.0}, {"score": 2.0}, {"score": 3.0}, {"score": 2.0}, {"score": 1.0}, {"score": 1.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 20.0, "code": "OCS"}, {"score": 3.0}, {"score": 4.0}, {"score": 2.0}, {"score": 3.0}, {"score": 3.0}, {"score": 2.0}, {"score": 7.0}, {"score": 3.0}, {"score": 4.0}, {"score": 3.0}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Ryusai Hatano"}, {"fleet": "Wingfoil", "rank": 7, "name": "Arthur Phan", "sailNumber": "29", "gender": "M", "club": "Kitesurfing Association of Singapore", "ageCategory": "Grand Master", "division": "Grand Master", "schoolName": "", "grossScore": 503.0, "nettScore": 363.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNF"}, {"score": 6.0}, {"score": 20.0, "code": "OCS"}, {"score": 7.0}, {"score": 7.0}, {"score": 6.0}, {"score": 7.0}, {"score": 7.0}, {"score": 6.0}, {"score": 3.0}, {"score": 9.0}, {"score": 7.0}, {"score": 7.0}, {"score": 8.0}, {"score": 6.0}, {"score": 9.0}, {"score": 9.0}, {"score": 6.0}, {"score": 7.0}, {"score": 6.0}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Arther Phan"}, {"fleet": "Wingfoil", "rank": 8, "name": "Malo Pichoir", "sailNumber": "6", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "u16,u19, Fun Open", "division": "u16,u19, Fun Open", "schoolName": "", "grossScore": 555.0, "nettScore": 415.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNF"}, {"score": 20.0, "code": "DNF"}, {"score": 10.0}, {"score": 8.0}, {"score": 8.0}, {"score": 20.0, "code": "DNC"}, {"score": 9.0}, {"score": 8.0}, {"score": 9.0}, {"score": 20.0, "code": "OCS"}, {"score": 10.0}, {"score": 9.0}, {"score": 9.0}, {"score": 7.0}, {"score": 8.0}, {"score": 8.0}, {"score": 8.0}, {"score": 8.0}, {"score": 8.0}, {"score": 8.0}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Malo Pichoir"}, {"fleet": "Wingfoil", "rank": 9, "name": "Xavier Lau", "sailNumber": "38", "gender": "M", "club": "", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 598.0, "nettScore": 458.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNF"}, {"score": 20.0, "code": "DNF"}, {"score": 9.0}, {"score": 4.0}, {"score": 3.0}, {"score": 5.0}, {"score": 6.0}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 7.0}, {"score": 6.0}, {"score": 8.0}, {"score": 20.0, "code": "RET"}, {"score": 20.0, "code": "RET"}, {"score": 5.0}, {"score": 5.0}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Xavier Lau"}, {"fleet": "Wingfoil", "rank": 10, "name": "Mikhail McEntyre", "sailNumber": "22", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "u16, u19", "division": "u16, u19", "schoolName": "", "grossScore": 615.0, "nettScore": 475.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNF"}, {"score": 20.0, "code": "DNF"}, {"score": 13.0}, {"score": 11.0}, {"score": 9.0}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 11.0}, {"score": 11.0}, {"score": 11.0}, {"score": 9.0}, {"score": 9.0}, {"score": 10.0}, {"score": 11.0}, {"score": 10.0}, {"score": 10.0}, {"score": 10.0}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Mikhail McEntyre"}, {"fleet": "Wingfoil", "rank": 11, "name": "Greg McEntyre", "sailNumber": "43", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Fun Master", "division": "Fun Master", "schoolName": "", "grossScore": 641.0, "nettScore": 501.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 5.0}, {"score": 9.0}, {"score": 8.0}, {"score": 12.0}, {"score": 10.0}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 10.0}, {"score": 9.0}, {"score": 9.0}, {"score": 9.0}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Greg McEntyre"}, {"fleet": "Wingfoil", "rank": 12, "name": "Bill Hickling", "sailNumber": "45", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Grand Master", "division": "Grand Master", "schoolName": "", "grossScore": 699.0, "nettScore": 559.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNF"}, {"score": 7.0}, {"score": 7.0}, {"score": 5.0}, {"score": 20.0, "code": "DNF"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Bill Hickling"}, {"fleet": "Wingfoil", "rank": 13, "name": "Ryan Lo", "sailNumber": "17", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 702.0, "nettScore": 562.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNF"}, {"score": 20.0, "code": "DNF"}, {"score": 5.0}, {"score": 20.0, "code": "DNF"}, {"score": 20.0, "code": "DNF"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 9.0}, {"score": 8.0}, {"score": 20.0, "code": "OCS"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Ryan Lo"}, {"fleet": "Wingfoil", "rank": 14, "name": "Andrew Lees", "sailNumber": "24", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Master", "division": "Master", "schoolName": "", "grossScore": 704.0, "nettScore": 564.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 6.0}, {"score": 8.0}, {"score": 10.0}, {"score": 20.0, "code": "RET"}, {"score": 20.0, "code": "RET"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Andrew Lees"}, {"fleet": "Wingfoil", "rank": 15, "name": "Mason Qifeng Lau", "sailNumber": "8", "gender": "M", "club": "", "ageCategory": "u16, u19", "division": "u16, u19", "schoolName": "", "grossScore": 704.0, "nettScore": 564.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNF"}, {"score": 20.0, "code": "DNF"}, {"score": 12.0}, {"score": 13.0}, {"score": 12.0}, {"score": 7.0}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNF"}, {"score": 20.0, "code": "DNS"}, {"score": 20.0, "code": "DNS"}, {"score": 20.0, "code": "RET"}, {"score": 20.0, "code": "RET"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Mason Lau"}, {"fleet": "Wingfoil", "rank": 16, "name": "Sven Welak", "sailNumber": "25", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Fun", "division": "Fun", "schoolName": "", "grossScore": 740.0, "nettScore": 600.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Sven Welack"}, {"fleet": "Wingfoil", "rank": 16, "name": "Jun Hao Lo", "sailNumber": "21", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Fun", "division": "Fun", "schoolName": "", "grossScore": 740.0, "nettScore": 600.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Lo Jun Hao"}, {"fleet": "Wingfoil", "rank": 16, "name": "Jun Hao Lo", "sailNumber": "21", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Master", "division": "Master", "schoolName": "", "grossScore": 740.0, "nettScore": 600.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "Lo Jun Hao"}, {"fleet": "Wingfoil", "rank": 16, "name": "James Feathers", "sailNumber": "19", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Master", "division": "Master", "schoolName": "", "grossScore": 740.0, "nettScore": 600.0, "races": [{"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "isDiscarded": true, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}, {"score": 20.0, "code": "DNC"}], "sourceName": "James Feathers"}, {"fleet": "Windfoil", "rank": 1, "name": "Angel Chew", "sailNumber": "SGP 42", "gender": "F", "club": "Changi Sailing Club", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 53, "nettScore": 38, "races": [{"score": 2.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 2.0}, {"score": 1.0}, {"score": 1.0}, {"score": 2.0}, {"score": 1.0}, {"score": 1.0}, {"score": 2}, {"score": 1}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 3.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 2.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}], "sourceName": "Angel Chew"}, {"fleet": "Windfoil", "rank": 2, "name": "Angyal Chew", "sailNumber": "SGP", "gender": "F", "club": "Changi Sailing Club", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 92, "nettScore": 67, "races": [{"score": 3.0, "isDiscarded": true}, {"score": 3.0, "isDiscarded": true}, {"score": 3.0, "isDiscarded": true}, {"score": 3.0, "isDiscarded": true}, {"score": 3.0, "isDiscarded": true}, {"score": 3.0, "isDiscarded": true}, {"score": 3.0}, {"score": 7.0, "isDiscarded": true, "code": "OCS"}, {"score": 2.0}, {"score": 3.0}, {"score": 2.0}, {"score": 2.0}, {"score": 1.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 1.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 1.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}], "sourceName": "Angyal Chew"}, {"fleet": "Windfoil", "rank": 3, "name": "Jonas Haris Knick", "sailNumber": "SGP 39", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 178, "nettScore": 129, "races": [{"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 4.0}, {"score": 3.0}, {"score": 2.0}, {"score": 3.0}, {"score": 3.0}, {"score": 5.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 4.0}, {"score": 3.0}, {"score": 4.0}, {"score": 4.0}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}], "sourceName": "Jonas Knick"}, {"fleet": "Windfoil", "rank": 4, "name": "Lukas Knick", "sailNumber": "SGP 31", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 195, "nettScore": 146, "races": [{"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5.0}, {"score": 5}, {"score": 6}, {"score": 4.0}, {"score": 7.0, "code": "DNF", "isDiscarded": true}, {"score": 6.0}, {"score": 4.0}, {"score": 5.0}, {"score": 4.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 5.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 4.0}, {"score": 3.0}, {"score": 3.0}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}], "sourceName": "Lukas Knick"}, {"fleet": "Windfoil", "rank": 5, "name": "Trevor Ng", "sailNumber": "SGP 21", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 225, "nettScore": 176, "races": [{"score": 6}, {"score": 6}, {"score": 6}, {"score": 6}, {"score": 6}, {"score": 6}, {"score": 5}, {"score": 5}, {"score": 4}, {"score": 5}, {"score": 5}, {"score": 4}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 4}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 4}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 5}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}], "sourceName": "Trevor Ng"}, {"fleet": "Windfoil", "rank": 6, "name": "John Tze Xiang Wong", "sailNumber": "SGP 2", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 234, "nettScore": 185, "races": [{"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 2.0}, {"score": 7.0, "isDiscarded": true, "code": "OCS"}, {"score": 1.0}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}], "sourceName": "John Tze Xiang Wong"}], "docs": {"Windfoil": "132093", "Techno 293": "132085", "Wingfoil": "132087"}}, {"key": "gps", "slug": "ne-monsoon-grand-prix-2025-gps-speed-challenge", "name": "2025 Northeast Monsoon Grand Prix Series 3 GPS Speed Challenge", "start": "2025-01-25", "end": "2025-02-08", "dates": "25 January \u2013 8 February 2025", "source": "132072", "summary": "GPS Speed Challenge within Singapore waters. Final results as of 12:52 on 7 March 2025. Finishes counted as nine notional races per NoR; these are ranking scores, not measured speeds.", "rows": [{"fleet": "Windfoil", "rank": 1, "name": "Angel Chew", "sailNumber": "SGP 42", "gender": "F", "club": "Changi Sailing Club", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 9, "nettScore": 7, "races": [{"score": 1.0, "isDiscarded": true}, {"score": 1.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}], "sourceName": "Angel Chew"}, {"fleet": "Windfoil", "rank": 2, "name": "Angyal Chew", "sailNumber": "SGP", "gender": "F", "club": "Changi Sailing Club", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 18, "nettScore": 14, "races": [{"score": 2.0, "isDiscarded": true}, {"score": 2.0, "isDiscarded": true}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}, {"score": 2.0}], "sourceName": "Angyal Chew"}, {"fleet": "Windfoil", "rank": 3, "name": "Jonas Haris Knick", "sailNumber": "SGP 39", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 63, "nettScore": 49, "races": [{"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}], "sourceName": "Jonas Knick"}, {"fleet": "Windfoil", "rank": 3, "name": "Lukas Knick", "sailNumber": "SGP 31", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 63, "nettScore": 49, "races": [{"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}], "sourceName": "Lukas Knick"}, {"fleet": "Windfoil", "rank": 3, "name": "Trevor Ng", "sailNumber": "SGP 21", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 63, "nettScore": 49, "races": [{"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}], "sourceName": "Trevor Ng"}, {"fleet": "Windfoil", "rank": 3, "name": "John Tze Xiang Wong", "sailNumber": "SGP 2", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "U19", "division": "U19", "schoolName": "", "grossScore": 63, "nettScore": 49, "races": [{"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "isDiscarded": true, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}, {"score": 7.0, "code": "DNC"}], "sourceName": "John Tze Xiang Wong"}, {"fleet": "Techno 293", "rank": 2, "name": "Jun Ler Chuah", "sailNumber": "16", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 54, "nettScore": 42, "races": [{"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}], "sourceName": "Jun Ler Chuah"}, {"fleet": "Techno 293", "rank": 2, "name": "Axl Tan", "sailNumber": "SGP 82", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 54, "nettScore": 42, "races": [{"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}], "sourceName": "Axl Tan"}, {"fleet": "Techno 293", "rank": 1, "name": "Muhammad Razin", "sailNumber": "3", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 9, "nettScore": 7, "races": [{"score": 1.0, "isDiscarded": true}, {"score": 1.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}], "sourceName": "Muhammad Razin"}, {"fleet": "Techno 293", "rank": 2, "name": "Reynold Chan", "sailNumber": "52", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 54, "nettScore": 42, "races": [{"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}], "sourceName": "Reynold Chan"}, {"fleet": "Techno 293", "rank": 2, "name": "Jonathan Chan", "sailNumber": "1", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 54, "nettScore": 42, "races": [{"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "isDiscarded": true, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}, {"score": 6.0, "code": "DNC"}], "sourceName": "Jonathan Chan"}, {"fleet": "Wingfoil", "rank": 1, "name": "Jackson Ho", "sailNumber": "11", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 9, "nettScore": 7, "races": [{"score": 1.0, "isDiscarded": true}, {"score": 1.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}], "sourceName": "Jackson Ho"}, {"fleet": "Wingfoil", "rank": 5, "name": "Ryusai Hatano", "sailNumber": "42", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Ryusai Hatano"}, {"fleet": "Wingfoil", "rank": 1, "name": "Guillaume Pichoir", "sailNumber": "16", "gender": "M", "club": "ONE\u00b015 Marina Club", "ageCategory": "Grand Master, Fun Open, Fun Master", "division": "Grand Master, Fun Open, Fun Master", "schoolName": "", "grossScore": 9, "nettScore": 7, "races": [{"score": 1.0, "isDiscarded": true}, {"score": 1.0, "isDiscarded": true}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}, {"score": 1.0}], "sourceName": "Guillaume Pichoir"}, {"fleet": "Wingfoil", "rank": 3, "name": "Ker Wan Chew", "sailNumber": "15", "gender": "M", "club": "PAssion Wave (East Coast)", "ageCategory": "Grand Master", "division": "Grand Master", "schoolName": "", "grossScore": 27, "nettScore": 21, "races": [{"score": 3.0, "isDiscarded": true}, {"score": 3.0, "isDiscarded": true}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}, {"score": 3.0}], "sourceName": "Chew Ker Wan"}, {"fleet": "Wingfoil", "rank": 5, "name": "Felix Knick", "sailNumber": "50", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Master", "division": "Master", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Felix Knick"}, {"fleet": "Wingfoil", "rank": 4, "name": "Sven Welak", "sailNumber": "25", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 36, "nettScore": 28, "races": [{"score": 4.0, "isDiscarded": true}, {"score": 4.0, "isDiscarded": true}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}, {"score": 4.0}], "sourceName": "Sven Welack"}, {"fleet": "Wingfoil", "rank": 5, "name": "Arthur Phan", "sailNumber": "29", "gender": "M", "club": "Kitesurfing Association of Singapore", "ageCategory": "Grand Master", "division": "Grand Master", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Arther Phan"}, {"fleet": "Wingfoil", "rank": 5, "name": "Malo Pichoir", "sailNumber": "6", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "U16, U19, Fun Open", "division": "U16, U19, Fun Open", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Malo Pichoir"}, {"fleet": "Wingfoil", "rank": 5, "name": "Xavier Lau", "sailNumber": "38", "gender": "M", "club": "", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Xavier Lau"}, {"fleet": "Wingfoil", "rank": 5, "name": "Mikhail McEntyre", "sailNumber": "22", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "U16, U19", "division": "U16, U19", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Mikhail McEntyre"}, {"fleet": "Wingfoil", "rank": 5, "name": "Greg McEntyre", "sailNumber": "43", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Greg McEntyre"}, {"fleet": "Wingfoil", "rank": 5, "name": "Bill Hickling", "sailNumber": "45", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Grand Master", "division": "Grand Master", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Bill Hickling"}, {"fleet": "Wingfoil", "rank": 5, "name": "Ryan Lo", "sailNumber": "17", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Ryan Lo"}, {"fleet": "Wingfoil", "rank": 5, "name": "Andrew Lees", "sailNumber": "24", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Master", "division": "Master", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Andrew Lees"}, {"fleet": "Wingfoil", "rank": 5, "name": "Mason Qifeng Lau", "sailNumber": "8", "gender": "M", "club": "", "ageCategory": "U16, U19", "division": "U16, U19", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Mason Lau"}, {"fleet": "Wingfoil", "rank": 5, "name": "James Feathers", "sailNumber": "19", "gender": "M", "club": "Constant Wind SeaSports", "ageCategory": "Master", "division": "Master", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "James Feathers"}, {"fleet": "Wingfoil", "rank": 5, "name": "Jun Hao Lo", "sailNumber": "21", "gender": "M", "club": "Aloha Sea Sports Centre", "ageCategory": "Open", "division": "", "schoolName": "", "grossScore": 162, "nettScore": 126, "races": [{"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "isDiscarded": true, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}, {"score": 18.0, "code": "DNC"}], "sourceName": "Lo Jun Hao"}], "docs": {"Windfoil": "132072", "Techno 293": "132072", "Wingfoil": "132072"}}]$events$::jsonb) LOOP
 INSERT INTO public.regatta_events(name,slug,start_date,end_date,venue,organizer,classes,nor_url,counts_for_ranking,is_selection_trial,schedule_summary,scoring_rules)
 VALUES(event_json->>'name',event_json->>'slug',(event_json->>'start')::date,(event_json->>'end')::date,
 CASE WHEN event_json->>'key'='gps' THEN 'Singapore waters' ELSE 'Changi Beach Park CP 1 / Tanah Merah, Singapore' END,
 'Singapore Sailing Federation','["Windfoil","Wingfoil","Techno 293"]'::jsonb,'https://www.racingrulesofsailing.org/documents/128729',false,false,event_json->>'summary',
 'WCR B8 low points; at least 3 races per round, 6 for combined series. Published penalties, discards and totals retained. GPS result counts as nine races. NoR section 15: division champions awarded on combined standings.')
 ON CONFLICT(slug) DO UPDATE SET schedule_summary=excluded.schedule_summary,scoring_rules=excluded.scoring_rules,updated_at=now()
 RETURNING id INTO event_uuid;
 FOR fleet IN SELECT DISTINCT value->>'fleet' FROM jsonb_array_elements(event_json->'rows') LOOP
 sheet_slug=(event_json->>'slug')||'-'||replace(lower(fleet),' ','-');
 INSERT INTO public.regattas(name,slug,event_id,date,end_date,total_fleet_size,division,boat_class,race_count,geography,counts_for_ranking,organizer,nor_url,schedule_notes,status)
 SELECT (event_json->>'name')||' — '||fleet,sheet_slug,event_uuid,(event_json->>'start')::date,(event_json->>'end')::date,
 count(*),'Open',fleet,max(jsonb_array_length(value->'races')),'SGP',false,'Singapore Sailing Federation','https://www.racingrulesofsailing.org/documents/128729',event_json->>'summary','published'
 FROM jsonb_array_elements(event_json->'rows') WHERE value->>'fleet'=fleet
 ON CONFLICT(slug) DO UPDATE SET event_id=excluded.event_id,status='published',schedule_notes=excluded.schedule_notes,updated_at=now()
 RETURNING id INTO sheet_uuid;
 FOR entry IN SELECT DISTINCT ON (value->>'name') value FROM jsonb_array_elements(event_json->'rows') WHERE value->>'fleet'=fleet ORDER BY value->>'name',(value->>'rank')::int LOOP
 canonical=entry->>'name'; sailor_uuid=null;
 SELECT count(*), min(id::text)::uuid INTO matches,sailor_uuid FROM public.sailors WHERE lower(trim(name))=lower(trim(canonical));
 IF matches>1 THEN RAISE EXCEPTION 'Ambiguous sailor identity: %',canonical; END IF;
 IF sailor_uuid IS NULL THEN
 SELECT count(DISTINCT sailor_id),min(sailor_id::text)::uuid INTO matches,sailor_uuid FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN(lower(canonical),lower(entry->>'sourceName'));
 IF matches>1 THEN RAISE EXCEPTION 'Ambiguous alias: %',canonical; END IF;
 END IF;
 IF sailor_uuid IS NULL THEN
 INSERT INTO public.sailors(name,handle,sail_number,gender,club) VALUES(canonical,regexp_replace(lower(canonical),'[^a-z0-9]+','-','g')||'-'||substr(md5(canonical),1,6),entry->>'sailNumber',entry->>'gender',coalesce(entry->>'club','')) RETURNING id INTO sailor_uuid;
 END IF;
 INSERT INTO public.regatta_results(sailor_id,regatta_id,rank,total_score,nett_score,gender,official_url,evidence_type,evidence_name,evidence_notes,verification_status,verified_at)
 VALUES(sailor_uuid,sheet_uuid,(entry->>'rank')::int,(entry->>'grossScore')::real,(entry->>'nettScore')::real,entry->>'gender',
 'https://www.racingrulesofsailing.org/documents/'||(event_json->'docs'->>fleet),'link','Official published results',
 concat('Published name: ',entry->>'sourceName','; Division: ',entry->>'division','; ',entry->>'sourceNotes'),'verified',now())
 ON CONFLICT(sailor_id,regatta_id) DO UPDATE SET rank=excluded.rank,total_score=excluded.total_score,nett_score=excluded.nett_score,evidence_notes=excluded.evidence_notes,updated_at=now()
 RETURNING id INTO result_uuid;
 race_no=0;
 FOR race IN SELECT value FROM jsonb_array_elements(entry->'races') LOOP
 race_no=race_no+1;
 INSERT INTO public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value)
 VALUES(result_uuid,race_no,(race->>'score')::real,race->>'code',coalesce((race->>'isDiscarded')::boolean,false),CASE WHEN coalesce((race->>'isDiscarded')::boolean,false) THEN '(' ELSE '' END || (race->>'score') || CASE WHEN race->>'code' IS NOT NULL THEN ' '||(race->>'code') ELSE '' END || CASE WHEN coalesce((race->>'isDiscarded')::boolean,false) THEN ')' ELSE '' END)
 ON CONFLICT(regatta_result_id,race_number) DO UPDATE SET score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();
 END LOOP;
 END LOOP;
 END LOOP;
 END LOOP;
 FOR board IN SELECT value FROM jsonb_array_elements($boards$[
  {
    "table": "wingfoil",
    "id": "ne-monsoon-grand-prix-2025-series-2-wingfoil",
    "name": "2025 Northeast Monsoon Grand Prix Series 2",
    "shortName": "NE GP2 2025",
    "dates": "8\u20139 February 2025",
    "venue": "Changi Beach Park CP 1 / Tanah Merah, Singapore",
    "organizer": "Singapore Sailing Federation",
    "format": "Slalom / Course / Marathon",
    "status": "Completed",
    "lifecycleStatus": "published",
    "scoringSystem": "WCR B8 / Appendix A low points; published discards retained",
    "rulesNotes": "Series 2 at Changi Beach Park CP 1 / Tanah Merah. Results provisional as of 21:14 on 10 February 2025. NoR: 1\u20134 races: 0 discards; 5\u20138: 1; 9\u201312: 2; 13\u201316: 3; 17\u201320: 4; 21\u201325: 5; 26\u201330: 6; 31\u201338: 7; 39\u201346: 8; 47\u201354: 9. Source-specific discard counts retained.",
    "websiteUrl": "https://www.sailing.org.sg/events/263406",
    "noticeBoardUrl": "https://www.racingrulesofsailing.org/documents/10645/event",
    "results": [
      {
        "rank": 1,
        "name": "Jackson Ho",
        "sailNumber": "11",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 43,
        "nettScore": 16,
        "races": [
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 6.0,
            "isDiscarded": true
          },
          {
            "score": 2.0,
            "isDiscarded": true
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "OCS"
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          }
        ],
        "sourceName": "Jackson Ho"
      },
      {
        "rank": 2,
        "name": "Ryusai Hatano",
        "sailNumber": "42",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 69,
        "nettScore": 36,
        "races": [
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 3.0
          },
          {
            "score": 2.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "OCS"
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0,
            "isDiscarded": true
          },
          {
            "score": 2.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 2.0
          },
          {
            "score": 7.0,
            "isDiscarded": true
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0,
            "isDiscarded": true
          },
          {
            "score": 3.0
          }
        ],
        "sourceName": "Ryusai Hatano"
      },
      {
        "rank": 3,
        "name": "Guillaume Pichoir",
        "sailNumber": "16",
        "gender": "M",
        "club": "ONE\u00b015 Marina Club",
        "ageCategory": "Grand Master, Fun Open, Fun Master",
        "division": "Grand Master, Fun Open, Fun Master",
        "schoolName": "",
        "grossScore": 79,
        "nettScore": 44,
        "races": [
          {
            "score": 6.0
          },
          {
            "score": 8.0,
            "isDiscarded": true
          },
          {
            "score": 2.0
          },
          {
            "score": 9.0,
            "isDiscarded": true
          },
          {
            "score": 11.0,
            "isDiscarded": true
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0
          },
          {
            "score": 1.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 6.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 7.0,
            "isDiscarded": true
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          }
        ],
        "sourceName": "Guillaume Pichoir"
      },
      {
        "rank": 4,
        "name": "Ker Wan Chew",
        "sailNumber": "15",
        "gender": "M",
        "club": "PAssion Wave (East Coast)",
        "ageCategory": "Grand Master",
        "division": "Grand Master",
        "schoolName": "",
        "grossScore": 112,
        "nettScore": 58,
        "races": [
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 11.0,
            "isDiscarded": true
          },
          {
            "score": 3.0
          },
          {
            "score": 2.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 4.0
          },
          {
            "score": 6.0
          },
          {
            "score": 5.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "OCS"
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0
          },
          {
            "score": 7.0,
            "isDiscarded": true
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0
          }
        ],
        "sourceName": "Chew Ker Wan"
      },
      {
        "rank": 5,
        "name": "Felix Knick",
        "sailNumber": "50",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Master",
        "division": "Master",
        "schoolName": "",
        "grossScore": 110,
        "nettScore": 69,
        "races": [
          {
            "score": 3.0
          },
          {
            "score": 5.0,
            "isDiscarded": true
          },
          {
            "score": 4.0
          },
          {
            "score": 10.0,
            "isDiscarded": true
          },
          {
            "score": 4.0
          },
          {
            "score": 8.0,
            "isDiscarded": true
          },
          {
            "score": 5.0
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "OCS"
          },
          {
            "score": 5.0
          },
          {
            "score": 5.0
          },
          {
            "score": 4.0
          },
          {
            "score": 5.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 5.0
          },
          {
            "score": 5.0
          },
          {
            "score": 5.0
          }
        ],
        "sourceName": "Felix Knick"
      },
      {
        "rank": 6,
        "name": "Sven Welak",
        "sailNumber": "25",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 131,
        "nettScore": 87,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 4.0
          },
          {
            "score": 6.0
          },
          {
            "score": 6.0
          },
          {
            "score": 5.0
          },
          {
            "score": 4.0
          },
          {
            "score": 8.0,
            "isDiscarded": true
          },
          {
            "score": 5.0
          },
          {
            "score": 7.0
          },
          {
            "score": 2.0
          },
          {
            "score": 8.0,
            "isDiscarded": true
          },
          {
            "score": 10.0,
            "isDiscarded": true
          },
          {
            "score": 5.0
          },
          {
            "score": 6.0
          },
          {
            "score": 5.0
          },
          {
            "score": 6.0
          },
          {
            "score": 6.0
          },
          {
            "score": 7.0
          },
          {
            "score": 6.0
          },
          {
            "score": 7.0
          }
        ],
        "sourceName": "Sven Welack"
      },
      {
        "rank": 7,
        "name": "Arthur Phan",
        "sailNumber": "29",
        "gender": "M",
        "club": "Kitesurfing Association of Singapore",
        "ageCategory": "Grand Master",
        "division": "Grand Master",
        "schoolName": "",
        "grossScore": 159,
        "nettScore": 105,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 6.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "OCS"
          },
          {
            "score": 7.0
          },
          {
            "score": 7.0
          },
          {
            "score": 6.0
          },
          {
            "score": 7.0
          },
          {
            "score": 7.0
          },
          {
            "score": 6.0
          },
          {
            "score": 3.0
          },
          {
            "score": 9.0,
            "isDiscarded": true
          },
          {
            "score": 7.0
          },
          {
            "score": 7.0
          },
          {
            "score": 8.0
          },
          {
            "score": 6.0
          },
          {
            "score": 9.0,
            "isDiscarded": true
          },
          {
            "score": 9.0
          },
          {
            "score": 6.0
          },
          {
            "score": 7.0
          },
          {
            "score": 6.0
          }
        ],
        "sourceName": "Arther Phan"
      },
      {
        "rank": 8,
        "name": "Malo Pichoir",
        "sailNumber": "6",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "U16, U19, Fun Open",
        "division": "U16, U19, Fun Open",
        "schoolName": "",
        "grossScore": 207,
        "nettScore": 135,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 10.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 9.0
          },
          {
            "score": 8.0
          },
          {
            "score": 9.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "OCS"
          },
          {
            "score": 10.0
          },
          {
            "score": 9.0
          },
          {
            "score": 9.0
          },
          {
            "score": 7.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          }
        ],
        "sourceName": "Malo Pichoir"
      },
      {
        "rank": 9,
        "name": "Xavier Lau",
        "sailNumber": "38",
        "gender": "M",
        "club": "",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 238,
        "nettScore": 166,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 9.0
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 5.0
          },
          {
            "score": 6.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 7.0
          },
          {
            "score": 6.0
          },
          {
            "score": 8.0
          },
          {
            "score": 18.0,
            "code": "RET"
          },
          {
            "score": 18.0,
            "code": "RET"
          },
          {
            "score": 5.0
          },
          {
            "score": 5.0
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Xavier Lau"
      },
      {
        "rank": 10,
        "name": "Mikhail McEntyre",
        "sailNumber": "22",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "U16, U19",
        "division": "U16, U19",
        "schoolName": "",
        "grossScore": 261,
        "nettScore": 189,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 13.0
          },
          {
            "score": 11.0
          },
          {
            "score": 9.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 11.0
          },
          {
            "score": 11.0
          },
          {
            "score": 11.0
          },
          {
            "score": 9.0
          },
          {
            "score": 9.0
          },
          {
            "score": 10.0
          },
          {
            "score": 11.0
          },
          {
            "score": 10.0
          },
          {
            "score": 10.0
          },
          {
            "score": 10.0
          }
        ],
        "sourceName": "Mikhail McEntyre"
      },
      {
        "rank": 11,
        "name": "Greg McEntyre",
        "sailNumber": "43",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 279,
        "nettScore": 207,
        "races": [
          {
            "score": 5.0
          },
          {
            "score": 9.0
          },
          {
            "score": 8.0
          },
          {
            "score": 12.0
          },
          {
            "score": 10.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 10.0
          },
          {
            "score": 9.0
          },
          {
            "score": 9.0
          },
          {
            "score": 9.0
          }
        ],
        "sourceName": "Greg McEntyre"
      },
      {
        "rank": 12,
        "name": "Bill Hickling",
        "sailNumber": "45",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Grand Master",
        "division": "Grand Master",
        "schoolName": "",
        "grossScore": 325,
        "nettScore": 253,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 7.0
          },
          {
            "score": 7.0
          },
          {
            "score": 5.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Bill Hickling"
      },
      {
        "rank": 13,
        "name": "Ryan Lo",
        "sailNumber": "17",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 328,
        "nettScore": 256,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 5.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 9.0
          },
          {
            "score": 8.0
          },
          {
            "score": 18.0,
            "code": "OCS"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Ryan Lo"
      },
      {
        "rank": 14,
        "name": "Andrew Lees",
        "sailNumber": "24",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Master",
        "division": "Master",
        "schoolName": "",
        "grossScore": 330,
        "nettScore": 258,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 6.0
          },
          {
            "score": 8.0
          },
          {
            "score": 10.0
          },
          {
            "score": 18.0,
            "code": "RET"
          },
          {
            "score": 18.0,
            "code": "RET"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Andrew Lees"
      },
      {
        "rank": 15,
        "name": "Mason Qifeng Lau",
        "sailNumber": "8",
        "gender": "M",
        "club": "",
        "ageCategory": "U16, U19",
        "division": "U16, U19",
        "schoolName": "",
        "grossScore": 332,
        "nettScore": 260,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 12.0
          },
          {
            "score": 13.0
          },
          {
            "score": 12.0
          },
          {
            "score": 7.0
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNF"
          },
          {
            "score": 18.0,
            "code": "DNS"
          },
          {
            "score": 18.0,
            "code": "DNS"
          },
          {
            "score": 18.0,
            "code": "RET"
          },
          {
            "score": 18.0,
            "code": "RET"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Mason Lau"
      },
      {
        "rank": 16,
        "name": "James Feathers",
        "sailNumber": "19",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Master",
        "division": "Master",
        "schoolName": "",
        "grossScore": 360,
        "nettScore": 288,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "James Feathers"
      },
      {
        "rank": 16,
        "name": "Jun Hao Lo",
        "sailNumber": "21",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 360,
        "nettScore": 288,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Lo Jun Hao"
      }
    ]
  },
  {
    "table": "techno293",
    "id": "ne-monsoon-grand-prix-2025-series-2-techno293",
    "name": "2025 Northeast Monsoon Grand Prix Series 2",
    "shortName": "NE GP2 2025",
    "dates": "8\u20139 February 2025",
    "venue": "Changi Beach Park CP 1 / Tanah Merah, Singapore",
    "organizer": "Singapore Sailing Federation",
    "format": "Slalom / Course / Marathon",
    "status": "Completed",
    "lifecycleStatus": "published",
    "scoringSystem": "WCR B8 / Appendix A low points; published discards retained",
    "rulesNotes": "Series 2 at Changi Beach Park CP 1 / Tanah Merah. Results provisional as of 21:14 on 10 February 2025. NoR: 1\u20134 races: 0 discards; 5\u20138: 1; 9\u201312: 2; 13\u201316: 3; 17\u201320: 4; 21\u201325: 5; 26\u201330: 6; 31\u201338: 7; 39\u201346: 8; 47\u201354: 9. Source-specific discard counts retained.",
    "websiteUrl": "https://www.sailing.org.sg/events/263406",
    "noticeBoardUrl": "https://www.racingrulesofsailing.org/documents/10645/event",
    "results": [
      {
        "rank": 1,
        "name": "Jun Ler Chuah",
        "sailNumber": "16",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 5,
        "nettScore": 4,
        "races": [
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          }
        ],
        "sourceName": "Jun Ler Chuah"
      },
      {
        "rank": 2,
        "name": "Axl Tan",
        "sailNumber": "SGP 82",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 10,
        "nettScore": 8,
        "races": [
          {
            "score": 2.0,
            "isDiscarded": true
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          }
        ],
        "sourceName": "Axl Tan"
      },
      {
        "rank": 3,
        "name": "Muhammad Razin",
        "sailNumber": "3",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 30,
        "nettScore": 24,
        "races": [
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Muhammad Razin"
      },
      {
        "rank": 3,
        "name": "Reynold Chan",
        "sailNumber": "52",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 30,
        "nettScore": 24,
        "races": [
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Reynold Chan"
      },
      {
        "rank": 3,
        "name": "Jonathan Chan",
        "sailNumber": "1",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 30,
        "nettScore": 24,
        "races": [
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Jonathan Chan"
      }
    ]
  },
  {
    "table": "wingfoil",
    "id": "ne-monsoon-grand-prix-2025-combined-wingfoil",
    "name": "2025 Northeast Monsoon Grand Prix Combined Series",
    "shortName": "NE Combined 2025",
    "dates": "25 January \u2013 9 February 2025",
    "venue": "Changi Beach Park CP 1 / Tanah Merah, Singapore",
    "organizer": "Singapore Sailing Federation",
    "format": "Slalom / Course / Marathon",
    "status": "Completed",
    "lifecycleStatus": "published",
    "scoringSystem": "WCR B8 / Appendix A low points; published discards retained",
    "rulesNotes": "Published combined standings for Series 1, Series 2 and Series 3 GPS Speed Challenge. Provisional March 7, 2025. Combined Windfoil PDF incorrectly headed Series 1; 41 race columns represent the combined series. Jackson Ho Wingfoil totals do not agree with displayed race sums; preserved as published. NoR: 1\u20134 races: 0 discards; 5\u20138: 1; 9\u201312: 2; 13\u201316: 3; 17\u201320: 4; 21\u201325: 5; 26\u201330: 6; 31\u201338: 7; 39\u201346: 8; 47\u201354: 9. Source-specific discard counts retained.",
    "websiteUrl": "https://www.sailing.org.sg/events/263406",
    "noticeBoardUrl": "https://www.racingrulesofsailing.org/documents/10645/event",
    "results": [
      {
        "rank": 1,
        "name": "Jackson Ho",
        "sailNumber": "11",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 66.5,
        "nettScore": 37.0,
        "races": [
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 6.0,
            "isDiscarded": true
          },
          {
            "score": 2.0,
            "isDiscarded": true
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "OCS"
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          }
        ],
        "sourceNotes": "Published gross 66.5 and net 37 differ from displayed race sums 62 and 30. Preserved as published; no correction inferred.",
        "sourceName": "Jackson Ho"
      },
      {
        "rank": 2,
        "name": "Ker Wan Chew",
        "sailNumber": "15",
        "gender": "M",
        "club": "PAssion Wave (East Coast)",
        "ageCategory": "Master",
        "division": "Master",
        "schoolName": "",
        "grossScore": 196.0,
        "nettScore": 92.0,
        "races": [
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 3.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNF"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 11.0,
            "isDiscarded": true
          },
          {
            "score": 3.0
          },
          {
            "score": 2.0
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 4.0
          },
          {
            "score": 6.0,
            "isDiscarded": true
          },
          {
            "score": 5.0
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "OCS"
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0
          },
          {
            "score": 7.0,
            "isDiscarded": true
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          }
        ],
        "sourceName": "Chew Ker Wan"
      },
      {
        "rank": 3,
        "name": "Guillaume Pichoir",
        "sailNumber": "16",
        "gender": "M",
        "club": "ONE\u00b015 Marina Club",
        "ageCategory": "Grand Master",
        "division": "Grand Master",
        "schoolName": "",
        "grossScore": 248.0,
        "nettScore": 108.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0
          },
          {
            "score": 6.0
          },
          {
            "score": 8.0
          },
          {
            "score": 2.0
          },
          {
            "score": 9.0
          },
          {
            "score": 11.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0
          },
          {
            "score": 1.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 6.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 7.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          }
        ],
        "sourceName": "Guillaume Pichoir"
      },
      {
        "rank": 4,
        "name": "Sven Welak",
        "sailNumber": "25",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 329.0,
        "nettScore": 189.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 4.0
          },
          {
            "score": 6.0
          },
          {
            "score": 6.0
          },
          {
            "score": 5.0
          },
          {
            "score": 4.0
          },
          {
            "score": 8.0
          },
          {
            "score": 5.0
          },
          {
            "score": 7.0
          },
          {
            "score": 2.0
          },
          {
            "score": 8.0
          },
          {
            "score": 10.0
          },
          {
            "score": 5.0
          },
          {
            "score": 6.0
          },
          {
            "score": 5.0
          },
          {
            "score": 6.0
          },
          {
            "score": 6.0
          },
          {
            "score": 7.0
          },
          {
            "score": 6.0
          },
          {
            "score": 7.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          }
        ],
        "sourceName": "Sven Welack"
      },
      {
        "rank": 5,
        "name": "Felix Knick",
        "sailNumber": "50",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Master",
        "division": "Master",
        "schoolName": "",
        "grossScore": 331.0,
        "nettScore": 191.0,
        "races": [
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 2.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "RET"
          },
          {
            "score": 2.0
          },
          {
            "score": 3.0
          },
          {
            "score": 5.0
          },
          {
            "score": 4.0
          },
          {
            "score": 10.0
          },
          {
            "score": 4.0
          },
          {
            "score": 8.0
          },
          {
            "score": 5.0
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "OCS"
          },
          {
            "score": 5.0
          },
          {
            "score": 5.0
          },
          {
            "score": 4.0
          },
          {
            "score": 5.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 5.0
          },
          {
            "score": 5.0
          },
          {
            "score": 5.0
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Felix Knick"
      },
      {
        "rank": 6,
        "name": "Ryusai Hatano",
        "sailNumber": "42",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Fun",
        "division": "Fun",
        "schoolName": "",
        "grossScore": 411.0,
        "nettScore": 271.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 3.0
          },
          {
            "score": 2.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 20.0,
            "code": "OCS"
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0
          },
          {
            "score": 2.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 2.0
          },
          {
            "score": 7.0
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Ryusai Hatano"
      },
      {
        "rank": 7,
        "name": "Arthur Phan",
        "sailNumber": "29",
        "gender": "M",
        "club": "Kitesurfing Association of Singapore",
        "ageCategory": "Grand Master",
        "division": "Grand Master",
        "schoolName": "",
        "grossScore": 503.0,
        "nettScore": 363.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 6.0
          },
          {
            "score": 20.0,
            "code": "OCS"
          },
          {
            "score": 7.0
          },
          {
            "score": 7.0
          },
          {
            "score": 6.0
          },
          {
            "score": 7.0
          },
          {
            "score": 7.0
          },
          {
            "score": 6.0
          },
          {
            "score": 3.0
          },
          {
            "score": 9.0
          },
          {
            "score": 7.0
          },
          {
            "score": 7.0
          },
          {
            "score": 8.0
          },
          {
            "score": 6.0
          },
          {
            "score": 9.0
          },
          {
            "score": 9.0
          },
          {
            "score": 6.0
          },
          {
            "score": 7.0
          },
          {
            "score": 6.0
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Arther Phan"
      },
      {
        "rank": 8,
        "name": "Malo Pichoir",
        "sailNumber": "6",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "u16,u19, Fun Open",
        "division": "u16,u19, Fun Open",
        "schoolName": "",
        "grossScore": 555.0,
        "nettScore": 415.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 10.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 9.0
          },
          {
            "score": 8.0
          },
          {
            "score": 9.0
          },
          {
            "score": 20.0,
            "code": "OCS"
          },
          {
            "score": 10.0
          },
          {
            "score": 9.0
          },
          {
            "score": 9.0
          },
          {
            "score": 7.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          },
          {
            "score": 8.0
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Malo Pichoir"
      },
      {
        "rank": 9,
        "name": "Xavier Lau",
        "sailNumber": "38",
        "gender": "M",
        "club": "",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 598.0,
        "nettScore": 458.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 9.0
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 5.0
          },
          {
            "score": 6.0
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 7.0
          },
          {
            "score": 6.0
          },
          {
            "score": 8.0
          },
          {
            "score": 20.0,
            "code": "RET"
          },
          {
            "score": 20.0,
            "code": "RET"
          },
          {
            "score": 5.0
          },
          {
            "score": 5.0
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Xavier Lau"
      },
      {
        "rank": 10,
        "name": "Mikhail McEntyre",
        "sailNumber": "22",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "u16, u19",
        "division": "u16, u19",
        "schoolName": "",
        "grossScore": 615.0,
        "nettScore": 475.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 13.0
          },
          {
            "score": 11.0
          },
          {
            "score": 9.0
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 11.0
          },
          {
            "score": 11.0
          },
          {
            "score": 11.0
          },
          {
            "score": 9.0
          },
          {
            "score": 9.0
          },
          {
            "score": 10.0
          },
          {
            "score": 11.0
          },
          {
            "score": 10.0
          },
          {
            "score": 10.0
          },
          {
            "score": 10.0
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Mikhail McEntyre"
      },
      {
        "rank": 11,
        "name": "Greg McEntyre",
        "sailNumber": "43",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Fun Master",
        "division": "Fun Master",
        "schoolName": "",
        "grossScore": 641.0,
        "nettScore": 501.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 5.0
          },
          {
            "score": 9.0
          },
          {
            "score": 8.0
          },
          {
            "score": 12.0
          },
          {
            "score": 10.0
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 10.0
          },
          {
            "score": 9.0
          },
          {
            "score": 9.0
          },
          {
            "score": 9.0
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Greg McEntyre"
      },
      {
        "rank": 12,
        "name": "Bill Hickling",
        "sailNumber": "45",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Grand Master",
        "division": "Grand Master",
        "schoolName": "",
        "grossScore": 699.0,
        "nettScore": 559.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 7.0
          },
          {
            "score": 7.0
          },
          {
            "score": 5.0
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Bill Hickling"
      },
      {
        "rank": 13,
        "name": "Ryan Lo",
        "sailNumber": "17",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 702.0,
        "nettScore": 562.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 5.0
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 9.0
          },
          {
            "score": 8.0
          },
          {
            "score": 20.0,
            "code": "OCS"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Ryan Lo"
      },
      {
        "rank": 14,
        "name": "Andrew Lees",
        "sailNumber": "24",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Master",
        "division": "Master",
        "schoolName": "",
        "grossScore": 704.0,
        "nettScore": 564.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 6.0
          },
          {
            "score": 8.0
          },
          {
            "score": 10.0
          },
          {
            "score": 20.0,
            "code": "RET"
          },
          {
            "score": 20.0,
            "code": "RET"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Andrew Lees"
      },
      {
        "rank": 15,
        "name": "Mason Qifeng Lau",
        "sailNumber": "8",
        "gender": "M",
        "club": "",
        "ageCategory": "u16, u19",
        "division": "u16, u19",
        "schoolName": "",
        "grossScore": 704.0,
        "nettScore": 564.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 12.0
          },
          {
            "score": 13.0
          },
          {
            "score": 12.0
          },
          {
            "score": 7.0
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNF"
          },
          {
            "score": 20.0,
            "code": "DNS"
          },
          {
            "score": 20.0,
            "code": "DNS"
          },
          {
            "score": 20.0,
            "code": "RET"
          },
          {
            "score": 20.0,
            "code": "RET"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Mason Lau"
      },
      {
        "rank": 16,
        "name": "Sven Welak",
        "sailNumber": "25",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Fun",
        "division": "Fun",
        "schoolName": "",
        "grossScore": 740.0,
        "nettScore": 600.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Sven Welack"
      },
      {
        "rank": 16,
        "name": "Jun Hao Lo",
        "sailNumber": "21",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Fun",
        "division": "Fun",
        "schoolName": "",
        "grossScore": 740.0,
        "nettScore": 600.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Lo Jun Hao"
      },
      {
        "rank": 16,
        "name": "Jun Hao Lo",
        "sailNumber": "21",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Master",
        "division": "Master",
        "schoolName": "",
        "grossScore": 740.0,
        "nettScore": 600.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Lo Jun Hao"
      },
      {
        "rank": 16,
        "name": "James Feathers",
        "sailNumber": "19",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Master",
        "division": "Master",
        "schoolName": "",
        "grossScore": 740.0,
        "nettScore": 600.0,
        "races": [
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          },
          {
            "score": 20.0,
            "code": "DNC"
          }
        ],
        "sourceName": "James Feathers"
      }
    ]
  },
  {
    "table": "techno293",
    "id": "ne-monsoon-grand-prix-2025-combined-techno293",
    "name": "2025 Northeast Monsoon Grand Prix Combined Series",
    "shortName": "NE Combined 2025",
    "dates": "25 January \u2013 9 February 2025",
    "venue": "Changi Beach Park CP 1 / Tanah Merah, Singapore",
    "organizer": "Singapore Sailing Federation",
    "format": "Slalom / Course / Marathon",
    "status": "Completed",
    "lifecycleStatus": "published",
    "scoringSystem": "WCR B8 / Appendix A low points; published discards retained",
    "rulesNotes": "Published combined standings for Series 1, Series 2 and Series 3 GPS Speed Challenge. Provisional March 7, 2025. Combined Windfoil PDF incorrectly headed Series 1; 41 race columns represent the combined series. Jackson Ho Wingfoil totals do not agree with displayed race sums; preserved as published. NoR: 1\u20134 races: 0 discards; 5\u20138: 1; 9\u201312: 2; 13\u201316: 3; 17\u201320: 4; 21\u201325: 5; 26\u201330: 6; 31\u201338: 7; 39\u201346: 8; 47\u201354: 9. Source-specific discard counts retained.",
    "websiteUrl": "https://www.sailing.org.sg/events/263406",
    "noticeBoardUrl": "https://www.racingrulesofsailing.org/documents/10645/event",
    "results": [
      {
        "rank": 1,
        "name": "Axl Tan",
        "sailNumber": "SGP 82",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 110,
        "nettScore": 74,
        "races": [
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 4.0
          },
          {
            "score": 3.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Axl Tan"
      },
      {
        "rank": 2,
        "name": "Jonathan Chan",
        "sailNumber": "1",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 126,
        "nettScore": 90,
        "races": [
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "RET"
          },
          {
            "score": 4.0
          },
          {
            "score": 2.0
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "OCS"
          },
          {
            "score": 3.0
          },
          {
            "score": 2.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Jonathan Chan"
      },
      {
        "rank": 3,
        "name": "Muhammad Razin",
        "sailNumber": "3",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 140,
        "nettScore": 104,
        "races": [
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 3.0
          },
          {
            "score": 2.0
          },
          {
            "score": 4.0
          },
          {
            "score": 2.0
          },
          {
            "score": 2.0
          },
          {
            "score": 4.0
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          }
        ],
        "sourceName": "Muhammad Razin"
      },
      {
        "rank": 4,
        "name": "Reynold Chan",
        "sailNumber": "52",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 169,
        "nettScore": 133,
        "races": [
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Reynold Chan"
      },
      {
        "rank": 5,
        "name": "Jun Ler Chuah",
        "sailNumber": "16",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 179,
        "nettScore": 143,
        "races": [
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Jun Ler Chuah"
      }
    ]
  },
  {
    "table": "wingfoil",
    "id": "ne-monsoon-grand-prix-2025-gps-speed-challenge-wingfoil",
    "name": "2025 Northeast Monsoon Grand Prix Series 3 GPS Speed Challenge",
    "shortName": "NE GPS 2025",
    "dates": "25 January \u2013 8 February 2025",
    "venue": "Singapore waters",
    "organizer": "Singapore Sailing Federation",
    "format": "GPS Speed Challenge",
    "status": "Completed",
    "lifecycleStatus": "published",
    "scoringSystem": "WCR B8 / Appendix A low points; published discards retained",
    "rulesNotes": "GPS Speed Challenge within Singapore waters. Final results as of 12:52 on 7 March 2025. Finishes counted as nine notional races per NoR; these are ranking scores, not measured speeds. NoR: 1\u20134 races: 0 discards; 5\u20138: 1; 9\u201312: 2; 13\u201316: 3; 17\u201320: 4; 21\u201325: 5; 26\u201330: 6; 31\u201338: 7; 39\u201346: 8; 47\u201354: 9. Source-specific discard counts retained.",
    "websiteUrl": "https://www.sailing.org.sg/events/263406",
    "noticeBoardUrl": "https://www.racingrulesofsailing.org/documents/10645/event",
    "results": [
      {
        "rank": 1,
        "name": "Jackson Ho",
        "sailNumber": "11",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 9,
        "nettScore": 7,
        "races": [
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          }
        ],
        "sourceName": "Jackson Ho"
      },
      {
        "rank": 5,
        "name": "Ryusai Hatano",
        "sailNumber": "42",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Ryusai Hatano"
      },
      {
        "rank": 1,
        "name": "Guillaume Pichoir",
        "sailNumber": "16",
        "gender": "M",
        "club": "ONE\u00b015 Marina Club",
        "ageCategory": "Grand Master, Fun Open, Fun Master",
        "division": "Grand Master, Fun Open, Fun Master",
        "schoolName": "",
        "grossScore": 9,
        "nettScore": 7,
        "races": [
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          }
        ],
        "sourceName": "Guillaume Pichoir"
      },
      {
        "rank": 3,
        "name": "Ker Wan Chew",
        "sailNumber": "15",
        "gender": "M",
        "club": "PAssion Wave (East Coast)",
        "ageCategory": "Grand Master",
        "division": "Grand Master",
        "schoolName": "",
        "grossScore": 27,
        "nettScore": 21,
        "races": [
          {
            "score": 3.0,
            "isDiscarded": true
          },
          {
            "score": 3.0,
            "isDiscarded": true
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          },
          {
            "score": 3.0
          }
        ],
        "sourceName": "Chew Ker Wan"
      },
      {
        "rank": 5,
        "name": "Felix Knick",
        "sailNumber": "50",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Master",
        "division": "Master",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Felix Knick"
      },
      {
        "rank": 4,
        "name": "Sven Welak",
        "sailNumber": "25",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 36,
        "nettScore": 28,
        "races": [
          {
            "score": 4.0,
            "isDiscarded": true
          },
          {
            "score": 4.0,
            "isDiscarded": true
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          },
          {
            "score": 4.0
          }
        ],
        "sourceName": "Sven Welack"
      },
      {
        "rank": 5,
        "name": "Arthur Phan",
        "sailNumber": "29",
        "gender": "M",
        "club": "Kitesurfing Association of Singapore",
        "ageCategory": "Grand Master",
        "division": "Grand Master",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Arther Phan"
      },
      {
        "rank": 5,
        "name": "Malo Pichoir",
        "sailNumber": "6",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "U16, U19, Fun Open",
        "division": "U16, U19, Fun Open",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Malo Pichoir"
      },
      {
        "rank": 5,
        "name": "Xavier Lau",
        "sailNumber": "38",
        "gender": "M",
        "club": "",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Xavier Lau"
      },
      {
        "rank": 5,
        "name": "Mikhail McEntyre",
        "sailNumber": "22",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "U16, U19",
        "division": "U16, U19",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Mikhail McEntyre"
      },
      {
        "rank": 5,
        "name": "Greg McEntyre",
        "sailNumber": "43",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Greg McEntyre"
      },
      {
        "rank": 5,
        "name": "Bill Hickling",
        "sailNumber": "45",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Grand Master",
        "division": "Grand Master",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Bill Hickling"
      },
      {
        "rank": 5,
        "name": "Ryan Lo",
        "sailNumber": "17",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Ryan Lo"
      },
      {
        "rank": 5,
        "name": "Andrew Lees",
        "sailNumber": "24",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Master",
        "division": "Master",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Andrew Lees"
      },
      {
        "rank": 5,
        "name": "Mason Qifeng Lau",
        "sailNumber": "8",
        "gender": "M",
        "club": "",
        "ageCategory": "U16, U19",
        "division": "U16, U19",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Mason Lau"
      },
      {
        "rank": 5,
        "name": "James Feathers",
        "sailNumber": "19",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Master",
        "division": "Master",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "James Feathers"
      },
      {
        "rank": 5,
        "name": "Jun Hao Lo",
        "sailNumber": "21",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 162,
        "nettScore": 126,
        "races": [
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          },
          {
            "score": 18.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Lo Jun Hao"
      }
    ]
  },
  {
    "table": "techno293",
    "id": "ne-monsoon-grand-prix-2025-gps-speed-challenge-techno293",
    "name": "2025 Northeast Monsoon Grand Prix Series 3 GPS Speed Challenge",
    "shortName": "NE GPS 2025",
    "dates": "25 January \u2013 8 February 2025",
    "venue": "Singapore waters",
    "organizer": "Singapore Sailing Federation",
    "format": "GPS Speed Challenge",
    "status": "Completed",
    "lifecycleStatus": "published",
    "scoringSystem": "WCR B8 / Appendix A low points; published discards retained",
    "rulesNotes": "GPS Speed Challenge within Singapore waters. Final results as of 12:52 on 7 March 2025. Finishes counted as nine notional races per NoR; these are ranking scores, not measured speeds. NoR: 1\u20134 races: 0 discards; 5\u20138: 1; 9\u201312: 2; 13\u201316: 3; 17\u201320: 4; 21\u201325: 5; 26\u201330: 6; 31\u201338: 7; 39\u201346: 8; 47\u201354: 9. Source-specific discard counts retained.",
    "websiteUrl": "https://www.sailing.org.sg/events/263406",
    "noticeBoardUrl": "https://www.racingrulesofsailing.org/documents/10645/event",
    "results": [
      {
        "rank": 2,
        "name": "Jun Ler Chuah",
        "sailNumber": "16",
        "gender": "M",
        "club": "Aloha Sea Sports Centre",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 54,
        "nettScore": 42,
        "races": [
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Jun Ler Chuah"
      },
      {
        "rank": 2,
        "name": "Axl Tan",
        "sailNumber": "SGP 82",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 54,
        "nettScore": 42,
        "races": [
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Axl Tan"
      },
      {
        "rank": 1,
        "name": "Muhammad Razin",
        "sailNumber": "3",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 9,
        "nettScore": 7,
        "races": [
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0,
            "isDiscarded": true
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          },
          {
            "score": 1.0
          }
        ],
        "sourceName": "Muhammad Razin"
      },
      {
        "rank": 2,
        "name": "Reynold Chan",
        "sailNumber": "52",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 54,
        "nettScore": 42,
        "races": [
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Reynold Chan"
      },
      {
        "rank": 2,
        "name": "Jonathan Chan",
        "sailNumber": "1",
        "gender": "M",
        "club": "Constant Wind SeaSports",
        "ageCategory": "Open",
        "division": "",
        "schoolName": "",
        "grossScore": 54,
        "nettScore": 42,
        "races": [
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "isDiscarded": true,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          },
          {
            "score": 6.0,
            "code": "DNC"
          }
        ],
        "sourceName": "Jonathan Chan"
      }
    ]
  }
]
$boards$::jsonb) LOOP
 IF board->>'table'='wingfoil' THEN
 INSERT INTO public.wingfoil_regattas(id,status,data) VALUES(board->>'id','published',board-'table') ON CONFLICT(id) DO UPDATE SET data=excluded.data,status='published',updated_at=now();
 ELSE
 INSERT INTO public.techno293_regattas(id,status,data) VALUES(board->>'id','published',board-'table') ON CONFLICT(id) DO UPDATE SET data=excluded.data,status='published',updated_at=now();
 END IF;
 END LOOP;
END $import$;
COMMIT;
