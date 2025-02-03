with base as (
    select 
        year(order_date) as years,
        customer_id,
        sum(price) as total_sales
    from 
        Orders 
    group by 
        years, customer_id
),
prev_info as (
    select 
        customer_id,
        lag(years,1,years) over (partition by customer_id order by years) as prev_years,
        years,
        lag(total_sales,1,0) over (partition by customer_id order by years) as prev_sales,
        total_sales
    from 
        base 
)
select 
    distinct 
    customer_id
from 
    prev_info a 
where not exists 
    (select 1 from prev_info b 
        where a.customer_id = b.customer_id and (b.years - b.prev_years > 1 or b.total_sales - b.prev_sales <= 0))