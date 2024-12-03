select
    round(coalesce(100.0*count(distinct case when a.state = 'immediate' then a.delivery_id else null end)/count(distinct a.delivery_id),0),2) as immediate_percentage
from (
    select
        delivery_id,
        customer_id,
        order_date,
        if(order_date = customer_pref_delivery_date,'immediate','scheduled') as state
    from 
        Delivery
) a
