# Write your MySQL query statement below
with base as (
    select 
        a.contact_id,
        b.first_name,
        a.type,
        a.duration
    from 
        Calls a 
    left join 
        Contacts b 
    on 
        a.contact_id = b.id
)
, dense_ranks as (
    select 
        distinct
        first_name,
        type,
        date_format(sec_to_time(duration),'%H:%i:%s') as duration,
        case when type = 'incoming' then 
        dense_rank() over (partition by type order by duration desc) end as incomings,
        case when type = 'outgoing' then
        dense_rank() over (partition by type order by duration desc) end as outgoings
    from 
        base
)
select 
    first_name,
    type,
    duration as duration_formatted
from 
    dense_ranks
where
    (incomings <=3 and outgoings is null) or (outgoings <= 3 and incomings is null)
order by 
    type desc, duration_formatted desc, first_name desc