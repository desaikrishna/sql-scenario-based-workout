
drop table if exists invoice;
create table invoice
(
	serial_no		int,
	invoice_date	date
);
insert into invoice values (330115, to_date('01-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330120, to_date('01-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330121, to_date('01-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330122, to_date('02-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330125, to_date('02-Mar-2024','DD-MON-YYYY'));

select * from invoice;

--solution 1
select generate_series(min(serial_no),max(serial_no)) as missing_data
from invoice
except
select serial_no from invoice

--solution 2
with recursive cte as
	(select min(serial_no) as n from invoice
	union
	 select (n+1) as n
	 from cte
	 where n<(select max(serial_no) from invoice))
select * from cte
except
select serial_no from invoice
