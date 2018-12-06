create or replace view potentialpatient as
with freq as(
select patient_id pi, count(patient_id) c
from class1_patient
group by pi
having c>3
),
notadmit as(
select pi from freq
where exists (select patient_id from class2_patient)
)
SELECT p.Person_ID, p.First_name, p.Last_name, c.phone_number
FROM person p, contacts c, notadmit na
WHERE c.person_id = p.person_id
and p.person_id = na.pi;
