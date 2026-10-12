-- Import visually reviewed, score-reconciled 2023 Singapore result sheets.
-- Included: NSC Cup Optimist Gold/Silver; Singapore National Sailing Championships Optimist Silver;
-- CSC Optimist Championships Gold/Silver (PowerScore provisional exports); 46th Singapore ILCA Open ILCA 4.
-- 477 result rows / 3,531 individual race scores. WingFoil is excluded.
-- Sailor resolution is exact normalized full-name/alias only. No profiles are created or merged.
-- 27 owner-approved source-name aliases and six source-backed profiles are added only after conflict guards pass.
-- Historical entry sail numbers are retained per result; matched profiles receive the latest staged number for their class.
-- Ambiguous or missing profile matches intentionally abort before result writes.
-- All imported results remain pending_review/in_review; CSC PowerScore discard markers are inferred.
-- Depends on migration 109 for regattas.official_results_url/source_name.

create temp table _sp23_events (slug text primary key, name text, start_date date, end_date date, venue text, organizer text, classes jsonb, nor_url text, counts_for_ranking boolean, is_selection_trial boolean);
insert into _sp23_events values
('nsc-cup-2023','NSC Cup 2023','2023-07-22','2023-07-23','National Sailing Centre, Singapore','Singapore Sailing Federation','["ILCA","Optimist Gold","Optimist Silver"]'::jsonb,'https://www.racingrulesofsailing.org/documents/75304',TRUE,FALSE),
('csc-optimist-championships-2023','CSC Optimist Championships 2023','2023-12-06','2023-12-15','Changi Sailing Club, 32 Netheravon Road, Singapore 508508','Changi Sailing Club','["Optimist Gold","Optimist Silver"]'::jsonb,'https://www.csc.org.sg/wp-content/uploads/2020/12/CSC-Optimist-Championship_Notice-of-Race-1.pdf',TRUE,FALSE),
('national-sailing-championships-2023','Singapore National Sailing Championships 2023','2023-09-02','2023-09-05','National Sailing Centre, Singapore','Singapore Sailing Federation','["Optimist Gold","Optimist Silver","ILCA 4","ILCA 6","ILCA 7","29er","Techno 293","iQFOiL"]'::jsonb,'https://www.racingrulesofsailing.org/documents/76162',TRUE,FALSE),
('singapore-ilca-open-2023','46th Singapore ILCA Open 2023','2023-12-02','2023-12-03','NSRCC Seasports Centre, Singapore','SAF Yacht Club in association with Singapore Sailing Federation','["ILCA 4","ILCA 6","ILCA 7"]'::jsonb,'https://www.racingrulesofsailing.org/documents/83985',TRUE,FALSE);

insert into public.regatta_events (name, slug, start_date, end_date, venue, organizer, classes, nor_url, counts_for_ranking, is_selection_trial, created_at, updated_at)
select name, slug, start_date, end_date, venue, organizer, classes, nor_url, counts_for_ranking, is_selection_trial, now(), now() from _sp23_events
on conflict (slug) do update set name = excluded.name, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, organizer = excluded.organizer, classes = excluded.classes, nor_url = excluded.nor_url, counts_for_ranking = excluded.counts_for_ranking, updated_at = now();

create temp table _sp23_sheets (sheet_no integer primary key, slug text unique, event_slug text, name text, start_date date, end_date date, division text, boat_class text, entries integer, race_count integer, nett_count integer, venue text, organizer text, results_url text, source_name text, result_status text);
insert into _sp23_sheets values
(1,'nsc-cup-optimist-gold-2023','nsc-cup-2023','NSC Cup 2023 (Optimist Gold)','2023-07-22','2023-07-23','Gold','Optimist',81,7,6,'National Sailing Centre, Singapore','Singapore Sailing Federation','https://drive.google.com/file/d/1imEIoMEol3yPAJXzdmp77sZjFurZpNEF/view','nsc-cup-optimist-gold.pdf','final'),
(2,'nsc-cup-optimist-silver-2023','nsc-cup-2023','NSC Cup 2023 (Optimist Silver)','2023-07-22','2023-07-23','Silver','Optimist',91,7,6,'National Sailing Centre, Singapore','Singapore Sailing Federation','https://drive.google.com/file/d/192qrjlHpchpJqymUT0Oibr9KtnkNbllz/view','nsc-cup-optimist-silver.pdf','final'),
(3,'snsc-optimist-silver-2023','national-sailing-championships-2023','Singapore National Sailing Championships 2023 (Optimist Silver)','2023-09-02','2023-09-05','Silver','Optimist',102,9,8,'National Sailing Centre, Singapore','Singapore Sailing Federation','https://drive.google.com/file/d/1K-QP4BJfvrtbWUVmVVR6XFmc9paNIj3y/view','snsc-optimist-silver.pdf','final'),
(4,'csc-optimist-gold-2023','csc-optimist-championships-2023','CSC Optimist Championships 2023 (Optimist Gold)','2023-12-12','2023-12-15','Gold','Optimist',73,8,7,'Changi Sailing Club, 32 Netheravon Road, Singapore 508508','Changi Sailing Club','https://drive.google.com/file/d/1bNMFW-OrHR33va4SHl7cFWN1MyrpjcJY/view','csc-optimist-gold.txt','provisional'),
(5,'csc-optimist-silver-2023','csc-optimist-championships-2023','CSC Optimist Championships 2023 (Optimist Silver)','2023-12-06','2023-12-08','Silver','Optimist',87,8,6,'Changi Sailing Club, 32 Netheravon Road, Singapore 508508','Changi Sailing Club','https://drive.google.com/file/d/16oTirfFnipCO2ivoXE0Ldd3bMJvBiD05/view','csc-optimist-silver.txt','provisional'),
(6,'singapore-ilca-open-ilca4-2023','singapore-ilca-open-2023','46th Singapore ILCA Open 2023 (ILCA 4)','2023-12-02','2023-12-03','Open','ILCA 4',43,3,3,'NSRCC Seasports Centre, Singapore','SAF Yacht Club in association with Singapore Sailing Federation','https://drive.google.com/file/d/1oG17FY1L327oDJuRBGs4EzMJRliAdNpt/view','46th-singapore-ilca-open-ilca4.pdf','final');

insert into public.regattas (name, slug, event_id, date, total_fleet_size, division, race_count, geography, boat_class, entry_type, min_participants, max_participants, counts_for_ranking, venue, end_date, nor_url, official_results_url, official_results_source_name, organizer, schedule_notes, status, created_at, updated_at)
select sh.name, sh.slug, ev.id, sh.start_date, sh.entries, sh.division, sh.race_count, 'SGP', sh.boat_class, 'individual', 1, 1, true, sh.venue, sh.end_date, e.nor_url, sh.results_url, sh.source_name, sh.organizer,
       format('%s; %s races, best %s of %s counted; source marked %s. Import held for profile/discard review.', sh.name, sh.race_count, sh.nett_count, sh.race_count, sh.result_status),
       'in_review', now(), now()
from _sp23_sheets sh join _sp23_events e on e.slug = sh.event_slug join public.regatta_events ev on ev.slug = sh.event_slug
on conflict (slug) do update set name = excluded.name, event_id = excluded.event_id, date = excluded.date, total_fleet_size = excluded.total_fleet_size, division = excluded.division, race_count = excluded.race_count, geography = excluded.geography, boat_class = excluded.boat_class, entry_type = excluded.entry_type, venue = excluded.venue, end_date = excluded.end_date, nor_url = excluded.nor_url, official_results_url = excluded.official_results_url, official_results_source_name = excluded.official_results_source_name, organizer = excluded.organizer, schedule_notes = excluded.schedule_notes, status = case when regattas.status = 'published' then regattas.status else 'in_review' end, updated_at = now();

