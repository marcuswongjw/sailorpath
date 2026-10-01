-- Move February SAFYC and December ILCA 6 off the July Optimist championship,
-- then store the official Silver Fleet race scores on that championship.

update public.regattas
set event_id = 'f5faeb6a-9996-42e4-9d08-0789d6834875', updated_at = now()
where slug in ('21st-safyc-regatta-2025-gold', '21st-safyc-regatta-2025-silver');

update public.regattas
set event_id = '22766575-9063-426e-a69f-c04ecddd4dcc', updated_at = now()
where slug = 'safyc-48th-singapore-ilca-open-ilca6-2025-12-06';

drop table if exists public._safyc_silver_2025_load;

create table public._safyc_silver_2025_load (
  final_rank integer not null,
  nett real not null,
  total real not null,
  races jsonb not null
);

insert into public._safyc_silver_2025_load (final_rank, nett, total, races) values
(1, 13.0, 79.0, '[{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":1.0,"code":null,"discarded":false,"raw":"1"}]'::jsonb),
(2, 28.0, 94.0, '[{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":13.0,"code":null,"discarded":false,"raw":"13"}]'::jsonb),
(3, 32.0, 43.0, '[{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":11.0,"code":null,"discarded":true,"raw":"(11)"},{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":5.0,"code":null,"discarded":false,"raw":"5"}]'::jsonb),
(4, 35.0, 101.0, '[{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":3.0,"code":null,"discarded":false,"raw":"3"}]'::jsonb),
(5, 41.0, 107.0, '[{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":4.0,"code":null,"discarded":false,"raw":"4"}]'::jsonb),
(6, 43.0, 74.0, '[{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":31.0,"code":null,"discarded":true,"raw":"(31)"},{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":9.0,"code":null,"discarded":false,"raw":"9"}]'::jsonb),
(7, 53.0, 80.0, '[{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":27.0,"code":null,"discarded":true,"raw":"(27)"},{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":7.0,"code":null,"discarded":false,"raw":"7"}]'::jsonb),
(8, 53.0, 87.0, '[{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":34.0,"code":null,"discarded":true,"raw":"(34)"}]'::jsonb),
(9, 56.0, 74.0, '[{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":18.0,"code":null,"discarded":true,"raw":"(18)"},{"score":2.0,"code":null,"discarded":false,"raw":"2"}]'::jsonb),
(10, 63.0, 82.0, '[{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":19.0,"code":null,"discarded":true,"raw":"(19)"}]'::jsonb),
(11, 68.0, 88.0, '[{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":20.0,"code":null,"discarded":true,"raw":"(20)"},{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":16.0,"code":null,"discarded":false,"raw":"16"}]'::jsonb),
(12, 69.0, 135.0, '[{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":17.0,"code":null,"discarded":false,"raw":"17"}]'::jsonb),
(13, 71.0, 91.0, '[{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":20.0,"code":null,"discarded":true,"raw":"(20)"},{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":10.0,"code":null,"discarded":false,"raw":"10"}]'::jsonb),
(14, 72.0, 100.0, '[{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":28.0,"code":null,"discarded":true,"raw":"(28)"},{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":20.0,"code":null,"discarded":false,"raw":"20"}]'::jsonb),
(15, 75.0, 110.0, '[{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":35.0,"code":null,"discarded":true,"raw":"(35)"},{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":11.0,"code":null,"discarded":false,"raw":"11"}]'::jsonb),
(16, 80.0, 112.0, '[{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":32.0,"code":null,"discarded":true,"raw":"(32)"},{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":12.0,"code":null,"discarded":false,"raw":"12"}]'::jsonb),
(17, 87.0, 153.0, '[{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":8.0,"code":null,"discarded":false,"raw":"8"}]'::jsonb),
(18, 107.0, 173.0, '[{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":66.0,"code":"UFD","discarded":false,"raw":"66 UFD"},{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":6.0,"code":null,"discarded":false,"raw":"6"}]'::jsonb),
(19, 123.0, 161.0, '[{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":23.0,"code":null,"discarded":false,"raw":"23"},{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":27.0,"code":null,"discarded":false,"raw":"27"},{"score":38.0,"code":null,"discarded":true,"raw":"(38)"}]'::jsonb),
(20, 123.0, 151.0, '[{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":28.0,"code":null,"discarded":true,"raw":"(28)"},{"score":24.0,"code":null,"discarded":false,"raw":"24"},{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":25.0,"code":null,"discarded":false,"raw":"25"}]'::jsonb),
(21, 130.0, 176.0, '[{"score":46.0,"code":null,"discarded":true,"raw":"(46)"},{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":23.0,"code":null,"discarded":false,"raw":"23"},{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":29.0,"code":null,"discarded":false,"raw":"29"}]'::jsonb),
(22, 132.0, 165.0, '[{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":33.0,"code":null,"discarded":true,"raw":"(33)"},{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":33.0,"code":null,"discarded":false,"raw":"33"},{"score":32.0,"code":null,"discarded":false,"raw":"32"},{"score":15.0,"code":null,"discarded":false,"raw":"15"}]'::jsonb),
(23, 139.0, 173.0, '[{"score":26.0,"code":null,"discarded":false,"raw":"26"},{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":31.0,"code":null,"discarded":false,"raw":"31"},{"score":34.0,"code":null,"discarded":true,"raw":"(34)"},{"score":28.0,"code":null,"discarded":false,"raw":"28"}]'::jsonb),
(24, 145.0, 211.0, '[{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":66.0,"code":"UFD","discarded":false,"raw":"66 UFD"},{"score":28.0,"code":null,"discarded":false,"raw":"28"},{"score":21.0,"code":null,"discarded":false,"raw":"21"}]'::jsonb),
(25, 157.0, 199.0, '[{"score":28.0,"code":null,"discarded":false,"raw":"28"},{"score":42.0,"code":null,"discarded":true,"raw":"(42)"},{"score":30.0,"code":null,"discarded":false,"raw":"30"},{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":40.0,"code":null,"discarded":false,"raw":"40"},{"score":23.0,"code":null,"discarded":false,"raw":"23"}]'::jsonb),
(26, 160.0, 226.0, '[{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":25.0,"code":null,"discarded":false,"raw":"25"},{"score":29.0,"code":null,"discarded":false,"raw":"29"},{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":23.0,"code":null,"discarded":false,"raw":"23"},{"score":29.0,"code":null,"discarded":false,"raw":"29"},{"score":37.0,"code":null,"discarded":false,"raw":"37"}]'::jsonb),
(27, 163.0, 208.0, '[{"score":24.0,"code":null,"discarded":false,"raw":"24"},{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":34.0,"code":null,"discarded":false,"raw":"34"},{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":45.0,"code":null,"discarded":true,"raw":"(45)"},{"score":38.0,"code":null,"discarded":false,"raw":"38"},{"score":36.0,"code":null,"discarded":false,"raw":"36"}]'::jsonb),
(28, 165.0, 231.0, '[{"score":30.0,"code":null,"discarded":false,"raw":"30"},{"score":37.0,"code":null,"discarded":false,"raw":"37"},{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":66.0,"code":"UFD","discarded":false,"raw":"66 UFD"},{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":14.0,"code":null,"discarded":false,"raw":"14"}]'::jsonb),
(29, 167.0, 233.0, '[{"score":33.0,"code":null,"discarded":false,"raw":"33"},{"score":23.0,"code":null,"discarded":false,"raw":"23"},{"score":25.0,"code":null,"discarded":false,"raw":"25"},{"score":28.0,"code":null,"discarded":false,"raw":"28"},{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":31.0,"code":null,"discarded":false,"raw":"31"},{"score":27.0,"code":null,"discarded":false,"raw":"27"}]'::jsonb),
(30, 169.0, 210.0, '[{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":30.0,"code":null,"discarded":false,"raw":"30"},{"score":28.0,"code":null,"discarded":false,"raw":"28"},{"score":24.0,"code":null,"discarded":false,"raw":"24"},{"score":34.0,"code":null,"discarded":false,"raw":"34"},{"score":35.0,"code":null,"discarded":false,"raw":"35"},{"score":41.0,"code":null,"discarded":true,"raw":"(41)"}]'::jsonb),
(31, 175.0, 222.0, '[{"score":29.0,"code":null,"discarded":false,"raw":"29"},{"score":47.0,"code":null,"discarded":true,"raw":"(47)"},{"score":41.0,"code":null,"discarded":false,"raw":"41"},{"score":32.0,"code":null,"discarded":false,"raw":"32"},{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":26.0,"code":null,"discarded":false,"raw":"26"},{"score":26.0,"code":null,"discarded":false,"raw":"26"}]'::jsonb),
(32, 175.0, 241.0, '[{"score":25.0,"code":null,"discarded":false,"raw":"25"},{"score":39.0,"code":null,"discarded":false,"raw":"39"},{"score":38.0,"code":null,"discarded":false,"raw":"38"},{"score":25.0,"code":null,"discarded":false,"raw":"25"},{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":24.0,"code":null,"discarded":false,"raw":"24"},{"score":24.0,"code":null,"discarded":false,"raw":"24"}]'::jsonb),
(33, 179.0, 235.0, '[{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":29.0,"code":null,"discarded":false,"raw":"29"},{"score":39.0,"code":null,"discarded":false,"raw":"39"},{"score":35.0,"code":null,"discarded":false,"raw":"35"},{"score":32.0,"code":null,"discarded":false,"raw":"32"},{"score":23.0,"code":null,"discarded":false,"raw":"23"},{"score":56.0,"code":null,"discarded":true,"raw":"(56)"}]'::jsonb),
(34, 181.0, 247.0, '[{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":27.0,"code":null,"discarded":false,"raw":"27"},{"score":36.0,"code":null,"discarded":false,"raw":"36"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":66.0,"code":"UFD","discarded":false,"raw":"66 UFD"},{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":22.0,"code":null,"discarded":false,"raw":"22"}]'::jsonb),
(35, 182.0, 221.0, '[{"score":27.0,"code":null,"discarded":false,"raw":"27"},{"score":33.0,"code":null,"discarded":false,"raw":"33"},{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":33.0,"code":null,"discarded":false,"raw":"33"},{"score":36.0,"code":null,"discarded":false,"raw":"36"},{"score":39.0,"code":null,"discarded":true,"raw":"(39)"},{"score":32.0,"code":null,"discarded":false,"raw":"32"}]'::jsonb),
(36, 183.0, 229.0, '[{"score":31.0,"code":null,"discarded":false,"raw":"31"},{"score":26.0,"code":null,"discarded":false,"raw":"26"},{"score":42.0,"code":null,"discarded":false,"raw":"42"},{"score":29.0,"code":null,"discarded":false,"raw":"29"},{"score":30.0,"code":null,"discarded":false,"raw":"30"},{"score":25.0,"code":null,"discarded":false,"raw":"25"},{"score":46.0,"code":null,"discarded":true,"raw":"(46)"}]'::jsonb),
(37, 195.0, 232.0, '[{"score":32.0,"code":null,"discarded":false,"raw":"32"},{"score":34.0,"code":null,"discarded":false,"raw":"34"},{"score":37.0,"code":null,"discarded":true,"raw":"(37)"},{"score":31.0,"code":null,"discarded":false,"raw":"31"},{"score":26.0,"code":null,"discarded":false,"raw":"26"},{"score":37.0,"code":null,"discarded":false,"raw":"37"},{"score":35.0,"code":null,"discarded":false,"raw":"35"}]'::jsonb),
(38, 203.0, 269.0, '[{"score":37.0,"code":null,"discarded":false,"raw":"37"},{"score":24.0,"code":null,"discarded":false,"raw":"24"},{"score":35.0,"code":null,"discarded":false,"raw":"35"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":47.0,"code":null,"discarded":false,"raw":"47"},{"score":30.0,"code":null,"discarded":false,"raw":"30"},{"score":30.0,"code":null,"discarded":false,"raw":"30"}]'::jsonb),
(39, 204.0, 247.0, '[{"score":35.0,"code":null,"discarded":false,"raw":"35"},{"score":35.0,"code":null,"discarded":false,"raw":"35"},{"score":27.0,"code":null,"discarded":false,"raw":"27"},{"score":27.0,"code":null,"discarded":false,"raw":"27"},{"score":38.0,"code":null,"discarded":false,"raw":"38"},{"score":42.0,"code":null,"discarded":false,"raw":"42"},{"score":43.0,"code":null,"discarded":true,"raw":"(43)"}]'::jsonb),
(40, 212.0, 263.0, '[{"score":42.0,"code":null,"discarded":false,"raw":"42"},{"score":36.0,"code":null,"discarded":false,"raw":"36"},{"score":32.0,"code":null,"discarded":false,"raw":"32"},{"score":34.0,"code":null,"discarded":false,"raw":"34"},{"score":24.0,"code":null,"discarded":false,"raw":"24"},{"score":44.0,"code":null,"discarded":false,"raw":"44"},{"score":51.0,"code":null,"discarded":true,"raw":"(51)"}]'::jsonb),
(41, 213.0, 279.0, '[{"score":41.0,"code":null,"discarded":false,"raw":"41"},{"score":40.0,"code":null,"discarded":false,"raw":"40"},{"score":45.0,"code":null,"discarded":false,"raw":"45"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":41.0,"code":null,"discarded":false,"raw":"41"},{"score":33.0,"code":null,"discarded":false,"raw":"33"}]'::jsonb),
(42, 219.0, 285.0, '[{"score":39.0,"code":null,"discarded":false,"raw":"39"},{"score":31.0,"code":null,"discarded":false,"raw":"31"},{"score":44.0,"code":null,"discarded":false,"raw":"44"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":25.0,"code":null,"discarded":false,"raw":"25"},{"score":49.0,"code":null,"discarded":false,"raw":"49"},{"score":31.0,"code":null,"discarded":false,"raw":"31"}]'::jsonb),
(43, 242.0, 308.0, '[{"score":23.0,"code":null,"discarded":false,"raw":"23"},{"score":41.0,"code":null,"discarded":false,"raw":"41"},{"score":26.0,"code":null,"discarded":false,"raw":"26"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":66.0,"code":"UFD","discarded":false,"raw":"66 UFD"},{"score":36.0,"code":null,"discarded":false,"raw":"36"},{"score":50.0,"code":null,"discarded":false,"raw":"50"}]'::jsonb),
(44, 243.0, 309.0, '[{"score":38.0,"code":null,"discarded":false,"raw":"38"},{"score":51.0,"code":null,"discarded":false,"raw":"51"},{"score":43.0,"code":null,"discarded":false,"raw":"43"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":43.0,"code":null,"discarded":false,"raw":"43"},{"score":49.0,"code":null,"discarded":false,"raw":"49"}]'::jsonb),
(45, 254.0, 320.0, '[{"score":43.0,"code":null,"discarded":false,"raw":"43"},{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":46.0,"code":null,"discarded":false,"raw":"46"},{"score":26.0,"code":null,"discarded":false,"raw":"26"},{"score":66.0,"code":"UFD","discarded":false,"raw":"66 UFD"},{"score":33.0,"code":null,"discarded":false,"raw":"33"},{"score":40.0,"code":null,"discarded":false,"raw":"40"}]'::jsonb),
(46, 260.0, 326.0, '[{"score":34.0,"code":null,"discarded":false,"raw":"34"},{"score":48.0,"code":null,"discarded":false,"raw":"48"},{"score":47.0,"code":null,"discarded":false,"raw":"47"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":40.0,"code":null,"discarded":false,"raw":"40"},{"score":52.0,"code":null,"discarded":false,"raw":"52"},{"score":39.0,"code":null,"discarded":false,"raw":"39"}]'::jsonb),
(47, 262.0, 328.0, '[{"score":49.0,"code":null,"discarded":false,"raw":"49"},{"score":43.0,"code":null,"discarded":false,"raw":"43"},{"score":49.0,"code":null,"discarded":false,"raw":"49"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":29.0,"code":null,"discarded":false,"raw":"29"},{"score":50.0,"code":null,"discarded":false,"raw":"50"},{"score":42.0,"code":null,"discarded":false,"raw":"42"}]'::jsonb),
(48, 269.0, 335.0, '[{"score":66.0,"code":"DNC","discarded":true,"raw":"(66 DNC)"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":46.0,"code":null,"discarded":false,"raw":"46"},{"score":18.0,"code":null,"discarded":false,"raw":"18"}]'::jsonb),
(49, 269.0, 335.0, '[{"score":47.0,"code":null,"discarded":false,"raw":"47"},{"score":49.0,"code":null,"discarded":false,"raw":"49"},{"score":66.0,"code":"NSC","discarded":true,"raw":"(66 NSC)"},{"score":30.0,"code":null,"discarded":false,"raw":"30"},{"score":39.0,"code":null,"discarded":false,"raw":"39"},{"score":51.0,"code":null,"discarded":false,"raw":"51"},{"score":53.0,"code":null,"discarded":false,"raw":"53"}]'::jsonb),
(50, 289.0, 355.0, '[{"score":36.0,"code":null,"discarded":false,"raw":"36"},{"score":44.0,"code":null,"discarded":false,"raw":"44"},{"score":66.0,"code":"NSC","discarded":true,"raw":"(66 NSC)"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":49.0,"code":null,"discarded":false,"raw":"49"},{"score":47.0,"code":null,"discarded":false,"raw":"47"},{"score":47.0,"code":null,"discarded":false,"raw":"47"}]'::jsonb),
(51, 291.0, 357.0, '[{"score":50.0,"code":null,"discarded":false,"raw":"50"},{"score":38.0,"code":null,"discarded":false,"raw":"38"},{"score":48.0,"code":null,"discarded":false,"raw":"48"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":66.0,"code":"UFD","discarded":false,"raw":"66 UFD"},{"score":45.0,"code":null,"discarded":false,"raw":"45"},{"score":44.0,"code":null,"discarded":false,"raw":"44"}]'::jsonb),
(52, 296.0, 362.0, '[{"score":40.0,"code":null,"discarded":false,"raw":"40"},{"score":54.0,"code":null,"discarded":false,"raw":"54"},{"score":55.0,"code":null,"discarded":false,"raw":"55"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":41.0,"code":null,"discarded":false,"raw":"41"},{"score":54.0,"code":null,"discarded":false,"raw":"54"},{"score":52.0,"code":null,"discarded":false,"raw":"52"}]'::jsonb),
(53, 309.0, 375.0, '[{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":45.0,"code":null,"discarded":false,"raw":"45"},{"score":52.0,"code":null,"discarded":false,"raw":"52"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":44.0,"code":null,"discarded":false,"raw":"44"},{"score":48.0,"code":null,"discarded":false,"raw":"48"},{"score":54.0,"code":null,"discarded":false,"raw":"54"}]'::jsonb),
(54, 312.0, 378.0, '[{"score":52.0,"code":null,"discarded":false,"raw":"52"},{"score":55.0,"code":null,"discarded":false,"raw":"55"},{"score":53.0,"code":null,"discarded":false,"raw":"53"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":42.0,"code":null,"discarded":false,"raw":"42"},{"score":55.0,"code":null,"discarded":false,"raw":"55"},{"score":55.0,"code":null,"discarded":false,"raw":"55"}]'::jsonb),
(55, 313.0, 379.0, '[{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":50.0,"code":null,"discarded":false,"raw":"50"},{"score":50.0,"code":null,"discarded":false,"raw":"50"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":37.0,"code":null,"discarded":false,"raw":"37"},{"score":53.0,"code":null,"discarded":false,"raw":"53"},{"score":57.0,"code":null,"discarded":false,"raw":"57"}]'::jsonb),
(56, 316.0, 382.0, '[{"score":48.0,"code":null,"discarded":false,"raw":"48"},{"score":52.0,"code":null,"discarded":false,"raw":"52"},{"score":40.0,"code":null,"discarded":false,"raw":"40"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":50.0,"code":null,"discarded":false,"raw":"50"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":60.0,"code":null,"discarded":false,"raw":"60"}]'::jsonb),
(57, 322.0, 388.0, '[{"score":66.0,"code":"UFD","discarded":true,"raw":"(66 UFD)"},{"score":46.0,"code":null,"discarded":false,"raw":"46"},{"score":66.0,"code":"NSC","discarded":false,"raw":"66 NSC"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":43.0,"code":null,"discarded":false,"raw":"43"},{"score":56.0,"code":null,"discarded":false,"raw":"56"},{"score":45.0,"code":null,"discarded":false,"raw":"45"}]'::jsonb),
(58, 344.0, 410.0, '[{"score":53.0,"code":null,"discarded":false,"raw":"53"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":54.0,"code":null,"discarded":false,"raw":"54"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":46.0,"code":null,"discarded":false,"raw":"46"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":59.0,"code":null,"discarded":false,"raw":"59"}]'::jsonb),
(59, 347.0, 413.0, '[{"score":45.0,"code":null,"discarded":false,"raw":"45"},{"score":53.0,"code":null,"discarded":false,"raw":"53"},{"score":51.0,"code":null,"discarded":false,"raw":"51"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"}]'::jsonb),
(60, 348.0, 414.0, '[{"score":54.0,"code":null,"discarded":false,"raw":"54"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":48.0,"code":null,"discarded":false,"raw":"48"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":48.0,"code":null,"discarded":false,"raw":"48"}]'::jsonb),
(61, 359.0, 425.0, '[{"score":44.0,"code":null,"discarded":false,"raw":"44"},{"score":66.0,"code":"DNF","discarded":true,"raw":"(66 DNF)"},{"score":66.0,"code":"RET","discarded":false,"raw":"66 RET"},{"score":66.0,"code":"DNS","discarded":false,"raw":"66 DNS"},{"score":51.0,"code":null,"discarded":false,"raw":"51"},{"score":66.0,"code":"NSC","discarded":false,"raw":"66 NSC"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"}]'::jsonb),
(62, 381.0, 447.0, '[{"score":51.0,"code":null,"discarded":false,"raw":"51"},{"score":66.0,"code":"RET","discarded":true,"raw":"(66 RET)"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"}]'::jsonb),
(63, 382.0, 448.0, '[{"score":66.0,"code":"NSC","discarded":true,"raw":"(66 NSC)"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":52.0,"code":null,"discarded":false,"raw":"52"},{"score":66.0,"code":"DNS","discarded":false,"raw":"66 DNS"},{"score":66.0,"code":"NSC","discarded":false,"raw":"66 NSC"}]'::jsonb),
(64, 388.0, 454.0, '[{"score":66.0,"code":"NSC","discarded":true,"raw":"(66 NSC)"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":66.0,"code":"UFD","discarded":false,"raw":"66 UFD"},{"score":66.0,"code":"DNF","discarded":false,"raw":"66 DNF"},{"score":58.0,"code":null,"discarded":false,"raw":"58"}]'::jsonb),
(65, 396.0, 462.0, '[{"score":66.0,"code":"DNC","discarded":true,"raw":"(66 DNC)"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"},{"score":66.0,"code":"DNC","discarded":false,"raw":"66 DNC"}]'::jsonb);

