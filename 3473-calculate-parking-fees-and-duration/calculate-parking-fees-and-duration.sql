# Write your MySQL query statement below
with base as (
    select 
        a.lot_id,
        a.car_id,
        sum(a.diff_of_minutes)/60 as duration,
        sum(a.fee_paid) as total_paid
    from (
        select 
            lot_id,
            car_id,
            fee_paid,
            timestampdiff(minute,entry_time,exit_time) as diff_of_minutes
        from 
            ParkingTransactions
    ) a
    group by 
        1,2
)
select 
    distinct
    car_id,
    round(sum(total_paid) over (partition by car_id),2) as total_fee_paid,
    round(sum(total_paid) over (partition by car_id)/sum(duration) over (partition by car_id),2) as avg_hourly_fee,
    first_value(lot_id) over (partition by car_id order by duration desc) as most_time_lot
from 
    base
order by 
    car_id