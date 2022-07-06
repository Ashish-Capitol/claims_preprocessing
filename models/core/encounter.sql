-------------------------------------------------------------------------------
-- Author       Thu Xuan Vu
-- Created      June 2022
-- Purpose      Populate encounter level details with insitutional data elements taking priority.
-------------------------------------------------------------------------------
-- Modification History
-- TXV 07/2022  Resolving bug that was omitting inst elemts (discharge disp, admit type)
--              due to prof claim link and logic.
-------------------------------------------------------------------------------

select distinct
  coalesce(i.encounter_id, p.encounter_id) as encounter_id
  ,coalesce(i.patient_id, p.patient_id) as patient_id
  ,coalesce(i.encounter_type, p.encounter_type) as encounter_type
  ,coalesce(i.encounter_start_date, p.encounter_start_date) as encounter_start_date
  ,coalesce(i.encounter_end_date, p.encounter_end_date) as encounter_end_date
  ,coalesce(i.admit_source_code, p.admit_source_code) as admit_source_code
  ,coalesce(i.admit_source_description, p.admit_source_description) as admit_source_description
  ,coalesce(i.admit_type_code, p.admit_type_code) as admit_type_code
  ,coalesce(i.admit_type_description, p.admit_type_description) as admit_type_description
  ,coalesce(i.discharge_disposition_code, p.discharge_disposition_code) as discharge_disposition_code
  ,coalesce(i.discharge_disposition_description, p.discharge_disposition_description) as discharge_disposition_description
  ,coalesce(i.physician_npi, p.physician_npi) as physician_npi
  ,coalesce(i.location, p.location) as location
  ,coalesce(i.facility_npi, p.facility_npi) as facility_npi
  ,coalesce(i.ms_drg, p.ms_drg) as ms_drg
  ,coalesce(i.paid_amount, p.paid_amount) as paid_amount
  ,coalesce(i.charge_amount, p.charge_amount) as charge_amount
from cclf_claims_preprocessing.encounter_inst_stage i
full outer join cclf_claims_preprocessing.encounter_prof_stage p
  on i.encounter_id = p.encounter_id