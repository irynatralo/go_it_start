
with cte as (
select
	spend, value, ad_date 
	from
	facebook_ads_basic_daily
union all 
select
	spend, value, ad_date
		from
	google_ads_basic_daily
)
select ad_date, SUM(value)::numeric / SUM(spend) as romi
from cte
where spend > 0
group by ad_date
order by romi desc
limit 5

