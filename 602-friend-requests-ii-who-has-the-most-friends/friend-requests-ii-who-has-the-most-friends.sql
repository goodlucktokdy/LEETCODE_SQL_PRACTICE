# Write your MySQL query statement below
with base as (
    select 
        requester_id as id,
        count(accepter_id) as num
    from 
        RequestAccepted
    where 
        requester_id != accepter_id
    group by 
        1
    union all 
    select 
        accepter_id as id,
        count(requester_id) as num
    from 
        RequestAccepted
    where 
        requester_id != accepter_id
    group by 
        accepter_id
)
, ranking as (
    select 
        a.id,
        num,
        dense_rank() over (order by a.num desc) as ranks
    from (
        select 
            id,
            sum(num) as num
        from 
            base 
        group by 
            id
    ) a
)
select 
    id,
    num
from 
    ranking
where 
    ranks = 1