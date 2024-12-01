with base as (
    select
        stock_name,
        operation_day,
        price,
        sum(case when operation = 'Buy' then -1 * price else price end) over (partition by stock_name order by operation_day) as capital_gain_loss
    from 
        Stocks
)
select
    distinct
    stock_name,
    first_value(capital_gain_loss) over (partition by stock_name order by operation_day desc) as capital_gain_loss
from 
    base
