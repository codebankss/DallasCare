insert into ROOM values ('102', 'P102', 'Special', curdate(), date_add(curdate(), interval 30 day));
insert into ROOM values ('103', 'P102', 'Ordinary', curdate(), date_add(curdate(), interval 30 day));
insert into ROOM values ('104', 'P104', 'Suite', curdate(), date_add(curdate(), interval 30 day));
insert into ROOM values ('105', 'P106', 'Special', curdate(), date_add(curdate(), interval 30 day));
insert into ROOM values ('106', 'P108', 'Special', curdate(), date_add(curdate(), interval 30 day));
commit;