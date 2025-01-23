-- -- -- -- -- -- -- -- # Write your MySQL query statement below
-- -- -- -- -- -- -- -- with recursive cte as (
-- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- --         1 as month
-- -- -- -- -- -- -- --     union all
-- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- --         cte.month + 1
-- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- --         cte
-- -- -- -- -- -- -- --     where 
-- -- -- -- -- -- -- --         cte.month < 12
-- -- -- -- -- -- -- -- ),
-- -- -- -- -- -- -- -- base as (
-- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- --         a.month,
-- -- -- -- -- -- -- --         b.ride_id,
-- -- -- -- -- -- -- --         ifnull(c.driver_id,0) as driver_id,
-- -- -- -- -- -- -- --         ifnull(c.ride_distance,0) as ride_distance,
-- -- -- -- -- -- -- --         ifnull(c.ride_duration,0) as ride_duration
-- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- --         cte a
-- -- -- -- -- -- -- --     left join 
-- -- -- -- -- -- -- --         Rides b
-- -- -- -- -- -- -- --     on 
-- -- -- -- -- -- -- --         a.month = month(b.requested_at) and year(b.requested_at) = 2020
-- -- -- -- -- -- -- --     left join 
-- -- -- -- -- -- -- --         AcceptedRides c 
-- -- -- -- -- -- -- --     on 
-- -- -- -- -- -- -- --         b.ride_id = c.ride_id
-- -- -- -- -- -- -- -- ),
-- -- -- -- -- -- -- -- final_info as (
-- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- --         month,
-- -- -- -- -- -- -- --         round(avg(ride_distance) over (order by month range between 0 preceding and 2 following),2) as average_ride_distance,
-- -- -- -- -- -- -- --         round(avg(ride_duration) over (order by month range between 0 preceding and 2 following),2) as average_ride_duration
-- -- -- -- -- -- -- --     from (
-- -- -- -- -- -- -- --         select 
-- -- -- -- -- -- -- --             month,
-- -- -- -- -- -- -- --             sum(ride_distance) as ride_distance,
-- -- -- -- -- -- -- --             sum(ride_duration) as ride_duration
-- -- -- -- -- -- -- --         from 
-- -- -- -- -- -- -- --             base 
-- -- -- -- -- -- -- --         group by 
-- -- -- -- -- -- -- --             month
-- -- -- -- -- -- -- --     ) a
-- -- -- -- -- -- -- -- )
-- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- --     month,
-- -- -- -- -- -- -- --     average_ride_distance,
-- -- -- -- -- -- -- --     average_ride_duration
-- -- -- -- -- -- -- -- from 
-- -- -- -- -- -- -- --     final_info
-- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- --     month <= 10
-- -- -- -- -- -- -- with recursive cte as (
-- -- -- -- -- -- --     select 
-- -- -- -- -- -- --         1 as month
-- -- -- -- -- -- --     union all
-- -- -- -- -- -- --     select 
-- -- -- -- -- -- --         cte.month + 1
-- -- -- -- -- -- --     from    
-- -- -- -- -- -- --         cte
-- -- -- -- -- -- --     where 
-- -- -- -- -- -- --         cte.month < 12
-- -- -- -- -- -- -- ),
-- -- -- -- -- -- --  rolling_avg as (
-- -- -- -- -- -- --     select 
-- -- -- -- -- -- --         a.month,
-- -- -- -- -- -- --         round(avg(ifnull(b.ride_distance,0)) over (order by a.month range between 0 preceding and 2 following),2) as average_ride_distance,
-- -- -- -- -- -- --         round(avg(ifnull(b.ride_duration,0)) over (order by a.month range between 0 preceding and 2 following),2) as average_ride_duration
-- -- -- -- -- -- --     from 
-- -- -- -- -- -- --         cte a 
-- -- -- -- -- -- --     left join   (
-- -- -- -- -- -- --         select 
-- -- -- -- -- -- --             month(a.requested_at) as month,
-- -- -- -- -- -- --             sum(b.ride_distance) as ride_distance,
-- -- -- -- -- -- --             sum(b.ride_duration) as ride_duration
-- -- -- -- -- -- --         from 
-- -- -- -- -- -- --             Rides a 
-- -- -- -- -- -- --         inner join 
-- -- -- -- -- -- --             AcceptedRides b
-- -- -- -- -- -- --         on 
-- -- -- -- -- -- --             a.ride_id = b.ride_id
-- -- -- -- -- -- --         where 
-- -- -- -- -- -- --             year(a.requested_at) = 2020
-- -- -- -- -- -- --         group by 
-- -- -- -- -- -- --             month
-- -- -- -- -- -- --     ) b
-- -- -- -- -- -- --     on 
-- -- -- -- -- -- --         a.month = b.month
-- -- -- -- -- -- -- )
-- -- -- -- -- -- -- select 
-- -- -- -- -- -- --     month,
-- -- -- -- -- -- --     average_ride_distance,
-- -- -- -- -- -- --     average_ride_duration
-- -- -- -- -- -- -- from 
-- -- -- -- -- -- --     rolling_avg
-- -- -- -- -- -- -- where 
-- -- -- -- -- -- --     month < 11
-- -- -- -- -- -- with recursive cte as (
-- -- -- -- -- --     select 
-- -- -- -- -- --         1 as month
-- -- -- -- -- --     union all
-- -- -- -- -- --     select 
-- -- -- -- -- --         cte.month + 1
-- -- -- -- -- --     from 
-- -- -- -- -- --         cte 
-- -- -- -- -- --     where 
-- -- -- -- -- --         cte.month < 12
-- -- -- -- -- -- ),
-- -- -- -- -- -- base as (
-- -- -- -- -- --     select 
-- -- -- -- -- --         month(a.requested_at) as month,
-- -- -- -- -- --         sum(b.ride_distance) as ride_distance,
-- -- -- -- -- --         sum(b.ride_duration) as ride_duration
-- -- -- -- -- --     from 
-- -- -- -- -- --         Rides a 
-- -- -- -- -- --     inner join 
-- -- -- -- -- --         AcceptedRides b 
-- -- -- -- -- --     on 
-- -- -- -- -- --         a.ride_id = b.ride_id
-- -- -- -- -- --     where 
-- -- -- -- -- --         year(a.requested_at) = 2020
-- -- -- -- -- --     group by 
-- -- -- -- -- --         month
-- -- -- -- -- -- )
-- -- -- -- -- -- select 
-- -- -- -- -- --     month,
-- -- -- -- -- --     round(average_ride_distance,2) as average_ride_distance,
-- -- -- -- -- --     round(average_ride_duration,2) as average_ride_duration
-- -- -- -- -- -- from (
-- -- -- -- -- --     select 
-- -- -- -- -- --         a.month,
-- -- -- -- -- --         avg(ifnull(b.ride_distance,0)) over (order by a.month rows between 0 preceding and 2 following) as average_ride_distance,
-- -- -- -- -- --         avg(ifnull(b.ride_duration,0)) over (order by a.month rows between 0 preceding and 2 following) as average_ride_duration
-- -- -- -- -- --     from 
-- -- -- -- -- --         cte a 
-- -- -- -- -- --     left join 
-- -- -- -- -- --         base b 
-- -- -- -- -- --     on 
-- -- -- -- -- --         a.month = b.month
-- -- -- -- -- -- ) a 
-- -- -- -- -- -- where 
-- -- -- -- -- --     month <= 10
-- -- -- -- -- -- order by 
-- -- -- -- -- --     month


