with person_country as (
    select
        a.id,
        a.name,
        left(a.phone_number,3) as country_code,
        b.name as country_name
    from 
        Person a 
    inner join 
        Country b
    on 
        left(a.phone_number,3) = b.country_code
)
, caller_callee as (
    select
        a.caller_id,
        a.callee_id,
        a.duration,
        b.country_name as caller_state,
        c.country_name as callee_state
    from 
        person_country b
    inner join 
        Calls a
    on 
        a.caller_id = b.id
    inner join
        person_country c
    on 
        a.callee_id = c.id
), mid_cte as (
    select
        caller_state as country,
        duration
    from 
        caller_callee
    union all
    select
        callee_state as country,
        duration
    from 
        caller_callee
)
select
    country
from 
    mid_cte
group by 
    country
having 
    avg(duration) > (select avg(duration) from mid_cte)