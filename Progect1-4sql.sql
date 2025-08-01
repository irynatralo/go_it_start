with cte as (
select
	reach  ,
	ad_date,
	campaign_name
from
	facebook_ads_basic_daily as fb
left join facebook_campaign as fc on
	fc.campaign_id = fb.campaign_id
union all
select
	reach,
	ad_date,
	campaign_name
from
	google_ads_basic_daily
)
,
month_date as(
select date_trunc('month', ad_date)::date as start, campaign_name, SUM(reach) as total
from cte
where ad_date is not null
group by start, campaign_name
)
,
month_prev as(
select *, coalesce(
lag(total) over (partition by campaign_name order by start)
, 0) as prev_impr 
from month_date)
select
	total-prev_impr as dif,
	campaign_name
from
	month_prev
order by
	dif desc
limit 1