create temp table _sp23_payloads (sheet_no integer primary key, payload text not null);
insert into _sp23_payloads values
(1,$sp23_1$1	Ethan Chia Han Wei	SGP 4508	M			11	15	0	BAEBAQMDAg==|AAAAAAAAAA==|1		0
2	Amos Tham	SGP 4463	M			14	25	0	AQIFBAELAQ==|AAAAAAAAAA==|32		0
3	Pee Teck Woon	SGP 3146	M			40	56	0	BRAHBgQFDQ==|AAAAAAAAAA==|2		0
4	Nia Zahedi	SGP 4670	F			46	71	0	BgYGFBkBBw==|AAAAAAAAAA==|16		0
5	Ethan Lee	SGP 4416	M			48	74	0	EAQTAhoCBQ==|AAAAAAAAAA==|16		0
6	Mikaela Rae Ng	SGP 4424	F			56	70	0	AgsODQoKCg==|AAAAAAAAAA==|4		0
7	Zeph Wan	SGP 3407	M			59	79	0	CwkDBRAUDw==|AAAAAAAAAA==|32		0
8	Ashlea Tham	SGP 4453	F			59	76	0	CgcQDgUHEQ==|AAAAAAAAAA==|64		0
9	Cheryl Yong Heng Xi	SGP 744	F			60	95	0	Bw8CAwwjFQ==|AAAAAAAAAA==|32		0
10	Desiree lee	SGP 4698	F			63	97	0	AyIKCBIVAw==|AAAAAAAAAA==|2		0
11	Lucas Cao Zhihong	SGP 3913	M			63	81	0	EhEEEQ0ECA==|AAAAAAAAAA==|1		0
12	Nicole Ashley Quek	SGP 3281	F			63	82	0	DQ4MEwYOBA==|AAAAAAAAAA==|8		0
13	Nigel Tan Xu Yuan	SGP 4693	M			63	80	0	DAUNCREMDA==|AAAAAAAAAA==|16		0
14	Kum Kok Wei Sean	SGP 4682	M			69	107	0	CAMIEiYQEA==|AAAAAAAAAA==|16		0
15	Germaine Sim	SGP 3177	F			74	96	0	ERYRBwcGFA==|AAAAAAAAAA==|2		0
16	Cheung Lap Yan Nathaniel	SGP 3711	M			85	118	0	GSELChUJCQ==|AAAAAAAAAA==|2		0
17	Wai Zhi Tong	SGP 3458	F			92	115	0	CRMVFxQRBg==|AAAAAAAAAA==|8		0
18	Li Yuxuan Lyric	SGP 728	F			105	130	0	GBgPDxAZCw==|AAAAAAYAAA==|32		0
19	Lee Wee Wen Nicholette	SGP 4725	F			106	139	0	HAoJFQ4YIQ==|AAAAAAAAAA==|64		0
20	Yap Swee Wayne	SGP 3228	M			109	147	0	FwwSJg8PGg==|AAAAAAAAAA==|8		0
21	Josh Low	SGP 3179	M			112	139	0	GhsUFgkIGw==|AAAAAAAAAA==|2		0
22	Tong Xuan Ya	SGP 4460	F			121	152	0	HxQZDBYcDg==|AAAAAAAAAA==|1		0
23	Tiago Cheng De Villemor Salgado	SGP 719	M			123	164	0	DxwpECANEw==|AAAAAAAAAA==|4		0
24	Tan Herng Yee	SGP 3000	M			143	189	0	KgguGQsiFw==|AAAAAAAAAA==|4		0
25	Yong Heng Yi	SGP 755	M			168	211	0	KB4kCysdFg==|AAAAAAAAAA==|16		0
26	Anya	SGP 4724	F			171	212	0	IxkXKRcfIg==|AAAAAAAAAA==|8		0
27	Nathaniel Kaiden Ng	SGP 3344	M			179	220	0	KQ0fGAIbUg==|AAAAAAAABQ==|1		0
28	Kevin Ho Jun Yi	SGP 3118	M			180	234	0	FCccHh82IA==|AAAAAAAAAA==|32		0
29	Alyssa Wong Li Lin	SGP 3396	F			182	220	0	JBcWJB0kJg==|AAAAAAAAAA==|64		0
30	Caleb Peck Rui- Kai	SGP 3153	M			191	260	0	FSYYLUUmGQ==|AAAABgAAAA==|16		0
31	Damien Huang	SGP 3300	M			203	256	0	FhUzKjUxEg==|AAAAAAAAAA==|16		0
32	Wong Qi Ke, Febe	SGP 3003	F			205	256	0	MCAgIiMzGA==|AAAAAAAAAA==|32		0
33	Ashlyn Tham	SGP 4452	F			212	294	0	UhohGhNJIw==|AgAAAAAAAA==|1		0
34	Jairus Teo Xin Jie	SGP 4073	M			224	271	0	Ey0jLyQrLg==|AAAAAAAAAA==|8		0
35	Chen Huan Heng	SGP 4729	F			224	290	0	ISg3HC4WQg==|AAAAAAAAAA==|64		0
36	Regis Wong Xuan Kai	SGP 3988	M			228	310	0	UhInIUcnHA==|AgAAAAAAAA==|1		0
37	James Kong	SGP 3464	M			228	310	0	UikvLi0THg==|AgAAAAAAAA==|1		0
38	Travis Yeo Jia Le	SGP 4556	M			229	298	0	DjMbJzBFMg==|AAAAAAAAAA==|32		0
39	Liew Soon Kit Jared	SGP 3198	M			234	308	0	MzEdShseMA==|AAAAAAAAAA==|8		0
40	Elliot Goh	SGP 3103	M			236	293	0	Mh0iNRguOQ==|AAAAAAAAAA==|64		0
41	Julien Christian	SGP 3102	M			239	321	0	UiVDKyUSJQ==|AgAAAAAAAA==|1		0
42	Axl Tan Yi En	SGP 4697	M			242	312	0	LSpGGyE4Jw==|AAAAAAAAAA==|4		0
43	Lucius Chimon	SGP 4719	M			246	314	0	Gx9EHUQ+HQ==|AAAAAAAAAA==|4		0
44	Lim Yuk Jun	SGP 3377	M			257	335	0	Ly4tLSkhTg==|AAAAAAAAAA==|64		0
45	Rupert Chang	SGP 5172	M			262	329	0	IjAmMCc3Qw==|AAAAAAAAAA==|64		0
46	Zaid Mohamed Noordeen Bin Jaffar Sadik	SGP 3666	M			269	351	0	UitCIDoXLw==|AgAAAAAAAA==|1		0
47	Zephyr Tan Wen	SGP 4717	M			270	333	0	Hiw1PCg/Kw==|AAAAAAAAAA==|32		0
48	Reyes Tan Jit Eng	SGP 4712	M			271	335	0	HTQoKEA6NA==|AAAAAAAAAA==|16		0
49	Joash Tan Jing En	SGP 3267	M			278	334	0	KzgrMjcvKA==|AAAAAAAAAA==|2		0
50	Jaye Low	SGP 3279	F			282	364	0	IDweRxw9Ug==|AAAAAAAABA==|64		0
51	Siti Ra'idah Biinte	SGP 3181	F			285	367	0	UjcxMSwaPg==|AgAAAAAAAA==|1		0
52	Dylan Goh Yue Teng	SGP 3800	M			306	388	0	UjI2OR5CMQ==|AgAAAAAAAA==|1		0
53	Kayden Tan Yi Kai	3104	M			307	384	0	LjtBRU0lHw==|AAAAAAAAAA==|16		0
54	Charles Kong	SGP 716	M			308	379	0	J0dHLDQ5LQ==|AAAAAAAAAA==|2		0
55	Gerome Sim	SGP 3188	M			314	396	0	UjYaPSJPPA==|AgAAAAAAAA==|1		0
56	Kate Yen Zi Ning	SGP 797	F			316	387	0	ND80IzFBRw==|AAAAAAAAAA==|64		0
57	Cecilia Kong	SGP 715	F			321	403	0	UjksH0gwRQ==|AgAAAAAAAA==|1		0
58	Elijah Ong	SGP 3950	M			323	405	0	UiNKODItPw==|AgAAAAAAAA==|1		0
59	Jade Yen Zi Ning	SGP 798	F			325	403	0	JUU/Tj40Kg==|AAAAAAAAAA==|8		0
60	Jonas Haris Knick	SGP 3482	M			334	410	0	JkxASyoqSQ==|AAAAAAAAAA==|2		0
61	Mohd Mikail Bin Mohd Shahrom	SGP 704	M			335	417	0	UksqTy8pMw==|AgAAAAAAAA==|1		0
62	Tan Kian Jeng Jonas	SGP 3888	M			339	421	0	UiQyNz1DRg==|AgAAAAAAAA==|1		0
63	John Raphael Lim	SGP 788	M			341	413	0	MUg8Q0YoNw==|AAAAAAAAAA==|2		0
64	Joash Kok Jit Yin	SGP 3057	M			345	427	0	Uj0+NjM1QA==|AgAAAAAAAA==|1		0
65	Eugene Tan Yi Ze	SGP 3999	M			347	418	0	NUNFM0JHKQ==|AAAAAAAAAA==|32		0
66	Cheryl Ho	SGP 3117	F			349	431	0	UjU5P0kyNQ==|AgAAAAAAAA==|1		0
67	Kaelyn Dayna Soh Zhi Yi	3113	F			352	434	0	UklOOzYsLA==|AgAAAAAAAA==|1		0
68	Rayson Ng Yee Meng	SGP 3793	M			353	435	0	Ui84NEFLOg==|AgAAAAAAAA==|1		0
69	Aaron Abraham	SGP 4669	M			360	442	0	UjpPUDkgNg==|AgAAAAAAAA==|1		0
70	Aaron Chan Kai En	SGP 3121	M			385	467	0	UkI9STxAPQ==|AgAAAAAAAA==|1		0
71	Angela Huang Fei'er	3175	F			386	468	0	UlAwTT87Ow==|AgAAAAAAAA==|1		0
72	Tan Kia Guan Joseph	SGP 3688	M			397	479	0	UkElRlBNRA==|AgAAAAAAAA==|1		0
73	Nicholas Ng Jiang En	SGP 3353	M			400	482	0	UkBNQE88OA==|AgAAAAAAAA==|1		0
74	Caleb Cao Zhixuan	SGP 3193	M			401	483	0	Uk9IQkxIJA==|AgAAAAAAAA==|1		0
75	Sun Weichen	SGP 4661	M			407	489	0	Uj46PkpMSw==|AgAAAAAAAA==|1		0
76	Evan Teo Ee Wen	SGP 3330	M			411	493	0	Uk47SENGQQ==|AgAAAAAAAA==|1		0
77	Ang Yuan Pin Javaughn	SGP 3205	M			421	499	0	LE1JTE5KTQ==|AAAAAAAAAA==|16		0
78	Joshua Khoo Zhuo Xi	4728	M			421	503	0	UkZMOktESg==|AgAAAAAAAA==|1		0
79	Noel Ng Jiang Wen	SGP 3166	M			421	503	0	UkRLQTtOTA==|AgAAAAAAAA==|1		0
80	Russell Xavier Quek	SGP 3008	M			432	514	0	UkpQRDhSSA==|AgAAAAABAA==|1		0
81	Chew Bo Le Deklen	SGP 3131	M			492	574	1	UlJSUlJSUg==|AQEBAQEBAQ==|1		0$sp23_1$),
(2,$sp23_2$1	Callum Wong Joon Thang	SGP 3321	M			24	31	0	AgMBBQYHBw==|AAAAAAAAAA==|32		0
2	Judy Zhang sudjana	33	F			27	119	0	AVwHAwEOAQ==|AAMAAAAAAA==|2		0
3	Sayawaki- Kogut Leopold	SGP 710	M			29	44	0	BQUGDwIIAw==|AAAAAAAAAA==|8		0
4	Martha Wazen	SGP 4689	F			40	71	0	AwYLAREfAg==|AAAAAAAAAA==|32		0
5	Tan Jun Quan Russell	SGP 3172	M			43	54	0	CwsCBgsJBA==|AAAAAAAAAA==|1		0
6	Elizabeth Chen Rui Tian	SGP 3148	F			52	144	0	CAENEwoBXA==|AAAAAAAAAw==|64		0
7	Lim Rui Kai, Lucas	SGP 3355	M			57	115	0	CQQQCjoDDw==|AAAAAAAAAA==|16		0
8	Lim Yuk Pin	SGP 3880	M			79	112	0	DQIaCxIhCQ==|AAAAAAAAAA==|32		0
9	Rachel Lim Qian Hui	SGP 3197	F			86	111	0	FA8PGQQNEw==|AAAAAAAAAA==|8		0
10	Mathias Cheow	SGP 3307	M			87	138	0	IgkEEDMGEg==|AAAAAAAAAA==|16		0
11	Jonathan Kwok Kum Loong	SGP 2003	M			92	184	0	BFwUDCgCDg==|AAMAAAAAAA==|2		0
12	Isaiah Yap Chor Hong	SGP 3946	M			99	191	0	DwgYGBZcBg==|AAAAAAADAA==|32		0
13	Gan Swee iok Lucien	SGP 2007	M			106	136	0	HhwKEQwaDQ==|AAAAAAAAAA==|1		0
14	Cheung Hei Yat Adriel	SGP 3611	M			112	145	0	IBUhAhMQFg==|AAAAAAAAAA==|4		0
15	Rahul Rajakanth	2006	M			114	163	0	MQwlIA0EEA==|AAAAAAAAAA==|1		0
16	Tan Kai En, Joel	SGP 3223	M			116	208	0	KB8FCBRcDA==|AAAAAAADAA==|32		0
17	Darius Goh Yue Siang	SGP 3111	M			116	153	0	DBEdFQklHA==|AAAAAAAAAA==|32		0
18	Lee Yi Zhe Elijah	SGP 4518	M			117	209	0	G1wREh0PCw==|AAMAAAAAAA==|2		0
19	Ethan Low Zhi Ren	SGP 3855	M			118	166	0	Bg0MKjAjCg==|AAAAAAAAAA==|16		0
20	Joel Khoo Zhuo Le	SGP 4730	M			123	160	0	BxMkJQUkFA==|AAAAAAAAAA==|8		0
21	Tan Yee Xuen	SGP 3001	F			127	192	0	ChoILEEiBQ==|AAAABgAAAA==|16		0
22	Janelle Tan Yi Han	5117	F			130	194	0	FxAWDkAWIQ==|AAAAAAAAAA==|16		0
23	Kai Yen- Yu	SGP 758	F			134	173	0	ESAOGxsRJw==|AAAAAAAAAA==|64		0
24	Liu Yunhao	SIN 2005	M			137	187	0	MgowCSELGg==|AAAAAAAAAA==|1		0
25	Zachary Low Zhi En	SGP 3369	M			140	194	0	GhI2JxAKHw==|AAAAAAAAAA==|4		0
26	Raynor Ng Jun Meng	SGP 3911	M			140	178	0	ExYTFiImGA==|AAAAAAAAAA==|32		0
27	Jeremiah Ong Rui Feng	SGP 3373	M			144	183	0	IQ4nFx4VFw==|AAAAAAAAAA==|4		0
28	Neo Caleb	SGP 3199	M			149	241	0	FVwSNR8FFQ==|AAMAAAAAAA==|2		0
29	Kate En Rui Bateman	SIN 4562	F			157	249	0	EBQDBEgqXA==|AAAAAAAAAw==|64		0
30	Cheong Yi Tng, Tristan	SGP 4627	M			162	220	0	HxgfOgccKQ==|AAAAAAAAAA==|8		0
31	Chew Kai Jun Elkan	SGP 600	M			166	217	0	HR0oHg4YMw==|AAAAAAAAAA==|64		0
32	Jedd Lam Zhi Hao	SGP 2000	M			172	264	0	JCEZKwMgXA==|AAAAAAAAAw==|64		0
33	Tan Abram Kai-Ser	SGP 4705	M			176	268	0	DiYVIg9cNg==|AAAAAAADAA==|32		0
34	Ryo En Hua Bateman	SGP 919	M			203	287	0	KgcjFFATVA==|AAAAAAkABg==|64		0
35	Jude Nathan Wong	SGP 3495	M			203	283	0	JzoeHFASHg==|AAAAAAkAAA==|16		0
36	Lee Gentaro Noah	SGP 4471	M			204	255	0	LysJLiQXMw==|AAAAAAAABg==|64		0
37	Edrei Ong	SGP 3957	M			208	255	0	IxksLy8eGw==|AAAAAAAAAA==|8		0
38	Wong Jing Chen, Nicole	SGP 3006	F			217	266	0	GCMxHS4xIg==|AAAAAAAAAA==|4		0
39	Cheong Ting Jia Olivia	SGP 3002	F			217	269	0	JSccNCcdLQ==|AAAAAAAAAA==|8		0
40	Tan Kai Ting Hannah	SGP 777	F			221	294	0	GRcqLEkpLg==|AAAAAAAAAA==|16		0
41	Koh Yi Jie Zachary	SGP 4731	M			234	303	0	LiI1RSkrEQ==|AAAAAAAAAA==|8		0
42	Rayson Lee Yin Yi	SGP 3828	M			239	299	0	NB44Jhk8Jg==|AAAAAAAAAA==|32		0
43	Kye Tang	SGP 2002	M			239	316	0	JigmJDwbTQ==|AAAAAAAACQ==|64		0
44	Tan Wan Wen Jeanette	SGP 2017	F			258	320	0	KyovPjksGQ==|AAAAAAAAAA==|8		0
45	Alessia Talpo	SGP 3105	F			264	342	0	QixOQiAUJA==|CQAAAAAAAA==|4		0
46	Darian Huang	SGP 3700	M			266	358	0	HFwgDTUwXA==|AAMAAAAAAw==|2		0
47	Dani Sherif Ahmed khalil	SGP 4457	M			266	336	0	QkYiLRUzMQ==|CQkAAAAAAA==|2		0
48	Ambrose Stewart	SGP 730	M			267	359	0	LTg7KBwnXA==|AAAAAAAAAw==|64		0
49	Akhshaya Santoz	SGP 2008	F			268	360	0	FiUpKU1cMg==|AAAAAAADAA==|32		0
50	Charlene Yong Heng Ning	SGP 766	F			270	332	0	KTw+MxcoNw==|AAAAAAAAAA==|4		0
51	Joel Ong Han Sheng	SGP 2014	M			274	350	0	Qi0rMCVMIw==|CQAAAAAAAA==|32		0
52	Spencer Isaac	SGP 3286	M			279	363	0	QkZRVCoMCA==|CQkJCQAAAA==|8		0
53	Aidan Yeo see hett	SGP 3749	M			280	372	0	ElwXHzFDXA==|AAMAAAAAAw==|2		0
54	Tan Li Ying Kayler	SGP 3787	F			280	343	0	MDE8Pxg7KA==|AAAAAAAAAA==|8		0
55	Paolo Gagliardi La Gala	SGP 2015	M			281	373	0	XDMuRQguPQ==|AwAABgAAAA==|1		0
56	Liao ZhiTing	3472	M			294	364	0	OTJFRjIZKw==|AAAAAAAAAA==|8		0
57	Oisin Maiden	SGP 3141	M			299	356	0	NjY5NzY1HQ==|AAAAAAAAAA==|4		0
58	Sven Ng	SGP 4733	M			309	380	0	NTBAQUcvIA==|AAAAAAAAAA==|16		0
59	Leyla sherif Ahmed khalil	177	F			311	403	0	XC5RIRo9QA==|CAAJAAAAAA==|1		0
60	Loh Yi Jie Luke	SGP 3322	M			316	385	0	NylCNjhFLA==|AAAAAAAAAA==|32		0
61	Kyle Jeremy Soh Zhi Jun	3183	M			323	388	0	MzQ6Oy1BOg==|AAAAAAAAAA==|32		0
62	Jonas Tan Yi Jun	SGP 3481	M			327	419	0	QlwbBytcXA==|CQMAAAADAw==|2		0
63	Yeo Shixi	SIN 3283	M			332	408	0	ODdJTCM2Ow==|AAAAAAAAAA==|8		0
64	Catherine maiden	SGP 3191	F			332	412	0	PTU9OFAtOA==|AAAAAAkAAA==|16		0
65	Yak Yun Zhong Joseph	SGP 4739	M			332	424	0	XD0yPTc5MA==|CAAAAAAAAA==|1		0
66	Merelle Tay Xuanying	SGP 3511	F			333	409	0	LD5MQ0M4JQ==|AAAAAAAAAA==|4		0
67	Alisha Shireen Ali	SIN 3101	F			344	436	0	XDs0OUUyOQ==|CAAAAAAAAA==|1		0
68	Aden Santoz	SGP 3169	M			348	426	0	PDlBTiY/QQ==|AAAAAAAAAA==|8		0
69	Mohamed Hamzah bin Mohamed faisal	SGP 735	M			351	425	0	Qi8/Mko+Pw==|CQAAAAAAAA==|16		0
70	Cyrus Chiam Jing Yi	SGP 3343	M			352	432	0	Pxs3OlBITQ==|AAAABgkACQ==|16		0
71	Shin Lin Chen Rui	SIN 3485	M			353	437	0	QiRRVCxPLw==|CQAJCQAJAA==|8		0
72	Khoo Boo Ming Manfred	SGP 3288	M			380	460	0	OkZISVA3NA==|AAkAAAkAAA==|16		0
73	Auwin Leow Zhao Hong	SGP 340	M			381	460	0	QkMzTzRJSA==|CQAAAAAAAA==|8		0
74	Asher Low	SGP 4643	M			385	462	0	PkZHTT1ENQ==|AAkAAAAAAA==|8		0
75	Lim Rui Xuan, Lavene	SGP 3553	F			399	479	0	QkJNSFA6PA==|CQAAAAkAAA==|16		0
76	Cory Loh Zhi Hang	SGP 3881	M			406	498	0	XEZRI0ZPRw==|CAkJBgAJAA==|1		0
77	Chan Zi Merng	SGP 4413	M			413	505	0	XEZDSjtCTQ==|CAkAAAAACQ==|1		0
78	Jamiroquai Tay Kai Nuo	99	M			417	509	0	XEYtVD5AXA==|CAkACQAAAw==|1		0
79	Isla Lee Zhi Xi	457	F			420	504	0	O0ZRVD9PRA==|AAkJCQAJAA==|8		0
80	Ren Jiachen Katharine	466	F			432	524	0	XEZGUFBGPg==|CAkABgkAAA==|1		0
81	Kang Jie Long Emrys	SGP 733	M			433	517	0	QkZRVERKSg==|CQkJCQAAAA==|8		0
82	Kyan Tan Chun Hong	SGP 4712	M			437	529	0	XEZRUVA0SQ==|CAkJAAkAAA==|1		0
83	Chia Xing Hua Julia	SGP 3313	F			442	534	0	XEFEVFBPQg==|CAAACQkJAA==|1		0
84	Yeh Fang Yu Sage	SGP 796	F			445	537	0	XFxRREJHQw==|CAMJAAAAAA==|1		0
85	Fong Luke Tin	SGP 2019	M			447	539	0	XD9LVExPRg==|CAAACQAJAA==|1		0
86	Tang Chi Cheng Elliot	96	M			449	533	0	QkZRVFBLTQ==|CQkJCQkACQ==|8		0
87	Aiden Wong Kang Jun	90	M			459	551	0	QkBRQFxcXA==|CQAJAAEBAQ==|16		0
88	Estelle Yeo Rui	SGP 773	F			459	551	0	XEZRUFBPRQ==|CAkJAAkJAA==|1		0
89	Chew Yu Han Macy	SIN 499	F			462	554	0	XEZRS1BPTQ==|CAkJAAkJCQ==|1		0
90	Raedon Tan	SGP 3010	M			503	595	0	XFxKW0tPXA==|CAMABgAJAw==|1		0
91	Tan Wei Kai Jonathan	SGP 2016	M			552	644	1	XFxcXFxcXA==|AQEBAQEBAQ==|1		0$sp23_2$),
(3,$sp23_3$1	Thuta Phyo	MYA 11	M			32	45	0	BQkBDQYHAQEC|AAAAAAAAAAAA|8		0
2	Judy Zhang Sudjana	SGP 33	F			35	62	0	BgIDBwQEBwIb|AAAAAAAAAAAA|256		0
3	Callum Wong Joon Thang	SGP 3321	M			42	62	0	AQcKBAMCBRQK|AAAAAAAAAAAA|128		0
4	Shin May Kha Kyaw	MYA 17	F			50	153	0	CgNnAQ8IBAgB|AAADAAAAAAAA|4		0
5	Lin Khant Kyaw @ William	MYA 19	M			55	77	0	ERYECwgBAgMJ|AAAAAAAAAAAA|2		0
6	Sayawaki-Kogut Leopold	SGP 710	M			59	71	0	DAYHCgkGCwYE|AAAAAAAAAAAA|1		0
7	Ethan Low Zhi Ren	SGP 3855				84	134	0	FgQCDw4yDAkG|AAAAAAAAAAAA|32		0
8	Naing Lin Aung	MYA 4	M			86	111	0	FBkGAgsKDQsN|AAAAAAAAAAAA|2		0
9	A Ka Kyar Phyu	MYA 10	F			97	200	0	BCxnBQIJCgUS|AAkDAAAAAAAG|4		0
10	Darian Huang	SGP 3700				108	146	0	AwsWJhkLFgcH|AAAAAAAAAAAA|8		0
11	Martha Wazen	SGP 4689	F			112	182	0	CwEMCBcPCCJG|AAAAAAAAAAAA|256		0
12	Jonathan Kwok Kum Loong	SGP 2003	M			120	159	0	Bw4nDBMOBhEf|AAAAAAAAAAAA|4		0
13	Linus Wun Htaik @ Shwe Bhone Kha	MYA 6	M			130	233	0	EwhnDgowAw0P|AAADAAAAAAAG|4		0
14	Lim Rui Kai, Lucas	SGP 3355				131	165	0	FSIREwcgEQ8D|AAAAAAAAAAAA|2		0
15	Lim Yuk Pin	SGP 3880				135	166	0	DxcSHw0VEgoR|AAAAAAAAAAAA|8		0
16	Lucien Gan Swee iok	SGP 2007				143	184	0	EAopCRsNExwV|AAAAAAAAAAAA|4		0
17	Cheung Hei Yat Adriel	SGP 3611				148	188	0	CBwIEgwlFSgQ|AAYAAAAAAAAA|128		0
18	Aung Kaung Myat	MYA 7				154	257	0	JSlnEAEDCQwj|AAADAAAAAAAA|4		0
19	May Moe Htet	MYA 13	F			158	204	0	LhwQFioRDwQO|AAAAAAAAAAAA|1		0
20	Isaiah Yap Chor Hong	SGP 3946				161	205	0	FwUcAxwsJhgM|AAAAAAAAAAAA|32		0
21	Jude Nathan Wong	SGP 3495				161	200	0	Gx0ZBhgSEBAn|AAAAAAAAAAAA|256		0
22	Jonas Tan Yi Jun	SGP 3481	M			172	220	0	HA0OJDAfDg4W|AAAAAAAAAAAA|16		0
23	Tan Jun Quan Russell	SGP 3172	M			198	243	0	GBgLJxQtGBYi|AAAAAAAAAAAA|32		0
24	Tan Kai En, Joel	SGP 3223				206	271	0	HywPLAUFJBpB|AAkAAAAAAAAA|256		0
25	Jedd Lam Zhi Hao	SGP 2000				209	259	0	DhEFMh0iFywr|AAAAAAAAAAAA|8		0
26	Mathias cheow	SGP 3307				210	313	0	CSMYFBoQLCRn|AAAAAAAAAAAD|256		0
27	Charlotte Sandra Hlaing	MYA 14	F			215	253	0	IyYVHCIWHRIc|AAAAAAAAAAAA|2		0
28	Rachel Lim Qian Hui	SGP 3197				229	282	0	KQweGSU1Ix8S|AAAAAAAAAAAA|32		0
29	Min Khant Thu	MYA 5	M			236	322	0	PiQJNBIXVhUP|AAAAAAAACQAA|64		0
30	Janelle Tan Yi Han	SGP 5117	F			237	279	0	KB4lFx4UGx4q|AAAAAAAAAAAA|256		0
31	Rahul Rajakanth	SGP 2006	M			248	294	0	DSwbER8nLS4g|AAkAAAAAAAAA|128		0
32	Akhshaya Santoz	SGP 2008				248	325	0	HSwiIRZNHiEX|AAkAAAAAAAAA|32		0
33	Ryo En Hua Bateman	SGP 119	M			249	320	0	EhssLhATRzEe|AAAAAAAAAAAG|64		0
34	Thein Thurain Myint	MYA 16	M			251	306	0	JigNLSs3HBMZ|AAAAAAAAAAAA|32		0
35	THEERAKAN KLAYSOMBOON	THA 1593				258	312	0	JCAoHSQ2GiMY|AAAAAAAAAAAA|32		0
36	Kate En Rui Bateman	SGP 117	F			259	325	0	AiU0KhUMQhtC|AAAAAAAAAAAA|64		0
37	Joel Khoo Zhuo Le	SGP 4730				272	333	0	Lw8kFTQcICk9|AAAAAAAAAAAA|256		0
38	Liu Yunhao	SIN 2005				275	331	0	Myw4ICEkGRkd|AAkAAAAAAAAA|4		0
39	Cheong Ting Jia Olivia	SGP 3002				286	348	0	NRAaNycaFD4z|AAAAAAAAAAAA|128		0
40	Spencer Isaac Quek	SGP 3108				287	377	0	ISwUIigqJSVa|AAkAAAAAAAAJ|256		0
41	Yeo Shi Xi	SGP 3269				287	354	0	Hh8XGEM6Ky0h|AAAAAAAAAAAA|16		0
42	Tan Abram Kai- Ser	SGP 4705				301	362	0	ORM9GzEdLxcy|AAAAAAAAAAAA|4		0
43	Paolo Gagliardi La Gala	ITA 2015				311	379	0	LCwwI0QeQyAL|AAkAAAAAAAAA|16		0
44	Kai Yen-Yu	SGP 758				315	374	0	OywrKCMoHx01|AAkAAAAAAAAA|1		0
45	Joel Han Sheng Ong	SGP 2014				324	395	0	RywmLy4ZJycu|AAkAAAAAAAAA|1		0
46	Hannah Tan Kai Ting	SGP 700				328	405	0	LScdGjgrTTYk|AAAAAAAAAAAA|64		0
47	WONG JING CHEN, NICOLE	SGP 3006				340	407	0	Jxo1QywvMCop|AAAAAAAAAAAA|8		0
48	Tan Yee Xuen	SGP 3001				340	443	0	ZywhMSYmNzUe|DAkAAAAAAAAA|1		0
49	Kye Tang	SGP 2002	M			357	420	0	PRUqPzcjNSY0|AAAAAAAAAAAA|8		0
50	Lee Gentaro Noah	SGP 4471				365	437	0	ICwfMz5IOSst|AAkAAAAGAAAA|32		0
51	Zachary Low Zhi En	SGP 3369				367	456	0	KywxWT0zMjIT|AAkAAAAAAAAA|8		0
52	Edrei ONG En Xu	SGP 3957				376	451	0	GixLSzsYNDAw|AAkAAAAAAAAA|4		0
53	Ambrose Oz Stewart	SGP 730	M			390	456	0	QixAPC8bKS88|AAkAAAAAAAAA|1		0
54	Tan Li Ying Kayler	SGP 3787				416	492	0	QBQ2JUVMQTQ3|AAAAAAAAAAAA|32		0
55	Aidan Yeo see hett	SGP 112				418	521	0	UiwgHhFKREdn|AAkAAAAAAAAB|256		0
56	Ng Jun Meng Raynor	SGP 3911				426	504	0	IiwuTk1AITxE|AAkAAAAAAAAA|8		0
57	Jeremiah Ong Rui Feng	SGP 3373				429	503	0	NywzQjpCSjMm|AAkAAAAAAAAA|64		0
58	TAN Wan Wen Jeanette	SGP 2017				433	493	0	MCw5OzI8Ozo6|AAkAAAAAAAAA|32		0
59	Lim Rui Xuan, Lavene	SGP 3553				436	539	0	NCxnODk0KD1K|AAkMAAAAAAAA|4		0
60	Oisin maiden	SGP 3141				442	537	0	TCw3XyA4Llks|AAkACQAAAAAA|8		0
61	Melina Tsikouras	GER 2021				444	515	0	KixHRTwuPTdD|AAkAAAAAAAAA|4		0
62	Koh Yi Jie Zachary	SGP 4731				448	529	0	GSw/Kz9HOlFR|AAkAAAAAAAAA|128		0
63	Liao zhiting	SGP 3472				451	521	0	Niw8QEY7KkE/|AAkAAAAAAAAA|16		0
64	Rayson Lee Yin Yi	SGP 3828				454	538	0	RSwyVCkxRThM|AAkAAAAAAAAA|8		0
65	Raedon Tan	SGP 3010				457	560	0	P2cTPjNSNjlF|AAIAAAAJAAAA|2		0
66	Loh Yi Jie Luke	SGP 3322				477	557	0	OCxDPVBFRkYo|AAkAAAAAAAAA|16		0
67	Cheong Yi Tng, Tristan	SGP 4627				480	570	0	Miw7MC0/VlVa|AAkAAAAACQAJ|256		0
68	Charlene Yong Heng Ning	SGP 766				484	587	0	QSwtRmdPS1Aa|AAkAAAQAAAAA|16		0
69	Sripratak Natcha	THA 2009	F			488	567	0	TyxIT0EpODtI|AAkAAAAAAAAA|1		0
70	Yak Yun Zhong Joseph	SGP 4739	M			489	576	0	VywjSEc9PlI+|CQkAAAAAAAAA|1		0
71	Chen WangSun	MON 733				497	600	0	RCxFZ2EhImcx|AAkABwkAAAcA|8		0
72	Dani Sherif Ahmed Khalil	SGP 4457				510	594	0	TSxBNk9BMU1U|AAkAAAAAAAAA|256		0
73	Catherine Maiden	SGP 3191				516	598	0	MSxEUkJJP0lQ|AAkAAAAAAAAA|8		0
74	Darius Goh Yue Siang	SGP 3111				536	639	0	QyFnZ2c5Mz87|AAABAQEAAAAA|4		0
75	Gloria Kwok Yen Rui	SGP 2004				542	618	0	SixMRElIQEpJ|AAkAAAAAAAAA|4		0
76	Alessia Talpo	SGP 3105				545	648	0	SSxbKUtGSGdP|AAkJAAAAAAcA|128		0
77	Fong Luke Tin	SGP 2019				559	649	0	USxCQUBSVlpH|AAkAAAAJCQAA|128		0
78	Dylan WEE Yong Jun	SGP 4649				559	662	0	V2dOSUhLPEMv|CQgAAAAAAAAA|2		0
79	Kyle Jeremy Soh Zhi Jun	SGP 3183				567	654	0	PCw+TVdST05V|AAkAAAAJAAAA|16		0
80	TAN Wei Kai Jonathan	SGP 2016				575	678	0	Oiw6NTVnZ2dn|AAkAAAABAQEB|32		0
81	Kang Jie Long Emrys	SGP 737				575	662	0	VyxWSkpSTlM2|CQkAAAAJAAAA|1		0
82	Merelle Tay Xuan Ying	SGP 3511				583	671	0	SCxSTFhSUEVO|AAkAAAAJAAAA|16		0
83	Aiden Wong Kang Jun	SGP 90				587	690	0	SywvOjZnZ2dn|AAkAAAABAQEB|32		0
84	Kyan Tan Chun Hong	SGP 4712				595	698	0	VyxbXGdSVkwl|CQkJAAIJCQAA|16		0
85	Isla Lee Zhi Xi	SGP 457				595	698	0	V2dGUFRDTEs4|CQgAAAAAAAAA|2		0
86	ASHER LOW	SGP 4666				604	697	0	UyxQOVJSVl1a|AAkAAAAJCQkJ|128		0
87	Aden Santoz	SGP 3169				613	703	0	VyxNVVNaVkRT|CQkAAAAGCQAA|32		0
88	Wai Yong Le	SGP 3488				617	720	0	VyxRWlpSVmc5|CQkAAAAJCQIA|128		0
89	Cyrus Chiam	SGP 3343				617	704	0	VyxTUVVSVk9N|CQkAAAAJCQAA|1		0
90	Leyla Sherif Ahmed Khalil	SGP 177				620	716	0	TixXX11OSUhg|AAkACQAAAAAG|256		0
91	Lauren Lim	SGP 3507	F			624	727	0	UGdJR1FSVkBX|AAgAAAAJCQAA|2		0
92	Julian Lim	SGP 468				637	728	0	VCxPWFtSVlRa|AAkAAAAJCQAJ|16		0
93	Yeh Fang Yu Sage	SGP 796				641	731	0	VyxYV1ZSUVZa|CQkAAAAJAAAJ|256		0
94	Jamiroquai Tay Kai Nuo	SGP 2013				647	742	0	VyxbX15SVlhL|CQkJCQAJCQAA|8		0
95	Quintan Rupert Low	SGP 4681				655	758	0	V2dKU05SUldS|CQgAAAAJAAAA|2		0
96	Tang Chi Cheong Elliot	SGP 96				668	771	0	V2dVVkxEU11a|CQgAAAAAAAkJ|2		0
97	Auwin Leow Zhao Hong	SGP 340				679	782	0	V2dUW1xSVl1A|CQgAAAAJCQkA|2		0
98	Cory Loh Zhi Hang	SGP 3881				686	789	0	V2dbX1lSVkJa|CQgJCQAJCQAJ|2		0
99	XINRAN LIU	HKG 260	F			723	826	0	VyxbX2FnZ2dn|CQkJCQkBAQEB|32		0
100	Shin Lin Chen Rui	SGP 3333				732	835	0	RixnZ2dnZ2dn|AAkBAQEBAQEB|4		0
101	Qiheng Liu	HKG 236				824	927	1	Z2dnZ2dnZ2dn|AQEBAQEBAQEB|1		0
101	Khoo Boo Ming Manfred	SGP 3288	M			824	927	1	Z2dnZ2dnZ2dn|AQEBAQEBAQEB|1		0$sp23_3$),
(4,$sp23_4$1	Ethan Chia Han Wei	121	M			9.0	11.0	0	AgEBAQEBAgI=|AAAAAAAAAAA=|128		1
2	Sean Kum Kok Wei	142	M			53.0	77.0	0	AQYDGBAICgk=|AAAAAAAAAAA=|8		0
3	Cheryl Yong Heng Xi	744	F			59.0	133.0	0	BgRKBx0CBgU=|AAADAAAAAAA=|4		0
4	Nathaniel Cheung Lap Yan	156	M			63.0	101.0	0	BQINCiYSCQY=|AAAAAAAAAAA=|16		0
5	Desiree Lee	4698	F			64.0	90.0	0	GgwLCQUVAwM=|AAAAAAAAAAA=|1		0
6	Nigel Tan Xu Yuan	4693	M			66.0	102.0	0	CQsKDwQMBSQ=|AAAAAAAAAAA=|128		0
7	Mikaele Rae Ng	151	F			70.0	109.0	0	CgUnBRkDDwc=|AAAAAAAAAAA=|4		0
8	Ethan Lee	4416	M			78.0	97.0	0	CBMMEBIFBA8=|AAAAAAAAAAA=|2		0
9	Nicole Ashley Quek	108	F			78.0	97.0	0	Cw0GDg0TCwo=|AAAAAAAAAAA=|32		0
10	Josh Low	3179	M			79.0	111.0	0	IAgFFQkHDBE=|AAAAAAAAAAA=|1		0
11	Ashlea Tham	175	F			82.0	135.0	0	Bw8TAwY1FQs=|AAAAAAAAAAA=|32		0
12	Zeph Wan	122	M			87.0	119.0	0	DRgIEQgQIAE=|AAAAAAAAAAA=|64		0
13	Lucas Cao Zhihong	149	M			88.0	121.0	0	DgcCEhMYIQQ=|AAAAAAAAAAA=|64		0
14	Pee Teck Woon	3146	M			97.0	154.0	0	BBQEAjkRGBo=|AAAAAAAAAAA=|16		0
15	Nia Zahedi	4670	F			102.0	135.0	0	AxYPIQsJHgw=|AAAAAAAAAAA=|8		0
16	Damien Huang	3300	M			108.0	160.0	0	DAoQBiAKFjQ=|AAAAAAAAAAA=|128		0
17	Tan Herng Yee	3000	M			109.0	164.0	0	ER83BAINByM=|AAAAAAAAAAA=|4		0
18	Ashlyn Tham	4452	F			112.0	148.0	0	EwMJHREkCBs=|AAAAAAAAAAA=|32		0
19	Germaine Sim	3177	F			114.0	156.0	0	FQ4dKgcGERQ=|AAAAAAAAAAA=|8		0
20	Wai Zhi Tong	3458	F			145.0	190.0	0	KxIcCwMELSY=|AAAAAAAAAAA=|64		0
21	Tong Xuan Ya	4460	F			160.0	212.0	0	ECAHIzQsARk=|AAAAAAAAAAA=|16		0
22	Nathaniel Kaiden Ng	3344	M			162.0	210.0	0	EhkbEzAnFA4=|AAAAAAAAAAA=|16		0
23	Chen Huan Heng	4729	F			176.0	225.0	0	MRESFxYqKQ0=|AAAAAAAAAAA=|1		0
24	Joash Tan	3267	M			179.0	233.0	0	FC0XGhUZNhM=|AAAAAAAAAAA=|64		0
25	Alyssa Wong Li Lin	3396	F			180.0	226.0	0	Dy4ZDC0tDhg=|AAAAAAAAAAA=|2		0
26	Mika Tew	3535	F			190.0	251.0	0	GR0WGRs9Jxc=|AAAAAAAJAAA=|32		0
27	Anya Zahedi	4724	F			192.0	241.0	0	JhUgFDEXKhA=|AAAAAAAAAAA=|16		0
28	Yong Heng Yi	755	M			200.0	260.0	0	KTIePBgPEhY=|AAkAAAAAAAA=|8		0
29	Lyric Li Yuxuan	728	F			220.0	294.0	0	SkoODQwOE0o=|DQgAAAAAAAo=|128		1
30	Kevin Ho Jun Yi	3118	M			220.0	266.0	0	Lh4aFiMoIyA=|AAAAAAAAAAA=|1		0
31	Elliot Goh	3103	M			224.0	283.0	0	OzIYCCQzECc=|CQkAAAAAAAA=|1		0
32	Julien Christian	3102	M			225.0	275.0	0	GC8pGyIyIhI=|AAAAAAAAAAA=|32		0
33	Jared Liew Joon Kit	3198	M			229.0	285.0	0	LRAsNQ44Gx4=|AAAAAAAAAAA=|32		0
34	Kayden Tan Yi Kai	3104	M			242.0	288.0	0	JCgiLigLJis=|AAAAAAAAAAA=|8		0
35	Lyu Zixuan	9066	F			246.0	320.0	0	KBdKIEocHBU=|AAADAAoAAAA=|16		1
36	Jaye Low	3279	M			246.0	296.0	0	MhwfKzIWFzE=|AAAAAAAAAAA=|16		1
37	Jairus TEo	4073	M			257.0	315.0	0	KhsUKSodOjg=|AAAAAAAAAAk=|64		0
38	Elijah Ong En Ze	3950	M			261.0	317.0	0	OBohMSsaMyE=|AAAAAAAAAAA=|1		0
39	Dylan Goh Yue Teng	3800	M			265.0	320.0	0	NAkVIjU3KzU=|AAAAAAAAAAA=|32		0
40	Caleb Peck Rui Kai	3153	M			265.0	329.0	0	GzIoQAopLjM=|AAkAAAAAAAA=|8		0
41	Deklen Chew	3131	M			272.0	321.0	0	FioxMC4hJC0=|AAAAAAAAAAA=|4		0
42	Liu Sining	9077	F			273.0	333.0	0	IiMRLDwlOy8=|AAAAAAAAAAA=|16		0
43	Lim Yuk Jun	3377	M			275.0	327.0	0	HTItJx80KCk=|AAkAAAAAAAA=|32		0
44	Febe Wong Qi Ke	3003	F			277.0	339.0	0	FyslNz4jMiI=|AAAAAAAAAAA=|16		0
45	Riley Sullivan	21745	M			282.0	356.0	0	SiIqLTs9DRw=|AQAAAAAJAAA=|1		0
46	Kate Yeh Zi Ning	797	F			283.0	346.0	0	NjIyHiwvPwg=|AAkAAAAAAAA=|64		0
47	Zaid Mohamed Noodeen Bin Jaffar Sadik	3666	M			284.0	345.0	0	OyEkKBQ7PSU=|CQAAAAAAAAA=|64		0
48	Rupert Chang	5172	M			288.0	345.0	0	ITI5JDMbJTY=|AAkAAAAAAAA=|4		0
49	Pitsilis Amandien Zoe	702	F			293.0	354.0	0	MCU4Jhc9MSo=|AAAAAAAJAAA=|32		0
50	Travis Yeo Jia Le	4556	M			297.0	354.0	0	OSwzORwgHTg=|AAAAAAAAAAk=|8		1
51	Siti Ra Idah Mohd Airudin	3181	F			298.0	354.0	0	LCQ0MikfLDg=|AAAAAAAAAAk=|128		0
52	Ren Yinuo	3869	F			303.0	377.0	0	HiZKJUorGTg=|AAADAAoAAAk=|16		1
53	Cecilia Kong	715	F			307.0	370.0	0	Myk/HB4wNTg=|AAAAAAAAAAk=|4		0
54	Kaelyn Dayna Soh Zhi Yi	3113	F			328.0	402.0	0	JzImOEoURTg=|AAkAAAQAAAk=|16		0
55	Jade Yeh Zi Yu	798	F			332.0	393.0	0	OzI1HyU9NDI=|CQkAAAAJAAA=|32		0
56	Russell Xaivier Quek	3008	M			334.0	408.0	0	O0o7RCceMB8=|CQgAAAAAAAA=|2		0
57	John Raphael Lim	788	M			336.0	403.0	0	IzJBQw8xQjg=|AAkAAAAAAAk=|8		0
58	Zephyr Tan Wen	4717	M			339.0	405.0	0	JTIuQj89Gjg=|AAkAAAAJAAk=|8		0
59	Gaitan Sullivan	22154	M			342.0	416.0	0	SjBCNiEmLzg=|AQAAAAAAAAk=|1		0
60	Joshua Khoo Zhuo Xi	4728	M			344.0	418.0	0	O0orLy89Hzg=|CQgAAAAJAAk=|2		0
61	Charles Kong	716	M			345.0	419.0	0	HycjMzY9Sko=|AAAAAAAJAQE=|128		1
62	Gerome Sim	3188	M			356.0	425.0	0	LzIwRT0uPCw=|AAkAAAAAAAA=|8		0
63	Joash Kok Jit Yin	3057	M			383.0	457.0	0	NUovNDo9ODg=|AAgAAAAJAAk=|2		0
64	Misa Lim	774	F			385.0	449.0	0	NzI+OkA5OS4=|AAkAAAAAAAA=|16		0
65	Cheryl Ho Hai Yan	3117	F			390.0	464.0	0	SjI6PUE9Nyg=|BAkAAAAJAAA=|1		0
66	Li Xuanyi	8501	M			393.0	460.0	0	OzJDP0IiQTg=|CQkAAAAAAAk=|4		0
67	Caleb Cao Zhixuan	3193	M			395.0	469.0	0	O0o9Pho9Rjg=|CQgAAAAJAAk=|2		0
68	Mohamed Mikail Bin Mohamed Shahrom	704	M			400.0	474.0	0	O0o2Ozc9QDA=|CQgAAAAJAAA=|2		0
69	Aaron Abraham Say	4669	M			407.0	481.0	0	O0pAQUo2Ph0=|CQgAAAoAAAA=|16		1
70	Reyes Tan Jit Eng	4712	M			430.0	504.0	0	O0o8Rjg9RDg=|CQgAAAAJAAk=|2		0
71	Angela Huang Fei er	3175	F			462.0	536.0	0	O0pKSko6Qzg=|CQEBAQEAAAk=|16		1
72	Nicholette Lee Wee Wen	4725	F			472.0	546.0	0	HEpKSkpKSko=|AAEBAQEBAQE=|128		1
73	Yap Swee Wayne	3228	M			518.0	592.0	0	SkpKSkpKSko=|AQEBAQEBAQE=|128		1$sp23_4$),
(5,$sp23_5$1	Lim Yuk Pin	3880	M			36.0	100.0	0	BwMLCQMuEgM=|AAAAAAAAAAA=|96		0
2	Isaiah Yap Chor Hong	3946	M			37.0	109.0	0	JAQIJAQJBQc=|AAAAAAAAAAA=|9		0
3	Lucas Lim Rui Kai	3355	M			44.0	95.0	0	AQgGEwoICyA=|AAAAAAAAAAA=|136		0
4	Rahul Rajakanth	2006	M			49.0	113.0	0	DhsCEAglCAE=|AAAAAAAAAAA=|34		0
5	Lucien Gan Swee Iok	2007	M			49.0	103.0	0	CQEfDAkXEAI=|AAAAAAAAAAA=|36		0
6	Joel Tan Kai En	3223	M			50.0	130.0	0	BAUHDSgTAig=|AAAAAAAAAAA=|144		0
7	Sayawaki-Kogut Leopold	710	M			53.0	107.0	0	DRUFESEBAw4=|AAAAAAAAAAA=|18		0
8	Judy Zhang Sudjana	33	F			56.0	133.0	0	AgcBIC0CHw0=|AAAAAAAAAAA=|24		0
9	Ethan Low Zhi Ren	3855	M			71.0	193.0	0	HCIEBhULAVg=|AAAAAAAAAA0=|130		0
10	Olivia Cheong Ting Jia	102	F			71.0	158.0	0	FBYKCzIDJQU=|AAAAAAAAAAA=|80		0
11	Kate Bateman	117	F			78.0	138.0	0	EhgXCAIRCiQ=|AAAAAAAAAAA=|130		0
12	Darian Huang	3700	M			82.0	220.0	0	CxcDAVgoBDI=|AAAAAAMAAAA=|144		0
13	Jonathan Kwok Kum Loong	2003	M			83.0	146.0	0	FRoMCiUPFQQ=|AAAAAAAAAAA=|18		0
14	Martha Wazen	4689	F			90.0	157.0	0	JgYNHQcSGBY=|AAAAAAAAAAA=|9		0
15	Jeremiah Ong Rui Feng	3373	M			94.0	184.0	0	JREPAyczDgg=|AAAAAAAAAAA=|48		0
16	Mathias Cheow	3307	M			96.0	177.0	0	Bg0OGhk3ERU=|AAAAAAAAAAA=|40		0
17	Jude Nathan Wong	3495	M			97.0	233.0	0	BRAwLQwGDVg=|AAAAAAAAAAM=|132		0
18	Paolo Gagliard La Gala	2015	M			97.0	158.0	0	EAoVHx4cBhA=|AAAAAAAAAAA=|24		0
19	Darius Goh Yue Siang	3111	M			103.0	192.0	0	ESsqLgEEHgk=|AAAAAAAAAAA=|10		0
20	Edrei Ong En Xu	3957	M			104.0	197.0	0	Fgs2AhsWFCc=|AAAAAAAAAAA=|132		0
21	Zachary Low Zhi En	3369	M			107.0	186.0	0	GDUZGBIKGgY=|AAAAAAAAAAA=|66		0
22	Rachel Lim Qian Hui	3197	F			109.0	170.0	0	HgkaDxMNGx8=|AAAAAAAAAAA=|129		0
23	Akhshaya Santoz	2008	F			111.0	211.0	0	Dx4JFB0URhI=|AAAAAAAAAAA=|66		0
24	Joel Khoo Zhuo Le	4730	M			112.0	206.0	0	AxMTMg0sFyM=|AAAAAAAAAAA=|40		0
25	Jedd Lam Zhi Hao	2000	M			112.0	194.0	0	Lw8jBwUfHBo=|AAAAAAAAAAA=|5		0
26	Ryo Bateman	119	M			113.0	237.0	0	ChkkFlgYBxk=|AAAAAAMAAAA=|20		0
27	Janelle Tan Yi Han	3517	F			120.0	192.0	0	Hx0QDg4QIiY=|AAAAAAAAAAA=|192		0
28	Kayler Tan Li YIng	3787	F			130.0	236.0	0	IjoWGRgwDwo=|AAAAAAAAAAA=|34		0
29	Russell Tan Jun Quan	3172	M			131.0	213.0	0	Gx8YIRExDBQ=|AAAAAAAAAAA=|40		0
30	Shin Lin Chen Rui	3333	M			131.0	210.0	0	KiUbFQ8OIxM=|AAAAAAAAAAA=|3		0
31	Lavene Lim Rui Xuan	3553	F			132.0	219.0	0	FxweKxQHLBg=|AAAAAAAAAAA=|72		0
32	Liu Yunhao	2005	M			133.0	225.0	0	IyAyFyoMEww=|AAAAAAAAAAA=|20		0
33	Joel Ong Han Sheng	2014	M			139.0	260.0	0	ExQcWBodIRE=|AAAACAAAAAA=|72		0
34	Yeo Shixi	508	M			155.0	253.0	0	HS01KQsZJgs=|AAAAAAAAAAA=|6		0
35	Adriel Cheung Hei Yat	3611	M			158.0	248.0	0	MSEpGykVCRs=|AAAAAAAAAAA=|17		1
36	Charlene Yong Heng Ning	766	F			165.0	293.0	0	DA4sNCYFSzU=|AAAAAAAAAAA=|192		0
37	Tan Abram Kai-Ser	4705	M			167.0	247.0	0	ICQUHBYmHSo=|AAAAAAAAAAA=|160		0
38	Cory Loh Zhi Hang	3881	M			177.0	319.0	0	CDwdJ1I4Fhc=|AAAAAAkAAAA=|18		0
39	Chen Wang Sun	3454	M			178.0	264.0	0	IRIiIigaLiE=|AAAAAAAAAAA=|80		0
40	Kai Yen Yu	758	F			192.0	327.0	0	GQIvKFgiLS4=|AAAAAAMAAAA=|20		0
41	Spencer Isaac Quek	3108	M			209.0	310.0	0	GjMSJi8yKyU=|AAAAAAAAAAA=|34		0
42	Nicole Wong Jing Chen	3006	F			223.0	328.0	0	LiY5MB8bJC0=|AAAAAAAAAAA=|12		0
43	Kyle Jeremy Soh Zhi Jun	3183	M			224.0	338.0	0	KzY8BDQpKSs=|AAAAAAAAAAA=|6		0
44	Gene Sudjana	3217	M			236.0	362.0	0	ODgRRDonKBw=|AAAAAAAAAAA=|24		0
45	Hannah Tan Kai Ting	777	F			242.0	354.0	0	KDQmLzwjMCI=|AAAAAAAAAAA=|18		0
46	Lee Gentaro Noah	4471	M			245.0	368.0	0	MzIuBTE2RSw=|AAAAAAAAAAA=|96		0
47	Adien Wong Kang Jun	2018	M			245.0	368.0	0	OSlCLC4rKh0=|AAAJAAAAAAA=|5		0
48	Cordelia Elif Ames	4737	F			245.0	377.0	0	LSMrHlA0Myk=|AAAAAAAAAAA=|48		0
49	Jiang Peiru	4637	M			246.0	409.0	0	Jww4SzghMlg=|AAAACQAAAAM=|136		0
50	Alessia Talpo	3105	F			250.0	397.0	0	PD8rEiJGIE0=|AAkAAAAAAAA=|160		0
51	Cyrus Chiam Jing Yi	3343	M			261.0	381.0	0	NScxKj81GTk=|AAAAAAAAAAA=|144		0
52	Kye Tang	2002	M			262.0	384.0	0	LC8tNitENR4=|AAAAAAAAAAA=|40		0
53	Rayson Lee Yin Yi	3828	M			270.0	415.0	0	WDElMyA5LzY=|BAAAAAAAAAA=|33		0
54	Manfred Khoo Boo Ming	3288	M			276.0	413.0	0	OzchQ0Y+NA8=|AAAAAAAAAAA=|24		0
55	Luke Loh Yi Jie	3322	M			281.0	419.0	0	Mj0gSxc/Nj0=|AAAACQAAAAA=|40		0
56	Zachary Koh Yi Jie	4731	M			283.0	433.0	0	QD9CMQYkVEE=|AAkJAAAAAAA=|68		0
57	Joseph Yak Yun Zhong	4739	M			285.0	459.0	0	NjtYJSMqVjo=|AAALAAAACQA=|68		0
58	Neo Caleb	3199	M			296.0	435.0	0	RDBCNRwtRzg=|CQAJAAAAAAA=|65		0
59	Oisin Maiden	3141	M			299.0	455.0	0	NC4zPzcgRFg=|AAAAAAAAAAM=|192		0
60	Liao Zhi Ting	4556	M			300.0	442.0	0	Oig0I087OD8=|AAAAAAAAAAA=|144		0
61	Jeanette Tan Wan Wen	2017	F			305.0	445.0	0	Nz89QiweSjQ=|AAkAAAAAAAA=|72		0
62	Gloria Kwok Yen Rui	2004	F			307.0	436.0	0	Qj8/PhA8NzM=|AAkAAAAAAAA=|5		1
63	Worawit Jutakhiti	2025	M			320.0	449.0	0	MD8+ODAvO0I=|AAkAAAAAAAA=|130		0
64	Estelle Yeo	773	F			358.0	502.0	0	Pj89OUJMMUQ=|AAkAAAAAAAA=|160		0
65	Elliot Tang Chi Cheong	2020	M			361.0	526.0	0	RFhCQDNNJ0k=|CQQJAAAAAAA=|34		0
66	Catherine Maiden	3191	F			362.0	501.0	0	QT9CST1COjE=|AAkJAAAAAAA=|40		1
67	Sage Yeh Fang Yu	796	F			362.0	496.0	0	RD9CN0FAPDc=|CQkJAAAAAAA=|5		0
68	Isla Lee Zhi Xi	3303	F			366.0	509.0	0	RDk7PUdIOUA=|CQAAAAAAAAA=|48		0
69	Fong Luke Tin	2019	M			368.0	526.0	0	PyxCPERPT0M=|AAAJAAAAAAA=|96		0
70	Denzel Seah Yong Zhen	3925	M			368.0	507.0	0	RD9CRkU9Py8=|CQkJAAAAAAA=|24		0
71	Raedon Tan	3010	M			369.0	508.0	0	RD9COj5HPTs=|CQkJAAAAAAA=|33		0
72	Sven Ng	4733	M			379.0	540.0	0	RD86WDtFST4=|CQkAAwAAAAA=|72		0
73	Ouyang Hanyue	3173	M			389.0	542.0	0	RD9ARTVOSEs=|CQkAAAAAAAA=|160		0
74	Auwin Leow Zhao Hong	3408	M			389.0	533.0	0	RD9CSEg6QEY=|CQkJAAAAAAA=|24		0
75	Kyan Tan chun Hong	4712	M			389.0	551.0	0	RFhCO0BDQUo=|CQsJAAAAAAA=|130		0
76	Owen Fun Kaii Meng	3482	M			396.0	572.0	0	KVhYS0NBTUc=|AA0NCQAAAAA=|6		0
77	Emrys Kang Jie Long	74	M			397.0	561.0	0	RD9CWExKQjw=|CQkJCAAAAAA=|24		0
78	Timonthy Ng Kai Zhe	2023	M			399.0	561.0	0	RD8oS0pRUU8=|CQkACQAAAAA=|96		0
79	Aden Santoz	3169	M			411.0	587.0	0	RFhCRzZYTEw=|CQQJAAADAAA=|34		0
80	Matthew Chiam Qin Hao	3606	M			418.0	582.0	0	RD9CQVJSTk4=|CQkJAAkAAAA=|48		0
81	Jamiroquai Tay Kai Nuo	2013	M			419.0	595.0	0	WD9YWDlQPkU=|CAkLCAAAAAA=|12		1
82	Raymon Li	3737	M			421.0	597.0	0	WFhCS01LUDA=|CwsJCQAAAAA=|3		0
83	Helo Kaya Ames	4706	M			433.0	609.0	0	WCpCWE5TU1E=|DQAJCAAAAAA=|9		0
84	Wai Yong le	3488	M			433.0	605.0	0	WD9CS0tUUkg=|DQkJCQAAAAA=|33		0
85	Hagen Goh Yong Chang	600	M			447.0	623.0	0	WFhCWElJQ1A=|CAsJCAAAAAA=|10		1
86	Alisha Shireen Ali	3101	F			476.0	652.0	0	PT9YWFhYWFg=|AAkBAQEBAQE=|192		1
87	Zhang Chenrui	4562	M			528.0	704.0	0	WFhYWFhYWFg=|AQEBAQEBAQE=|192		1$sp23_5$),
(6,$sp23_6$1	AUSTIN Yeo Jia Yu	221062				11.0	11.0	0	AwYC|AAAA|0		0
2	Aurick Leow You Shun	214737				17.0	17.0	0	AggH|AAAA|0		0
3	Ian Goh	SGP 222713				19.0	19.0	0	BQML|AAAA|0	Row 3 R1 visually corrected from OCR 9 to official-table value 5; 5 + 3 + 11 = published 19.	0
4	Ikuto Mori	221687				30.0	30.0	0	DQ0E|AAAA|0		0
5	Lim YuTing Elisha	214808				31.0	31.0	0	CgsK|AAAA|0		0
6	Lukas Kiesselbach	221597				33.0	33.0	0	DwUN|AAAA|0		0
7	Eitan Oh	222743				39.0	39.0	0	CAcY|AAAA|0		0
8	Wong Wei Kai Zachary	221061				40.0	40.0	0	FgkJ|AAAA|0		0
9	Wong Li Xuan Mildred	SGP 223200				40.0	40.0	0	DAwQ|AAAA|0		0
10	Sarah Yong	214438				44.0	44.0	0	BAQk|AAAA|0		0
11	Jemimah Chang	138				44.0	44.0	0	BxMS|AAAA|0		0
12	Yap Swee Dean	214716				47.0	47.0	0	LAIB|AwAA|0		0
13	Danielle Lai	SGP 222257				48.0	48.0	0	DhER|AAAA|0		0
14	Jayden Khor	SGP 203110				49.0	49.0	0	HBID|AAAA|0		0
15	Caden Tan	213191				50.0	50.0	0	HQEU|AAAA|0		0
16	Fang Si Wei Hayley	221688				50.0	50.0	0	ARwV|AAAA|0		0
17	Wong Yu Da Mathias	SGP 222255				50.0	50.0	0	GhAI|AAAA|0		0
18	Ang Zhi Shan Jewel	193911				52.0	52.0	0	ER4F|AAAA|0		0
19	Gabi Oh	224461				53.0	53.0	0	EA8W|AAAA|0		0
20	Gordon Allan	221058				54.0	54.0	0	Cw4d|AAAA|0		0
21	Chloe Poh	37				59.0	59.0	0	FSAG|AAAA|0		0
22	Ethan Chia Han Wei	214789				59.0	59.0	0	CQoo|AAAA|0		0
23	Isaac Poon Weng-Yew	214841				64.0	64.0	0	Bhgi|AAAA|0		0
24	Simone Ng	219762				67.0	67.0	0	FxkT|AAAA|0		0
25	Elizabeth Victoria Say	214873				68.0	68.0	0	GB0P|AAAA|0		0
26	WONG KAI LUN	214779				69.0	69.0	0	IhcM|AAAA|0		0
27	Travis Yeo Jia Le	22106				77.0	77.0	0	EiQX|AAAA|0		0
28	Tristan Joseph Low	214797				82.0	82.0	0	ExYp|AAAA|0		0
29	Aaron Abraham Say	203846				82.0	82.0	0	HxoZ|AAAA|0		0
30	Josiah Tan Zhi En	1978				83.0	83.0	0	GRQm|AAAA|0		0
31	Eunice Tan Yi Ning	SGP 147875				86.0	86.0	0	JSMO|AAAA|0		0
32	Ong Yong Jun Josh	189662				89.0	89.0	0	GyIc|AAAA|0		0
33	Febe Wong Qi Ke	13				90.0	90.0	0	JBUh|AAAA|0		0
34	Samuel Tan Hsien Ern	223134				90.0	90.0	0	IRse|AAAA|0		0
35	Foo Yuei Jit	221686				93.0	93.0	0	FB8q|AAAA|0		0
36	Seah En Rui Cleo	204286				100.0	100.0	0	HiEl|AAAA|0		0
37	Cheong Ting Rui Magdalene	197857				104.0	104.0	0	KCUb|AAAA|0		0
38	Reyes Tan Jit Eng	214251				106.0	106.0	0	ICcj|AAAA|0		0
39	Darren Lai	SGP 222256				110.0	110.0	0	LCga|AgAA|0		0
40	Ethan Wong Yi Chen	221059				111.0	111.0	0	Jykf|AAAA|0		0
41	Sun Weichen	21915				112.0	112.0	0	Jiog|AAAA|0		0
42	Bu Ruigiao	214814				112.0	112.0	0	IyYn|AAAA|0		0
43	Lu Zixi	214813				130.0	130.0	0	LCsr|AQAA|0		0$sp23_6$);