-- -- -- -- -- with recursive month_cte as (
-- -- -- -- --     select 
-- -- -- -- --         1 as month
-- -- -- -- --     union all
-- -- -- -- --     select 
-- -- -- -- --         month_cte.month + 1
-- -- -- -- --     from 
-- -- -- -- --         month_cte
-- -- -- -- --     where 
-- -- -- -- --         month_cte.month < 12
-- -- -- -- -- ),
-- -- -- -- -- distance_duration as (
-- -- -- -- --     select 
-- -- -- -- --         month(r.requested_at) as month,
-- -- -- -- --         sum(a.ride_distance) as sum_distance,
-- -- -- -- --         sum(a.ride_duration) as sum_duration
-- -- -- -- --     from 
-- -- -- -- --         Rides r 
-- -- -- -- --     inner join 
-- -- -- -- --         AcceptedRides a 
-- -- -- -- --     on 
-- -- -- -- --         a.ride_id = r.ride_id
-- -- -- -- --     where 
-- -- -- -- --         year(r.requested_at) = 2020
-- -- -- -- --     group by 
-- -- -- -- --         month
-- -- -- -- -- ),
-- -- -- -- -- final_info as (
-- -- -- -- --     select 
-- -- -- -- --         a.month as month,
-- -- -- -- --         round(avg(ifnull(b.sum_distance,0)) over (order by a.month range between 0 preceding and 2 following),2) as average_ride_distance,
-- -- -- -- --         round(avg(ifnull(b.sum_duration,0)) over (order by a.month range between 0 preceding and 2 following),2) as 
-- -- -- -- --     average_ride_duration
-- -- -- -- --     from 
-- -- -- -- --         month_cte a 
-- -- -- -- --     left join 
-- -- -- -- --         distance_duration b
-- -- -- -- --     on 
-- -- -- -- --         a.month = b.month
-- -- -- -- --     order by 
-- -- -- -- --         month
-- -- -- -- -- )
-- -- -- -- -- select 
-- -- -- -- --     *
-- -- -- -- -- from 
-- -- -- -- --     final_info 
-- -- -- -- -- where 
-- -- -- -- --     month <= 10
-- -- -- -- with recursive cte as (
-- -- -- --     select 
-- -- -- --         1 as month
-- -- -- --     union all
-- -- -- --     select 
-- -- -- --         cte.month + 1
-- -- -- --     from 
-- -- -- --         cte 
-- -- -- --     where 
-- -- -- --         cte.month < 12
-- -- -- -- ),
-- -- -- -- base as (
-- -- -- --     select 
-- -- -- --         month(a.requested_at) as month,
-- -- -- --         sum(b.ride_distance) as ride_distance,
-- -- -- --         sum(b.ride_duration) as ride_duration
-- -- -- --     from 
-- -- -- --         Rides a 
-- -- -- --     inner join 
-- -- -- --         AcceptedRides b 
-- -- -- --     on 
-- -- -- --         a.ride_id = b.ride_id 
-- -- -- --     where 
-- -- -- --         year(a.requested_at) = 2020
-- -- -- --     group by 
-- -- -- --         month
-- -- -- -- )
-- -- -- -- select 
-- -- -- --     month,
-- -- -- --     average_ride_distance,
-- -- -- --     average_ride_duration
-- -- -- -- from (
-- -- -- --     select 
-- -- -- --         a.month as month,
-- -- -- --         round(avg(ifnull(b.ride_distance,0)) over (order by a.month range between 0 preceding and 2 following),2) as average_ride_distance,
-- -- -- --         round(avg(ifnull(b.ride_duration,0)) over (order by a.month range between 0 preceding and 2 following),2) as average_ride_duration
-- -- -- --     from 
-- -- -- --         cte a 
-- -- -- --     left join 
-- -- -- --         base b 
-- -- -- --     on 
-- -- -- --         a.month = b.month 
-- -- -- -- ) a 
-- -- -- -- where 
-- -- -- --     month <= 10
-- -- -- -- order by 
-- -- -- --     month


