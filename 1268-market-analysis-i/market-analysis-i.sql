select 
    a.buyer_id,
    a.join_date,
    count(distinct case when year(a.order_date) = 2019 then a.order_id else null end) as orders_in_2019
from (
    select
        a.user_id as buyer_id,
        a.join_date,
        b.order_id,
        b.order_date
    from 
        Users a 
    left join
        Orders b
    on 
        a.user_id = b.buyer_id
) a
group by 
    a.buyer_id, a.join_date        
