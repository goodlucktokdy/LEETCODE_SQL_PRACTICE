# Write your MySQL query statement below
with rank_info as (
    select 
        country,
        winery,
        total_points,
        dense_rank() over (partition by country order by total_points desc, winery asc) as rnums
    from (
        select 
            country,
            winery,
            sum(points) as total_points
        from 
            Wineries
        group by 
            country, winery
    ) a 
)
select 
    country,
    max(if(rnums = 1,concat(winery,' (',total_points,')'),null)) as top_winery,
    coalesce(max(if(rnums = 2,concat(winery,' (',total_points,')'),null)),'No second winery') as second_winery,
    coalesce(max(if(rnums = 3,concat(winery,' (',total_points,')'),null)),'No third winery') as third_winery
from 
    rank_info 
group by 
    country
order by 
    country