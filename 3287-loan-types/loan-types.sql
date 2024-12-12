# Write your MySQL query statement below
with base as (
    select 
        a.user_id,
        a.loan_type,
        sum(case when a.loan_type in ('Refinance','Mortgage') then 1 else 0 end) over (partition by a.user_id) as sessions
    from ( 
        select
            distinct
            user_id,
            loan_type
        from 
            Loans
    ) a
)
select
    distinct
    user_id
from 
    base 
where 
    sessions = 2