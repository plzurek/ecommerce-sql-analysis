with month_order_2017 as (
		select
		    o.order_id
			,to_char(date_trunc('month',o.order_purchase_timestamp),'YYYY-MM') as month_order
		from orders o
		where extract(year from o.order_purchase_timestamp) = 2017
		and   o.order_status = 'delivered'
		),
	month_revenue as (
		select
			mo.month_order
			,round(sum(oi.price)::numeric, 2) as month_revenue
		from month_order_2017 mo
		join order_items oi on oi.order_id = mo.order_id
		group by month_order
	),
	calculations as (
		select
			round(avg(mr.month_revenue),2) as avg_month_revenue
			,sum(mr.month_revenue) as year2017_revenue
		from month_revenue mr
	)
select 
	mr.month_order
	,mr.month_revenue
	,c.avg_month_revenue
	,case 
		when mr.month_revenue > c.avg_month_revenue then 'revenue above average'
		when mr.month_revenue < c.avg_month_revenue then 'revenue below average'
		else 'average'
	end as avg_comparison
	,c.year2017_revenue
	,round((100.0*mr.month_revenue / c.year2017_revenue ),2) as month_prc_share
from month_revenue mr
cross join calculations c
order by mr.month_order