create temp table _sp23_source_rows as
select payload.sheet_no, record.ordinality::integer as pos, split_part(record.line, E'\t', 1)::integer as final_rank, split_part(record.line, E'\t', 2) as source_name, nullif(split_part(record.line, E'\t', 3), '') as source_sail_number, nullif(split_part(record.line, E'\t', 4), '') as gender, nullif(split_part(record.line, E'\t', 5), '') as nationality, nullif(split_part(record.line, E'\t', 6), '')::integer as birth_year, split_part(record.line, E'\t', 7)::real as nett, split_part(record.line, E'\t', 8)::real as total, split_part(record.line, E'\t', 9) = '1' as is_dns, split_part(record.line, E'\t', 10) as race_payload, nullif(split_part(record.line, E'\t', 11), '') as source_extra_note, split_part(record.line, E'\t', 12) = '1' as discard_assignment_ambiguous
from _sp23_payloads payload cross join lateral regexp_split_to_table(payload.payload, E'\n') with ordinality as record(line, ordinality);

create temp table _sp23_rows as
select sh.slug as regatta_slug, src.pos, src.final_rank, src.source_name, src.source_sail_number, src.gender, src.nationality, src.birth_year, src.nett, src.total, src.is_dns,
  (select jsonb_agg(jsonb_build_object('raceNumber', race_number, 'score', get_byte(payload.scores, race_number - 1)::real, 'scoringCode', codes.code, 'discarded', ((payload.discard_mask >> (race_number - 1)) & 1) = 1, 'rawValue', case when codes.code is not null then get_byte(payload.scores, race_number - 1)::text || ' ' || codes.code when ((payload.discard_mask >> (race_number - 1)) & 1) = 1 then '(' || get_byte(payload.scores, race_number - 1)::text || ')' else get_byte(payload.scores, race_number - 1)::text end) order by race_number)
   from generate_series(1, sh.race_count) race_number cross join lateral (select decode(split_part(src.race_payload, '|', 1), 'base64') as scores, decode(split_part(src.race_payload, '|', 2), 'base64') as codes, split_part(src.race_payload, '|', 3)::integer as discard_mask) payload cross join lateral (select case get_byte(payload.codes, race_number - 1) when 1 then 'DNC' when 2 then 'DNF' when 3 then 'UFD' when 4 then 'DSQ' when 5 then 'DNE' when 6 then 'SCP' when 7 then 'RET' when 8 then 'DNS' when 9 then 'TLE' when 10 then 'BFD' when 11 then 'NSC' when 12 then 'OCS' when 13 then 'RTD' else null end as code) codes) as races,
  'Official Sailing Singapore archive; ' || sh.result_status || ' source; visually reviewed.' || coalesce(' ' || src.source_extra_note, '') || case when sh.slug like 'csc-optimist-%' then ' Source says Best ' || sh.nett_count || ' of 8 but does not mark discarded race cells; inferred by highest score(s), ties at cut line must be reviewed.' else '' end as source_note, src.discard_assignment_ambiguous
