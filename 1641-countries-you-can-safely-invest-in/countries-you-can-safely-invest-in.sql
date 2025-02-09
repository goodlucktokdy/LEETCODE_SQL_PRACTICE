# Write your MySQL query statement below
with base as (
    select 
        a.id,
        a.name,
        b.name as country
    from 
        Person a 
    inner join 
        Country b 
    on 
        substring(a.phone_number,1,3) = b.country_code
),
call_pairs as (
    select 
        caller_id as country_id,
        duration
    from 
        Calls
    union all
    select 
        callee_id as country_id,
        duration
    from 
        Calls
)
select 
    distinct 
    country
from (
    select 
        a.country,
        b.duration,
        avg(b.duration) over (partition by a.country) as country_avg,
        avg(b.duration) over () as total_avg
    from 
        base a 
    inner join 
        call_pairs b 
    on 
        a.id = b.country_id
    inner join 
        base c
    on 
        b.country_id = c.id
) a
where 
    country_avg > total_avg