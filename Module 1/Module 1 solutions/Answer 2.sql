SELECT sname
FROM student
WHERE gpa = (SELECT MIN(gpa) FROM student);