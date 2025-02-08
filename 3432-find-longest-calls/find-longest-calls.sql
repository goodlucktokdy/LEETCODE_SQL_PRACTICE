# Write your MySQL query statement below
with base as (
    select 
        first_name,
        type,
        date_format(sec_to_time(duration),'%H:%i:%S') as duration_formatted,
        dense_rank() over (partition by type order by duration desc) as ranks
    from (
        select 
            a.first_name,
            b.type,
            b.duration as duration
        from 
            Contacts a
        inner join 
            Calls b 
        on 
            a.id = b.contact_id
    ) a
)
select 
    first_name,
    type,
    duration_formatted
from 
    base 
where 
    ranks <= 3
order by 
    type desc, duration_formatted desc, first_name desc 
