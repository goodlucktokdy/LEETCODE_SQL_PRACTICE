# Write your MySQL query statement below
with base as (
    select 
        departure_airport as airport_id,
        flights_count as flights
    from 
        Flights
    union all
    select 
        arrival_airport as airport_id,
        flights_count as flights
    from 
        Flights
),
final_info as (
    select 
        airport_id,
        dense_rank() over (order by flights desc) as ranks
    from (
        select 
            airport_id,
            sum(flights) as flights
        from 
            base 
        group by 
            airport_id
    ) a
)
select 
    airport_id
from 
    final_info 
where 
    ranks = 1