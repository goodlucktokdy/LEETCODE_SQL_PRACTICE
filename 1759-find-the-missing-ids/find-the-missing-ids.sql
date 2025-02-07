# Write your MySQL query statement below
with recursive cte as (
    select 
        1 as ids
    from 
        Customers
    union all
    select 
        cte.ids + 1 
    from 
        cte 
    where 
        cte.ids < (select max(customer_id) from Customers)
)
select 
    distinct
    ids
from 
    cte a
left join 
    Customers b 
on 
    a.ids = b.customer_id
where 
    b.customer_id is null
order by 
    ids