-- TASK 1

DROP DATABASE IF EXISTS SISDB;
CREATE DATABASE SISDB;
USE SISDB;

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(5),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);

CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(5),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    credits INT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number) VALUES
('Sri', 'V', '2000-01-15', 'sri.r@example.com', '9876500010'),
('Mickey', 'R', '1999-05-21', 'mickey.r@example.com', '9876500020'),
('Jenny', 'M', '2001-09-12', 'jenny.m@example.com', '9876500030'),
('Charls', 'D', '2000-07-08', 'charls.d@example.com', '9876500040'),
('Sujana', 'N', '1998-03-30', 'sujana.n@example.com', '9876500050'),
('Sai', 'V', '2002-11-05', 'sai.v@example.com', '9876500060'),
('Jack', 'D', '2001-12-17', 'jack.d@example.com', '9876500070'),
('Srinidhi', 'V', '2003-12-02', 'srinidhi.r@example.com', '9876500080'),
('Aakash', 'K', '2003-12-13', 'aakash.m@example.com', '9876500090'),
('Benita', 'J', '2001-10-14', 'benita.j@example.com', '9876500100');

INSERT INTO Teacher (first_name, last_name, email) VALUES
('Madhu', 'K', 'madhu.k@school.com'),
('Raj', 'S', 'raj.s@school.com'),
('Sign', 'P', 'sign.p@school.com');

INSERT INTO Courses (course_name, credits, teacher_id) VALUES
('Mathematics', 4, 1),
('Physics', 3, 2),
('Chemistry', 4, 3),
('Biology', 3, 1),
('English', 2, 2),
('Computer Science', 4, 3),
('History', 3, 1),
('Geography', 3, 2),
('Economics', 3, 3),
('Tamil', 2, 1);

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-01-11'),
(3, 3, '2024-01-12'),
(4, 1, '2024-01-13'),
(5, 4, '2024-01-14'),
(6, 5, '2024-01-15'),
(7, 6, '2024-01-16'),
(8, 7, '2024-01-17'),
(9, 8, '2024-01-18'),
(10, 9, '2024-01-19');

INSERT INTO Payments (student_id, amount, payment_date) VALUES
(1, 1000.00, '2024-02-01'),
(2, 1200.00, '2024-02-02'),
(3, 1100.00, '2024-02-03'),
(4, 1300.00, '2024-02-04'),
(5, 1250.00, '2024-02-05'),
(6, 1400.00, '2024-02-06'),
(7, 1150.00, '2024-02-07'),
(8, 1500.00, '2024-02-08'),
(9, 1600.00, '2024-02-09'),
(10, 1700.00, '2024-02-10');

-- TASK 2

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES ('John', 'D', '1995-08-15', 'john.doe@example.com', '1234567890');
SELECT * FROM Students;

INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES (1, 1, '2024-03-01');
SELECT * FROM Enrollments;


UPDATE Teacher
SET email = 'raj.updated@school.com'
WHERE teacher_id = 2;

SELECT * FROM Teacher;

DELETE FROM Enrollments
WHERE student_id = 1 AND course_id = 2;
SELECT* FROM Enrollments;

-- Assigning Madhu (teacher_id = 1) to course_id = 5 (English)
UPDATE Courses
SET teacher_id = 1
WHERE course_id = 5;
SELECT *FROM Courses;

-- Delete student_id = 10 (Benita)
DELETE FROM Enrollments WHERE student_id = 10;
DELETE FROM Payments WHERE student_id = 10;
DELETE FROM Students WHERE student_id = 10;
SELECT * FROM Students;


-- Update payment for payment_id = 1
UPDATE Payments
SET amount = 1500.00
WHERE payment_id = 1;
SELECT* FROM Payments;

-- TASK 3
SELECT s.first_name, s.last_name, SUM(p.amount) AS total_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
WHERE s.student_id = 1
GROUP BY s.student_id;

SELECT c.course_name, COUNT(e.student_id) AS enrolled_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id;

SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;


SELECT t.first_name, t.last_name, c.course_name
FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id;

-- For course_id = 1 (Mathematics)
SELECT s.first_name, s.last_name, e.enrollment_date
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.course_id = 1;

SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id
WHERE p.payment_id IS NULL;

SELECT c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;

SELECT s.first_name, s.last_name, COUNT(e.course_id) AS course_count
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.course_id) > 1;

SELECT t.first_name, t.last_name
FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id
WHERE c.course_id IS NULL;

-- 1. Average number of students enrolled in each course
SELECT AVG(student_count) AS avg_students_per_course
FROM (
    SELECT course_id, COUNT(*) AS student_count
    FROM Enrollments
    GROUP BY course_id
) AS course_enrollments;

-- 2. Student(s) who made the highest payment
SELECT s.first_name, s.last_name, p.amount
FROM Payments p
JOIN Students s ON p.student_id = s.student_id
WHERE p.amount = (
    SELECT MAX(amount) FROM Payments
);

-- 3. Courses with the highest number of enrollments
SELECT c.course_name, COUNT(e.enrollment_id) AS enrollment_count
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id
HAVING COUNT(e.enrollment_id) = (
    SELECT MAX(enrollment_count)
    FROM (
        SELECT course_id, COUNT(*) AS enrollment_count
        FROM Enrollments
        GROUP BY course_id
    ) AS sub
);

-- 4. Total payments made to courses taught by each teacher
SELECT t.first_name, t.last_name, SUM(p.amount) AS total_payments
FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Payments p ON e.student_id = p.student_id
GROUP BY t.teacher_id;

-- 5. Students enrolled in ALL available courses
SELECT s.first_name, s.last_name
FROM Students s
WHERE NOT EXISTS (
    SELECT c.course_id FROM Courses c
    WHERE NOT EXISTS (
        SELECT * FROM Enrollments e
        WHERE e.course_id = c.course_id AND e.student_id = s.student_id
    )
);

-- 6. Teachers not assigned to any courses
SELECT first_name, last_name
FROM Teacher
WHERE teacher_id NOT IN (
    SELECT DISTINCT teacher_id FROM Courses WHERE teacher_id IS NOT NULL
);

-- 7. Average age of all students
SELECT AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS average_age
FROM Students;

-- 8. Courses with no enrollments
SELECT course_name
FROM Courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM Enrollments
);

-- 9. Total payments made by each student for each course
SELECT s.first_name, s.last_name, c.course_name, SUM(p.amount) AS total_payment
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Payments p ON p.student_id = s.student_id
GROUP BY s.student_id, c.course_id;

-- 10. Students who made more than one payment
SELECT s.first_name, s.last_name, COUNT(p.payment_id) AS payment_count
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id
HAVING COUNT(p.payment_id) > 1;

-- 11. Total payments made by each student
SELECT s.first_name, s.last_name, SUM(p.amount) AS total_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id;

-- 12. Course names and count of students enrolled in each
SELECT c.course_name, COUNT(e.enrollment_id) AS num_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id;

-- 13. Average payment amount made by students
SELECT s.first_name, s.last_name, AVG(p.amount) AS avg_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id;

