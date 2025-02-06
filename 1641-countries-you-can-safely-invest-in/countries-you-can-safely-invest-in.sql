# Write your MySQL query statement below
with base as (
    select 
        b.id,
        b.name,
        a.name as country
    from 
        Country a 
    inner join (
        select 
            id,
            name,
            left(phone_number,3) as country_code
        from 
            Person
    ) b 
    on
        a.country_code = b.country_code
),
pairs as (
    select 
        caller_id,
        callee_id,
        duration
    from 
        Calls
    union all
    select 
        callee_id,
        caller_id,
        duration
    from 
        Calls
)
select 
    distinct
    callers as country
from (
    select 
        a.country as callers,
        duration,
        avg(b.duration) over () as global_avg,
        avg(b.duration) over (partition by a.country) as country_avg
    from 
        base a 
    inner join 
        pairs b 
    on 
        a.id = b.caller_id
    inner join 
        base c 
    on 
        b.callee_id = c.id
) a
where 
    country_avg > global_avg