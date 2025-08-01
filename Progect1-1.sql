select
	spend,
	'facebook' as name,
	MAX(spend),
	min(spend),
	AVG(spend)
from
	facebook_ads_basic_daily
group by
	spend
union all 
select
	spend,
	'google' as name,
	MAX(spend),
	min(spend),
	AVG(spend)
from
	google_ads_basic_daily
group by
	spend;