from _sp23_source_rows src join _sp23_sheets sh on sh.sheet_no = src.sheet_no;

create temp table _sp23_new_profiles (source_name text primary key, handle text unique not null, sail_number text not null, gender text);
insert into _sp23_new_profiles values
('Jeanette Tan Wan Wen','historical-2023-csc-optimist-silver-jeanette-tan-wan-wen-2017','2017','F'),
('Jiang Peiru','historical-2023-csc-optimist-silver-jiang-peiru-4637','4637','M'),
('Li Xuanyi','historical-2023-csc-optimist-gold-li-xuanyi-8501','8501','M'),
('Liu Sining','historical-2023-csc-optimist-gold-liu-sining-9077','9077','F'),
('Lyu Zixuan','historical-2023-csc-optimist-gold-lyu-zixuan-9066','9066','F'),
('Ren Yinuo','historical-2023-csc-optimist-gold-ren-yinuo-3869','3869','F');

do $$ declare existing_identity text; existing_handle text; begin
  select string_agg(new_profile.source_name, '; ' order by new_profile.source_name) into existing_identity
  from _sp23_new_profiles new_profile
  where exists (select 1 from public.sailors sailor where regexp_replace(trim(regexp_replace(lower(sailor.name), '[^a-z0-9]+', ' ', 'g')), '[[:space:]]+', ' ', 'g') = regexp_replace(trim(regexp_replace(lower(new_profile.source_name), '[^a-z0-9]+', ' ', 'g')), '[[:space:]]+', ' ', 'g'))
     or exists (select 1 from public.sailor_aliases alias where regexp_replace(trim(regexp_replace(lower(alias.alias_name), '[^a-z0-9]+', ' ', 'g')), '[[:space:]]+', ' ', 'g') = regexp_replace(trim(regexp_replace(lower(new_profile.source_name), '[^a-z0-9]+', ' ', 'g')), '[[:space:]]+', ' ', 'g'));
  if existing_identity is not null then raise exception '2023 import stopped: approved new profile already has an identity match: %', existing_identity; end if;
  select string_agg(new_profile.handle, '; ' order by new_profile.handle) into existing_handle from _sp23_new_profiles new_profile join public.sailors sailor on sailor.handle = new_profile.handle;
  if existing_handle is not null then raise exception '2023 import stopped: approved new profile handle already exists: %', existing_handle; end if;