-- -- -- with recursive cte as (
-- -- --     select 
-- -- --         1 as month
-- -- --     union all
-- -- --     select 
-- -- --         cte.month + 1 
-- -- --     from 
-- -- --         cte 
-- -- --     where 
-- -- --         cte.month < 12
-- -- -- ),
-- -- -- filtered_info as (
-- -- --     select 
-- -- --         month(a.requested_at) as month,
-- -- --         sum(b.ride_distance) as ride_distance,
-- -- --         sum(b.ride_duration) as ride_duration
-- -- --     from 
-- -- --         Rides a 
-- -- --     inner join 
-- -- --         AcceptedRides b 
-- -- --     on 
-- -- --         a.ride_id = b.ride_id
-- -- --     where 
-- -- --         year(a.requested_at) = 2020
-- -- --     group by 
-- -- --         month
-- -- -- )
-- -- -- select 
-- -- --     month,
-- -- --     average_ride_distance,
-- -- --     average_ride_duration
-- -- -- from (
-- -- --     select 
-- -- --         a.month,
-- -- --         round(avg(coalesce(b.ride_distance,0)) over (order by a.month range between 0 preceding and 2 following),2) as average_ride_distance,
-- -- --         round(avg(coalesce(b.ride_duration,0)) over (order by a.month range between 0 preceding and 2 following),2) as average_ride_duration
-- -- --     from 
-- -- --         cte a 
-- -- --     left join 
-- -- --         filtered_info b 
-- -- --     on 
-- -- --         a.month = b.month
-- -- -- ) a 
-- -- -- where 
-- -- --     month <= 10
-- -- -- order by 
-- -- --     month asc 

