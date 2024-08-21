DROP TABLE IF EXISTS Friends;

CREATE TABLE Friends
(
	Friend1 	VARCHAR(10),
	Friend2 	VARCHAR(10)
);
INSERT INTO Friends VALUES ('Jason','Mary');
INSERT INTO Friends VALUES ('Mike','Mary');
INSERT INTO Friends VALUES ('Mike','Jason');
INSERT INTO Friends VALUES ('Susan','Jason');
INSERT INTO Friends VALUES ('John','Mary');
INSERT INTO Friends VALUES ('Susan','Mary');

select * from Friends;

with all_friends as
	(select friend1,friend2 from friends
	union all
	select friend2, friend1 from friends)
select distinct(f.*) --,af.friend2 as mutual_friends,
,count(af.friend2) over(partition by f.friend1,f.friend2 order by f.friend1,f.friend2
					  range between unbounded preceding and unbounded following) as mutual_friends
from Friends f
left join all_friends af  -- left join to include non mutual friend
on f.friend1 = af.friend1 -- all friends of first columns
and af.friend2 in (select af2.friend2
			   from all_friends af2
			   where af2.friend1 = f.friend2) --all friends of second column is returned