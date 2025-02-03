with recursive cte as (
    select 
        1 as month
    union all
    select 
        cte.month + 1 
    from    
        cte 
    where   
        cte.month < 12
), 
final_info as (
    select 
        a.month as month,
        round(avg(coalesce(b.ride_distance,0)) over (order by a.month range between 0 preceding and 2 following),2) as average_ride_distance,
        round(avg(coalesce(b.ride_duration,0)) over (order by a.month range between 0 preceding and 2 following),2) as average_ride_duration
    from 
        cte a 
    left join (
        select 
            month(a.requested_at) as month,
            sum(b.ride_distance) as ride_distance,
            sum(b.ride_duration) as ride_duration
        from 
            Rides a 
        inner join 
            AcceptedRides b 
        on 
            a.ride_id = b.ride_id
        where 
            year(a.requested_at) = 2020
        group by 
            month 
    ) b 
    on 
        a.month = b.month 
)
select 
    month,
    average_ride_distance,
    average_ride_duration
from 
    final_info 
where 
    month <= 10 
order by 
    month 