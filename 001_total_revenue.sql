select
	round(sum(oi.price::numeric),2) as total_revenue
from orders o
join order_items oi		on o.order_id = oi.order_id
where o.order_status = 'delivered'
