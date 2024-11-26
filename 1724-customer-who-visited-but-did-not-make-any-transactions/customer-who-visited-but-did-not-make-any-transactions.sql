with base as (
    select 
        a.visit_id,
        a.customer_id,
        b.transaction_id
    from 
        Visits a 
    left join 
        Transactions b
    on 
        a.visit_id = b.visit_id
)
select 
    a.customer_id,
    (count(distinct a.visit_id) - count(distinct case when a.transaction_id is not null then a.visit_id else null end)) as count_no_trans
from (
    select 
        visit_id,
        customer_id,
        transaction_id
    from 
        base 
    where 
        customer_id in (select distinct customer_id from base where transaction_id is null)
) a
group by 
    1