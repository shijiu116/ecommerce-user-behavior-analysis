select 
    hr as 小时,
    count(*) as 总行为次数,
    count(distinct user_id) as 活跃用户数,
    sum(case when behavior_type='buy' then 1 else 0 end) as 购买次数,
    concat(
        round(
           sum(case when behavior_type='buy' then 1 else 0 end)/count(*)*100,4),
              '%')  as 购买转化率
from userbehavior_1 
group by hr
order by hr;