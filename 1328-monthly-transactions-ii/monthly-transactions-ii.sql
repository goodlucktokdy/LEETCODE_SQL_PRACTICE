with base as (
    select 
        date_format(a.trans_date,'%Y-%m') as month,
        b.country,
        0 as approved_count,
        0 as approved_amount,
        count(distinct a.trans_id) as chargeback_count,
        sum(b.amount) as chargeback_amount
    from 
        Chargebacks a 
    join 
        Transactions b
    on 
        a.trans_id = b.id
    group by 
        1,2
    union all
    select 
        date_format(trans_date,'%Y-%m') as month,
        country,
        count(distinct id) as approved_count,
        sum(amount) as approved_amount,
        0 as chargeback_count,
        0 as chargeback_amount
    from
        Transactions 
    where 
        state = 'approved'
    group by 
        1,2
)
select 
    month,
    country,
    sum(approved_count) as approved_count,
    sum(approved_amount) as approved_amount,
    sum(chargeback_count) as chargeback_count,
    sum(chargeback_amount) as chargeback_amount
from 
    base 
group by 
    1,2