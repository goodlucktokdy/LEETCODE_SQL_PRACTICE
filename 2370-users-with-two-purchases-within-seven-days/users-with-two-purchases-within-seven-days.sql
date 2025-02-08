# Write your MySQL query statement below

select 
    distinct
    a.user_id
from 
    Purchases a 
inner join 
    Purchases b 
on 
    a.user_id = b.user_id and a.purchase_id != b.purchase_id
    and abs(timestampdiff(day,a.purchase_date,b.purchase_date)) <= 7
order by 
    a.user_id

