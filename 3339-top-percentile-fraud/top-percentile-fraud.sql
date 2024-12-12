# Write your MySQL query statement below
select 
    a.policy_id as policy_id,
    a.state as state,
    a.fraud_score
from (
    select 
        distinct
        policy_id,
        state,
        fraud_score,
        percent_rank() over (partition by state order by fraud_score desc) as percentile
    from 
        Fraud
) a 
where 
    a.percentile <= 0.05
order by 
    state asc, fraud_score desc, policy_id asc