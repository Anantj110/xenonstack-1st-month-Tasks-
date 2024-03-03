-- 1. Print the names of professors who work in departments that have fewer than 50 PhD
-- students.

SELECT *
FROM prof AS P
RIGHT JOIN dept AS D
ON P.dname = D.dname
WHERE D.numphds < 50;

-- 2. Print the names of the students with the lowest GPA.

SELECT sname
FROM student
WHERE gpa = (SELECT MIN(gpa) FROM student);

-- 3. For each Computer Sciences class, print the class number, section number, and the average
-- gpa of the students enrolled in the class section.

SELECT E.cno, E.sectno, AVG(S.gpa)
FROM enroll AS E
JOIN student AS S
ON E.sid = S.sid
GROUP BY E.dname, E.cno, E.sectno
HAVING E.dname = 'Computer Sciences'

-- 4. Print the names and section numbers of all sections with more than six students enrolled in
-- them

SELECT dname, sectno
FROM enroll
GROUP BY dname, sectno
HAVING COUNT(dname) > 6

-- 5. Print the name(s) and sid(s) of the student(s) enrolled in the most sections.

SELECT S.sname, E.sid, COUNT(E.sectno)
FROM enroll AS E
JOIN student AS S
ON S.sid = E.sid
GROUP BY S.sname, E.sid
ORDER BY COUNT(E.sectno) DESC
LIMIT 1

-- 6. Print the names of departments that have one or more majors who are under 18 years old.

SELECT M.dname
FROM major AS M
JOIN student AS S
ON M.sid = S.sid
WHERE S.age < 18

-- 7. Print the names and majors of students who are taking one of the College Geometry
-- courses

SELECT S.sname, E.dname
FROM enroll AS E
JOIN course AS C
ON E.cno = C.cno
JOIN student AS S 
ON S.sid = E.sid
WHERE C.cname IN ('College Geometry 1', 'College Geometry 2')

-- 8. For those departments that have no major taking a College Geometry course print the
-- department name and the number of PhD students in the department.

SELECT D.dname, D.numphds
FROM dept AS D
WHERE D.dname NOT IN 
			(SELECT M.dname
			 FROM enroll AS E
			 JOIN major AS M
			 ON M.sid = E.sid
			 JOIN course AS C
			 ON C.cno = E.cno
			 WHERE C.cname LIKE 'College Geometry %');
			 
-- 9. Print the names of students who are taking both a Computer Sciences course and a
-- Mathematics course.

SELECT S.sname
FROM student AS S
WHERE S.sid IN  
			(SELECT E1.sid
			 FROM enroll AS E1
			 JOIN enroll AS E2
			 ON E1.sid = E2.sid
			 WHERE E1.dname = 'Computer Sciences'
			 AND E2.dname = 'Mathematics'
   );

-- 10. Print the age difference between the oldest and the youngest Computer Sciences major.

SELECT MAX(S.age)-MIN(S.age) AS age_difference
FROM student AS S
JOIN major AS M
ON M.sid = S.sid
WHERE M.dname = 'Computer Sciences'

-- 11. For each department that has one or more majors with a GPA under 1.0, print the name of
-- the department and the average GPA of its majors.

SELECT M.dname, AVG(S.gpa)
FROM student AS S
JOIN major AS M
ON S.sid = M.sid
WHERE S.gpa < 1.0
GROUP BY M.dname

-- 12. Print the ids, names and GPAs of the students who are currently taking all the Civil
-- Engineering courses.

SELECT S.sname, S.sid, S.gpa
FROM Student AS S
WHERE NOT EXISTS (
	SELECT C.cno 
	FROM course AS C 
	WHERE C.dname = 'Civil Engineering'
	EXCEPT
	SELECT E.cno 
	FROM enroll AS E 
	WHERE E.sid = S.sid 
	AND E.dname = 'Civil Engineering'
);