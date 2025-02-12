# Write your MySQL query statement below
select 
    first_name,
    type,
    date_format(sec_to_time(duration),'%H:%i:%S') as duration_formatted
from (
    select 
        a.first_name,
        b.type,
        dense_rank() over (partition by b.type order by b.duration desc) as ranks,
        b.duration
    from 
        Contacts a 
    inner join 
        Calls b 
    on 
        a.id = b.contact_id
) a
where 
    ranks <= 3
order by 
    type desc, duration desc, first_name desc