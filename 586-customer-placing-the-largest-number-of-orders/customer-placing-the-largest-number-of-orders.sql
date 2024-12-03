with maximum as (
    select
        customer_number,
        count(distinct order_number) as orders
    from 
        Orders
    group by 
        1
)
select
    a.customer_number
from (
    select
        customer_number,
        rank() over (order by orders desc) as ranks
    from 
        maximum
) a
where
    a.ranks = 1