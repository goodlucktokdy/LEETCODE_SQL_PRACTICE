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
    id as ids
from 
    cte
where 
    id not in (select customer_id from Customers)
order by 
    ids