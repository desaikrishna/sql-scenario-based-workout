with cte as(
select * , LAG(marks) over(order by test_id) as previous_mark from student_tests)
select * from cte where marks>previous_mark or  previous_mark is null