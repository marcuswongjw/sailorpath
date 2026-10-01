-- Load official race scores for the 5th CSC ILCA & 29er Opens, 22-23 February 2025.
-- ILCA 4: 67 entries, six races, best five count. ILCA 6: 23 entries, four races, all count.
-- A 100% name match is attached to the existing sailor. Sheet spellings that are the
-- same person with a stored middle name are attached too, and saved as an alias.
-- Names and sail numbers already on a profile are left unchanged.

drop table if exists public._csc_ilca_2025_load;

create table public._csc_ilca_2025_load (
  fleet text not null,
  pos integer not null,
  final_rank integer not null,
  sail text not null,
  pdf_name text not null,
  sex text not null,
  nett real not null,
  total real not null,
  races jsonb not null,
  sailor_id uuid
);

insert into public._csc_ilca_2025_load (
  fleet, pos, final_rank, sail, pdf_name, sex, nett, total, races, sailor_id
) values
('ILCA 4', 1, 1, '222713', 'Ian Goh', 'M', 7.0, 16.0, '[{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":9.0,"code":null,"discarded":true,"raw":"9"}]'::jsonb, 'd52d284f-c0d7-4a72-b86d-45c57b963c6c'),
('ILCA 4', 2, 2, '222257', 'Danielle Lai', 'F', 20.0, 30.0, '[{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":10.0,"code":null,"discarded":true,"raw":"10"}]'::jsonb, 'a95b6b0a-6c38-40b6-a0bc-2dcaa9bcb9e2'),
('ILCA 4', 3, 3, '221062', 'Austin Yeo Jia Yu', 'M', 20.0, 39.0, '[{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":19.0,"code":null,"discarded":true,"raw":"19"}]'::jsonb, 'd7ce117b-5c64-40ea-86bd-79a7a73bb833'),
('ILCA 4', 4, 4, '214438', 'Sarah Yong', 'F', 28.0, 36.0, '[{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":8.0,"code":null,"discarded":true,"raw":"8"},{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":1.0,"code":null,"discarded":false,"raw":"1"}]'::jsonb, '82ab4ba4-a693-4e7d-a9c5-6531752cea6e'),
('ILCA 4', 5, 5, '224717', 'Gabi Oh', 'F', 32.0, 42.0, '[{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":10.0,"code":null,"discarded":true,"raw":"10"},{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":8.0,"code":null,"discarded":false,"raw":"8"}]'::jsonb, 'ee4ffc51-2ad1-46fd-85d1-0d100676840f'),
('ILCA 4', 6, 6, '185202', 'NIgel Tan', 'M', 32.0, 48.0, '[{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":16.0,"code":null,"discarded":true,"raw":"16"}]'::jsonb, 'ca98c637-aebd-4f38-81c7-80345846c93a'),
('ILCA 4', 7, 7, '214737', 'Aurick Leow You Shun', 'M', 38.0, 106.0, '[{"score":68.0,"code":"BFD","discarded":true,"raw":"BFD,68"},{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":24.0,"code":null,"discarded":false,"raw":"24"},{"score":3.0,"code":null,"discarded":false,"raw":"3"}]'::jsonb, '85614793-d030-483c-9ce8-57f7edcc4add'),
('ILCA 4', 8, 8, '91', 'Ethan Chia', 'M', 41.0, 57.0, '[{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":16.0,"code":null,"discarded":true,"raw":"16"},{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":5.0,"code":null,"discarded":false,"raw":"5"}]'::jsonb, '156283b1-fac6-48ba-a530-bd5a78d77114'),
('ILCA 4', 9, 9, '222743', 'Eitan Oh', 'M', 43.0, 73.0, '[{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":30.0,"code":null,"discarded":true,"raw":"30"}]'::jsonb, '922e1135-5c83-45cc-81cd-69c7b5a5ee65'),
('ILCA 4', 10, 10, '221687', 'Ikuto Mori', 'M', 49.0, 83.0, '[{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":34.0,"code":null,"discarded":true,"raw":"34"}]'::jsonb, '61334a08-e796-43d7-aeb8-ac70f6bf6f30'),
('ILCA 4', 11, 11, '221061', 'Zachary Wong Wei Kai', 'M', 60.0, 81.0, '[{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":21.0,"code":null,"discarded":true,"raw":"21"}]'::jsonb, 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a'),
('ILCA 4', 12, 12, '223202', 'Misa Lim Laurie', 'F', 61.0, 92.0, '[{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":31.0,"code":null,"discarded":true,"raw":"31"},{"score":26.0,"code":null,"discarded":false,"raw":"26"}]'::jsonb, '3b802239-ec10-402e-8ced-5499c5a1ea57'),
('ILCA 4', 13, 13, '197833', 'Nicholette Lee', 'F', 66.0, 87.0, '[{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":21.0,"code":null,"discarded":true,"raw":"21"},{"score":2.0,"code":null,"discarded":false,"raw":"2"}]'::jsonb, '37d98dd9-3749-45ce-8195-c1b9cce74f60'),
('ILCA 4', 14, 14, '219762', 'Mika Tew', 'F', 77.0, 108.0, '[{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":31.0,"code":null,"discarded":true,"raw":"31"},{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":6.0,"code":null,"discarded":false,"raw":"6"}]'::jsonb, 'bf1de4cb-9dd4-426d-a9e1-a669f7e091d9'),
('ILCA 4', 15, 15, '224245', 'Nia Zahedi', 'F', 86.0, 154.0, '[{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":31.0,"code":null,"discarded":false,"raw":"31"},{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":68.0,"code":"UFD","discarded":true,"raw":"UFD,68"}]'::jsonb, '20af3d01-7d86-4111-bad1-0c2be026e039'),
('ILCA 4', 16, 16, '214636', 'Jemima Chang', 'F', 86.0, 131.0, '[{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":45.0,"code":null,"discarded":true,"raw":"45"}]'::jsonb, '1ba65410-fa86-472d-ad75-bc510bffd07b'),
('ILCA 4', 17, 17, '1978', 'Josiah Tan', 'M', 89.0, 130.0, '[{"score":23.0,"code":null,"discarded":false,"raw":"23"},{"score":41.0,"code":null,"discarded":true,"raw":"41"},{"score":24.0,"code":null,"discarded":false,"raw":"24"},{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":23.0,"code":null,"discarded":false,"raw":"23"}]'::jsonb, '2219526e-ea8e-481a-bc84-dab55afe9de8'),
('ILCA 4', 18, 18, '225226', 'Wai Zhi Tong', 'F', 90.0, 125.0, '[{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":25.0,"code":null,"discarded":false,"raw":"25"},{"score":32.0,"code":null,"discarded":false,"raw":"32"},{"score":35.0,"code":null,"discarded":true,"raw":"35"},{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":7.0,"code":null,"discarded":false,"raw":"7"}]'::jsonb, '903d2cf9-2099-4411-8cf0-e6074ac2c369'),
('ILCA 4', 19, 19, '223200', 'Mildred Wong', 'F', 94.0, 126.0, '[{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":27.0,"code":null,"discarded":false,"raw":"27"},{"score":23.0,"code":null,"discarded":false,"raw":"23"},{"score":32.0,"code":null,"discarded":true,"raw":"32"},{"score":13.0,"code":null,"discarded":false,"raw":"13"}]'::jsonb, '3cf3ef94-6f08-485b-86f0-6c1d46de7a02'),
('ILCA 4', 20, 20, '221686', 'Foo Yei Jit', 'M', 99.0, 131.0, '[{"score":27.0,"code":null,"discarded":false,"raw":"27"},{"score":26.0,"code":null,"discarded":false,"raw":"26"},{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":32.0,"code":null,"discarded":true,"raw":"32"}]'::jsonb, 'a02141fb-6d40-4a74-b577-653fae3f2c11'),
('ILCA 4', 21, 21, '214251', 'Reyes Tan Jit Eng', 'M', 101.0, 142.0, '[{"score":41.0,"code":null,"discarded":true,"raw":"41"},{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":38.0,"code":null,"discarded":false,"raw":"38"},{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":11.0,"code":null,"discarded":false,"raw":"11"}]'::jsonb, 'f268697a-ceb4-483a-8a53-9c5241f3f0cc'),
('ILCA 4', 22, 22, '197834', 'Cheryl Yong Heng Xi', 'F', 101.0, 130.0, '[{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":29.0,"code":null,"discarded":true,"raw":"29"},{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":25.0,"code":null,"discarded":false,"raw":"25"},{"score":20.0,"code":null,"discarded":false,"raw":"20"}]'::jsonb, null),
('ILCA 4', 23, 23, '225182', 'Lim Yuk Jun', 'M', 105.0, 140.0, '[{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":35.0,"code":null,"discarded":true,"raw":"35"},{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":32.0,"code":null,"discarded":false,"raw":"32"},{"score":26.0,"code":null,"discarded":false,"raw":"26"},{"score":17.0,"code":null,"discarded":false,"raw":"17"}]'::jsonb, '26414c39-ffe4-417d-aabc-a577d6355fd5'),
('ILCA 4', 24, 24, '203110', 'Jayden Khan', 'M', 105.0, 151.0, '[{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":23.0,"code":null,"discarded":false,"raw":"23"},{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":30.0,"code":null,"discarded":false,"raw":"30"},{"score":46.0,"code":null,"discarded":true,"raw":"46"}]'::jsonb, '1bfbc092-0325-4e8f-aa32-0eeeded7a7ae'),
('ILCA 4', 25, 25, '225221', 'Caleb Peck', 'M', 108.0, 147.0, '[{"score":24.0,"code":null,"discarded":false,"raw":"24"},{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":39.0,"code":null,"discarded":true,"raw":"39"},{"score":34.0,"code":null,"discarded":false,"raw":"34"},{"score":12.0,"code":null,"discarded":false,"raw":"12"}]'::jsonb, '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f'),
('ILCA 4', 26, 26, '2228', 'Febe Wong Qi Ke', 'F', 124.0, 167.0, '[{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":42.0,"code":null,"discarded":false,"raw":"42"},{"score":43.0,"code":null,"discarded":true,"raw":"43"},{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":31.0,"code":null,"discarded":false,"raw":"31"}]'::jsonb, '97297f2f-45a3-4a42-bb8b-7de07d9a5cde'),
('ILCA 4', 27, 27, '214848', 'Jonathan Ho Jian Yi', 'M', 124.0, 166.0, '[{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":24.0,"code":null,"discarded":false,"raw":"24"},{"score":25.0,"code":null,"discarded":false,"raw":"25"},{"score":34.0,"code":null,"discarded":false,"raw":"34"},{"score":42.0,"code":null,"discarded":true,"raw":"42"},{"score":24.0,"code":null,"discarded":false,"raw":"24"}]'::jsonb, 'dd2d0d83-4cb8-4ea5-bc90-59531d262be2'),
('ILCA 4', 28, 28, '219725', 'Amandine Zoe Pitsilis', 'F', 132.0, 178.0, '[{"score":46.0,"code":null,"discarded":true,"raw":"46"},{"score":43.0,"code":null,"discarded":false,"raw":"43"},{"score":36.0,"code":null,"discarded":false,"raw":"36"},{"score":31.0,"code":null,"discarded":false,"raw":"31"},{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":4.0,"code":null,"discarded":false,"raw":"4"}]'::jsonb, '328bdcaa-1773-4bb8-801d-c845c11f2667'),
('ILCA 4', 29, 29, '8', 'Mikaela Ng', 'F', 139.0, 174.0, '[{"score":26.0,"code":null,"discarded":false,"raw":"26"},{"score":34.0,"code":null,"discarded":false,"raw":"34"},{"score":26.0,"code":null,"discarded":false,"raw":"26"},{"score":33.0,"code":null,"discarded":false,"raw":"33"},{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":35.0,"code":null,"discarded":true,"raw":"35"}]'::jsonb, 'cf6ab6b5-6792-4493-b4ff-4dff86acd6df'),
('ILCA 4', 30, 30, '225175', 'Gaitan Sullivan', 'M', 144.0, 192.0, '[{"score":33.0,"code":null,"discarded":false,"raw":"33"},{"score":38.0,"code":null,"discarded":false,"raw":"38"},{"score":30.0,"code":null,"discarded":false,"raw":"30"},{"score":36.0,"code":null,"discarded":false,"raw":"36"},{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":48.0,"code":null,"discarded":true,"raw":"48"}]'::jsonb, 'ea9482d1-dd48-4140-b17e-da9affef197d'),
('ILCA 4', 31, 31, '214779', 'Wong Kai Lun', 'M', 145.0, 192.0, '[{"score":37.0,"code":null,"discarded":false,"raw":"37"},{"score":27.0,"code":null,"discarded":false,"raw":"27"},{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":45.0,"code":null,"discarded":false,"raw":"45"},{"score":47.0,"code":null,"discarded":true,"raw":"47"}]'::jsonb, '8203869d-2432-48ee-bd3e-0c591aeb9fdb'),
('ILCA 4', 32, 32, '224379', 'Cleo Seah En Rui', 'F', 149.0, 193.0, '[{"score":44.0,"code":null,"discarded":true,"raw":"44"},{"score":30.0,"code":null,"discarded":false,"raw":"30"},{"score":37.0,"code":null,"discarded":false,"raw":"37"},{"score":30.0,"code":null,"discarded":false,"raw":"30"},{"score":27.0,"code":null,"discarded":false,"raw":"27"},{"score":25.0,"code":null,"discarded":false,"raw":"25"}]'::jsonb, 'bee71ffd-0b62-4fda-af0a-5b931c110e57'),
('ILCA 4', 33, 33, '221628', 'Riley Sullivan', 'M', 151.0, 195.0, '[{"score":30.0,"code":null,"discarded":false,"raw":"30"},{"score":37.0,"code":null,"discarded":false,"raw":"37"},{"score":34.0,"code":null,"discarded":false,"raw":"34"},{"score":44.0,"code":null,"discarded":true,"raw":"44"},{"score":28.0,"code":null,"discarded":false,"raw":"28"},{"score":22.0,"code":null,"discarded":false,"raw":"22"}]'::jsonb, 'f1293134-c948-4eef-b57f-8e8851feab28'),
('ILCA 4', 34, 34, '214730', 'Bu Ruiqiao', 'M', 152.0, 207.0, '[{"score":45.0,"code":null,"discarded":false,"raw":"45"},{"score":36.0,"code":null,"discarded":false,"raw":"36"},{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":28.0,"code":null,"discarded":false,"raw":"28"},{"score":29.0,"code":null,"discarded":false,"raw":"29"},{"score":55.0,"code":null,"discarded":true,"raw":"55"}]'::jsonb, '75f10506-9163-486d-858a-27730adc0d47'),
('ILCA 4', 35, 35, '71', 'Sean Kum Kok Wei', 'M', 154.0, 200.0, '[{"score":42.0,"code":null,"discarded":false,"raw":"42"},{"score":46.0,"code":null,"discarded":true,"raw":"46"},{"score":39.0,"code":null,"discarded":false,"raw":"39"},{"score":25.0,"code":null,"discarded":false,"raw":"25"},{"score":33.0,"code":null,"discarded":false,"raw":"33"},{"score":15.0,"code":null,"discarded":false,"raw":"15"}]'::jsonb, 'e84ec5f5-02aa-4b5b-889a-edf1eefdbfbf'),
('ILCA 4', 36, 36, '88', 'Ashlea Tham', 'F', 162.0, 219.0, '[{"score":25.0,"code":null,"discarded":false,"raw":"25"},{"score":33.0,"code":null,"discarded":false,"raw":"33"},{"score":40.0,"code":null,"discarded":false,"raw":"40"},{"score":46.0,"code":null,"discarded":false,"raw":"46"},{"score":57.0,"code":null,"discarded":true,"raw":"57"},{"score":18.0,"code":null,"discarded":false,"raw":"18"}]'::jsonb, '90b36217-ca95-4a90-b8f3-a502537842ab'),
('ILCA 4', 37, 37, '223728', 'Travis Yeo Jia Le', 'M', 169.0, 211.0, '[{"score":32.0,"code":null,"discarded":false,"raw":"32"},{"score":42.0,"code":null,"discarded":true,"raw":"42"},{"score":23.0,"code":null,"discarded":false,"raw":"23"},{"score":37.0,"code":null,"discarded":false,"raw":"37"},{"score":39.0,"code":null,"discarded":false,"raw":"39"},{"score":38.0,"code":null,"discarded":false,"raw":"38"}]'::jsonb, 'a6bb6826-4786-4a05-8844-4b51f172e3aa'),
('ILCA 4', 38, 38, '185203', 'Darius Low Xian Rui', 'M', 170.0, 228.0, '[{"score":36.0,"code":null,"discarded":false,"raw":"36"},{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":35.0,"code":null,"discarded":false,"raw":"35"},{"score":40.0,"code":null,"discarded":false,"raw":"40"},{"score":38.0,"code":null,"discarded":false,"raw":"38"},{"score":58.0,"code":null,"discarded":true,"raw":"58"}]'::jsonb, '8ec46c01-1663-4341-9c77-40da9edfe4ce'),
('ILCA 4', 39, 39, '224664', 'Eunice Tan Yi Ning', 'F', 174.0, 242.0, '[{"score":68.0,"code":"BFD","discarded":true,"raw":"BFD,68"},{"score":29.0,"code":null,"discarded":false,"raw":"29"},{"score":43.0,"code":null,"discarded":false,"raw":"43"},{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":23.0,"code":null,"discarded":false,"raw":"23"},{"score":57.0,"code":null,"discarded":false,"raw":"57"}]'::jsonb, 'd7452539-48a3-4903-8a1d-f031ebe2a5e6'),
('ILCA 4', 40, 40, '217112', 'Desiree Lee', 'F', 180.0, 235.0, '[{"score":34.0,"code":null,"discarded":false,"raw":"34"},{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":53.0,"code":null,"discarded":false,"raw":"53"},{"score":55.0,"code":null,"discarded":true,"raw":"55"},{"score":50.0,"code":null,"discarded":false,"raw":"50"},{"score":29.0,"code":null,"discarded":false,"raw":"29"}]'::jsonb, '7a1b19c2-78a8-414c-8acf-a6dc6f7fb617'),
('ILCA 4', 41, 41, '1', 'Adrien Picquenard', 'M', 180.0, 230.0, '[{"score":28.0,"code":null,"discarded":false,"raw":"28"},{"score":39.0,"code":null,"discarded":false,"raw":"39"},{"score":38.0,"code":null,"discarded":false,"raw":"38"},{"score":26.0,"code":null,"discarded":false,"raw":"26"},{"score":49.0,"code":null,"discarded":false,"raw":"49"},{"score":50.0,"code":null,"discarded":true,"raw":"50"}]'::jsonb, '3a7d8f32-6749-4129-84ba-d88c865eda9b'),
('ILCA 4', 42, 42, '21424', 'Joash Tan', 'M', 182.0, 236.0, '[{"score":29.0,"code":null,"discarded":false,"raw":"29"},{"score":28.0,"code":null,"discarded":false,"raw":"28"},{"score":47.0,"code":null,"discarded":false,"raw":"47"},{"score":54.0,"code":null,"discarded":true,"raw":"54"},{"score":36.0,"code":null,"discarded":false,"raw":"36"},{"score":42.0,"code":null,"discarded":false,"raw":"42"}]'::jsonb, '5b7d75f5-3786-41de-81a1-76bbba1869e9'),
('ILCA 4', 43, 43, '222256', 'Darren Lai', 'M', 184.0, 240.0, '[{"score":50.0,"code":null,"discarded":false,"raw":"50"},{"score":45.0,"code":null,"discarded":false,"raw":"45"},{"score":28.0,"code":null,"discarded":false,"raw":"28"},{"score":24.0,"code":null,"discarded":false,"raw":"24"},{"score":37.0,"code":null,"discarded":false,"raw":"37"},{"score":56.0,"code":null,"discarded":true,"raw":"56"}]'::jsonb, '8065d18f-d94f-4961-b18f-d126676ce052'),
('ILCA 4', 44, 44, '217034', 'Josh Ong Yong Jun', 'M', 193.0, 244.0, '[{"score":39.0,"code":null,"discarded":false,"raw":"39"},{"score":51.0,"code":null,"discarded":true,"raw":"51"},{"score":41.0,"code":null,"discarded":false,"raw":"41"},{"score":27.0,"code":null,"discarded":false,"raw":"27"},{"score":46.0,"code":null,"discarded":false,"raw":"46"},{"score":40.0,"code":null,"discarded":false,"raw":"40"}]'::jsonb, '607e25ec-a16d-47e7-9782-8cc5406fdd93'),
('ILCA 4', 45, 45, '221063', 'Regis Wong', 'M', 195.0, 248.0, '[{"score":47.0,"code":null,"discarded":false,"raw":"47"},{"score":53.0,"code":null,"discarded":true,"raw":"53"},{"score":33.0,"code":null,"discarded":false,"raw":"33"},{"score":29.0,"code":null,"discarded":false,"raw":"29"},{"score":43.0,"code":null,"discarded":false,"raw":"43"},{"score":43.0,"code":null,"discarded":false,"raw":"43"}]'::jsonb, 'e1f64962-8765-419f-9e47-5f9e92624ae6'),
('ILCA 4', 46, 46, '18539', 'Yong Heng Yi', 'M', 200.0, 256.0, '[{"score":38.0,"code":null,"discarded":false,"raw":"38"},{"score":56.0,"code":null,"discarded":true,"raw":"56"},{"score":45.0,"code":null,"discarded":false,"raw":"45"},{"score":49.0,"code":null,"discarded":false,"raw":"49"},{"score":54.0,"code":null,"discarded":false,"raw":"54"},{"score":14.0,"code":null,"discarded":false,"raw":"14"}]'::jsonb, '6d0f89fb-9212-4992-bb80-7f5e79b6804b'),
('ILCA 4', 47, 47, '206799', 'John Raphael Lim', 'M', 215.0, 276.0, '[{"score":31.0,"code":null,"discarded":false,"raw":"31"},{"score":48.0,"code":null,"discarded":false,"raw":"48"},{"score":51.0,"code":null,"discarded":false,"raw":"51"},{"score":48.0,"code":null,"discarded":false,"raw":"48"},{"score":61.0,"code":null,"discarded":true,"raw":"61"},{"score":37.0,"code":null,"discarded":false,"raw":"37"}]'::jsonb, '6bc22d30-b06a-4e64-86a9-f4cb99535f33'),
('ILCA 4', 48, 48, '197857', 'Magdalene Cheong', 'F', 220.0, 275.0, '[{"score":51.0,"code":null,"discarded":false,"raw":"51"},{"score":55.0,"code":null,"discarded":true,"raw":"55"},{"score":46.0,"code":null,"discarded":false,"raw":"46"},{"score":47.0,"code":null,"discarded":false,"raw":"47"},{"score":40.0,"code":null,"discarded":false,"raw":"40"},{"score":36.0,"code":null,"discarded":false,"raw":"36"}]'::jsonb, 'eda0daf0-7469-4a87-9015-3abaf54c5f6e'),
('ILCA 4', 49, 49, '209042', 'Nicholas Ng Jiang en', 'M', 230.0, 298.0, '[{"score":68.0,"code":"RTD","discarded":true,"raw":"RTD,68"},{"score":44.0,"code":null,"discarded":false,"raw":"44"},{"score":49.0,"code":null,"discarded":false,"raw":"49"},{"score":51.0,"code":null,"discarded":false,"raw":"51"},{"score":58.0,"code":null,"discarded":false,"raw":"58"},{"score":28.0,"code":null,"discarded":false,"raw":"28"}]'::jsonb, '52b4742c-b3f5-4667-8e44-fabd5c0a9fae'),
('ILCA 4', 50, 50, '214760', 'Liao Zhi Ting', 'M', 235.0, 294.0, '[{"score":48.0,"code":null,"discarded":false,"raw":"48"},{"score":49.0,"code":null,"discarded":false,"raw":"49"},{"score":59.0,"code":null,"discarded":true,"raw":"59"},{"score":53.0,"code":null,"discarded":false,"raw":"53"},{"score":52.0,"code":null,"discarded":false,"raw":"52"},{"score":33.0,"code":null,"discarded":false,"raw":"33"}]'::jsonb, 'f9138c57-b669-4793-bb7e-0532eb4ad7b3'),
('ILCA 4', 51, 51, '225207', 'Caleb Cao Zhixuan', 'M', 237.0, 298.0, '[{"score":43.0,"code":null,"discarded":false,"raw":"43"},{"score":32.0,"code":null,"discarded":false,"raw":"32"},{"score":57.0,"code":null,"discarded":false,"raw":"57"},{"score":52.0,"code":null,"discarded":false,"raw":"52"},{"score":53.0,"code":null,"discarded":false,"raw":"53"},{"score":61.0,"code":null,"discarded":true,"raw":"61"}]'::jsonb, '1308ee47-a24a-4248-8040-427a48391187'),
('ILCA 4', 52, 52, '204286', 'Jayden Bai Zi Xi', 'M', 240.0, 299.0, '[{"score":52.0,"code":null,"discarded":false,"raw":"52"},{"score":54.0,"code":null,"discarded":false,"raw":"54"},{"score":48.0,"code":null,"discarded":false,"raw":"48"},{"score":42.0,"code":null,"discarded":false,"raw":"42"},{"score":44.0,"code":null,"discarded":false,"raw":"44"},{"score":59.0,"code":null,"discarded":true,"raw":"59"}]'::jsonb, '8395d6a8-d7fe-4024-ad7e-d3ef7fda1cca'),
('ILCA 4', 53, 53, '70', 'Zeph Wan', 'M', 242.0, 302.0, '[{"score":35.0,"code":null,"discarded":false,"raw":"35"},{"score":50.0,"code":null,"discarded":false,"raw":"50"},{"score":60.0,"code":null,"discarded":false,"raw":"60"},{"score":58.0,"code":null,"discarded":false,"raw":"58"},{"score":60.0,"code":null,"discarded":true,"raw":"60"},{"score":39.0,"code":null,"discarded":false,"raw":"39"}]'::jsonb, 'e178e8d4-02b8-470f-9235-4a451f5eb31a'),
('ILCA 4', 54, 54, '216431', 'Lauren Lim', 'F', 243.0, 302.0, '[{"score":57.0,"code":null,"discarded":false,"raw":"57"},{"score":40.0,"code":null,"discarded":false,"raw":"40"},{"score":52.0,"code":null,"discarded":false,"raw":"52"},{"score":41.0,"code":null,"discarded":false,"raw":"41"},{"score":59.0,"code":null,"discarded":true,"raw":"59"},{"score":53.0,"code":null,"discarded":false,"raw":"53"}]'::jsonb, '96ee16c3-fbca-4a89-858d-80d73cf078c6'),
('ILCA 4', 55, 55, '203846', 'Aaron Say', 'M', 249.0, 317.0, '[{"score":49.0,"code":null,"discarded":false,"raw":"49"},{"score":52.0,"code":null,"discarded":false,"raw":"52"},{"score":54.0,"code":null,"discarded":false,"raw":"54"},{"score":59.0,"code":null,"discarded":false,"raw":"59"},{"score":35.0,"code":null,"discarded":false,"raw":"35"},{"score":68.0,"code":"UFD","discarded":true,"raw":"UFD,68"}]'::jsonb, '4e344e28-9a6f-4ae4-93d8-537bc03e1813'),
('ILCA 4', 56, 56, '214866', 'Gan Ha Joon', 'M', 256.0, 320.0, '[{"score":58.0,"code":null,"discarded":false,"raw":"58"},{"score":57.0,"code":null,"discarded":false,"raw":"57"},{"score":44.0,"code":null,"discarded":false,"raw":"44"},{"score":45.0,"code":null,"discarded":false,"raw":"45"},{"score":64.0,"code":null,"discarded":true,"raw":"64"},{"score":52.0,"code":null,"discarded":false,"raw":"52"}]'::jsonb, '4c2bb410-36c0-4c67-8211-49ed5e3c1b7c'),
('ILCA 4', 57, 57, '4819', 'Gemma Chen Huan Heng', 'F', 258.0, 320.0, '[{"score":53.0,"code":null,"discarded":false,"raw":"53"},{"score":61.0,"code":null,"discarded":false,"raw":"61"},{"score":56.0,"code":null,"discarded":false,"raw":"56"},{"score":61.0,"code":null,"discarded":false,"raw":"61"},{"score":62.0,"code":null,"discarded":true,"raw":"62"},{"score":27.0,"code":null,"discarded":false,"raw":"27"}]'::jsonb, '688cc8ae-873e-40a3-9bc4-7d05a496994a'),
('ILCA 4', 58, 58, '197840', 'Jonas Tan', 'M', 260.0, 328.0, '[{"score":40.0,"code":null,"discarded":false,"raw":"40"},{"score":47.0,"code":null,"discarded":false,"raw":"47"},{"score":61.0,"code":null,"discarded":false,"raw":"61"},{"score":57.0,"code":null,"discarded":false,"raw":"57"},{"score":55.0,"code":null,"discarded":false,"raw":"55"},{"score":68.0,"code":"UFD","discarded":true,"raw":"UFD,68"}]'::jsonb, 'eb832e1f-2644-4453-9089-1598544bf217'),
('ILCA 4', 59, 59, '193911', 'Noel Ng Jiang Wen', 'M', 265.0, 330.0, '[{"score":56.0,"code":null,"discarded":false,"raw":"56"},{"score":59.0,"code":null,"discarded":false,"raw":"59"},{"score":58.0,"code":null,"discarded":false,"raw":"58"},{"score":65.0,"code":null,"discarded":true,"raw":"65"},{"score":41.0,"code":null,"discarded":false,"raw":"41"},{"score":51.0,"code":null,"discarded":false,"raw":"51"}]'::jsonb, 'e69d73b0-e640-4fc3-a143-f83ab7d11030'),
('ILCA 4', 60, 60, 'PHI 2', 'RoahnneRoy T Santos', 'M', 269.0, 332.0, '[{"score":61.0,"code":null,"discarded":false,"raw":"61"},{"score":63.0,"code":null,"discarded":true,"raw":"63"},{"score":50.0,"code":null,"discarded":false,"raw":"50"},{"score":50.0,"code":null,"discarded":false,"raw":"50"},{"score":48.0,"code":null,"discarded":false,"raw":"48"},{"score":60.0,"code":null,"discarded":false,"raw":"60"}]'::jsonb, 'a5b6a7b9-622e-45c2-9051-d81b22fec7f2'),
('ILCA 4', 61, 61, '217060', 'Rayson Lee Yin Yi', 'M', 270.0, 329.0, '[{"score":59.0,"code":null,"discarded":true,"raw":"59"},{"score":58.0,"code":null,"discarded":false,"raw":"58"},{"score":55.0,"code":null,"discarded":false,"raw":"55"},{"score":56.0,"code":null,"discarded":false,"raw":"56"},{"score":47.0,"code":null,"discarded":false,"raw":"47"},{"score":54.0,"code":null,"discarded":false,"raw":"54"}]'::jsonb, '9ab9e8c2-896a-4d8f-8049-0878e7d210ba'),
('ILCA 4', 62, 62, '213191', 'Angela Huang Feier', 'F', 281.0, 349.0, '[{"score":68.0,"code":"RTD","discarded":true,"raw":"RTD,68"},{"score":62.0,"code":null,"discarded":false,"raw":"62"},{"score":62.0,"code":null,"discarded":false,"raw":"62"},{"score":60.0,"code":null,"discarded":false,"raw":"60"},{"score":56.0,"code":null,"discarded":false,"raw":"56"},{"score":41.0,"code":null,"discarded":false,"raw":"41"}]'::jsonb, '2a4918d1-c3a5-4092-bfe5-0567f2c011cd'),
('ILCA 4', 63, 63, '14', 'Jade Yeh', 'F', 285.0, 349.0, '[{"score":60.0,"code":null,"discarded":false,"raw":"60"},{"score":64.0,"code":null,"discarded":true,"raw":"64"},{"score":63.0,"code":null,"discarded":false,"raw":"63"},{"score":62.0,"code":null,"discarded":false,"raw":"62"},{"score":51.0,"code":null,"discarded":false,"raw":"51"},{"score":49.0,"code":null,"discarded":false,"raw":"49"}]'::jsonb, 'b644dd47-331b-4452-be98-e4b8815c4186'),
('ILCA 4', 64, 64, '81', 'Lucien Gan Swee Iok', 'M', 287.0, 352.0, '[{"score":55.0,"code":null,"discarded":false,"raw":"55"},{"score":60.0,"code":null,"discarded":false,"raw":"60"},{"score":64.0,"code":null,"discarded":false,"raw":"64"},{"score":64.0,"code":null,"discarded":false,"raw":"64"},{"score":65.0,"code":null,"discarded":true,"raw":"65"},{"score":44.0,"code":null,"discarded":false,"raw":"44"}]'::jsonb, 'c269a5f9-6b34-4ed7-a5bd-b1d956d357aa'),
('ILCA 4', 65, 65, '217035', 'Qi Shan', 'F', 310.0, 378.0, '[{"score":54.0,"code":null,"discarded":false,"raw":"54"},{"score":65.0,"code":null,"discarded":false,"raw":"65"},{"score":65.0,"code":null,"discarded":false,"raw":"65"},{"score":63.0,"code":null,"discarded":false,"raw":"63"},{"score":63.0,"code":null,"discarded":false,"raw":"63"},{"score":68.0,"code":"RTD","discarded":true,"raw":"RTD,68"}]'::jsonb, '1a7d2b71-08c8-4ff7-88ea-de5b56a90c65'),
('ILCA 4', 66, 66, '222437', 'Tiago Cheng De Villemor Salgado', 'M', 340.0, 408.0, '[{"score":68.0,"code":"DNC","discarded":false,"raw":"DNC,68"},{"score":68.0,"code":"DNC","discarded":false,"raw":"DNC,68"},{"score":68.0,"code":"DNC","discarded":false,"raw":"DNC,68"},{"score":68.0,"code":"DNC","discarded":false,"raw":"DNC,68"},{"score":68.0,"code":"DNC","discarded":false,"raw":"DNC,68"},{"score":68.0,"code":"DNC","discarded":true,"raw":"DNC,68"}]'::jsonb, 'ad785bc0-da18-41e2-aa35-f8d90af36153'),
('ILCA 4', 67, 66, '221597', 'Lukas Kiesselbach', 'M', 340.0, 408.0, '[{"score":68.0,"code":"DNC","discarded":false,"raw":"DNC,68"},{"score":68.0,"code":"DNC","discarded":false,"raw":"DNC,68"},{"score":68.0,"code":"DNC","discarded":false,"raw":"DNC,68"},{"score":68.0,"code":"DNC","discarded":false,"raw":"DNC,68"},{"score":68.0,"code":"DNC","discarded":false,"raw":"DNC,68"},{"score":68.0,"code":"DNC","discarded":true,"raw":"DNC,68"}]'::jsonb, 'e164bdfd-0bbc-46fd-8f2b-46570366aacf'),
('ILCA 6', 1, 1, '185201', 'Kenan Tan Kee Zen', 'M', 4.0, 4.0, '[{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":1.0,"code":null,"discarded":false,"raw":"1"},{"score":1.0,"code":null,"discarded":false,"raw":"1"}]'::jsonb, '7baafbd0-cddb-4217-9727-a692f6902b79'),
('ILCA 6', 2, 2, '222727', 'Jania Ang', 'F', 8.0, 8.0, '[{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":2.0,"code":null,"discarded":false,"raw":"2"},{"score":2.0,"code":null,"discarded":false,"raw":"2"}]'::jsonb, 'ddfe8d27-5c27-4cc6-b7b3-5c5d89564914'),
('ILCA 6', 3, 3, '214237', 'Abigail Koh', 'F', 19.0, 19.0, '[{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":5.0,"code":null,"discarded":false,"raw":"5"}]'::jsonb, null),
('ILCA 6', 4, 4, '158031', 'Justiin Ang', 'M', 27.0, 27.0, '[{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":9.0,"code":null,"discarded":false,"raw":"9"}]'::jsonb, 'ee13d1f0-bbd2-4c2b-9f95-ceff48c978e2'),
('ILCA 6', 5, 5, '221931', 'Caio Sullivan', 'M', 29.0, 29.0, '[{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":3.0,"code":null,"discarded":false,"raw":"3"},{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":3.0,"code":null,"discarded":false,"raw":"3"}]'::jsonb, null),
('ILCA 6', 6, 6, '212216', 'Keira Marie Carlyle', 'F', 32.0, 32.0, '[{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":6.0,"code":null,"discarded":false,"raw":"6"}]'::jsonb, 'be779040-d45c-4052-b458-9c9e88803505'),
('ILCA 6', 7, 7, '214808', 'Elisha Lim Yu Ting', 'F', 33.0, 33.0, '[{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":11.0,"code":null,"discarded":false,"raw":"11"}]'::jsonb, null),
('ILCA 6', 8, 8, '223201', 'Maia Lim Laurie', 'F', 35.0, 35.0, '[{"score":10.0,"code":null,"discarded":false,"raw":"10"},{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":7.0,"code":null,"discarded":false,"raw":"7"}]'::jsonb, '7f41f48a-efed-41aa-a914-07d6a29ab919'),
('ILCA 6', 9, 9, '219162', 'Sarah Seow Hui Yan', 'F', 37.0, 37.0, '[{"score":5.0,"code":null,"discarded":false,"raw":"5"},{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":16.0,"code":null,"discarded":false,"raw":"16"}]'::jsonb, null),
('ILCA 6', 10, 10, '221058', 'Gordon Allan', 'M', 38.0, 38.0, '[{"score":24.0,"code":"DNC","discarded":false,"raw":"DNC,24"},{"score":6.0,"code":null,"discarded":false,"raw":"6"},{"score":4.0,"code":null,"discarded":false,"raw":"4"},{"score":4.0,"code":null,"discarded":false,"raw":"4"}]'::jsonb, '97828399-4ff6-40c1-8deb-6b308b6072ad'),
('ILCA 6', 11, 11, '222255', 'Mahias Wong', 'M', 44.0, 44.0, '[{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":10.0,"code":null,"discarded":false,"raw":"10"}]'::jsonb, null),
('ILCA 6', 12, 12, '221934', 'Sam Tan-Hardy', 'M', 48.0, 48.0, '[{"score":7.0,"code":null,"discarded":false,"raw":"7"},{"score":9.0,"code":null,"discarded":false,"raw":"9"},{"score":8.0,"code":null,"discarded":false,"raw":"8"},{"score":24.0,"code":"RTD","discarded":false,"raw":"RTD,24"}]'::jsonb, null),
('ILCA 6', 13, 13, '225262', 'John Gabriel Lim', 'M', 51.0, 51.0, '[{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":8.0,"code":null,"discarded":false,"raw":"8"}]'::jsonb, '3143b0a2-ba21-46fd-9576-6fe6560f6a07'),
('ILCA 6', 14, 14, '214240', 'Clive Seah Wei Jun', 'M', 55.0, 55.0, '[{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":13.0,"code":null,"discarded":false,"raw":"13"}]'::jsonb, '9feccee3-556f-494a-bb80-593be88884cc'),
('ILCA 6', 15, 15, '223148', 'Zachary Zhang Hong Yi', 'F', 57.0, 57.0, '[{"score":12.0,"code":null,"discarded":false,"raw":"12"},{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":12.0,"code":null,"discarded":false,"raw":"12"}]'::jsonb, 'a841f654-dcfd-44ca-9546-a31595385ee0'),
('ILCA 6', 16, 16, '2179', 'Abigail Ling', 'F', 61.0, 61.0, '[{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":14.0,"code":null,"discarded":false,"raw":"14"}]'::jsonb, '659d2fab-d7dc-409c-8c87-22379c586910'),
('ILCA 6', 17, 17, '214873', 'Elizabeth Victoria Say', 'F', 68.0, 68.0, '[{"score":11.0,"code":null,"discarded":false,"raw":"11"},{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":18.0,"code":null,"discarded":false,"raw":"18"},{"score":17.0,"code":null,"discarded":false,"raw":"17"}]'::jsonb, '1873b5fc-0682-4bfc-b02b-9e453e49f384'),
('ILCA 6', 18, 18, '121113', 'Lucas Quek', 'M', 71.0, 71.0, '[{"score":13.0,"code":null,"discarded":false,"raw":"13"},{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":19.0,"code":null,"discarded":false,"raw":"19"}]'::jsonb, null),
('ILCA 6', 19, 19, '209145', 'Omar Agoes', 'M', 71.0, 71.0, '[{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":14.0,"code":null,"discarded":false,"raw":"14"},{"score":22.0,"code":null,"discarded":false,"raw":"22"},{"score":15.0,"code":null,"discarded":false,"raw":"15"}]'::jsonb, '0951d7ed-7faf-4fab-a660-ca9bb034dc4d'),
('ILCA 6', 20, 20, '221703', 'Jaydn Wilkins', 'M', 73.0, 73.0, '[{"score":16.0,"code":null,"discarded":false,"raw":"16"},{"score":15.0,"code":null,"discarded":false,"raw":"15"},{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":21.0,"code":null,"discarded":false,"raw":"21"}]'::jsonb, '0da305f9-96d4-4cc3-9eb5-ce47b0952a39'),
('ILCA 6', 21, 21, '221690', 'Arabelle Tan En Xi', 'F', 77.0, 77.0, '[{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":21.0,"code":null,"discarded":false,"raw":"21"},{"score":17.0,"code":null,"discarded":false,"raw":"17"},{"score":18.0,"code":null,"discarded":false,"raw":"18"}]'::jsonb, '6057a852-a589-4ed9-b887-e96a2178a307'),
('ILCA 6', 22, 22, '209051', 'Samuel Tan', 'M', 78.0, 78.0, '[{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":19.0,"code":null,"discarded":false,"raw":"19"},{"score":20.0,"code":null,"discarded":false,"raw":"20"},{"score":20.0,"code":null,"discarded":false,"raw":"20"}]'::jsonb, '4145fe82-76b8-498f-8612-32a6e9bf6c78'),
('ILCA 6', 23, 23, '219158', 'Isaac Goh', 'M', 96.0, 96.0, '[{"score":24.0,"code":"DNS","discarded":false,"raw":"DNS,24"},{"score":24.0,"code":"DNC","discarded":false,"raw":"DNC,24"},{"score":24.0,"code":"DNC","discarded":false,"raw":"DNC,24"},{"score":24.0,"code":"DNC","discarded":false,"raw":"DNC,24"}]'::jsonb, '93fc1c81-1ec7-4600-b9a1-bc613d11449c');

insert into public.sailors (
  name, handle, sail_number, sail_number_ilca4, club, gender, nationality,
  nationality_from_sail, created_at, updated_at
)
select new_sailor.name, new_sailor.handle, '0', new_sailor.ilca4_sail, new_sailor.club,
       new_sailor.sex, 'SGP', false, now(), now()
from (values
('Cheryl Yong Heng Xi', 'cheryl-yong-heng-xi-csc25', '197834', 'Changi Sailing Club', 'F'),
('Abigail Koh', 'abigail-koh-csc25', null, 'PAssion Wave', 'F'),
('Caio Sullivan', 'caio-sullivan-csc25', null, 'Changi Sailing Club', 'M'),
('Elisha Lim Yu Ting', 'elisha-lim-yu-ting-csc25', null, 'Constant Wind SeaSports', 'F'),
('Sarah Seow Hui Yan', 'sarah-seow-hui-yan-csc25', null, 'Republic of Singapore Yacht Club', 'F'),
('Mahias Wong', 'mahias-wong-csc25', null, 'Constant Wind SeaSports', 'M'),
('Sam Tan-Hardy', 'sam-tan-hardy-csc25', null, 'Changi Sailing Club', 'M'),
('Lucas Quek', 'lucas-quek-csc25', null, 'Constant Wind SeaSports', 'M')
) as new_sailor(name, handle, ilca4_sail, club, sex)
where not exists (
  select 1 from public.sailors existing
  where lower(trim(existing.name)) = lower(trim(new_sailor.name))
     or existing.handle = new_sailor.handle
);

update public._csc_ilca_2025_load sheet
set sailor_id = sailor.id
from public.sailors sailor
where sheet.sailor_id is null
  and lower(trim(sailor.name)) = lower(trim(sheet.pdf_name));

do $$
declare
  missing integer;
  distinct_sailors integer;
  bad_scores integer;
begin
  select count(*) into missing from public._csc_ilca_2025_load where sailor_id is null;
  select count(distinct sailor_id) into distinct_sailors from public._csc_ilca_2025_load;
  select count(*) into bad_scores
  from public._csc_ilca_2025_load sheet
  cross join lateral (
    select
      coalesce(sum((race.item->>'score')::numeric), 0) as total_sum,
      coalesce(sum((race.item->>'score')::numeric) filter (
        where coalesce((race.item->>'discarded')::boolean, false) = false
      ), 0) as nett_sum,
      count(*) filter (where coalesce((race.item->>'discarded')::boolean, false)) as discards,
      count(*) as race_count
    from jsonb_array_elements(sheet.races) as race(item)
  ) scored
  where scored.total_sum <> sheet.total::numeric
     or scored.nett_sum <> sheet.nett::numeric
     or (sheet.fleet = 'ILCA 4' and (scored.discards <> 1 or scored.race_count <> 6))
     or (sheet.fleet = 'ILCA 6' and (scored.discards <> 0 or scored.race_count <> 4));
  if missing <> 0 or distinct_sailors <> 90 or bad_scores <> 0 then
    raise exception 'CSC ILCA 2025 load failed: missing %, distinct %, bad scores %',
      missing, distinct_sailors, bad_scores;
  end if;
end $$;

insert into public.regatta_events (
  name, slug, start_date, end_date, venue, organizer, classes,
  counts_for_ranking, is_selection_trial, created_at, updated_at
) values (
  '5th CSC ILCA & 29er Opens 2025',
  '5th-csc-ilca-29er-open-2025',
  '2025-02-22',
  '2025-02-23',
  'Changi Sailing Club, 32 Netheravon Road, Singapore 508508',
  'Changi Sailing Club',
  '["ILCA 4", "ILCA 6"]'::jsonb,
  true,
  false,
  now(),
  now()
)
on conflict (slug) do update set
  name = excluded.name,
  start_date = excluded.start_date,
  end_date = excluded.end_date,
  venue = excluded.venue,
  organizer = excluded.organizer,
  classes = excluded.classes,
  updated_at = now();

insert into public.regattas (
  name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
  geography, counts_for_ranking, venue, organizer, schedule_notes, status, created_at, updated_at
)
select
  '5th CSC ILCA & 29er Opens 2025 (ILCA 6)',
  'csc-ilca6-feb-25-2025-02-22',
  '2025-02-22',
  '2025-02-23',
  'ILCA 6',
  'Open',
  23,
  4,
  'SGP',
  true,
  'Changi Sailing Club, 32 Netheravon Road, Singapore 508508',
  'Changi Sailing Club',
  '5th CSC ILCA & 29er Opens ILCA 6, 22-23 February 2025. Four races completed; all count. Provisional results 22 February 2025.',
  'published',
  now(),
  now()
where not exists (
  select 1 from public.regattas where slug = 'csc-ilca6-feb-25-2025-02-22'
);

update public.regattas regatta
set event_id = event.id,
    name = case regatta.boat_class
      when 'ILCA 6' then '5th CSC ILCA & 29er Opens 2025 (ILCA 6)'
      else '5th CSC ILCA & 29er Opens 2025 (ILCA 4)'
    end,
    date = '2025-02-22',
    end_date = '2025-02-23',
    division = 'Open',
    race_count = case regatta.boat_class when 'ILCA 6' then 4 else 6 end,
    total_fleet_size = case regatta.boat_class when 'ILCA 6' then 23 else 67 end,
    geography = 'SGP',
    venue = 'Changi Sailing Club, 32 Netheravon Road, Singapore 508508',
    organizer = 'Changi Sailing Club',
    schedule_notes = case regatta.boat_class
      when 'ILCA 6' then '5th CSC ILCA & 29er Opens ILCA 6, 22-23 February 2025. Four races completed; all count. Provisional results 22 February 2025.'
      else '5th CSC ILCA & 29er Opens ILCA 4, 22-23 February 2025. Six races completed; best five count. Provisional results 23 February 2025.'
    end,
    counts_for_ranking = true,
    status = 'published',
    updated_at = now()
from public.regatta_events event
where event.slug = '5th-csc-ilca-29er-open-2025'
  and regatta.slug in ('csc-ilca4-feb-25-2025-02-22', 'csc-ilca6-feb-25-2025-02-22');

delete from public.regatta_results result
using public.regattas regatta
where result.regatta_id = regatta.id
  and regatta.slug in ('csc-ilca4-feb-25-2025-02-22', 'csc-ilca6-feb-25-2025-02-22');

insert into public.regatta_results (
  sailor_id, regatta_id, rank, nett_score, total_score, is_dns, is_overseas_commitment,
  gender, nationality, birth_year, evidence_name, evidence_type, evidence_notes,
  verification_status, verified_at, created_at, updated_at
)
select
  source.sailor_id,
  regatta.id,
  source.final_rank,
  source.nett,
  source.total,
  false,
  false,
  source.sex,
  sailor.nationality,
  case
    when extract(year from sailor.dob) between 1990 and 2035
      then extract(year from sailor.dob)::integer
    else null
  end,
  case source.fleet
    when 'ILCA 6' then 'Summary-ILCA-6.pdf'
    else 'ILCA-4-Summary-13.pdf'
  end,
  'pdf',
  case source.fleet
    when 'ILCA 6' then 'Official PowerScore provisional results, 22 February 2025. Four races, no discard.'
    else 'Official PowerScore provisional results, 23 February 2025. Six races, one discard.'
  end,
  'verified',
  now(),
  now(),
  now()
from public._csc_ilca_2025_load source
join public.sailors sailor on sailor.id = source.sailor_id
join public.regattas regatta on regatta.slug = case source.fleet
  when 'ILCA 6' then 'csc-ilca6-feb-25-2025-02-22'
  else 'csc-ilca4-feb-25-2025-02-22'
end;

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
from public._csc_ilca_2025_load source
join public.regattas regatta on regatta.slug = case source.fleet
  when 'ILCA 6' then 'csc-ilca6-feb-25-2025-02-22'
  else 'csc-ilca4-feb-25-2025-02-22'
end
join public.regatta_results result
  on result.regatta_id = regatta.id and result.sailor_id = source.sailor_id
cross join lateral jsonb_array_elements(source.races) with ordinality as race(item, ordinality);

update public.sailors sailor
set gender = source.sex, updated_at = now()
from public._csc_ilca_2025_load source
where sailor.id = source.sailor_id
  and sailor.gender is null;

insert into public.sailor_aliases (sailor_id, alias_name, created_at)
select source.sailor_id, source.pdf_name, now()
from public._csc_ilca_2025_load source
join public.sailors sailor on sailor.id = source.sailor_id
where lower(trim(sailor.name)) <> lower(trim(source.pdf_name))
on conflict (alias_name) do nothing;

drop table public._csc_ilca_2025_load;
