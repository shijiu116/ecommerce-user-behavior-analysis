select count(*) as null_count from userbehavior_1
where user_id is null or item_id is null or category_id is null or behavior_type is null or ts is null;
delete from userbehavior_1
where id not in (
    select keep_id from (
       select max(id) as keep_id
       from userbehavior_1
       group by user_id,item_id,ts)as t
);
alter table userbehavior_1 add column behavior_time datetime;
alter table userbehavior_1 add column dt date;
alter table userbehavior_1 add column hr tinyint;

update userbehavior_1
SET
  behavior_time=FROM_UNIXTIME(ts),
  dt=date(FROM_UNIXTIME(ts)),
  hr=hour(FROM_UNIXTIME(ts));
SELECT 
  min(dt) as start_date,
  max(dt) as end_date,
  count(distinct user_id) as unique_users,
  count(distinct item_id) as unique_items,
  count(*) as total_records
from userbehavior_1

set global innodb_buffer_pool_size=10*1024*1024;