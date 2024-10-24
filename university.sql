-- Active: 1729344281943@@127.0.0.1@5432@university_db

-- create database 
create DATABASE university_db;

-- create students table 
CREATE TABLE students(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL,
    email VARCHAR(50) NOT NULL,
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR(20) 
)

-- create course table  
CREATE table courses(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(200) NOT NULL,
    credits INTEGER NOT NULL
)


--create enrollment table
create TABLE enrollment(
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
)


-- insert new student 
-- Insert a new student
INSERT INTO students VALUES(7,'fahad', 34, 'fahad@example.com', 35, 50, NULL) 

-- insert course data 
INSERT INTO courses (course_id, course_name, credits)
VALUES
(1, 'Next.js', 3),
(2, 'React.js', 4),
(3, 'Databases', 3),
(4, 'Prisma', 3);

-- insert into enrollment
INSERT INTO enrollment (enrollment_id, student_id, course_id)
VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2);

-- Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
select student_name from enrollment
    JOIN  students USING(student_id)
    JOIN courses USING(course_id)  
    WHERE course_name = 'Next.js' 


-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'
UPDATE students
SET status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (
    SELECT MAX(frontend_mark + backend_mark)
    FROM students
); 

-- Delete all courses that have no students enrolled.
DELETE from courses
    where course_id not IN(
        select course_id from enrollment
    )

-- Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name from students 
 LIMIT 2 OFFSET 1


-- Retrieve the course names and the number of students enrolled in each course.
select course_name, count(*) as students_enrolled from enrollment
    join courses USING(course_id)
    join students USING(student_id)
    GROUP BY course_name

-- Calculate and display the average age of all students.
SELECT round(avg(age)) as average_age from students


-- Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name from students 
   WHERE email LIKE '%example%'
 
 