with base as (
    select
        customer_id
    from
        Orders
    where 
        product_name = 'C'
), mid_cte as (
    select
        distinct
        customer_id,
        case when product_name = 'A' then 1 else null end as A,
        case when product_name = 'B' then 1 else null end as B
    from 
        Orders
    where
        customer_id not in (select * from base)
)
select
    a.customer_id,
    b.customer_name
from
    mid_cte a 
inner join
    Customers b
on
    a.customer_id = b.customer_id
group by 
    1,2
having 
    max(A) = 1 and max(B) = 1
order by 
    a.customer_id
