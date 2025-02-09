# Write your MySQL query statement below
select  
    name
from (
    select 
        a.id,
        a.name,
        b.id as bid,
        b.name as bname
    from 
        Employee a
    inner join 
        Employee b 
    on 
        a.id = b.managerId
) a
group by 
    id 
having 
    count(distinct bid) >= 5