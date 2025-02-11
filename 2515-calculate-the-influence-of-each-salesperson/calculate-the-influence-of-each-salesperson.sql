# Write your MySQL query statement below
with base as (
    select 
        a.salesperson_id,
        a.customer_id,
        sum(b.price) as sales
    from 
        Customer a 
    inner join 
        Sales b 
    on 
        a.customer_id = b.customer_id
    group by 
        a.salesperson_id, a.customer_id
)
select 
    a.salesperson_id,
    a.name,
    sum(coalesce(b.sales,0)) as total
from 
    Salesperson a
left join 
    base b 
on 
    a.salesperson_id = b.salesperson_id
group by 
    a.salesperson_id, a.name