select country,age
from
(select *, row_number() over (partition by country order by age) age_rank,
cast(count(id) over(partition by country order by age range between unbounded preceding and unbounded following) as decimal) as total_ppl
from people) x
where age_rank >=total_ppl/2 and age_rank <= (total_ppl/2)+1