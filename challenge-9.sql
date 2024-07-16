/*

PROBLEM STATEMENT: 
Write an sql query to merge products per customer for each day as shown in expected output.

*/


drop TABLE if exists orders;
CREATE TABLE orders 
(
	customer_id 	INT,
	dates 			DATE,
	product_id 		INT
);
INSERT INTO orders VALUES
(1, '2024-02-18', 101),
(1, '2024-02-18', 102),
(1, '2024-02-19', 101),
(1, '2024-02-19', 103),
(2, '2024-02-18', 104),
(2, '2024-02-18', 105),
(2, '2024-02-19', 101),
(2, '2024-02-19', 106); 

select dates,cast(product_id as varchar) as products
from orders
--where dates='2024-02-18' and customer_id=1
union
select dates, string_agg(cast(product_id as varchar),',') as products
from orders
--where dates='2024-02-18' and customer_id=1
group by dates, customer_id
order by dates,products