do $$
declare
  missing integer;
  bad integer;
  sailors integer;
begin
  select count(*) into missing
  from public._safyc_silver_2025_load source
  left join public.regattas regatta on regatta.slug = 'safyc-silver-jul-25-2025-07-12'
  left join public.regatta_results result
    on result.regatta_id = regatta.id
   and result.rank = source.final_rank
   and result.nett_score = source.nett
   and result.total_score = source.total
  where result.id is null;

  select count(*) into bad
  from public._safyc_silver_2025_load source
  where source.nett <> (
    select sum((race.item->>'score')::real)
    from jsonb_array_elements(source.races) race(item)
    where (race.item->>'discarded')::boolean = false
  )
  or (
    select count(*)
    from jsonb_array_elements(source.races) race(item)
    where (race.item->>'discarded')::boolean
  ) <> 1;

  select count(distinct result.sailor_id) into sailors
  from public._safyc_silver_2025_load source
  join public.regattas regatta on regatta.slug = 'safyc-silver-jul-25-2025-07-12'
  join public.regatta_results result
    on result.regatta_id = regatta.id
   and result.rank = source.final_rank
   and result.nett_score = source.nett;

  if missing <> 0 or bad <> 0 or sailors <> 65 then
    raise exception 'SAFYC Silver 2025 load failed: missing %, bad %, sailors %', missing, bad, sailors;
  end if;
