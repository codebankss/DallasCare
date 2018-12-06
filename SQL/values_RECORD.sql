insert into RECORD values('1', 'P110', 'P103', date_add(curdate(), interval 3 day), curdate(), 'fever');
insert into RECORD values('2', 'P110', 'P109', date_add(curdate(), interval 5 day), curdate(), 'indigestion');
insert into RECORD values('3', 'P111', 'P112', date_add(curdate(), interval 2 day), curdate(), 'cough');
insert into RECORD values('4', 'P111', 'P113', date_add(curdate(), interval 2 day), curdate(), 'loose motion');
commit;


