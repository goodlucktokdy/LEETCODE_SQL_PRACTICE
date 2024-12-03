with base as (
    select
        a.order_id,
        a.customer_id,
        c.name,
        a.product_id,
        month(a.order_date) as month,
        a.quantity * b.price as sales
    from 
        Orders a
    left join
        Product b
    on 
        a.product_id = b.product_id
    left join
        Customers c
    on 
        a.customer_id = c.customer_id
    where 
        a.order_date between '2020-06-01' and '2020-07-31'
)
select
    a.customer_id,
    a.name
from (
    select
        distinct
        customer_id,
        name,
        month,
        sum(sales) over (partition by month, customer_id) as sum_sales_month
    from 
        base
) a
where 
    a.sum_sales_month >= 100
group by 
    1,2
having 
    count(customer_id) = 2 