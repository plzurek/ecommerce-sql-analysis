with revenue_per_product as (
		select
			oi.product_id
			,round(sum(oi.price)::numeric, 2) as revenue_per_product
		from order_items oi
		join orders o
			 on o.order_id = oi.order_id
		where o.order_status = 'delivered'
		group by oi.product_id
),
	ranked_products as (
		select
			rpp.*
			,sum(rpp.revenue_per_product) over() as total_revenue
			,sum(rpp.revenue_per_product) over (order by rpp.revenue_per_product desc) as cumulative_revenue
		from revenue_per_product rpp
	),
	pareto as (
		select
			rp.*
			,round((100.0*rp.cumulative_revenue / rp.total_revenue)::numeric, 2) as pct_cumulative
		from ranked_products rp
	)
select 
	count(p.product_id) as total_products
	,count(p.product_id) filter (where p.pct_cumulative <= 80 ) as top_products
	,round((100.0*count(p.product_id) filter (where p.pct_cumulative <= 80 )/count(p.product_id))::numeric, 2)
from pareto p