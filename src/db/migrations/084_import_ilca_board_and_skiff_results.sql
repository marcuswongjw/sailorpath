-- Official final results imported from five supplied Singapore Sailing PDFs.
begin;

update public.regattas set race_count=12, updated_at=now()
where slug='sysc-ilca-mar-26-2026-03-14';
update public.regatta_results rr set evidence_name='ILCA 4 - Results are final as of 0004hrs on 19 March 2026.pdf', evidence_type='pdf', verification_status='verified', verified_at=now(), updated_at=now()
from public.regattas r where rr.regatta_id=r.id and r.slug='sysc-ilca-mar-26-2026-03-14';
update public.regattas set race_count=4, total_fleet_size=42, updated_at=now()
where slug='temasek-ilca-jun-26-2026-06-20';
update public.regattas set race_count=2, total_fleet_size=42, updated_at=now()
where slug='cincapura-2026-ilca4';
update public.regatta_results rr set evidence_name='ILCA 4 Final Results.pdf', evidence_type='pdf', verification_status='verified', verified_at=now(), updated_at=now()
from public.regattas r where rr.regatta_id=r.id and r.slug in ('temasek-ilca-jun-26-2026-06-20','cincapura-2026-ilca4');

create temporary table import_084_ilca(regatta_slug text, final_rank int, sailor_name text, nett real, race_number int, score real, scoring_code text, discarded boolean, raw_value text) on commit drop;
insert into import_084_ilca values
('cincapura-2026-ilca4',1,'',7.0,1,1.0,null,false,'1'),
('cincapura-2026-ilca4',1,'',7.0,2,6.0,null,false,'6'),
('cincapura-2026-ilca4',2,'',10.0,1,8.0,null,false,'8'),
('cincapura-2026-ilca4',2,'',10.0,2,2.0,null,false,'2'),
('cincapura-2026-ilca4',3,'',10.0,1,2.0,null,false,'2'),
('cincapura-2026-ilca4',3,'',10.0,2,8.0,null,false,'8'),
('cincapura-2026-ilca4',4,'',12.0,1,11.0,null,false,'11'),
('cincapura-2026-ilca4',4,'',12.0,2,1.0,null,false,'1'),
('cincapura-2026-ilca4',5,'',14.0,1,3.0,null,false,'3'),
('cincapura-2026-ilca4',5,'',14.0,2,11.0,null,false,'11'),
('cincapura-2026-ilca4',6,'',14.0,1,4.0,null,false,'4'),
('cincapura-2026-ilca4',6,'',14.0,2,10.0,null,false,'10'),
('cincapura-2026-ilca4',7,'',16.0,1,12.0,null,false,'12'),
('cincapura-2026-ilca4',7,'',16.0,2,4.0,null,false,'4'),
('cincapura-2026-ilca4',8,'',18.0,1,9.0,null,false,'9'),
('cincapura-2026-ilca4',8,'',18.0,2,9.0,null,false,'9'),
('cincapura-2026-ilca4',9,'',22.0,1,17.0,null,false,'17'),
('cincapura-2026-ilca4',9,'',22.0,2,5.0,null,false,'5'),
('cincapura-2026-ilca4',10,'',23.0,1,5.0,null,false,'5'),
('cincapura-2026-ilca4',10,'',23.0,2,18.0,null,false,'18'),
('cincapura-2026-ilca4',11,'',27.0,1,6.0,null,false,'6'),
('cincapura-2026-ilca4',11,'',27.0,2,21.0,null,false,'21'),
('cincapura-2026-ilca4',12,'',27.0,1,20.0,null,false,'20'),
('cincapura-2026-ilca4',12,'',27.0,2,7.0,null,false,'7'),
('cincapura-2026-ilca4',13,'',29.0,1,7.0,null,false,'7'),
('cincapura-2026-ilca4',13,'',29.0,2,22.0,null,false,'22'),
('cincapura-2026-ilca4',14,'',30.0,1,16.0,null,false,'16'),
('cincapura-2026-ilca4',14,'',30.0,2,14.0,null,false,'14'),
('cincapura-2026-ilca4',15,'',30.0,1,15.0,null,false,'15'),
('cincapura-2026-ilca4',15,'',30.0,2,15.0,null,false,'15'),
('cincapura-2026-ilca4',16,'',34.0,1,21.0,null,false,'21'),
('cincapura-2026-ilca4',16,'',34.0,2,13.0,null,false,'13'),
('cincapura-2026-ilca4',17,'',36.0,1,33.0,null,false,'33'),
('cincapura-2026-ilca4',17,'',36.0,2,3.0,null,false,'3'),
('cincapura-2026-ilca4',18,'',36.0,1,19.0,null,false,'19'),
('cincapura-2026-ilca4',18,'',36.0,2,17.0,null,false,'17'),
('cincapura-2026-ilca4',19,'',42.0,1,10.0,null,false,'10'),
('cincapura-2026-ilca4',19,'',42.0,2,32.0,null,false,'32'),
('cincapura-2026-ilca4',20,'',44.0,1,32.0,null,false,'32'),
('cincapura-2026-ilca4',20,'',44.0,2,12.0,null,false,'12'),
('cincapura-2026-ilca4',21,'',44.0,1,28.0,null,false,'28'),
('cincapura-2026-ilca4',21,'',44.0,2,16.0,null,false,'16'),
('cincapura-2026-ilca4',22,'',45.0,1,18.0,null,false,'18'),
('cincapura-2026-ilca4',22,'',45.0,2,27.0,null,false,'27'),
('cincapura-2026-ilca4',23,'',46.0,1,26.0,null,false,'26'),
('cincapura-2026-ilca4',23,'',46.0,2,20.0,null,false,'20'),
('cincapura-2026-ilca4',24,'',47.0,1,13.0,null,false,'13'),
('cincapura-2026-ilca4',24,'',47.0,2,34.0,null,false,'34'),
('cincapura-2026-ilca4',25,'',47.0,1,22.0,null,false,'22'),
('cincapura-2026-ilca4',25,'',47.0,2,25.0,null,false,'25'),
('cincapura-2026-ilca4',26,'',47.0,1,24.0,null,false,'24'),
('cincapura-2026-ilca4',26,'',47.0,2,23.0,null,false,'23'),
('cincapura-2026-ilca4',27,'',49.0,1,23.0,null,false,'23'),
('cincapura-2026-ilca4',27,'',49.0,2,26.0,null,false,'26'),
('cincapura-2026-ilca4',28,'',50.0,1,31.0,null,false,'31'),
('cincapura-2026-ilca4',28,'',50.0,2,19.0,null,false,'19'),
('cincapura-2026-ilca4',29,'',51.0,1,27.0,null,false,'27'),
('cincapura-2026-ilca4',29,'',51.0,2,24.0,null,false,'24'),
('cincapura-2026-ilca4',30,'',54.0,1,14.0,null,false,'14'),
('cincapura-2026-ilca4',30,'',54.0,2,40.0,null,false,'40'),
('cincapura-2026-ilca4',31,'',54.0,1,25.0,null,false,'25'),
('cincapura-2026-ilca4',31,'',54.0,2,29.0,null,false,'29'),
('cincapura-2026-ilca4',32,'',58.0,1,30.0,null,false,'30'),
('cincapura-2026-ilca4',32,'',58.0,2,28.0,null,false,'28'),
('cincapura-2026-ilca4',33,'',59.0,1,29.0,null,false,'29'),
('cincapura-2026-ilca4',33,'',59.0,2,30.0,null,false,'30'),
('cincapura-2026-ilca4',34,'',69.0,1,38.0,null,false,'38'),
('cincapura-2026-ilca4',34,'',69.0,2,31.0,null,false,'31'),
('cincapura-2026-ilca4',35,'',71.0,1,35.0,null,false,'35'),
('cincapura-2026-ilca4',35,'',71.0,2,36.0,null,false,'36'),
('cincapura-2026-ilca4',36,'',72.0,1,34.0,null,false,'34'),
('cincapura-2026-ilca4',36,'',72.0,2,38.0,null,false,'38'),
('cincapura-2026-ilca4',37,'',73.0,1,40.0,null,false,'40'),
('cincapura-2026-ilca4',37,'',73.0,2,33.0,null,false,'33'),
('cincapura-2026-ilca4',38,'',73.0,1,36.0,null,false,'36'),
('cincapura-2026-ilca4',38,'',73.0,2,37.0,null,false,'37'),
('cincapura-2026-ilca4',39,'',76.0,1,41.0,null,false,'41'),
('cincapura-2026-ilca4',39,'',76.0,2,35.0,null,false,'35'),
('cincapura-2026-ilca4',40,'',79.0,1,37.0,null,false,'37'),
('cincapura-2026-ilca4',40,'',79.0,2,42.0,null,false,'42'),
('cincapura-2026-ilca4',41,'',80.0,1,39.0,null,false,'39'),
('cincapura-2026-ilca4',41,'',80.0,2,41.0,null,false,'41'),
('cincapura-2026-ilca4',42,'',81.0,1,42.0,null,false,'42'),
('cincapura-2026-ilca4',42,'',81.0,2,39.0,null,false,'39'),
('temasek-ilca-jun-26-2026-06-20',1,'Desiree Yuet Chi Lee',5.0,1,1.0,null,false,'1'),
('temasek-ilca-jun-26-2026-06-20',1,'Desiree Yuet Chi Lee',5.0,2,1.0,null,false,'1'),
('temasek-ilca-jun-26-2026-06-20',1,'Desiree Yuet Chi Lee',5.0,3,4.0,null,true,'(4)'),
('temasek-ilca-jun-26-2026-06-20',1,'Desiree Yuet Chi Lee',5.0,4,3.0,null,false,'3'),
('temasek-ilca-jun-26-2026-06-20',2,'Teck Woon Pee',6.0,1,4.0,null,true,'(4)'),
('temasek-ilca-jun-26-2026-06-20',2,'Teck Woon Pee',6.0,2,4.0,null,false,'4'),
('temasek-ilca-jun-26-2026-06-20',2,'Teck Woon Pee',6.0,3,1.0,null,false,'1'),
('temasek-ilca-jun-26-2026-06-20',2,'Teck Woon Pee',6.0,4,1.0,null,false,'1'),
('temasek-ilca-jun-26-2026-06-20',3,'Jemima Chang',10.0,1,3.0,null,false,'3'),
('temasek-ilca-jun-26-2026-06-20',3,'Jemima Chang',10.0,2,2.0,null,false,'2'),
('temasek-ilca-jun-26-2026-06-20',3,'Jemima Chang',10.0,3,5.0,null,false,'5'),
('temasek-ilca-jun-26-2026-06-20',3,'Jemima Chang',10.0,4,18.0,null,true,'(18)'),
('temasek-ilca-jun-26-2026-06-20',4,'Mika Tew',11.0,1,7.0,null,true,'(7)'),
('temasek-ilca-jun-26-2026-06-20',4,'Mika Tew',11.0,2,7.0,null,false,'7'),
('temasek-ilca-jun-26-2026-06-20',4,'Mika Tew',11.0,3,2.0,null,false,'2'),
('temasek-ilca-jun-26-2026-06-20',4,'Mika Tew',11.0,4,2.0,null,false,'2'),
('temasek-ilca-jun-26-2026-06-20',5,'Yuk Jun Lim',16.0,1,5.0,null,false,'5'),
('temasek-ilca-jun-26-2026-06-20',5,'Yuk Jun Lim',16.0,2,18.0,null,true,'(18)'),
('temasek-ilca-jun-26-2026-06-20',5,'Yuk Jun Lim',16.0,3,6.0,null,false,'6'),
('temasek-ilca-jun-26-2026-06-20',5,'Yuk Jun Lim',16.0,4,5.0,null,false,'5'),
('temasek-ilca-jun-26-2026-06-20',6,'Jayden Zi Xi Bai',21.0,1,12.0,null,true,'(12)'),
('temasek-ilca-jun-26-2026-06-20',6,'Jayden Zi Xi Bai',21.0,2,3.0,null,false,'3'),
('temasek-ilca-jun-26-2026-06-20',6,'Jayden Zi Xi Bai',21.0,3,8.0,null,false,'8'),
('temasek-ilca-jun-26-2026-06-20',6,'Jayden Zi Xi Bai',21.0,4,10.0,null,false,'10'),
('temasek-ilca-jun-26-2026-06-20',7,'Isaiah Chor Hong Yap',25.0,1,25.0,null,true,'(25)'),
('temasek-ilca-jun-26-2026-06-20',7,'Isaiah Chor Hong Yap',25.0,2,11.0,null,false,'11'),
('temasek-ilca-jun-26-2026-06-20',7,'Isaiah Chor Hong Yap',25.0,3,10.0,null,false,'10'),
('temasek-ilca-jun-26-2026-06-20',7,'Isaiah Chor Hong Yap',25.0,4,4.0,null,false,'4'),
('temasek-ilca-jun-26-2026-06-20',8,'Amandine Zoe Pitsilis',25.0,1,11.0,null,false,'11'),
('temasek-ilca-jun-26-2026-06-20',8,'Amandine Zoe Pitsilis',25.0,2,5.0,null,false,'5'),
('temasek-ilca-jun-26-2026-06-20',8,'Amandine Zoe Pitsilis',25.0,3,9.0,null,false,'9'),
('temasek-ilca-jun-26-2026-06-20',8,'Amandine Zoe Pitsilis',25.0,4,14.0,null,true,'(14)'),
('temasek-ilca-jun-26-2026-06-20',9,'Mildred Li Xuan Wong',25.0,1,8.0,null,false,'8'),
('temasek-ilca-jun-26-2026-06-20',9,'Mildred Li Xuan Wong',25.0,2,8.0,null,false,'8'),
('temasek-ilca-jun-26-2026-06-20',9,'Mildred Li Xuan Wong',25.0,3,29.0,null,true,'(29)'),
('temasek-ilca-jun-26-2026-06-20',9,'Mildred Li Xuan Wong',25.0,4,9.0,null,false,'9'),
('temasek-ilca-jun-26-2026-06-20',10,'Isla Zhi Xi Lee',27.0,1,2.0,null,false,'2'),
('temasek-ilca-jun-26-2026-06-20',10,'Isla Zhi Xi Lee',27.0,2,22.0,null,false,'22'),
('temasek-ilca-jun-26-2026-06-20',10,'Isla Zhi Xi Lee',27.0,3,3.0,null,false,'3'),
('temasek-ilca-jun-26-2026-06-20',10,'Isla Zhi Xi Lee',27.0,4,23.0,null,true,'(23)'),
('temasek-ilca-jun-26-2026-06-20',11,'Caleb Peck',32.0,1,41.0,'UFD',true,'(41 UFD)'),
('temasek-ilca-jun-26-2026-06-20',11,'Caleb Peck',32.0,2,6.0,null,false,'6'),
('temasek-ilca-jun-26-2026-06-20',11,'Caleb Peck',32.0,3,13.0,null,false,'13'),
('temasek-ilca-jun-26-2026-06-20',11,'Caleb Peck',32.0,4,13.0,null,false,'13'),
('temasek-ilca-jun-26-2026-06-20',12,'Callum Joon Thang Wong',33.0,1,21.0,null,true,'(21)'),
('temasek-ilca-jun-26-2026-06-20',12,'Callum Joon Thang Wong',33.0,2,15.0,null,false,'15'),
('temasek-ilca-jun-26-2026-06-20',12,'Callum Joon Thang Wong',33.0,3,7.0,null,false,'7'),
('temasek-ilca-jun-26-2026-06-20',12,'Callum Joon Thang Wong',33.0,4,11.0,null,false,'11'),
('temasek-ilca-jun-26-2026-06-20',13,'Charles Shing Chak Kong',34.0,1,10.0,null,false,'10'),
('temasek-ilca-jun-26-2026-06-20',13,'Charles Shing Chak Kong',34.0,2,23.0,null,true,'(23'),
('temasek-ilca-jun-26-2026-06-20',13,'Charles Shing Chak Kong',34.0,3,12.0,null,false,'12'),
('temasek-ilca-jun-26-2026-06-20',13,'Charles Shing Chak Kong',34.0,4,12.0,null,false,'12'),
('temasek-ilca-jun-26-2026-06-20',14,'Lucas Rui Kai Lim',35.0,1,16.0,null,true,'(16)'),
('temasek-ilca-jun-26-2026-06-20',14,'Lucas Rui Kai Lim',35.0,2,14.0,null,false,'14'),
('temasek-ilca-jun-26-2026-06-20',14,'Lucas Rui Kai Lim',35.0,3,15.0,null,false,'15'),
('temasek-ilca-jun-26-2026-06-20',14,'Lucas Rui Kai Lim',35.0,4,6.0,null,false,'6'),
('temasek-ilca-jun-26-2026-06-20',15,'James Kong',35.0,1,30.0,null,true,'(30)'),
('temasek-ilca-jun-26-2026-06-20',15,'James Kong',35.0,2,9.0,null,false,'9'),
('temasek-ilca-jun-26-2026-06-20',15,'James Kong',35.0,3,19.0,null,false,'19'),
('temasek-ilca-jun-26-2026-06-20',15,'James Kong',35.0,4,7.0,null,false,'7'),
('temasek-ilca-jun-26-2026-06-20',16,'Cecilia Sze Sen Kong',42.0,1,13.0,null,false,'13'),
('temasek-ilca-jun-26-2026-06-20',16,'Cecilia Sze Sen Kong',42.0,2,13.0,null,false,'13'),
('temasek-ilca-jun-26-2026-06-20',16,'Cecilia Sze Sen Kong',42.0,3,36.0,null,true,'(36)'),
('temasek-ilca-jun-26-2026-06-20',16,'Cecilia Sze Sen Kong',42.0,4,16.0,null,false,'16'),
('temasek-ilca-jun-26-2026-06-20',17,'Julien Christian Petracco',45.0,1,6.0,null,false,'6'),
('temasek-ilca-jun-26-2026-06-20',17,'Julien Christian Petracco',45.0,2,24.0,null,true,'(24)'),
('temasek-ilca-jun-26-2026-06-20',17,'Julien Christian Petracco',45.0,3,18.0,null,false,'18'),
('temasek-ilca-jun-26-2026-06-20',17,'Julien Christian Petracco',45.0,4,21.0,null,false,'21'),
('temasek-ilca-jun-26-2026-06-20',18,'Liao Zhiting',46.0,1,9.0,null,false,'9'),
('temasek-ilca-jun-26-2026-06-20',18,'Liao Zhiting',46.0,2,10.0,null,false,'10'),
('temasek-ilca-jun-26-2026-06-20',18,'Liao Zhiting',46.0,3,27.0,'SCP',false,'27 SCP'),
('temasek-ilca-jun-26-2026-06-20',18,'Liao Zhiting',46.0,4,34.0,null,true,'(34)'),
('temasek-ilca-jun-26-2026-06-20',19,'Travis Jia Le Yeo',54.0,1,27.0,null,true,'(27)'),
('temasek-ilca-jun-26-2026-06-20',19,'Travis Jia Le Yeo',54.0,2,16.0,null,false,'16'),
('temasek-ilca-jun-26-2026-06-20',19,'Travis Jia Le Yeo',54.0,3,16.0,null,false,'16'),
('temasek-ilca-jun-26-2026-06-20',19,'Travis Jia Le Yeo',54.0,4,22.0,null,false,'22'),
('temasek-ilca-jun-26-2026-06-20',20,'Reyes Jit Eng Tan',57.0,1,19.0,null,false,'19'),
('temasek-ilca-jun-26-2026-06-20',20,'Reyes Jit Eng Tan',57.0,2,21.0,null,false,'21'),
('temasek-ilca-jun-26-2026-06-20',20,'Reyes Jit Eng Tan',57.0,3,25.0,null,true,'(25)'),
('temasek-ilca-jun-26-2026-06-20',20,'Reyes Jit Eng Tan',57.0,4,17.0,null,false,'17'),
('temasek-ilca-jun-26-2026-06-20',21,'Kai Lun Wong',58.0,1,18.0,null,false,'18'),
('temasek-ilca-jun-26-2026-06-20',21,'Kai Lun Wong',58.0,2,20.0,null,false,'20'),
('temasek-ilca-jun-26-2026-06-20',21,'Kai Lun Wong',58.0,3,30.0,null,true,'(30)'),
('temasek-ilca-jun-26-2026-06-20',21,'Kai Lun Wong',58.0,4,20.0,null,false,'20'),
('temasek-ilca-jun-26-2026-06-20',22,'Gerome Sim',60.0,1,15.0,null,false,'15'),
('temasek-ilca-jun-26-2026-06-20',22,'Gerome Sim',60.0,2,26.0,null,false,'26'),
('temasek-ilca-jun-26-2026-06-20',22,'Gerome Sim',60.0,3,32.0,null,true,'(32)'),
('temasek-ilca-jun-26-2026-06-20',22,'Gerome Sim',60.0,4,19.0,null,false,'19'),
('temasek-ilca-jun-26-2026-06-20',23,'Lauren Lim',62.0,1,26.0,null,false,'26'),
('temasek-ilca-jun-26-2026-06-20',23,'Lauren Lim',62.0,2,27.0,null,true,'(27)'),
('temasek-ilca-jun-26-2026-06-20',23,'Lauren Lim',62.0,3,11.0,null,false,'11'),
('temasek-ilca-jun-26-2026-06-20',23,'Lauren Lim',62.0,4,25.0,null,false,'25'),
('temasek-ilca-jun-26-2026-06-20',24,'Heng Yi Yong',62.0,1,14.0,null,false,'14'),
('temasek-ilca-jun-26-2026-06-20',24,'Heng Yi Yong',62.0,2,28.0,null,true,'(28)'),
('temasek-ilca-jun-26-2026-06-20',24,'Heng Yi Yong',62.0,3,20.0,null,false,'20'),
('temasek-ilca-jun-26-2026-06-20',24,'Heng Yi Yong',62.0,4,28.0,null,false,'28'),
('temasek-ilca-jun-26-2026-06-20',25,'Kye Tang',65.0,1,29.0,null,false,'29'),
('temasek-ilca-jun-26-2026-06-20',25,'Kye Tang',65.0,2,34.0,null,true,'(34)'),
('temasek-ilca-jun-26-2026-06-20',25,'Kye Tang',65.0,3,28.0,null,false,'28'),
('temasek-ilca-jun-26-2026-06-20',25,'Kye Tang',65.0,4,8.0,null,false,'8'),
('temasek-ilca-jun-26-2026-06-20',26,'Jonathan Kum Loong Kwok',67.0,1,31.0,null,false,'31'),
('temasek-ilca-jun-26-2026-06-20',26,'Jonathan Kum Loong Kwok',67.0,2,33.0,null,true,'(33)'),
('temasek-ilca-jun-26-2026-06-20',26,'Jonathan Kum Loong Kwok',67.0,3,21.0,null,false,'21'),
('temasek-ilca-jun-26-2026-06-20',26,'Jonathan Kum Loong Kwok',67.0,4,15.0,null,false,'15'),
('temasek-ilca-jun-26-2026-06-20',27,'Mathias Cheow',67.0,1,17.0,null,false,'17'),
('temasek-ilca-jun-26-2026-06-20',27,'Mathias Cheow',67.0,2,29.0,null,true,'(29)'),
('temasek-ilca-jun-26-2026-06-20',27,'Mathias Cheow',67.0,3,26.0,null,false,'26'),
('temasek-ilca-jun-26-2026-06-20',27,'Mathias Cheow',67.0,4,24.0,null,false,'24'),
('temasek-ilca-jun-26-2026-06-20',28,'Joel Kai En Tan',70.0,1,23.0,null,false,'23'),
('temasek-ilca-jun-26-2026-06-20',28,'Joel Kai En Tan',70.0,2,35.0,null,true,'(35)'),
('temasek-ilca-jun-26-2026-06-20',28,'Joel Kai En Tan',70.0,3,14.0,null,false,'14'),
('temasek-ilca-jun-26-2026-06-20',28,'Joel Kai En Tan',70.0,4,33.0,null,false,'33'),
('temasek-ilca-jun-26-2026-06-20',29,'Yunosuke Ogawa',71.0,1,41.0,'UFD',true,'(41 UFD)'),
('temasek-ilca-jun-26-2026-06-20',29,'Yunosuke Ogawa',71.0,2,25.0,null,false,'25'),
('temasek-ilca-jun-26-2026-06-20',29,'Yunosuke Ogawa',71.0,3,17.0,null,false,'17'),
('temasek-ilca-jun-26-2026-06-20',29,'Yunosuke Ogawa',71.0,4,29.0,null,false,'29'),
('temasek-ilca-jun-26-2026-06-20',30,'Joshua Zhuo Xi Khoo',71.0,1,20.0,null,false,'20'),
('temasek-ilca-jun-26-2026-06-20',30,'Joshua Zhuo Xi Khoo',71.0,2,31.0,null,true,'(31)'),
('temasek-ilca-jun-26-2026-06-20',30,'Joshua Zhuo Xi Khoo',71.0,3,24.0,null,false,'24'),
('temasek-ilca-jun-26-2026-06-20',30,'Joshua Zhuo Xi Khoo',71.0,4,27.0,null,false,'27'),
('temasek-ilca-jun-26-2026-06-20',31,'Alaric Shenthil Naidu',73.0,1,24.0,null,false,'24'),
('temasek-ilca-jun-26-2026-06-20',31,'Alaric Shenthil Naidu',73.0,2,17.0,null,false,'17'),
('temasek-ilca-jun-26-2026-06-20',31,'Alaric Shenthil Naidu',73.0,3,37.0,null,true,'(37)'),
('temasek-ilca-jun-26-2026-06-20',31,'Alaric Shenthil Naidu',73.0,4,32.0,null,false,'32'),
('temasek-ilca-jun-26-2026-06-20',32,'Caleb Zhixuan Cao',74.0,1,22.0,null,false,'22'),
('temasek-ilca-jun-26-2026-06-20',32,'Caleb Zhixuan Cao',74.0,2,32.0,null,true,'(32)'),
('temasek-ilca-jun-26-2026-06-20',32,'Caleb Zhixuan Cao',74.0,3,22.0,null,false,'22'),
('temasek-ilca-jun-26-2026-06-20',32,'Caleb Zhixuan Cao',74.0,4,30.0,null,false,'30'),
('temasek-ilca-jun-26-2026-06-20',33,'Jonas Kia Jeng Tan',77.0,1,28.0,null,false,'28'),
('temasek-ilca-jun-26-2026-06-20',33,'Jonas Kia Jeng Tan',77.0,2,23.0,null,false,'23'),
('temasek-ilca-jun-26-2026-06-20',33,'Jonas Kia Jeng Tan',77.0,3,31.0,null,true,'(31)'),
('temasek-ilca-jun-26-2026-06-20',33,'Jonas Kia Jeng Tan',77.0,4,26.0,null,false,'26'),
('temasek-ilca-jun-26-2026-06-20',34,'Rayson Yin Yi Lee',80.0,1,32.0,null,false,'32'),
('temasek-ilca-jun-26-2026-06-20',34,'Rayson Yin Yi Lee',80.0,2,12.0,null,false,'12'),
('temasek-ilca-jun-26-2026-06-20',34,'Rayson Yin Yi Lee',80.0,3,39.0,null,true,'(39)'),
('temasek-ilca-jun-26-2026-06-20',34,'Rayson Yin Yi Lee',80.0,4,36.0,null,false,'36'),
('temasek-ilca-jun-26-2026-06-20',35,'Tomas Agea',90.0,1,33.0,null,false,'33'),
('temasek-ilca-jun-26-2026-06-20',35,'Tomas Agea',90.0,2,30.0,null,false,'30'),
('temasek-ilca-jun-26-2026-06-20',35,'Tomas Agea',90.0,3,27.0,null,false,'27'),
('temasek-ilca-jun-26-2026-06-20',35,'Tomas Agea',90.0,4,39.0,null,true,'(39)'),
('temasek-ilca-jun-26-2026-06-20',36,'Tiffany Teo',99.0,1,34.0,null,false,'34'),
('temasek-ilca-jun-26-2026-06-20',36,'Tiffany Teo',99.0,2,36.0,null,true,'(36)'),
('temasek-ilca-jun-26-2026-06-20',36,'Tiffany Teo',99.0,3,34.0,null,false,'34'),
('temasek-ilca-jun-26-2026-06-20',36,'Tiffany Teo',99.0,4,31.0,null,false,'31'),
('temasek-ilca-jun-26-2026-06-20',37,'Maximilian Ha',107.0,1,35.0,null,false,'35'),
('temasek-ilca-jun-26-2026-06-20',37,'Maximilian Ha',107.0,2,38.0,null,true,'(38)'),
('temasek-ilca-jun-26-2026-06-20',37,'Maximilian Ha',107.0,3,35.0,null,false,'35'),
('temasek-ilca-jun-26-2026-06-20',37,'Maximilian Ha',107.0,4,37.0,null,false,'37'),
('temasek-ilca-jun-26-2026-06-20',38,'Jamiroquai Kai Nuo Tay',108.0,1,37.0,null,false,'37'),
('temasek-ilca-jun-26-2026-06-20',38,'Jamiroquai Kai Nuo Tay',108.0,2,40.0,null,true,'(40)'),
('temasek-ilca-jun-26-2026-06-20',38,'Jamiroquai Kai Nuo Tay',108.0,3,33.0,null,false,'33'),
('temasek-ilca-jun-26-2026-06-20',38,'Jamiroquai Kai Nuo Tay',108.0,4,38.0,null,false,'38'),
('temasek-ilca-jun-26-2026-06-20',39,'Mohamed Mikail Bin Mohd',108.0,1,36.0,null,false,'36'),
('temasek-ilca-jun-26-2026-06-20',39,'Mohamed Mikail Bin Mohd',108.0,2,37.0,null,false,'37'),
('temasek-ilca-jun-26-2026-06-20',39,'Mohamed Mikail Bin Mohd',108.0,3,41.0,null,true,'(41'),
('temasek-ilca-jun-26-2026-06-20',39,'Mohamed Mikail Bin Mohd',108.0,4,35.0,null,false,'35'),
('temasek-ilca-jun-26-2026-06-20',40,'Sheng Rui Li',117.0,1,38.0,null,false,'38'),
('temasek-ilca-jun-26-2026-06-20',40,'Sheng Rui Li',117.0,2,39.0,null,false,'39'),
('temasek-ilca-jun-26-2026-06-20',40,'Sheng Rui Li',117.0,3,40.0,null,false,'40'),
('temasek-ilca-jun-26-2026-06-20',40,'Sheng Rui Li',117.0,4,41.0,null,true,'(41'),
('temasek-ilca-jun-26-2026-06-20',41,'Kate Zi Ning Yeh',129.0,1,43.0,null,true,'(43'),
('temasek-ilca-jun-26-2026-06-20',41,'Kate Zi Ning Yeh',129.0,2,43.0,'DNC',false,'43 DNC'),
('temasek-ilca-jun-26-2026-06-20',41,'Kate Zi Ning Yeh',129.0,3,43.0,'DNC',false,'43 DNC'),
('temasek-ilca-jun-26-2026-06-20',41,'Kate Zi Ning Yeh',129.0,4,43.0,'DNC',false,'43 DNC'),
('temasek-ilca-jun-26-2026-06-20',41,'Cory Zhi Hang Loh',129.0,1,43.0,null,true,'(43'),
('temasek-ilca-jun-26-2026-06-20',41,'Cory Zhi Hang Loh',129.0,2,43.0,'DNC',false,'43 DNC'),
('temasek-ilca-jun-26-2026-06-20',41,'Cory Zhi Hang Loh',129.0,3,43.0,'DNC',false,'43 DNC'),
('temasek-ilca-jun-26-2026-06-20',41,'Cory Zhi Hang Loh',129.0,4,43.0,'DNC',false,'43 DNC');

insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select matched.result_id, src.race_number, src.score, src.scoring_code, src.discarded, src.raw_value, now(), now()
from import_084_ilca src
join public.regattas r on r.slug=src.regatta_slug
join lateral (
  select rr.id result_id from public.regatta_results rr
  join public.sailors s on s.id=rr.sailor_id
  where rr.regatta_id=r.id and rr.rank=src.final_rank
    and abs(coalesce(rr.nett_score,-999)-src.nett)<0.01
    and (src.sailor_name='' or regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower(src.sailor_name),'[^a-z0-9]','','g'))
  limit 1
) matched on true
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regattas(name,slug,event_id,date,end_date,boat_class,division,total_fleet_size,race_count,geography,counts_for_ranking,is_selection_trial,venue,organizer,schedule_notes,status,created_at,updated_at)
select 'Cincapura Regatta 2026 (29er)','cincapura-2026-29er',e.id,'2026-07-20','2026-07-21','29er','Open',3,2,'SG',false,false,'National Sailing Centre, Singapore','Singapore Sailing Federation','Official final results from 29er & T293 Final Results.pdf','published',now(),now()
from public.regatta_events e where e.slug='cincapura-regatta-2026'
on conflict(slug) do update set event_id=excluded.event_id,end_date=excluded.end_date,boat_class=excluded.boat_class,division=excluded.division,total_fleet_size=excluded.total_fleet_size,race_count=excluded.race_count,status='published',updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Cheryl Ho / Gemma Chen','cheryl-ho-gemma-chen-2869','2869','Raffles Girls'' School','F','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,1,2,2,false,false,'F','SGP','29er & T293 Final Results.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='cincapura-2026-29er'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Cheryl Yong / Seth Low','cheryl-yong-seth-low-2466','2466','Changi Sailing Club','Mixed','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Seth Low'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,2,4,4,false,false,'Mixed','SGP','29er & T293 Final Results.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Seth Low'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='cincapura-2026-29er'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Seth Low'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Seth Low'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Sean Kum / Nigel Tan','sean-kum-nigel-tan-2742','2742',null,'M','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,3,8,8,false,false,'M','SGP','29er & T293 Final Results.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='cincapura-2026-29er'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regattas(name,slug,event_id,date,end_date,boat_class,division,total_fleet_size,race_count,geography,counts_for_ranking,is_selection_trial,venue,organizer,schedule_notes,status,created_at,updated_at)
select 'Cincapura Regatta 2026 (Techno 293)','cincapura-2026-techno-293',e.id,'2026-07-20','2026-07-21','Techno 293','Open',7,8,'SG',false,false,'National Sailing Centre, Singapore','Singapore Sailing Federation','Official final results from 29er & T293 Final Results.pdf','published',now(),now()
from public.regatta_events e where e.slug='cincapura-regatta-2026'
on conflict(slug) do update set event_id=excluded.event_id,end_date=excluded.end_date,boat_class=excluded.boat_class,division=excluded.division,total_fleet_size=excluded.total_fleet_size,race_count=excluded.race_count,status='published',updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Addy Armand Anuar','addy-armand-anuar-143','143','Constant Wind SeaSports','M','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,1,14,19,false,false,'M','SGP','29er & T293 Final Results.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='cincapura-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,5,null,true,'(5)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Axl Tan','axl-tan-64','64','Constant Wind SeaSports','M','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,2,20,26,false,false,'M','SGP','29er & T293 Final Results.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='cincapura-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,6,null,true,'(6)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,6,null,false,'6',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Trevor Ng','trevor-ng-45','45','Constant Wind SeaSports','M','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,3,23,31,false,false,'M','SGP','29er & T293 Final Results.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='cincapura-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,6,null,false,'6',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,8,'DNF',true,'(8 DNF)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Kate Teo','kate-teo-235','235','Constant Wind SeaSports','F','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,4,24,30,false,false,'F','SGP','29er & T293 Final Results.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='cincapura-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,6,null,true,'(6)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,6,null,false,'6',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Eunice Yi Ning Tan','eunice-yi-ning-tan-679','679','SAF Yacht Club','F','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,5,26,34,false,false,'F','SGP','29er & T293 Final Results.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='cincapura-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,8,'DNF',true,'(8 DNF)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Shan Qi','shan-qi-26','26','SAF Yacht Club','F','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,6,27,35,false,false,'F','SGP','29er & T293 Final Results.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='cincapura-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,8,'DNF',true,'(8 DNF)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,6,null,false,'6',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Kerraine Lee','kerraine-lee-8','8','Constant Wind SeaSports','F','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kerraine Lee'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,7,54,62,false,false,'F','SGP','29er & T293 Final Results.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Kerraine Lee'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='cincapura-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,8,'DNF',true,'(8 DNF)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kerraine Lee'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,8,'DNF',false,'8 DNF',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kerraine Lee'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,8,'DNF',false,'8 DNF',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kerraine Lee'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,7,null,false,'7',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kerraine Lee'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,8,'DNF',false,'8 DNF',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kerraine Lee'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,8,'DNF',false,'8 DNF',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kerraine Lee'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,7,null,false,'7',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kerraine Lee'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,8,'DNF',false,'8 DNF',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='cincapura-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kerraine Lee'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regattas(name,slug,event_id,date,end_date,boat_class,division,total_fleet_size,race_count,geography,counts_for_ranking,is_selection_trial,venue,organizer,schedule_notes,status,created_at,updated_at)
select 'Singapore Youth Sailing Championships 2026 (29er)','sysc-2026-29er',e.id,'2026-03-14','2026-03-17','29er','Open',3,12,'SG',false,false,'National Sailing Centre, Singapore','Singapore Sailing Federation','Official final results from T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','published',now(),now()
from public.regatta_events e where e.slug='sysc-2026'
on conflict(slug) do update set event_id=excluded.event_id,end_date=excluded.end_date,boat_class=excluded.boat_class,division=excluded.division,total_fleet_size=excluded.total_fleet_size,race_count=excluded.race_count,status='published',updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Cheryl Yong / Febe Wong','cheryl-yong-febe-wong-2466','2466','CHIJ St. Theresa''s Convent','F','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,1,10,13,false,false,'F','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-29er'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,1,null,true,'(1)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,2,null,true,'(2)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,9,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,10,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,11,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,12,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Yong / Febe Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Cheryl Ho / Gemma Chen','cheryl-ho-gemma-chen-2869','2869','Raffles Girls'' School','F','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,2,19,25,false,false,'F','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-29er'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,2,null,true,'(2)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,4,'DNF',true,'(4 DNF)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,9,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,10,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,11,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,12,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Cheryl Ho / Gemma Chen'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Sean Kum / Nigel Tan','sean-kum-nigel-tan-2472','2472','ACS(I) & SJI','M','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,3,40,48,false,false,'M','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-29er'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,4,'DNC',true,'(4 DNC)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,4,'DNC',true,'(4 DNC)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,9,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,10,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,11,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,12,4,'DNC',false,'4 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-29er' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Sean Kum / Nigel Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regattas(name,slug,event_id,date,end_date,boat_class,division,total_fleet_size,race_count,geography,counts_for_ranking,is_selection_trial,venue,organizer,schedule_notes,status,created_at,updated_at)
select 'Singapore Youth Sailing Championships 2026 (Techno 293)','sysc-2026-techno-293',e.id,'2026-03-14','2026-03-17','Techno 293','Open',7,11,'SG',false,false,'National Sailing Centre, Singapore','Singapore Sailing Federation','Official final results from T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','published',now(),now()
from public.regatta_events e where e.slug='sysc-2026'
on conflict(slug) do update set event_id=excluded.event_id,end_date=excluded.end_date,boat_class=excluded.boat_class,division=excluded.division,total_fleet_size=excluded.total_fleet_size,race_count=excluded.race_count,status='published',updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Axl Tan','axl-tan-64','64','Anglo-Chinese School (Barker Road)','M','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,1,13,19,false,false,'M','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,3,null,true,'(3)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,3,null,true,'(3)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,9,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,10,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,11,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Axl Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Trevor Ng','trevor-ng-45','45','Victoria School','M','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,2,16,22,false,false,'M','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,3,null,true,'(3)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,9,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,10,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,11,3,null,true,'(3)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Trevor Ng'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Addy Armand Anuar','addy-armand-anuar-143','143','Bedok Green Secondary School','M','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,3,19,29,false,false,'M','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,5,null,true,'(5)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,5,null,true,'(5)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,2,null,false,'2',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,9,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,10,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,11,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Addy Armand Anuar'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Eunice Yi Ning Tan','eunice-yi-ning-tan-679','679','Dunman High School','F','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,4,41,55,false,false,'F','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,6,null,true,'(6)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,8,'DNF',true,'(8 DNF)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,9,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,10,6,null,false,'6',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,11,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Eunice Yi Ning Tan'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Shan Qi','shan-qi-26','26','Bedok View Secondary School','F','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,5,42,56,false,false,'F','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,6,null,true,'(6)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,6,null,false,'6',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,8,'DNS',true,'(8 DNS)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,6,null,false,'6',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,9,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,10,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,11,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Shan Qi'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Kate Teo','kate-teo-235','235','Paya Lebar Methodist Girls'' School','F','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,6,43,57,false,false,'F','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,6,null,true,'(6)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,3,null,false,'3',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,8,'DNF',true,'(8 DNF)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,6,null,false,'6',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,5,null,false,'5',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,9,6,null,false,'6',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,10,4,null,false,'4',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,11,6,null,false,'6',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Kate Teo'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Michael Shi Jun Lim','michael-shi-jun-lim-38','38','St. Joseph''s Institution International','M','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,7,72,88,false,false,'M','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-techno-293'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,8,'DNC',true,'(8 DNC)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,8,'DNC',true,'(8 DNC)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,8,'DNC',false,'8 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,8,'DNC',false,'8 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,8,'DNC',false,'8 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,6,8,'DNC',false,'8 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,7,8,'DNC',false,'8 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,8,8,'DNC',false,'8 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,9,8,'DNC',false,'8 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,10,8,'DNC',false,'8 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,11,8,'DNC',false,'8 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-techno-293' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Michael Shi Jun Lim'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regattas(name,slug,event_id,date,end_date,boat_class,division,total_fleet_size,race_count,geography,counts_for_ranking,is_selection_trial,venue,organizer,schedule_notes,status,created_at,updated_at)
select 'Singapore Youth Sailing Championships 2026 (iQFOiL)','sysc-2026-iqfoil',e.id,'2026-03-14','2026-03-17','iQFOiL','Open',2,5,'SG',false,false,'National Sailing Centre, Singapore','Singapore Sailing Federation','Official final results from T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','published',now(),now()
from public.regatta_events e where e.slug='sysc-2026'
on conflict(slug) do update set event_id=excluded.event_id,end_date=excluded.end_date,boat_class=excluded.boat_class,division=excluded.division,total_fleet_size=excluded.total_fleet_size,race_count=excluded.race_count,status='published',updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'Angyal Chew','angyal-chew-711','711',null,'F','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Angyal Chew'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,1,6,9,false,false,'F','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('Angyal Chew'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-iqfoil'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,3,'DNC',true,'(3 DNC)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-iqfoil' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Angyal Chew'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,3,'DNC',false,'3 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-iqfoil' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Angyal Chew'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-iqfoil' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Angyal Chew'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-iqfoil' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Angyal Chew'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-iqfoil' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('Angyal Chew'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.sailors(name,handle,sail_number,club,gender,nationality,created_at,updated_at)
select 'John Tze Xiang Wong','john-tze-xiang-wong-2','2','Singapore Sports School','M','SGP',now(),now()
where not exists(select 1 from public.sailors s where regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('John Tze Xiang Wong'),'[^a-z0-9]','','g'));
insert into public.regatta_results(sailor_id,regatta_id,rank,nett_score,total_score,is_dns,is_overseas_commitment,gender,nationality,evidence_name,evidence_type,evidence_notes,verification_status,verified_at,created_at,updated_at)
select s.id,r.id,2,8,11,false,false,'M','SGP','T293, iQFOiL and 29er Results are final as of 0025hrs on 19 March 2026.pdf','pdf','Official final results supplied by administrator.','verified',now(),now(),now()
from public.regattas r join lateral(select id from public.sailors where regexp_replace(lower(name),'[^a-z0-9]','','g')=regexp_replace(lower('John Tze Xiang Wong'),'[^a-z0-9]','','g') limit 1)s on true
where r.slug='sysc-2026-iqfoil'
on conflict(sailor_id,regatta_id) do update set rank=excluded.rank,nett_score=excluded.nett_score,total_score=excluded.total_score,gender=excluded.gender,evidence_name=excluded.evidence_name,evidence_type='pdf',verification_status='verified',verified_at=now(),updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,1,1,'SCP',false,'1 SCP',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-iqfoil' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('John Tze Xiang Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,2,1,null,false,'1',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-iqfoil' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('John Tze Xiang Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,3,3,'DNC',true,'(3 DNC)',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-iqfoil' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('John Tze Xiang Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,4,3,'DNC',false,'3 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-iqfoil' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('John Tze Xiang Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();


insert into public.regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value,created_at,updated_at)
select rr.id,5,3,'DNC',false,'3 DNC',now(),now()
from public.regatta_results rr join public.regattas r on r.id=rr.regatta_id join public.sailors s on s.id=rr.sailor_id
where r.slug='sysc-2026-iqfoil' and regexp_replace(lower(s.name),'[^a-z0-9]','','g')=regexp_replace(lower('John Tze Xiang Wong'),'[^a-z0-9]','','g')
on conflict(regatta_result_id,race_number) do update set score=excluded.score,scoring_code=excluded.scoring_code,discarded=excluded.discarded,raw_value=excluded.raw_value,updated_at=now();

commit;
