# Write your MySQL query statement below
select 
    a.salesperson_id,
    a.name,
    coalesce(b.total,0) as total
from 
    Salesperson a 
left join (
    select 
        a.salesperson_id,
        sum(b.price) as total
    from 
        Customer a 
    inner join 
        Sales b 
    on 
        a.customer_id = b.customer_id
    group by 
        a.salesperson_id
) b
on 
    a.salesperson_id = b.salesperson_id
