# Write your MySQL query statement below
with base as (
    select 
        a.customer_id,
        a.customer_name,
        b.product_name
    from 
        Customers a 
    inner join 
        Orders b 
    on 
        a.customer_id = b.customer_id
)
select 
    customer_id,
    customer_name
from (
    select 
        a.customer_id,
        a.customer_name,
        a.product_name
    from 
        base a 
    where not exists 
        (select 1 from base b 
            where a.customer_id = b.customer_id and b.product_name = 'C')
    and exists
        (select 1 from base b 
            where a.customer_id = b.customer_id and b.product_name in ('A','B'))
) a 
where 
    product_name in ('A','B')
group by 
    customer_id,customer_name 
having 
    count(distinct product_name) = 2
order by 
    customer_id