create or replace view toptreatment as

with top_treatm as(
select td.treatment_id ti, count(treatment_id) as c
from treatment_details td
group by ti
order by c desc
limit 1
),
patient as(
select td.patient_id pi
from treatment_details td, top_treatm tt
where td.treatment_id = tt.ti
),
amt as(
select sum(p.amount_due) s
from payments p, patient pa
where p.patient_id = pa.pi
)
select t.treatment_name, amt.s
from treatment t, amt, top_treatm tt
where t.treatment_id = tt.ti;
