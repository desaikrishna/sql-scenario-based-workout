create table split_join(
	id int,
	items varchar(20)
);

insert into split_join(id, items) values
(1,'22,122,1022'),
(2,',6,0,9999'),
(3,'100,2000,2'),
(4,'4,44,444,4444');

select id, string_agg(lengths,',') as lengths
from(
select id, length(unnest(string_to_array(items,',')))::varchar as lengths
from split_join) x
group by id
order by id

select id, string_agg(lengths,',') as lengths
from split_join
cross join lateral
		(select length(unnest(string_to_array(items,',')))::varchar as lengths) l
group by id
order by id

-- unnest give row for each value in array