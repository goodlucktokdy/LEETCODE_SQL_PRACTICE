# Write your MySQL query statement below
with recursive cte as (
    select 
        1 as id
    union all
    select 
        cte.id + 1
    from 
        cte 
    where 
        cte.id < (select max(customer_id) from Customers where customer_id <= 100)
)
select 
    a.id as ids
from 
    cte a 
left join 
    Customers b 
on 
    a.id = b.customer_id
where 
    b.customer_id is null
order by 
    ids