end $$;

insert into public.sailors (name, handle, sail_number, club, gender, created_at, updated_at)
select source_name, handle, sail_number, 'N/A', gender, now(), now() from _sp23_new_profiles
on conflict (handle) do nothing;

create temp table _sp23_approved_aliases (source_name text primary key, target_name text not null);
insert into _sp23_approved_aliases values
('Aaron Abraham','Aaron Abraham Say'),
('Adien Wong Kang Jun','Aiden Wong Kang Jun'),
('Adriel Cheung Hei Yat','Cheung Hei Yat Adriel'),
('Amos Tham','Tham Wan Yew Amos'),
('Bu Ruigiao','Ruiqiao Bu'),
('Elliot Tang Chi Cheong','Tang Chi Cheong Elliot'),
('Emrys Kang Jie Long','Kang Jie Long Emrys'),
('Estelle Yeo Rui','Estelle Yeo Rui En'),
('Jade Yen Zi Ning','Jade Yeh Zi Yu'),
('Jared Liew Joon Kit','Jared Soon Kit Liew'),
('Jemimah Chang','Jemima Chang'),
('Joseph Yak Yun Zhong','Yak Yun Zhong Joseph'),
('Kate Bateman','Kate En Rui Bateman'),
('Kate Yen Zi Ning','Kate Yeh Zi Ning'),
('Kayler Tan Li YIng','Tan Li Ying Kayler'),
('Li Yuxuan Lyric','Lyric Li Yuxuan'),
('Mikaele Rae Ng','Mikaela Rae Ng'),
('Misa Lim','Misa Lim Laurie'),
('Pitsilis Amandien Zoe','Amandine Zoe Pitsilis'),
('Russell Xaivier Quek','Russell Xavier Quek'),
('Ryo Bateman','Ryo En Hua Bateman'),
('Sage Yeh Fang Yu','Yeh Fang Yu Sage'),
('Siti Ra''idah Biinte','Siti Raidah Binte Mohd Airudin'),
('Spencer Isaac','Spencer Quek'),
('Timonthy Ng Kai Zhe','Ng Kai Zhe Timothy'),
('Worawit Jutakhiti','Worawit Jutahkiti'),
('Zaid Mohamed Noodeen Bin Jaffar Sadik','Zaid Mohd Noordeen Bin Jaffar Sadik');

