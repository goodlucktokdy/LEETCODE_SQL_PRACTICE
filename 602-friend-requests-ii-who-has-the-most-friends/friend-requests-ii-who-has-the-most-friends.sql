# Write your MySQL query statement below
with pairs as (
    select 
        requester_id,
        accepter_id
    from 
        RequestAccepted
    union all
    select 
        accepter_id,
        requester_id
    from 
        RequestAccepted
),
ranks_cte as (
    select 
        id,
        num,
        dense_rank() over (order by num desc) as ranks
    from (
        select 
            requester_id as id,
            count(distinct accepter_id) as num
        from 
            pairs 
        group by 
            requester_id
    ) a
)
select 
    id,
    num
from 
    ranks_cte 
where
    ranks = 1