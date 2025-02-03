with winery_ranks as (
    select 
        country,
        winery,
        total_points,
        dense_rank() over (partition by country order by total_points desc, winery asc) as ranks
    from (
        select 
            country,
            winery,
            sum(points) as total_points
        from 
            Wineries
        group by 
            country,winery
    ) a 
)
select 
    country,
    coalesce(max(case when ranks = 1 then concat(winery,' (',total_points,')') else null end),'No top winery') as top_winery,
    coalesce(max(case when ranks = 2 then concat(winery,' (',total_points,')') else null end),'No second winery') as second_winery,
    coalesce(max(case when ranks = 3 then concat(winery,' (',total_points,')') else null end),'No third winery') as third_winery
from 
    winery_ranks
group by 
    country
order by 
    country