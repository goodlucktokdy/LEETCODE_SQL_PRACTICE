# Write your MySQL query statement below
with base as (
    select 
        b.country_name as country_name,
        avg(a.weather_state) as weathers
    from 
        Weather a 
    left join 
        Countries b 
    on 
        a.country_id = b.country_id
    where 
        date_format(a.day,'%Y-%m') = '2019-11'
    group by 
        country_name
)
select 
    country_name,
    case when weathers <= 15 then 'Cold'
        when weathers >= 25 then 'Hot' 
        else 'Warm' end as weather_type
from 
    base