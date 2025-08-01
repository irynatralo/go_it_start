
with cte as (
select
	 value,
	ad_date,
	campaign_name
from
	facebook_ads_basic_daily as fb
left join facebook_campaign as fc on
	fc.campaign_id = fb.campaign_id
union all
select
	value,
	ad_date,
	campaign_name
from
	google_ads_basic_daily
)
select
	date_trunc('week', ad_date)::date as start,
	SUM(value)as total,
	campaign_name
from
	cte
where
	ad_date is not null
group by
	start,
	campaign_name
order by
	total desc
limit 1