-- -- with recursive cte as (
-- --     select 
-- --         1 as month 
-- --     union all 
-- --     select 
-- --         cte.month + 1 
-- --     from    
-- --         cte 
-- --     where 
-- --         cte.month < 12
-- -- ),
-- -- sum_month as (
-- --     select 
-- --         month(a.requested_at) as month,
-- --         sum(b.ride_distance) as ride_distance,
-- --         sum(b.ride_duration) as ride_duration 
-- --     from 
-- --         Rides a 
-- --     inner join 
-- --         AcceptedRides b 
-- --     on
-- --         a.ride_id = b.ride_id 
-- --     where 
-- --         year(a.requested_at) = 2020
-- --     group by 
-- --         month 
-- -- ),
-- -- final_info as (
-- --     select 
-- --         month,
-- --         round(average_ride_distance,2) as average_ride_distance,
-- --         round(average_ride_duration,2) as average_ride_duration
-- --     from (
-- --         select 
-- --             a.month as month,
-- --             avg(coalesce(b.ride_distance,0)) over (order by a.month range between 0 preceding and 2 following) as average_ride_distance,
-- --             avg(coalesce(b.ride_duration,0)) over (order by a.month range between 0 preceding and 2 following) as average_ride_duration
-- --         from 
-- --             cte a 
-- --         left join 
-- --             sum_month b 
-- --         on 
-- --             a.month = b.month 
-- --     ) a 
-- --     order by 
-- --         month 
-- -- )
-- -- select 
-- --     month,
-- --     average_ride_distance,
-- --     average_ride_duration
-- -- from 
-- --     final_info 
-- -- where 
-- --     month <= 10 
-- -- order by 
-- --     month 
-- with recursive cte as (
--     select 
--         1 as month 
--     union all
--     select 
--         cte.month + 1 
--     from 
--         cte 
--     where 
--         cte.month < 12 
-- ),
-- base as (
--     select 
--         month(a.requested_at) as month,
--         sum(ride_distance) as ride_distance,
--         sum(ride_duration) as ride_duration
--     from 
--         Rides a 
--     inner join 
--         AcceptedRides b 
--     on 
--         a.ride_id = b.ride_id 
--     where 
--         year(a.requested_at) = 2020
--     group by 
--         month 
-- )
-- select 
--     month,
--     average_ride_distance,
--     average_ride_duration
-- from (
--     select 
--     a.month,
--     round(avg(coalesce(b.ride_distance,0)) over (order by a.month rows between 0 preceding and 2 following),2) as average_ride_distance,
--     round(avg(coalesce(b.ride_duration,0)) over (order by a.month rows between 0 preceding and 2 following),2) as average_ride_duration
--     from 
--         cte a 
--     left join 
--         base b 
--     on 
--         a.month = b.month
-- ) a 
-- where 
--     month <= 10
-- order by 
--     month

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