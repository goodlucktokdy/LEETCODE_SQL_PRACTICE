# Write your MySQL query statement below
select 
    a.user_id as buyer_id,
    a.join_date as join_date,
    count(distinct b.order_id) as orders_in_2019
from 
    Users a 
left join 
    Orders b 
on 
    a.user_id = b.buyer_id and year(b.order_date) = 2019
group by 
    a.user_id, a.join_date