# Write your MySQL query statement below
select 
    city_id,
    day,
    degree
from (
    select 
        city_id,
        day,
        degree,
        dense_rank() over (partition by city_id order by degree desc, day asc) as ranks
    from 
        Weather
) a
where 
    ranks = 1
order by 
    city_id 