# Write your MySQL query statement below
with base as (
    select 
        year,
        product_id,
        curr_year_spend,
        lag(curr_year_spend) over (partition by product_id order by year) as prev_year_spend
    from (
        select 
            year(transaction_date) as year,
            product_id,
            sum(spend) as curr_year_spend
        from 
            user_transactions
        group by 
            year, product_id
    ) b
)
select 
    year,
    product_id,
    curr_year_spend,
    prev_year_spend,
    round(100.0*(curr_year_spend - prev_year_spend)/prev_year_spend,2) as yoy_rate
from 
    base 
order by 
    product_id, year