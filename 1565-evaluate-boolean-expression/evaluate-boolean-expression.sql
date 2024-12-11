# Write your MySQL query statement below
with base as (
    select 
        b.left_operand,
        a.value as left_value,
        b.operator,
        b.right_operand,
        c.value as right_value
    from 
        Variables a 
    inner join 
        Expressions b
    on 
        a.name = b.left_operand
    inner join 
        Variables c 
    on 
        c.name = b.right_operand
)
select 
    left_operand,
    operator,
    right_operand,
    case when operator = '>' and left_value - right_value > 0 then 'true'
        when operator = '=' and left_value - right_value = 0 then 'true'
        when operator = '<' and left_value - right_value < 0 then 'true'
        else 'false' end as value
from 
    base