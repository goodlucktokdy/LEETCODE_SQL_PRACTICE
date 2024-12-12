# Write your MySQL query statement below
select 
    a.interval_no,
    sum(order_count) as total_orders
from (
    select 
        minute,
        order_count,
        ceil(minute / 6) as interval_no 
    from 
        Orders
) a
group by 
    a.interval_no
order by 
    a.interval_no asc