insert into link values(1, 2);
insert into link values(1, 3);

select student_name, course_name
from students s join link l
	on s.student_id = l.student_id
    join courses c 
    on l.course_id = c.course_id;
    
select course_name, student_name
from courses c join link l
on c.course_id = l.course_id
join students s
on l.student_id = s.student_id;

insert into students values(default, 'dd');
insert into courses values(default, 'CS', 'sunday', '7am');