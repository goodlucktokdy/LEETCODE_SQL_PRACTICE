# Write your MySQL query statement below
with winery_ranks as (
    select 
        country,
        winery,
        points,
        dense_rank() over (partition by country order by points desc, winery) as ranks
    from (
        select 
            country,
            winery,
            sum(points) as points
        from 
            Wineries
        group by 
            country, winery
    ) a 
)
select 
    country,
    max(if(ranks = 1, concat(winery,' (',points,')'), null)) as top_winery,
    coalesce(max(if(ranks = 2, concat(winery,' (',points,')'),null)),'No second winery') as second_winery,
    coalesce(max(if(ranks = 3, concat(winery,' (',points,')'),null)),'No third winery') as third_winery
from 
    winery_ranks
group by 
    country 
order by 
    country asc