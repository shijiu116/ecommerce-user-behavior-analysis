select 
    user_segment,
    count(*) as user_count,
    concat(round(count(*)/(select count(*) from rfm_segment)*100,2),'%')
from rfm_segment
group by user_segment
order by user_count desc;

WITH daily_active AS (
    SELECT DISTINCT user_id, dt AS active_date
    FROM userbehavior_1
),
user_first_day AS (
    SELECT user_id, MIN(active_date) AS first_date
    FROM daily_active
    GROUP BY user_id
),
retention_calc AS (
    SELECT
        f.first_date,
        f.user_id,
        DATEDIFF(d.active_date, f.first_date) AS day_diff
    FROM user_first_day f
    JOIN daily_active d ON f.user_id = d.user_id
)
select
    first_date,
    count(distinct user_id)  as 首日活跃用户数,
    count(distinct case when day_diff=1 then user_id end)  as 次日留存用户数,
    concat(round(count(distinct case when day_diff=1 then user_id end)/count(distinct user_id)*100,2),'%') as 次日留存率,
    count(distinct case when day_diff=7 then user_id end) as 七日留存用户数,
    concat(round(count(distinct case when day_diff=7 then user_id end)/count(distinct user_id)*100,2),'%') as 七日后留存率
  from retention_calc
  group by first_date
  order by first_date;