-- Find out the employees who attended all compan events
-- Find out the employees who attended all compan events

drop table if exists employees;
create table employees
(
	id			int,
	name		varchar(50)
);
insert into employees values(1, 'Lewis');
insert into employees values(2, 'Max');
insert into employees values(3, 'Charles');
insert into employees values(4, 'Sainz');


drop table if exists events;
create table events
(
	event_name		varchar(50),
	emp_id			int,
	dates			date
);
insert into events values('Product launch', 1, to_date('01-03-2024','DD-MM-YYYY'));
insert into events values('Product launch', 3, to_date('01-03-2024','DD-MM-YYYY'));
insert into events values('Product launch', 4, to_date('01-03-2024','DD-MM-YYYY'));
insert into events values('Conference', 2, to_date('02-03-2024','DD-MM-YYYY'));
insert into events values('Conference', 2, to_date('03-03-2024','DD-MM-YYYY'));
insert into events values('Conference', 3, to_date('02-03-2024','DD-MM-YYYY'));
insert into events values('Conference', 4, to_date('02-03-2024','DD-MM-YYYY'));
insert into events values('Training', 3, to_date('04-03-2024','DD-MM-YYYY'));
insert into events values('Training', 2, to_date('04-03-2024','DD-MM-YYYY'));
insert into events values('Training', 4, to_date('04-03-2024','DD-MM-YYYY'));
insert into events values('Training', 4, to_date('05-03-2024','DD-MM-YYYY'));



select * from employees;
select * from events;

select count(distinct(event_name)) from events


with total_events as(
	select  distinct(emp_id), count(distinct(event_name)) as total_events_attended from events
	group by emp_id
	order by total_events_attended
	),
sum_events as(
	select count(distinct(event_name)) as total_events from events
	)
select e.name, t.total_events_attended
from employees e
join total_events t on
e.id = t.emp_id
where t.total_events_attended = (select total_events from sum_events)