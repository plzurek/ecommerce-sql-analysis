with revenue_per_customer as (
		select
			o.customer_id
			,round(sum(oi.price)::numeric, 2) as revenue_per_customer
		from order_items oi
		join orders o 
			 on o.order_id = oi.order_id
		where o.order_status = 'delivered'
		group by o.customer_id
),
	ranked_customers as (
		select
			rpc.*
			,sum(rpc.revenue_per_customer) over() as total_revenue
			,sum(rpc.revenue_per_customer) over (order by rpc.revenue_per_customer desc) as cumulative_revenue
		from revenue_per_customer rpc
	),
	pareto as (
		select
			rc.*
			,round((100.0*rc.cumulative_revenue / rc.total_revenue)::numeric,2) as pct_cumulative
		from ranked_customers rc
	)
select 
	count(p.customer_id) filter (where p.pct_cumulative <= 80) as top_customers
	,count(p.customer_id) as total_customers
	,round((100.0*count(p.customer_id) filter (where p.pct_cumulative <= 80) / count(p.customer_id))::numeric,2) as pct_customers_of_80_pct_revenue
from pareto p
