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