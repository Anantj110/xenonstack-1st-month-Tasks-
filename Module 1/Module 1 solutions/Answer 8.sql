SELECT D.dname, D.numphds
FROM dept AS D
WHERE D.dname NOT IN 
			(SELECT M.dname
			 FROM enroll AS E
			 JOIN major AS M
			 ON M.sid = E.sid
			 JOIN course AS C
			 ON C.cno = E.cno
			 WHERE C.cname LIKE ('College Geometry %')
			 )