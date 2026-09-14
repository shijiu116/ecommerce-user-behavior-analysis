select
    category_id 类别名称,
    count(*) as 购买次数,
    concat(round(count(*)/(select count(*) from userbehavior_1 where behavior_type='buy')*100,2),'%') as 占百分比
from userbehavior_1
where behavior_type='buy'
group by category_id
order by count(*) DESC
limit 15;