# Write your MySQL query statement below
select 
    coalesce(round(sum(a.total_items)/sum(a.order_occurrences),2),0) as average_items_per_order
from (
    select 
        order_id,
        item_count,
        order_occurrences,
        item_count * order_occurrences as total_items
    from 
        Orders
) a
