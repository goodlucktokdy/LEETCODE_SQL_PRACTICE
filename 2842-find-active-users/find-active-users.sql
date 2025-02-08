# Write your MySQL query statement below
with base as (
    select 
        user_id,
        item,
        created_at,
        amount,
        row_number() over () as rnums
    from 
        Users
)
select 
    distinct 
    a.user_id
from 
    base a 
inner join 
    base b 
on 
    a.user_id = b.user_id and a.rnums != b.rnums
    and abs(datediff(a.created_at,b.created_at)) <=7