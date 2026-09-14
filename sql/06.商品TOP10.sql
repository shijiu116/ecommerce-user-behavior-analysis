SELECT
    item_id as 商品名称,
    count(*)   as 购买次数,
    count(distinct user_id)  as 购买用户数,
    rank() over(order by count(*) desc) as 排名
from userbehavior_1
where behavior_type = 'buy'
group by item_id
order by count(*) desc
limit 10;
