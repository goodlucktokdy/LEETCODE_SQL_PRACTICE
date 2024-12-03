with recents as (
    select
        product_id,
        max(order_date) as most_recent
    from 
        Orders 
    group by 
        product_id
)
select
    c.product_name,
    a.product_id,
    b.order_id,
    a.most_recent as order_date
from 
    recents a
inner join 
    Orders b
on 
    a.product_id = b.product_id and a.most_recent = b.order_date
inner join 
    Products c
on
    a.product_id = c.product_id
order by 
    c.product_name asc, a.product_id asc, b.order_id asc
