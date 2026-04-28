with revenue_per_category as (
		select 
			pcnt.product_category_name_english
			,round(sum(oi.price)::numeric, 2) as revenue_per_category
		from order_items oi
		join products p 	
			 on p.product_id = oi.product_id
		join product_category_name_translation pcnt
			 on pcnt.product_category_name = p.product_category_name
		join orders o
			 on o.order_id = oi.order_id
		where o.order_status = 'delivered'
		group by pcnt.product_category_name_english 
		)
select 
	rpc.product_category_name_english
	,rpc.revenue_per_category
	,sum(rpc.revenue_per_category) over() as total_revenue
	,round((100.0*(rpc.revenue_per_category / sum(rpc.revenue_per_category) over()))::numeric, 2)  as percentage_share
	,dense_rank() over (order by rpc.revenue_per_category desc) as ranking
from revenue_per_category rpc
order by rpc.revenue_per_category desc
limit 10
