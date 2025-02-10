# Write your MySQL query statement below
with recursive cte as (
    select 
        1 as customer_id
    union all
    select 
        cte.customer_id + 1
    from 
        cte 
    where 
        cte.customer_id < (select max(customer_id) from Customers)
)
select
    a.customer_id as ids
from 
    cte a 
left join 
    Customers b 
on 
    a.customer_id = b.customer_id 
where 
    b.customer_id is null
order by 
    ids