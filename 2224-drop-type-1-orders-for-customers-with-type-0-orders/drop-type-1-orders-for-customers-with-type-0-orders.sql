# Write your MySQL query statement below
select 
    order_id,
    customer_id,
    order_type
from 
    Orders 
where 
    order_type = 0
union all
select 
    order_id,
    customer_id,
    order_type
from 
    Orders a 
where not exists 
    (select 1 from Orders b    
        where a.customer_id = b.customer_id and b.order_type = 0)
and 
    order_type = 1