with base as (
    select
        concat(actor_id,',',director_id) as pairs,
        count(timestamp) as cnts
    from 
        ActorDirector
    group by 
        pairs
    having
        cnts >= 3
)
select
    distinct
    cast(substring_index(pairs,',',1) as real) as actor_id,
    cast(substring_index(pairs,',',-1) as real) as director_id
from 
    base
