with revenue_per_customer as 
		(select
			o.customer_id
			,sum(oi.price) as revenue_per_customer
		from order_items oi
		join orders o
			 on oi.order_id = o.order_id
		where o.order_status = 'delivered'
		group by o.customer_id),
	 percentile_segmentation as 
	 	(select
			rpc.*
			,ntile(4) over (order by rpc.revenue_per_customer desc) as customer_segment
		 from revenue_per_customer rpc),
	 segment_distribution as (
		select 
			ps.*
			,case
				when ps.customer_segment = 1 then 'VIP'
				when ps.customer_segment = 2 then 'High'
				when ps.customer_segment = 3 then 'Medium'
				else 'Low'
			end as customer_type
		from percentile_segmentation ps )
select 
	sd.customer_type
	,count(sd.customer_type) as nr_of_customers
	,round(avg(sd.revenue_per_customer)::numeric,2) as avg_revenue
from segment_distribution sd
group by 1
