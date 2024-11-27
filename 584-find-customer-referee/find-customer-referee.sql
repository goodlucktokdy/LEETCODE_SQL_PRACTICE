# Write your MySQL query statement below
with base as (
    select 
        distinct
        a.id,
        a.name
    from 
        Customer a
    where 
        referee_id != 2 or referee_id is null
)
select 
    name
from 
    base