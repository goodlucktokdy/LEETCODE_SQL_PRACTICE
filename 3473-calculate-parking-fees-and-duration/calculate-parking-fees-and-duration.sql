# Write your MySQL query statement below
with fee_cte as (
    select 
        car_id,
        round(total_fee_paid,2) as total_fee_paid,
        round(total_fee_paid/(total_time/3600),2) as avg_hourly_fee
    from (
        select 
            car_id,
            sum(timestampdiff(second,entry_time,exit_time)) as total_time,
            sum(fee_paid) as total_fee_paid
        from 
            ParkingTransactions
        group by 
            car_id
    ) a
),
lot_cte as (
    select 
        car_id,
        lot_id,
        dense_rank() over (partition by car_id order by lot_times desc) as ranks
    from (
        select 
            car_id,
            lot_id,
            sum(timestampdiff(second,entry_time,exit_time)) as lot_times
        from 
            ParkingTransactions
        group by 
            car_id, lot_id
    ) a
)
select 
    a.car_id,
    a.total_fee_paid,
    a.avg_hourly_fee,
    b.lot_id as most_time_lot
from 
    fee_cte a 
inner join 
    lot_cte b 
on 
    a.car_id = b.car_id
where 
    b.ranks = 1
order by 
    a.car_id asc 