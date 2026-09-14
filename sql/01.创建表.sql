create database if not exists ecommerce_analysis character set utf8mb4 collate utf8mb4_general_ci;

use ecommerce_analysis;

create table userbehavior_raw(
      user_id   varchar(20),
      item_id   varchar(20),
      category_id varchar(20),
      behavior_type varchar(20),
      ts  varchar(20)
      );

set global local_infile=1;

create table userbehavior_1(
      user_id   int,
      item_id   int,
      category_id int,
      behavior_type varchar(5),
      ts  int
      );
      
alter  table userbehavior
change column`f1` `user_id` int ,
change column`f2` `item_id` int ,    
change column`f3` `category_id` int ,    
change column`f4` `behavior_type` varchar(5) ,    
change column`f5` `ts` int;      
      
      
      
      
insert into userbehavior_1 
SELECT 
      user_id  ,
      item_id ,
      category_id,
      behavior_type,
      ts
from userbehavior;

alter table userbehavior_1 modify column ts bigint

truncate table userbehavior_1

select ts,length(ts) from userbehavior limit 5