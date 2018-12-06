create or replace view topdoctor as
with checked_class1 as(
select consult_doctor d1, count(consult_doctor)  as c1
from class1_patient
where consult_doctor in (select emp_id from doctor) 
group by consult_doctor
),
checked_class2 as(
select consult_doctor d2, count(consult_doctor)  as c2
from class2_patient_consultation
where consult_doctor in (select emp_id from doctor) 
group by consult_doctor
)
select p.person_id, p.first_name, p.last_name, start_date, sum(c1+c2) total_patients
from person p, doctor d, checked_class1 cn1, checked_class2 cn2
where p.person_id = d.emp_id
and d.emp_id = cn1.d1
and cn1.c1 > 5
and d.emp_id = cn2.d2
and cn2.c2 > 10
group by person_id, first_name, last_name, start_date
;