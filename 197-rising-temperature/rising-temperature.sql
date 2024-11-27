# Write your MySQL query statement below
select 
    id
from (
select 
    id,
    lag(recordDate) over (order by recordDate) as prev_day,
    recordDate,
    lag(temperature) over (order by recordDate) as prev_temp,
    temperature
from 
    Weather
) a
where 
    a.temperature > a.prev_temp and timestampdiff(day,a.prev_day,a.recordDate) = 1