create temp table _sp23_approved_alias_targets as
select approved.source_name, approved.target_name, sailor.id as sailor_id
from _sp23_approved_aliases approved
join public.sailors sailor on regexp_replace(trim(regexp_replace(lower(sailor.name), '[^a-z0-9]+', ' ', 'g')), '[[:space:]]+', ' ', 'g') = regexp_replace(trim(regexp_replace(lower(approved.target_name), '[^a-z0-9]+', ' ', 'g')), '[[:space:]]+', ' ', 'g');

do $$ declare missing_targets text; duplicate_targets text; alias_conflicts text; begin
  select string_agg(approved.source_name || ' -> ' || approved.target_name, '; ' order by approved.source_name) into missing_targets
  from _sp23_approved_aliases approved left join _sp23_approved_alias_targets target using (source_name, target_name)
  where target.sailor_id is null;
  if missing_targets is not null then raise exception '2023 import stopped: approved alias target profile missing: %', missing_targets; end if;
  select string_agg(source_name || ' -> ' || target_name, '; ' order by source_name) into duplicate_targets
  from (select source_name, target_name from _sp23_approved_alias_targets group by source_name, target_name having count(*) <> 1) duplicate_target;
  if duplicate_targets is not null then raise exception '2023 import stopped: approved alias target profile is ambiguous: %', duplicate_targets; end if;
  select string_agg(target.source_name || ' is already owned by a different profile', '; ' order by target.source_name) into alias_conflicts
  from _sp23_approved_alias_targets target join public.sailor_aliases alias on alias.alias_name = target.source_name and alias.sailor_id <> target.sailor_id;
  if alias_conflicts is not null then raise exception '2023 import stopped: approved alias conflict: %', alias_conflicts; end if;
