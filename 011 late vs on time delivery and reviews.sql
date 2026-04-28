with delivery_time as (
		select 
			o.order_id
		 	,(o.order_estimated_delivery_date::date - o.order_purchase_timestamp::date) 
    			as estimated_delivery_time
			,(o.order_delivered_customer_date::date - o.order_purchase_timestamp::date) 
    			as real_delivery_time
			,or2.review_score
		from orders o
		join order_reviews or2
				on or2.order_id = o.order_id
		where o.order_status = 'delivered'
		and o.order_delivered_customer_date is not null
		and o.order_estimated_delivery_date is not null
),
	 delay_days as (
		select
			dt.*
			,(dt.real_delivery_time - dt.estimated_delivery_time) as delay_days
		from delivery_time dt
		)
select 
	case 
		when dd.delay_days >= 4 then 'Very late'
		when dd.delay_days > 0 and dd.delay_days < 4 then '1-3 days late'
		when dd.delay_days < 0 and dd.delay_days > -4 then '1-3 days sooner'
		when dd.delay_days <= -4  then 'Very early'
		else 'On time'
	end as delivery_date
	,round(avg(dd.review_score),2) as avg_review_score_per_delivery_date
	,count(dd.order_id) as nr_orders_per_delivery_time 
from delay_days dd
group by delivery_date
order by avg_review_score_per_delivery_date desc