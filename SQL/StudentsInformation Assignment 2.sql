-- Query 1 Inserting a new student into the "Students" table

INSERT INTO Student_Information.students (first_name, date_of_birth, email, phone_number) 
VALUES ('John', '1995-08-15', 'john.doe@example.com', '1234567890');

-- Query 3 Update the email address of a specific teacher

UPDATE teacher 
SET email = 'muntasirthameem@gmail.com' 
WHERE id = 1;

-- Query 4 Delete a specific enrollment record from the "Enrollments" table

DELETE from enrollments
WHERE students_id = 3 AND `courses_id` = 2;

-- Query 5 Update the "Courses" table to assign a specific teacher to a course

UPDATE courses 
SET teacher_id = 3 
WHERE id = 2;

-- Query 6 Delete a specific student from the "Students" table and remove all their enrollment records

DELETE from students 
WHERE id = 5;

-- Query 7 Update the payment amount for a specific payment record in the "Payments" table

UPDATE payments 
SET amount = 1200
WHERE id = 4;

# Task 3:
-- Query 8 Calculate the total payments made by a specific student

select  sum(amount) as total_payments
from payments
WHERE students_id = 2;

-- Query 9 Retrieve a list of courses along with the count of students enrolled in each course

select  c.id, c.courier_name, count(e.students_id) as enrolled_students
from courses c
left join enrollments e on c.id = e.courses_id
group by c.id, c.courier_name;

-- Query 10 Find the names of students who have not enrolled in any course

select  s.first_name, s.last_name
from students s
left join enrollments e on s.id = e.students_id
WHERE e.students_id IS NULL;

-- Query 11 Retrieve the first name, last name of students, and the names of the courses they are enrolled in

select  s.first_name, s.last_name, c.courier_name
from students s
join enrollments e on s.id = e.students_id
join courses c on e.courses_id = c.id;

-- Query 12 List the names of teachers and the courses they are assigned to

select  t.first_name, t.last_name, c.courier_name
from teacher t
join courses c on t.id = c.teacher_id;

-- Query 13 Retrieve a list of students and their enrollment dates for a specific course

select  s.first_name, s.last_name, e.enrollment_date
from students s
join enrollments e on s.id = e.students_id
join courses c on e.courses_id = c.id
WHERE c.id = 4;

-- Query 14 Find the names of students who have not made any payments

select  s.first_name, s.last_name
from students s
left join payments p on s.id = p.students_id
WHERE p.students_id IS NULL;

-- Query 15 Identify courses that have no enrollments

select  c.id, c.courier_name
from courses c
left join enrollments e on c.id = e.courses_id
WHERE e.courses_id IS NULL;

-- Query 16 Identify students who are enrolled in more than one course

select  s.id, s.first_name, s.last_name, count(e.courses_id) as enrolled_courses
from students s
join enrollments e on s.id = e.students_id
group by s.id, s.first_name, s.last_name
having count(e.courses_id) > 1;

-- Query 17 Find teachers who are not assigned to any courses

select  t.id, t.first_name, t.last_name
from teacher t
left join courses c on t.id = c.teacher_id
WHERE c.teacher_id IS NULL;

#Task 4:

-- Query 18 Calculate the average number of students enrolled in each course

select  avg(enrollment_count) as average_enrollment
from (select  count(*) as enrollment_count
      from enrollments
      group by courses_id) as course_enrollment_counts;

-- Query 19 Identify the student(s) who made the highest payment

select  *
from students
WHERE id = (select  students_id
             from payments
             order  by amount DESC
             LIMIT 1);
-- Query 20 Retrieve a list of courses with the highest number of enrollments

select  id, courier_name
from courses
WHERE id = (select  courses_id
            from enrollments
            group by courses_id
            order  by count(*) DESC
            LIMIT 1);
            
-- Query 21 Calculate the total payments made to courses taught by each teacher

select  t.id, t.first_name, t.last_name, sum(p.amount) as total_payments
from teacher t
join courses c on t.id = c.teacher_id
join enrollments e on c.id = e.courses_id
join payments p on e.students_id = p.students_id
group by t.id, t.first_name, t.last_name;

-- Query 22 Identify students who are enrolled in all available courses

select  s.id, s.first_name, s.last_name
from students s
WHERE (select  count(DISTINCT courses_id) from enrollments) = 
      (select  count(DISTINCT courses_id) from enrollments e2 WHERE e2.students_id = s.id);

-- Query 23 Retrieve the names of teachers who have not been assigned to any courses

select  t.id, t.first_name, t.last_name
from teacher t
left join courses c on t.id = c.teacher_id
WHERE c.teacher_id IS NULL;

-- Query 24 Calculate the average age of all students

select  avg(datediff(current_date, date_of_birth) / 365) as average_age
from students;

-- Query 25 Identify courses with no enrollments

select  c.id, c.courier_name
from courses c
left join enrollments e on c.id = e.courses_id
WHERE e.courses_id IS NULL;

-- Query 26 Calculate the total payments made by each student for each course they are enrolled in

select  s.id as student_id, s.first_name, s.last_name, c.id as course_id, c.courier_name, sum(p.amount) as total_payment
from students s
join enrollments e on s.id = e.students_id
join courses c on e.courses_id = c.id
join payments p on s.id = p.students_id
group by s.id, s.first_name, s.last_name, c.id, c.courier_name;

-- Query 27 Identify students who have made more than one payment

select  s.id, s.first_name, s.last_name
from students s
join payments p on s.id = p.students_id
group by s.id, s.first_name, s.last_name
HAVING count(*) > 1;

-- Query 28 Calculate the total payments made by each student

select  s.id as student_id, s.first_name, s.last_name, sum(p.amount) as total_payment
from students s
join payments p on s.id = p.students_id
group by s.id, s.first_name, s.last_name;

-- Query 29 Retrieve a list of course names along with the count of students enrolled in each course

select  c.id, c.courier_name, count(e.students_id) as enrolled_students
from courses c
left join enrollments e on c.id = e.courses_id
group by c.id, c.courier_name;

-- Query 30 Calculate the average payment amount made by students

select  avg(amount) as average_payment
from payments;