end $$;

insert into public.sailor_aliases (sailor_id, alias_name, created_at)
select sailor_id, source_name, now() from _sp23_approved_alias_targets
on conflict (alias_name) do nothing;

create temp table _sp23_identity as
select src.regatta_slug, src.pos, coalesce(array_agg(distinct candidate.sailor_id) filter (where candidate.sailor_id is not null), '{}'::uuid[]) as candidate_ids
from _sp23_rows src
left join lateral (
  select s.id as sailor_id from public.sailors s
  where regexp_replace(trim(regexp_replace(lower(s.name), '[^a-z0-9]+', ' ', 'g')), '[[:space:]]+', ' ', 'g') = regexp_replace(trim(regexp_replace(lower(src.source_name), '[^a-z0-9]+', ' ', 'g')), '[[:space:]]+', ' ', 'g')
  union
  select s.id as sailor_id from public.sailor_aliases a join public.sailors s on s.id = a.sailor_id
  where regexp_replace(trim(regexp_replace(lower(a.alias_name), '[^a-z0-9]+', ' ', 'g')), '[[:space:]]+', ' ', 'g') = regexp_replace(trim(regexp_replace(lower(src.source_name), '[^a-z0-9]+', ' ', 'g')), '[[:space:]]+', ' ', 'g')
) candidate on true
group by src.regatta_slug, src.pos;

