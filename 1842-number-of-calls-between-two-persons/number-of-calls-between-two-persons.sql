with base as (
    select
        a.pairs,
        sum(a.duration) as total_duration,
        count(a.pairs) as call_count
    from (
        select
            case when from_id < to_id then concat(from_id,',',to_id) 
                    else concat(to_id,',',from_id) end as pairs,
            duration
        from
            Calls
    ) a
    group by 
        a.pairs
)
select
    cast(substring_index(pairs,',',1) as real) as person1,
    cast(substring_index(pairs,',',-1) as real) as person2,
    call_count,
    total_duration
from 
    base