select
	oi.product_id
	,pcnt.product_category_name_english
	,round(sum(oi.price)::numeric,2) as revenue_per_product
from order_items oi
join orders o 
		on o.order_id = oi.order_id
join products p
		on p.product_id = oi.product_id
join product_category_name_translation pcnt
		on pcnt.product_category_name = p.product_category_name
where o.order_status = 'delivered'
group by oi.product_id, 
		 pcnt.product_category_name_english
order by revenue_per_product desc
limit 5