end $$;

update public.regattas
set
  name = '1st SAFYC Optimist Championship 2025 (Silver Fleet)',
  race_count = 7,
  total_fleet_size = 65,
  end_date = '2025-07-13',
  schedule_notes = '1st SAFYC Optimist Championship 2025 Silver Fleet, 12-13 July 2025. Seven races completed; best six count.',
  updated_at = now()
where slug = 'safyc-silver-jul-25-2025-07-12';

delete from public.regatta_race_results race
using public.regatta_results result, public.regattas regatta
where race.regatta_result_id = result.id
  and result.regatta_id = regatta.id
  and regatta.slug = 'safyc-silver-jul-25-2025-07-12';

insert into public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
)
select
  result.id,
  race.ordinality::integer,
  (race.item->>'score')::real,
  nullif(race.item->>'code', ''),
  (race.item->>'discarded')::boolean,
  race.item->>'raw',
  now(),
  now()
from public._safyc_silver_2025_load source
join public.regattas regatta on regatta.slug = 'safyc-silver-jul-25-2025-07-12'
join public.regatta_results result
  on result.regatta_id = regatta.id
 and result.rank = source.final_rank
 and result.nett_score = source.nett
cross join lateral jsonb_array_elements(source.races) with ordinality as race(item, ordinality);

update public.regatta_results result
set
  is_dns = false,
  evidence_name = '1st SAFYC Optimist Silver.xlsx',
  evidence_notes = 'Official Silver Fleet spreadsheet. Seven races, one discard.',
  verification_status = 'verified',
  verified_at = coalesce(result.verified_at, now()),
  updated_at = now()
from public.regattas regatta
where result.regatta_id = regatta.id
  and regatta.slug = 'safyc-silver-jul-25-2025-07-12';

drop table public._safyc_silver_2025_load;
