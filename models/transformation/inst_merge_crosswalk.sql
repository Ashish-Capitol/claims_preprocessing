-------------------------------------------------------------------------------
-- Author       Thu Xuan Vu
-- Created      June 2022
-- Purpose      Use recursion to umbrella claim pairs under one id.
-- Notes        
-------------------------------------------------------------------------------
-- Modification History
--
-------------------------------------------------------------------------------

with recursive stage (patient_id, group_claim_id, merge_claim_id, depth) as(
    select
        patient_id
        ,claim_id_a as group_claim_id
        , claim_id_a as merge_claim_id
        , 1 as depth
    from {{ ref('inst_merge_final')}}
    where claim_id_b is null

union all
  
    select
        a.patient_id
        ,s.group_claim_id
        ,a.claim_id_b as merge_claim_id
        ,s.depth + 1 as depth
    from {{ ref('inst_merge_final')}} a
    inner join stage s
        on a.claim_id_a = s.merge_claim_id
  )

select * from stage
where merge_claim_id is not null
  
