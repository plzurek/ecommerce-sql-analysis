select
	oi.product_id
	,pcnt.product_category_name_english
	,count(oi.order_item_id) as total_units_sold
from order_items oi
join orders o on o.order_id = oi.order_id
join products p on p.product_id = oi.product_id
join product_category_name_translation pcnt on pcnt.product_category_name = p.product_category_name
where o.order_status = 'delivered'
group by oi.product_id, pcnt.product_category_name_english
order by total_units_sold desc
limit 5