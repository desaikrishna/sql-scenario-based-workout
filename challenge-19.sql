DROP TABLE IF EXISTS pizza_delivery;
CREATE TABLE pizza_delivery 
(
	order_id 			INT,
	order_time 			TIMESTAMP,
	expected_delivery 	TIMESTAMP,
	actual_delivery 	TIMESTAMP,
	no_of_pizzas 		INT,
	price 				DECIMAL
);


select to_char(order_time,'Mon-YYYY') as period,
round((cast(sum(case when cast(to_char(actual_delivery - order_time,'MI') as int) > 30
		then 1 else 0 end) as decimal) / count(1)) *100,1) delayed_flag,
		sum(case when cast(to_char(actual_delivery - order_time,'MI') as int) > 30
		then no_of_pizzas else 0 end) as free_pizzas
from public.pizza_delivery
where actual_delivery is not null
group by to_char(order_time,'Mon-YYYY')
order by extract(month from to_date(to_char(order_time,'Mon-YYYY'),'Mon-YYYY'))

/*
first cast is to convert the month into integer, which is converted to_char to extract month
case is used to give flag, delayed order is given flag as 1
sum is taken to get total orders per month
cast to decimal is done for calculating percentage of pizza delivered late which is delayed_order/total_orders
each month

to calculate sum of pizza same logic is used

*/