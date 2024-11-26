# Write your MySQL query statement below
with base as (
    select 
        a.user_id,
        count(distinct a.movie_id) as movie_reviews,
        b.name
    from 
        MovieRating a
    left join 
        Users b
    on 
        a.user_id = b.user_id
    group by 
        a.user_id, b.name
    order by 
        movie_reviews desc, b.name asc limit 1
)
,movie as (
    select 
        a.movie_id,
        a.rating,
        a.created_at,
        b.title
    from 
        MovieRating a 
    left join 
        Movies b 
    on 
        a.movie_id = b.movie_id
)
,filtered_movie as (
    select 
        movie_id,
        title,
        avg(rating) as avg_rating
    from 
        movie
    where 
        created_at between '2020-02-01' and '2020-02-29'
    group by 
        movie_id, title
    order by 
        avg_rating desc, title asc
    limit 1
)
select 
    name as results
from 
    base 
union all 
select 
    title as results
from 
    filtered_movie