select
    a.customer_id
from (
    select
        distinct
        customer_id,
        year,
        sum(revenue) over (partition by year, customer_id) as sum_revenue
    from 
        Customers
) a
where
    a.sum_revenue > 0 and a.year = 2021
