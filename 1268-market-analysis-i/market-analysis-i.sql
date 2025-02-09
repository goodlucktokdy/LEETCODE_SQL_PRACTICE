# Write your MySQL query statement below
select 
    a.user_id as buyer_id,
    a.join_date,
    count(distinct case when year(b.order_date) = 2019 then b.order_id else null end) as orders_in_2019
from 
    Users a 
left join 
    Orders b 
on 
    a.user_id = b.buyer_id
group by 
    a.user_id, a.join_date