create or replace view mostfreqissues as
with reason as(
select record_description rd, count(record_description) c
from record
group by record_description
order by c desc
limit 1
),
patient as(
select patient_id
from record, reason
where record.record_description = reason.rd
)
select r.rd as reason, r.c as freq, t.treatment_name
from treatment t, treatment_details td, patient p, reason r
where td.patient_id = p.patient_id;
