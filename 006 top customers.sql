with revenue_per_customer as 
		(select
			o.customer_id
			,sum(oi.price) as revenue_per_customer
		from order_items oi
		join orders o
			 on oi.order_id = o.order_id
		where o.order_status = 'delivered'
		group by o.customer_id)
select 
	rpc.customer_id
	,rpc.revenue_per_customer
	,dense_rank() over (order by rpc.revenue_per_customer desc) as ranking
	,round((sum(rpc.revenue_per_customer) over()::numeric),2) as total_revenue
	,round((100.0*rpc.revenue_per_customer / sum(rpc.revenue_per_customer) over())::numeric, 2) as percentage_share
	,round((avg(rpc.revenue_per_customer) over()::numeric),2) as avg_customer_revenue
	,case 
		when rpc.revenue_per_customer > avg(rpc.revenue_per_customer) over() then 'customer revenue above average'
		when rpc.revenue_per_customer < avg(rpc.revenue_per_customer) over() then 'customer revenue below average'
		else 'average'
	end as average_revenue_comparison
from revenue_per_customer rpc
order by rpc.revenue_per_customer desc
limit 50