# Write your MySQL query statement below
with base as (
    select 
        invoice_id,
        sales,
        dense_rank() over (order by sales desc, invoice_id asc) as ranks
    from (
        select 
            a.invoice_id as invoice_id,
            sum(b.price * a.quantity) as sales 
        from 
            Purchases a 
        inner join 
            Products b 
        on 
            a.product_id = b.product_id
        group by 
            invoice_id
    ) a
)
select 
    a.product_id as product_id,
    b.quantity as quantity,
    a.price * b.quantity as price
from 
    Products a 
inner join 
    Purchases b 
on 
    a.product_id = b.product_id
where 
    b.invoice_id in (select invoice_id from base where ranks = 1)