do $$ declare unresolved text; duplicate_rows text; begin
  select string_agg(format('%s rank %s %s (%s exact profile matches)', r.regatta_slug, r.final_rank, r.source_name, cardinality(i.candidate_ids)), '; ' order by r.regatta_slug, r.final_rank)
    into unresolved from _sp23_rows r join _sp23_identity i using (regatta_slug, pos) where cardinality(i.candidate_ids) <> 1;
  if unresolved is not null then raise exception '2023 import stopped: resolve missing/ambiguous sailor profiles first: %', unresolved; end if;
  select string_agg(format('%s profile %s appears at ranks %s', d.regatta_slug, d.sailor_id, d.ranks), '; ' order by d.regatta_slug)
    into duplicate_rows from (select i.regatta_slug, i.candidate_ids[1] as sailor_id, string_agg(r.final_rank::text, ', ' order by r.final_rank) as ranks from _sp23_identity i join _sp23_rows r using (regatta_slug, pos) group by i.regatta_slug, i.candidate_ids[1] having count(*) > 1) d;
  if duplicate_rows is not null then raise exception '2023 import stopped: same profile matched multiple source rows in one fleet: %', duplicate_rows; end if;
end $$;

insert into public.regatta_results (sailor_id, entry_label, regatta_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, entry_sail_number, gender, nationality, birth_year, official_url, evidence_name, evidence_type, evidence_notes, verification_status, created_at, updated_at)
select i.candidate_ids[1], src.source_name, reg.id, src.final_rank, src.nett, src.total, src.is_dns, false, src.source_sail_number, src.gender, coalesce(src.nationality, sailor.nationality), coalesce(src.birth_year, extract(year from sailor.dob)::integer), sh.results_url, sh.source_name, 'link',
       src.source_note || case when src.discard_assignment_ambiguous then ' Discard race assignment is ambiguous at a tied cutoff; verify before publication.' else '' end,
       'pending_review', now(), now()
from _sp23_rows src join _sp23_identity i using (regatta_slug, pos) join public.sailors sailor on sailor.id = i.candidate_ids[1] join public.regattas reg on reg.slug = src.regatta_slug join _sp23_sheets sh on sh.slug = src.regatta_slug
on conflict (sailor_id, regatta_id) do update set entry_label = excluded.entry_label, rank = excluded.rank, nett_score = excluded.nett_score, total_score = excluded.total_score, is_dns = excluded.is_dns, is_overseas_commitment = excluded.is_overseas_commitment, entry_sail_number = excluded.entry_sail_number, gender = excluded.gender, nationality = excluded.nationality, birth_year = excluded.birth_year, official_url = excluded.official_url, evidence_name = excluded.evidence_name, evidence_type = excluded.evidence_type, evidence_notes = excluded.evidence_notes, verification_status = case when regatta_results.verification_status = 'verified' and regatta_results.rank = excluded.rank and regatta_results.nett_score is not distinct from excluded.nett_score and regatta_results.total_score is not distinct from excluded.total_score then 'verified' else 'pending_review' end, verified_at = case when regatta_results.verification_status = 'verified' and regatta_results.rank = excluded.rank and regatta_results.nett_score is not distinct from excluded.nett_score and regatta_results.total_score is not distinct from excluded.total_score then regatta_results.verified_at else null end, updated_at = now();

insert into public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
select result.id, (race.item->>'raceNumber')::integer, (race.item->>'score')::real, nullif(race.item->>'scoringCode', ''), (race.item->>'discarded')::boolean, race.item->>'rawValue', now(), now()
from _sp23_rows src join _sp23_identity i using (regatta_slug, pos) join public.regattas reg on reg.slug = src.regatta_slug join public.regatta_results result on result.regatta_id = reg.id and result.sailor_id = i.candidate_ids[1] cross join lateral jsonb_array_elements(src.races) as race(item)
on conflict (regatta_result_id, race_number) do update set score = excluded.score, scoring_code = excluded.scoring_code, discarded = excluded.discarded, raw_value = excluded.raw_value, updated_at = now();

insert into public.regatta_result_participants (regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at)
select result.id, i.candidate_ids[1], src.source_name, 1, 'solo', 'matched', true, now(), now()
from _sp23_rows src join _sp23_identity i using (regatta_slug, pos) join public.regattas reg on reg.slug = src.regatta_slug join public.regatta_results result on result.regatta_id = reg.id and result.sailor_id = i.candidate_ids[1]
on conflict (regatta_result_id, display_order) do update set sailor_id = excluded.sailor_id, source_name = excluded.source_name, role = excluded.role, match_status = excluded.match_status, ranking_credit = excluded.ranking_credit, updated_at = now();

-- User-approved policy: preserve each entry snapshot above, then update current profile numbers by latest official 2023 date within the matching class.
create temp table _sp23_latest_profile_sails as
select distinct on (i.candidate_ids[1], sh.boat_class) i.candidate_ids[1] as sailor_id, sh.boat_class, src.source_sail_number, sh.end_date, sh.start_date, src.pos
from _sp23_rows src join _sp23_identity i using (regatta_slug, pos) join _sp23_sheets sh on sh.slug = src.regatta_slug
where src.source_sail_number is not null
order by i.candidate_ids[1], sh.boat_class, sh.end_date desc, sh.start_date desc, src.pos asc;

update public.sailors sailor set sail_number = latest.source_sail_number, updated_at = now()
from _sp23_latest_profile_sails latest
where latest.sailor_id = sailor.id and latest.boat_class = 'Optimist' and sailor.sail_number is distinct from latest.source_sail_number;

update public.sailors sailor set sail_number_ilca4 = latest.source_sail_number, updated_at = now()
from _sp23_latest_profile_sails latest
where latest.sailor_id = sailor.id and latest.boat_class = 'ILCA 4' and sailor.sail_number_ilca4 is distinct from latest.source_sail_number;

do $$ declare bad_sheets text; begin
  select string_agg(format('%s: results %s/%s, races %s/%s, participants %s/%s', sh.slug, counts.results, sh.entries, counts.races, sh.entries * sh.race_count, counts.participants, sh.entries), '; ' order by sh.slug) into bad_sheets
  from _sp23_sheets sh left join lateral (select count(distinct result.id) as results, count(distinct race.id) as races, count(distinct participant.id) as participants from public.regattas reg left join public.regatta_results result on result.regatta_id = reg.id left join public.regatta_race_results race on race.regatta_result_id = result.id left join public.regatta_result_participants participant on participant.regatta_result_id = result.id where reg.slug = sh.slug) counts on true
  where counts.results <> sh.entries or counts.races <> sh.entries * sh.race_count or counts.participants <> sh.entries;
  if bad_sheets is not null then raise exception '2023 import post-check failed: %', bad_sheets; end if;
end $$;
