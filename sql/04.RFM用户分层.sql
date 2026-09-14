with rfm_base as (
     select 
        user_id,
        datediff((select max(dt) from userbehavior_1),max(dt)) as recency,
        count(distinct dt)  frequency,
        count(*)  monetary
        from userbehavior_1
        where behavior_type = 'buy'
        group by user_id
        ),
rfm_score as(
     SELECT  
        user_id,
        recency,
        frequency,
        monetary,
        ntile(4) over(order by recency asc) as r_score,
        ntile(4) over(order by frequency asc) as f_score,
        ntile(4) over(order by monetary asc) as m_score
        from rfm_base
        ),
rfm_segment as(
    SELECT
        user_id
        recency,
        frequency,
        monetary,
        r_score,
        f_score,
        m_score,
        CASE 
            when r_score>=3 and f_score>=3 and m_score>=3 then '高价值用户'
            when r_score>=3 and f_score<3 then '新客/潜力用户'
            when r_score<3 and f_score<3 then  '流失预警客户'
            else '一般/流失用户'
        end as user_segment
      from rfm_score
)