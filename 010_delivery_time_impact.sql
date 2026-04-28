with delivery_time as (
		select
			o.order_id
			,extract (day from (o.order_delivered_customer_date - o.order_purchase_timestamp ) ) as delivery_time
			,or2.review_score
		from orders o
		join order_reviews or2 
			 on or2.order_id = o.order_id
		where o.order_status = 'delivered'
			and o.order_delivered_customer_date is not null
		)
select 
	case
		when dt.delivery_time < 4 then 'Very fast'
		when dt.delivery_time < 10 then 'Fast'
		when dt.delivery_time < 30 then 'Medium'
		when dt.delivery_time < 100 then 'Low'
		else 'Very low'
	end as delivery_speed
	,case
		when dt.delivery_time < 4 then '0-3 days'
		when dt.delivery_time < 10 then '4-9 days'
		when dt.delivery_time < 30 then '10-29 days'
		when dt.delivery_time < 100 then '30-99 days'
		else '100 days and more'
	end as delivery_range
	,round(avg(dt.review_score),2) as avg_score_per_delivery_speed
	,count(dt.order_id) as nr_of_orders_per_delivery_speed
from delivery_time dt
group by delivery_speed, delivery_range
order by avg_score_per_delivery_speed desc
