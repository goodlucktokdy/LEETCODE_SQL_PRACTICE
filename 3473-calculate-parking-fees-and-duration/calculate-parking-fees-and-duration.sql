# Write your MySQL query statement below
with base as (
    select 
        car_id,
        lot_id,
        diff_seconds,
        total_fee_paid,
        dense_rank() over (partition by car_id order by diff_seconds desc) as lot_ranks
    from (
        select 
            car_id,
            lot_id,
            sum(timestampdiff(second,entry_time,exit_time)) as diff_seconds,
            sum(fee_paid) as total_fee_paid
        from 
            ParkingTransactions
        group by 
            car_id, lot_id
    ) a
)
select 
    car_id,
    round(sum(total_fee_paid),2) as total_fee_paid,
    round(sum(total_fee_paid)/(sum(diff_seconds)/3600),2) as avg_hourly_fee,
    max(case when lot_ranks = 1 then lot_id else null end) as most_time_lot
from 
    base 
group by 
    car_id 
order by 
    car_id