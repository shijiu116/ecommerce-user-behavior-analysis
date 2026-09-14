SELECT
    count(distinct user_id)     as 总用户数,
    count(distinct item_id)     as 总商品数,
    count(distinct category_id) as 总类目数,
    count(*)  as 总行为数,
    sum(case when behavior_type='pv'  then 1 else 0 end) as 浏览次数,
    sum(case when behavior_type='fav'  then 1 else 0 end) as 收藏次数,
    sum(case when behavior_type='cart'  then 1 else 0 end) as 加购次数,
    sum(case when behavior_type='buy'  then 1 else 0 end) as 购买次数
from userbehavior_1;


with funnel as(
    select 
      count(distinct case when behavior_type='pv' then user_id end) as 浏览用户,
      count(distinct case when behavior_type='fav' then user_id end) as 收藏用户,
      count(distinct case when behavior_type='cart' then user_id end) as 加购用户,
      count(distinct case when behavior_type='buy' then user_id end) as 购买用户
    from userbehavior_1
 )
select 
   浏览用户,
   收藏用户,
   concat(round(收藏用户/浏览用户*100,2),'%') as 浏览到收藏转化率,
   加购用户,
   concat(round(加购用户/收藏用户*100,2),'%') as 收藏到加购转化率,
   购买用户,
   concat(round(购买用户/加购用户*100,2),'%') as 购买到加购转化率,
   concat(round(购买用户/浏览用户*100,2),'%') as 总转化率
from funnel;