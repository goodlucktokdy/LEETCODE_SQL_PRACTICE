# Write your MySQL query statement below
with base as (
    select 
        customer_id,
        total_amount,
        transaction_count,
        unique_categories,
        avg_transaction_amount,
        round((transaction_count * 10) + (total_amount/100),2) as loyalty_score
    from (
        select 
            a.customer_id,
            round(sum(a.amount),2) as total_amount,
            count(distinct a.transaction_id) as transaction_count,
            count(distinct b.category) as unique_categories,
            round(avg(a.amount),2) as avg_transaction_amount
        from 
            Transactions a
        inner join 
            Products b 
        on 
            a.product_id = b.product_id
        group by 
            a.customer_id
    ) a
),
category_ranks as (
    select 
        customer_id,
        category,
        dense_rank() over (partition by customer_id order by cnts desc, transaction_date desc) as ranks
    from (
        select 
            a.customer_id,
            b.category,
            a.transaction_date,
            count(a.transaction_id) over (partition by a.customer_id,b.category) as cnts
        from 
            Transactions a 
        inner join 
            Products b 
        on 
            a.product_id = b.product_id
    ) a
)
select 
    a.customer_id,
    a.total_amount,
    a.transaction_count,
    a.unique_categories,
    a.avg_transaction_amount,
    b.category as top_category,
    a.loyalty_score
from 
    base a 
inner join 
    category_ranks b 
on 
    a.customer_id = b.customer_id 
where 
    b.ranks = 1
order by 
    a.loyalty_score desc, a.customer_id asc 