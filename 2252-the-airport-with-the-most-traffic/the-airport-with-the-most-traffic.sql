# Write your MySQL query statement below
with base as (
    select 
        departure_airport as airport,
        flights_count
    from 
        Flights
    union all
    select 
        arrival_airport as airport,
        flights_count
    from 
        Flights
),
ranks_cte as (
    select 
        airport,
        dense_rank() over (order by cnts desc) as ranks
    from (
        select 
            airport,
            sum(flights_count) as cnts
        from 
            base
        group by 
            airport
    ) a
)
select 
    airport as airport_id 
from 
    ranks_cte 
where 
    ranks = 1