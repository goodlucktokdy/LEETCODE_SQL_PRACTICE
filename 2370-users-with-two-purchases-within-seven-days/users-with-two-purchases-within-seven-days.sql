# Write your MySQL query statement below
select 
    distinct 
    user_id
from (
    select 
        a.user_id,
        a.purchase_date,
        b.purchase_date as bdate
    from 
        Purchases a 
    inner join 
        Purchases b 
    on 
        a.user_id = b.user_id and a.purchase_id != b.purchase_id
        and abs(datediff(a.purchase_date,b.purchase_date)) <= 7
) a 
order by 
    user_id