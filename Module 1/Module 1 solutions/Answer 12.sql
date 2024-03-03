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