'PROBLEM STATEMENT: 
Given graph shows the hierarchy of employees in a company. 
Write an SQL query to split the hierarchy and show the employees corresponding to their team.'


DROP TABLE IF EXISTS company;
CREATE TABLE company
(
	employee	varchar(10) primary key,
	manager		varchar(10)
);

INSERT INTO company values ('Elon', null);
INSERT INTO company values ('Ira', 'Elon');
INSERT INTO company values ('Bret', 'Elon');
INSERT INTO company values ('Earl', 'Elon');
INSERT INTO company values ('James', 'Ira');
INSERT INTO company values ('Drew', 'Ira');
INSERT INTO company values ('Mark', 'Bret');
INSERT INTO company values ('Phil', 'Mark');
INSERT INTO company values ('Jon', 'Mark');
INSERT INTO company values ('Omid', 'Earl');

SELECT * FROM company;


select mng.employee, concat('Team ',row_number() over(order by mng.employee)) as teams 
from company root
join company mng on root.employee=mng.manager
where root.manager is null


with recursive cte as
	(select c.employee, c.manager, t.teams
	 from company c
	 cross join cte_teams t 
	 where c.manager is null
	 union
	 select c.employee,c.manager
	 /*,case when t.teams is not null then t.teams
	 		else case when c.manager = cte.employee then cte.teams end
	 	end as teams */
	 , coalesce(t.teams,cte.teams) as teams
	 from company c
	 join cte on cte.employee = c.manager
	 left join cte_teams t on t.employee=c.employee
	),
	cte_teams as
	(select mng.employee, concat('Team ',row_number() over(order by mng.employee)) as teams 
	from company root
	join company mng on root.employee=mng.manager
	where root.manager is null)
select teams, string_agg(employee,', ') as members
from cte
group by teams
order by teams

'cross join done to fetch elon in every team'